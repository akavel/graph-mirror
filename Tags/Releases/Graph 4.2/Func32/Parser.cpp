/* Copyright 2006 Ivan Johansen
 *
 * Func32 is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 */
//---------------------------------------------------------------------------
#include "Func32.h"
#include "Func32Impl.h"
#pragma hdrstop
#include <stack>
#ifdef _DEBUG
#define BOOST_SPIRIT_DEBUG
#define BOOST_SPIRIT_DEBUG_OUT DebugOutput
std::stringstream DebugOutput;
#else
#define NDEBUG
#endif

#pragma option -vi- //Disable inline expansion to fix several compiler bugs in BCC 5.6.4

#include "boost/spirit/core.hpp"
#include "boost/spirit/symbols/symbols.hpp"
#include "boost/spirit/utility/chset.hpp"
#include "boost/spirit/error_handling/exceptions.hpp"
#include <boost/spirit/attribute.hpp>
#include <boost/bind.hpp>
//---------------------------------------------------------------------------
#ifdef _DEBUG
std::ostream& operator<<(std::ostream& Stream, const std::deque<Func32::TElem>&)
{
  return Stream;
}
#endif
//---------------------------------------------------------------------------
namespace Func32
{
  using namespace boost::spirit;
  using namespace phoenix;

  struct TFuncSymbols : public symbols<TElem>
  {
	  TFuncSymbols()
    {
      for(int I = FirstFunction1P; I <= LastFunction; I++)
      {
        TIdent Ident = static_cast<TIdent>(I);
        const char *Name = FunctionName(Ident);
        if(*Name)
          add(Name, Ident);
      }
    }
  };
//---------------------------------------------------------------------------
  //Predefined constants. Variables are added later. Case sensitive
  struct TSymbols : symbols<TElem>
  {
	  TSymbols()
    {
       add("e",  Codee)
          ("i",  Codei);
    }
  } Symbols;
//---------------------------------------------------------------------------
  //Case sensitive symbols
  struct TNoCaseSymbols : symbols<TElem>
  {
	  TNoCaseSymbols()
    {
       add("pi",    CodePi)
          ("rand",  CodeRand)
          ("undef", CodeUndef);
    }
  };
//---------------------------------------------------------------------------
  struct TCompareSymbols : symbols<TElem>
  {
    TCompareSymbols()
    { add("=",  cmEqual)
         ("<>", cmNotEqual)
         ("<",  cmLess)
         (">",  cmGreater)
         ("<=", cmLessEqual)
         (">=", cmGreaterEqual);
    }
  } CompareSymbols;
//---------------------------------------------------------------------------
  //User defined symbols
  struct TUserSymbols : symbols<std::string>
  {
	  TUserSymbols(const TSymbolList *Symbols)
    {
      if(Symbols)
      {
        TSymbolList::TConstIterator Begin = Symbols->Begin();
        TSymbolList::TConstIterator End = Symbols->End();
        for(TSymbolList::TConstIterator Iter = Begin; Iter != End; ++Iter)
          add(Iter->first.c_str(), Iter->first);
      }
    }
  };
//---------------------------------------------------------------------------
  struct TContext : boost::spirit::closure<TContext, std::deque<TElem>, unsigned>
  {
    member1 List;
    member2 Arg;
  };
//---------------------------------------------------------------------------
  //Action: Throws an error from the place where the action is invoked
  class TDoError
  {
    TErrorCode ErrorCode;
  public:
    TDoError(TErrorCode AErrorCode): ErrorCode(AErrorCode) {}
    void operator()(const char *Begin, const char*) const
    {
      if(ErrorCode == ecUnknownChar)
        throw parser_error<EParseError>(Begin, EParseError(ecUnknownChar, 0, std::string(1, *Begin)));
      throw parser_error<EParseError>(Begin, ErrorCode);
    }
  };
//---------------------------------------------------------------------------
  //Action: Called when an operator is found
  struct TDoOperator
  {
    TIdent Ident;
    TContext::member1 &Elements;
    TDoOperator(TContext::member1 &AElements, TIdent Operator) : Ident(Operator), Elements(AElements) {}
    void operator()(const std::deque<TElem> &List)
    {
      Elements().push_front(Ident);
      Elements().insert(Elements().end(), List.begin(), List.end());
    }
  };
//---------------------------------------------------------------------------
  struct TDoNegate
  {
    TContext::member1 &Elements;
    TDoNegate(TContext::member1 &AElements) : Elements(AElements) {}
    void operator()(const std::deque<TElem> &List)
    {
      if(List.front().Ident == CodeNumber)
        Elements().push_back(-List.front().Number);
      else
      {
        Elements().push_front(CodeNeg);
        Elements().insert(Elements().end(), List.begin(), List.end());
      }
    }
  };
//---------------------------------------------------------------------------
  struct TDoFuncSymbol
  {
    TContext::member1 &Container;
    const TContext::member2 &Arg;

    TDoFuncSymbol(TContext::member1 &AContainer, const TContext::member2 &AArg)
      : Container(AContainer), Arg(AArg) {}
    void operator()(const char *Begin, const char*) const
    {
      TElem &Elem = Container().front();
      unsigned ActualArg = Arg();

      if(Elem.Ident == CodeCustom)
      {
        if(Elem.Arguments != ActualArg)
          throw parser_error<EParseError>(Begin, EParseError(ecArgCountError, -1, FunctionName(Elem)));
      }
      else
      {
        if(!ArgCountValid(Elem.Ident, ActualArg))
          throw parser_error<EParseError>(Begin, EParseError(ecArgCountError, -1, FunctionName(Elem.Ident)));
        Elem.Arguments = ActualArg;
      }
    }
  };
//---------------------------------------------------------------------------
  //Policies for real parser. Exponential 'E' must be in upper case
  template <typename T>
  struct TFuncURealParserPolicies : public ureal_parser_policies<T>
  {
    BOOST_STATIC_CONSTANT(bool, allow_trailing_dot = false);
    template <typename ScannerT>
    static typename parser_result<chlit<>, ScannerT>::type
    parse_exp(ScannerT& scan)
    {
      return ch_p('E').parse(scan);
    }
  };
//---------------------------------------------------------------------------
  //Parser used for parsing unsigned real numbers. Example: 5.457E-87
  real_parser<long double, TFuncURealParserPolicies<long double> > const
    FuncUReal_p = real_parser<long double, TFuncURealParserPolicies<long double> >();

  //Assertion: Throws an exception if the parser does not succed
  assertion<EParseError> AssertFactor_p(ecFactorExpected);
  assertion<EParseError> AssertExpression_p(ecExpressionExp);
  assertion<EParseError> AssertEndPar_p(ecNoEndPar);

  template <typename T, typename T2>
  class TPushFront
  {
  public:
    explicit TPushFront(T& AContainer, const T2 &AData) : Container(AContainer), Data(AData) {}

    template <typename T3>
    void operator()(const T3 &Val) const
    {
      Container().push_front(Data(Val));
    }

  private:
    T &Container;
    const T2 &Data;
  };

  template <typename T, typename T2>
  inline TPushFront<T, T2> PushFront(T& t, const T2 &t2)
  {
    return TPushFront<T, T2>(t, t2);
  }

  template <typename T>
  inline TPushFront<T, actor<argument<0> > > PushFront(T& t)
  {
    return TPushFront<T, actor<argument<0> > >(t, arg1);
  }

  class TAssign
  {
    TContext::member1 &Container;
  public:
    TAssign(TContext::member1 &AContainer) : Container(AContainer) {}
    void operator()(const TElem &Elem)
    {
      Container().clear();
      Container().push_back(Elem);
    }
  };

  class TPushBack
  {
    TContext::member1 &Container;
  public:
    TPushBack(TContext::member1 &AContainer) : Container(AContainer) {}
    void operator()(const std::deque<TElem> &List)
    {
      Container().insert(Container().end(), List.begin(), List.end());
    }
  };

  class TConvertRelation
  {
    TContext::member1 &Container;
  public:
    TConvertRelation(TContext::member1 &AContainer) : Container(AContainer) {}
    void operator()(const TElem &Elem)
    {
      Container().front().Ident = CodeCompare2;
      Container().front().Compare[1] = Elem.Compare[0];
    }
  };

  //---------------------------------------------------------------------------
  /** Parse the string and store the result. The function is strong exception safe.
   *  \param Str: The string to parse
   *  \param Args: Argument names to the function
   *  \param SymbolList: List of global symbols
   *  \throw EParseError on parsing errors
   */
  void TFuncData::Parse(const std::string &Str, const std::vector<std::string> &Args, const TSymbolList *SymbolList)
  {
    TFuncSymbols FuncSymbols;
    TNoCaseSymbols NoCaseSymbols;

    //Add arguments before symbol names, so they take precedens.
    for(unsigned I = 0; I < Args.size(); ++I)
      NoCaseSymbols.add(Args[I].c_str(), TElem(CodeVariable, I, 0));

    if(SymbolList)
    { //WARNING: Do not remove {} (bcc 5.6.4 bug)
      for(TSymbolList::TConstIterator Iter = SymbolList->Begin(); Iter != SymbolList->End(); ++Iter)
        if(Iter->second.GetArguments().empty())
        {
          //Don't add a function/constant with same name as an argument
          if(find(NoCaseSymbols, Iter->first.c_str()) == NULL)
            NoCaseSymbols.add(Iter->first.c_str(), TElem(CodeCustom, Iter->first, 0, Iter->second.FuncData));
        }
        else
          FuncSymbols.add(Iter->first.c_str(), TElem(CodeCustom, Iter->first, Iter->second.Args.size(), Iter->second.FuncData));
    }

    rule<phrase_scanner_t, TContext::context_t> Term, Expression, Factor, Constant, Function, Parentheses, Power, FactorSeq, Sum, Neg, Relation;

    //A constant may not be followed by a alpha-numeric character
    //A constant may not be followed a a parenthesis
    Constant =
        lexeme_d[ nocase_d[NoCaseSymbols[TAssign(Constant.List)]] >> (eps_p - alnum_p)
                | Symbols[TAssign(Constant.List)] >> (eps_p - alnum_p)
                ] >> !(+ch_p('('))[TDoError(ecParAfterConst)];

    //A function name may not be followd by character og digit, because they should be part of the name.
    //If an aplhanumeric character is found afterwards, the pushed function is popped
    Function =
        lexeme_d[nocase_d[FuncSymbols[PushFront(Function.List)][Function.Arg = 1] >> (eps_p - alnum_p)]] >>
            (   '(' >> Expression[TPushBack(Function.List)] >>
                *(',' >> AssertExpression_p(Expression)[TPushBack(Function.List)])[++Function.Arg] >> AssertEndPar_p(ch_p(')'))
            |   FactorSeq[TPushBack(Function.List)]
            )[TDoFuncSymbol(Function.List, Function.Arg)];

    Parentheses =
                '(' >> AssertExpression_p(Expression)[Parentheses.List = arg1] >> AssertEndPar_p(ch_p(')'))
            |   '[' >> AssertExpression_p(Expression)[Parentheses.List = arg1] >> AssertEndPar_p(ch_p(']'))
            |   '{' >> AssertExpression_p(Expression)[Parentheses.List = arg1] >> AssertEndPar_p(ch_p('}'));

    Relation =
        Sum[Relation.List = arg1] >>
                !(CompareSymbols[PushFront(Relation.List)] >> AssertExpression_p(Sum)[TPushBack(Relation.List)] >>
                !(CompareSymbols[TConvertRelation(Relation.List)] >> AssertExpression_p(Sum)[TPushBack(Relation.List)]))
            ;

    Expression =
        Relation[Expression.List = arg1] >>
           *(   lexeme_d[nocase_d["and"] >> (eps_p - alnum_p)] >> AssertExpression_p(Relation[TDoOperator(Expression.List, CodeAnd)])
            |   lexeme_d[nocase_d["or"] >> (eps_p - alnum_p)] >> AssertExpression_p(Relation[TDoOperator(Expression.List, CodeOr)])
            |   lexeme_d[nocase_d["xor"] >> (eps_p - alnum_p)] >> AssertExpression_p(Relation[TDoOperator(Expression.List, CodeXor)])
            );

    Sum =
        Term[Sum.List = arg1] >>
           *(   '+' >> AssertFactor_p(Term)[TDoOperator(Sum.List, CodeAdd)]
            |   '-' >> AssertFactor_p(Term)[TDoOperator(Sum.List, CodeSub)]
            );

    FactorSeq = AssertFactor_p(Neg[FactorSeq.List = arg1] >> *Factor[TDoOperator(FactorSeq.List, CodeMul)]);

    Neg = ('-' >> AssertFactor_p(Neg[TDoNegate(Neg.List)])) | Factor[Neg.List = arg1];

    Term =
        Neg[Term.List = arg1] >>
           *Factor[TDoOperator(Term.List, CodeMul)] >>
           *(   ('*' >> FactorSeq[TDoOperator(Term.List, CodeMul)])
            |   ('/' >> FactorSeq[TDoOperator(Term.List, CodeDiv)])
            );

    Factor =
        (   Function[Factor.List = arg1]
        |   Constant[Factor.List = arg1]
        |   FuncUReal_p[PushFront(Factor.List)] >> !(+ch_p('.'))[TDoError(ecInvalidNumber)]
        |   Parentheses[Factor.List = arg1]
        )   >> !('^' >> AssertExpression_p(Neg)[TDoOperator(Factor.List, CodePow)])
        ;

  BOOST_SPIRIT_DEBUG_RULE(Expression);
  BOOST_SPIRIT_DEBUG_RULE(Relation);
  BOOST_SPIRIT_DEBUG_RULE(Term);
  BOOST_SPIRIT_DEBUG_RULE(Sum);
  BOOST_SPIRIT_DEBUG_RULE(FactorSeq);
  BOOST_SPIRIT_DEBUG_RULE(Factor);
  BOOST_SPIRIT_DEBUG_RULE(Parentheses);
  BOOST_SPIRIT_DEBUG_RULE(Power);
  BOOST_SPIRIT_DEBUG_RULE(Function);
  BOOST_SPIRIT_DEBUG_RULE(Constant);
  BOOST_SPIRIT_DEBUG_RULE(Neg);

    if(Str.empty())
      throw EParseError(ecEmptyString);

    const char *Begin = &Str[0];
    const char *End = &Str[0] + Str.size();

    try
    {
      //Parse expression and ignore spaces at the end
      std::deque<TElem> Temp;
      parse_info<> Info = parse(Begin, End, Expression[var(Temp) = arg1], space_p);
      std::vector<TElem> Temp2(Temp.begin(), Temp.end());

      if(!Info.full)
      {
        if(std::isalpha(*Info.stop))
        {
          const char *Ch;
          for(Ch = Info.stop; std::isalnum(*Ch); ++Ch);
          throw EParseError(ecUnknownVar, Info.stop - Begin, std::string(Info.stop, Ch));
        }
        if(*Info.stop == ',')
          throw EParseError(ecCommaError, Info.stop - Begin);
        if(*Info.stop == 0)
          throw EParseError(ecUnexpectedEnd, Info.stop - Begin);
        if(std::string("+-/*^").find_first_of(*Info.stop) != std::string::npos)
          throw EParseError(ecOperatorError, Info.stop - Begin, std::string(1, *Info.stop));
        if(*Info.stop == ')')
          throw EParseError(ecInvalidEndPar, Info.stop - Begin);
        if(*Info.stop == '.' || std::isdigit(*Info.stop))
          throw EParseError(ecInvalidNumber, Info.stop - Begin);
        if(*Info.stop == '<' || *Info.stop == '>' || *Info.stop == '=')
          throw EParseError(ecInvalidCompare, Info.stop - Begin);
        if(!std::isdigit(*Info.stop) && std::string(".( ").find_first_of(*Info.stop) == std::string::npos)
          throw EParseError(ecUnknownChar, Info.stop - Begin, std::string(1, *Info.stop));
        throw EParseError(ecParseError, Info.stop - Begin);
      }

//      DEBUG_LOG(std::clog << MakeText(Temp2.begin()) << std::endl);
      Data.swap(Temp2);
    }
    //Should not be necesarry. Bug in BCB6? Error on "sin �" is not caught without
    catch(parser_error<const EParseError, const char*> &E)
    {
      if(std::isalpha(*E.where))
      {
        const char *Ch;
        for(Ch = E.where; std::isalnum(*Ch); ++Ch);
        throw EParseError(ecUnknownVar, E.where - Begin, std::string(E.where, Ch));
      }
      throw EParseError(E.descriptor.ErrorCode, E.where - Begin, E.descriptor.Str);
    }
    catch(parser_error<EParseError, const char*> &E)
    {
      if(std::isalpha(*E.where))
      {
        const char *Ch;
        for(Ch = E.where; std::isalnum(*Ch); ++Ch);
        throw EParseError(ecUnknownVar, E.where - Begin, std::string(E.where, Ch));
      }

      //Convert to a comma error if the error was detected at a comma (eg. "(0,8)")
      if(*E.where == ',')
        throw EParseError(ecCommaError, E.where - Begin);

      throw EParseError(E.descriptor.ErrorCode, E.where - Begin, E.descriptor.Str);
    }
    catch(EFuncError &E)
    {
      throw;
    }
    catch(...)
    {
      throw EFuncError(ecInternalError);
    }
  }
//---------------------------------------------------------------------------
} //namespace Func32














