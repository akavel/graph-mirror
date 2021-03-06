/* Copyright 2007 Ivan Johansen
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
#include <limits>
namespace Func32
{
//---------------------------------------------------------------------------
/** Default constructor: Constructs a new empty polar function.
 */
TParamFunc::TParamFunc() : xFuncData(new TFuncData), yFuncData(new TFuncData)
{
}
//---------------------------------------------------------------------------
/** Constructor to create a TParamFunc object from x(t) and y(t) text strings
 *  \param xText: The x(t) part of the parameter function
 *  \param yText: The y(t) part of the parameter function
 *  \param Variable: Name of the paramater. Defaults to "t".
 *  \param ATrigonometry: Select to use radians or degrees for trigonometric functions. Defaults to Radian.
 *  \throw EParseError: Thrown on parse errors in one of the function parts
 */
TParamFunc::TParamFunc(const std::string &xText, const std::string &yText, const std::string &Variable, TTrigonometry ATrigonometry)
  : TBaseFunc(ATrigonometry), xFuncData(new TFuncData(xText, Variable))
{
  try
  {
    yFuncData.reset(new TFuncData(yText, Variable));
  }
  catch(EParseError &Error)
  {
    Error.ErrorFunc = efParamY;
    throw;
  }
}
//---------------------------------------------------------------------------
/** Constructor to create a TParamFunc object from x(t) and y(t) text strings and a symbol list
 *  \param xText: The x(t) part of the parameter function
 *  \param yText: The y(t) part of the parameter function
 *  \param Variable: Name of the paramater.
 *  \param SymbolList: List of custom functions/constants
 *  \param ATrigonometry: Select to use radians or degrees for trigonometric functions. Defaults to Radian.
 *  \throw EParseError: Thrown on parse errors in one of the function parts
 */
TParamFunc::TParamFunc(const std::string &xText, const std::string &yText, const std::string &Variable, const TSymbolList &SymbolList, TTrigonometry ATrigonometry)
  : TBaseFunc(ATrigonometry), xFuncData(new TFuncData(xText, Variable, SymbolList))
{
  try
  {
    yFuncData.reset(new TFuncData(yText, Variable, SymbolList));
  }
  catch(EParseError &Error)
  {
    Error.ErrorFunc = efParamY;
    throw;
  }
}
//---------------------------------------------------------------------------
/** Constructor to create a TParamFunc object from two constants
 *  \param xValue: Constant used to initialize x(t)
 *  \param yValue: Constant used to initialize y(t)
 */
TParamFunc::TParamFunc(long double xValue, long double yValue)
  : xFuncData(new TFuncData), yFuncData(new TFuncData)
{
  //Set element to indicate constant number
  xFuncData->Add(xValue);
  yFuncData->Add(yValue);
}
//---------------------------------------------------------------------------
/** Constructor used to create a TParamFunc object from a TFunc object. y(t) is
 *  assigned the TFunc object and x(t)=t.
 *  \param Func: TFunc object assigned to y(t)
 */
TParamFunc::TParamFunc(const TFunc &Func)
  : TBaseFunc(Func.Trigonometry), xFuncData(new TFuncData), yFuncData(Func.FuncData)
{
  xFuncData->Add(CodeVariable);
}
//---------------------------------------------------------------------------
/** Ensures that xFuncData and YFuncData has a reference count of 1. Differentiation data are cleared.
 */
inline void TParamFunc::Unique()
{
  if(!xFuncData.unique())
    xFuncData.reset(new TFuncData(*xFuncData));
  if(!yFuncData.unique())
    yFuncData.reset(new TFuncData(*yFuncData));
  xDifData.reset();
  yDifData.reset();
}
//---------------------------------------------------------------------------
/** Assigns the text strings to x(t) and y(t) of the object
 *  \param xText: String attached to x(t)
 *  \param yText: String attached to y(t)
 *  \param Variable: Name of the paramater variable. Defaults to "t"
 *  \throw EParseError: Thrown on parse errors
 */
void TParamFunc::SetFunc(const std::string &xText, const std::string &yText, const std::string &Variable)
{
  boost::shared_ptr<TFuncData> TempData;
  try
  {
    TempData.reset(new TFuncData(xText, Variable));
  }
  catch(EParseError &Error)
  {
    Error.ErrorFunc = efParamX;
    throw;
  }

  try
  {
    yFuncData.reset(new TFuncData(yText, Variable));
  }
  catch(EParseError &Error)
  {
    Error.ErrorFunc = efParamY;
    throw;
  }
  xFuncData = TempData;
}
//---------------------------------------------------------------------------
/** Assigns the text strings to x(t) and y(t) of the object
 *  \param xText: String attached to x(t)
 *  \param yText: String attached to y(t)
 *  \param Variable: Name of the paramater variable.
 *  \param SymbolList: List of custom functions/constants
 *  \throw EParseError: Thrown on parse errors
 */
void TParamFunc::SetFunc(const std::string &xText, const std::string &yText, const std::string &Variable, const TSymbolList &SymbolList)
{
  boost::shared_ptr<TFuncData> TempData;
  try
  {
    TempData.reset(new TFuncData(xText, Variable, SymbolList));
  }
  catch(EParseError &Error)
  {
    Error.ErrorFunc = efParamX;
    throw;
  }

  try
  {
    yFuncData.reset(new TFuncData(yText, Variable, SymbolList));
  }
  catch(EParseError &Error)
  {
    Error.ErrorFunc = efParamY;
    throw;
  }
  xFuncData = TempData;
}
//---------------------------------------------------------------------------
/** Calculate the x-coordinate at a given parameter. This function does not throw any exceptions.
 *  \param t: The parameter variable to evaluate at.
 *  \param E: Error infomration filled on return.
 *  \return The evaluated x-coordinate.
 */
long double TParamFunc::CalcX(long double t, ECalcError &E) const
{
  return xFuncData->Calc(&t, Trigonometry, E);
}
//---------------------------------------------------------------------------
/** Calculate the y-coordinate at a given parameter. This function does not throw any exceptions.
 *  \param t: The parameter variable to evaluate at.
 *  \param E: Error infomration filled on return.
 *  \return The evaluated y-coordinate.
 */
long double TParamFunc::CalcY(long double t, ECalcError &E) const
{
  return yFuncData->Calc(&t, Trigonometry, E);
}
//---------------------------------------------------------------------------
/** Ensure that there is a differentiation of the function.
 *  \throw EFuncError: If differentiation fails.
 */
inline void TParamFunc::EnsureDif() const
{
  if(!xDifData)
    xDifData = xFuncData->MakeDif(CodeVariable, Trigonometry);
  if(!yDifData)
    yDifData = yFuncData->MakeDif(CodeVariable, Trigonometry);
}
//---------------------------------------------------------------------------
/** Finds and returns a pointer to a new object with the first derivative of the function.
 *  \throw EFuncError: If the differentiation fails.
 */
TParamFunc* TParamFunc::MakeDifPtr() const
{
  EnsureDif();
  return new TParamFunc(xDifData, yDifData, Trigonometry);
}
//---------------------------------------------------------------------------
/** Finds and returns a pointer to a new object with the first derivative of the function.
 *  \param Var: Variable to differentiate with respect to.
 *  \throw EFuncError: If the differentiation fails.
 */
TParamFunc* TParamFunc::MakeDifPtr(const std::string &Var) const
{
  return new TParamFunc(xDifData->MakeDif(TElem(CodeCustom, Var), Trigonometry),
                        yDifData->MakeDif(TElem(CodeCustom, Var), Trigonometry), Trigonometry);
}
//---------------------------------------------------------------------------
/** Returns the first derivative of the function
 *  \throw EFuncError: If the differentiation fails.
 */
TParamFunc TParamFunc::MakeDif() const
{
  EnsureDif();
  return TParamFunc(xDifData, yDifData, Trigonometry);
}
//---------------------------------------------------------------------------
/** Returns the first derivative of the function
 *  \param Var: Name of variable/constant to differentiate with respect to.
 *  \throw EFuncError: If differentiation fails.
 */
TParamFunc TParamFunc::MakeDif(const std::string &Var) const
{
  return TParamFunc(xDifData->MakeDif(TElem(CodeCustom, Var), Trigonometry),
                    yDifData->MakeDif(TElem(CodeCustom, Var), Trigonometry), Trigonometry);
}
//---------------------------------------------------------------------------
//! Clear internal format so function becomes empty
void TParamFunc::Clear()
{
  xFuncData.reset(new TFuncData);
  yFuncData.reset(new TFuncData);
  Trigonometry = Radian;
}
//---------------------------------------------------------------------------
//! Return true if function doesn't contain any data
bool TParamFunc::IsEmpty() const
{
  return xFuncData->IsEmpty() && yFuncData->IsEmpty();
}
//---------------------------------------------------------------------------
/** Creates a string containing x(t)
 *  \param Variable: Name of paramater variable.
 *  \return The string with the x(t) part of the function.
 */
std::string TParamFunc::MakeXText(const std::string &Variable) const
{
  return xFuncData->MakeText(std::vector<std::string>(1, Variable));
}
//---------------------------------------------------------------------------
/** Creates a string containing y(t)
 *  \param Variable: Name of paramater variable.
 *  \return The string with the y(t) part of the function.
 */
std::string TParamFunc::MakeYText(const std::string &Variable) const
{
  return yFuncData->MakeText(std::vector<std::string>(1, Variable));
}
//---------------------------------------------------------------------------
/** Assigns Func to the parameter function
 *  \param Func: Functon to copy
 */
TParamFunc& TParamFunc::operator=(const TParamFunc &Func)
{
  TBaseFunc::operator=(Func);

  xFuncData = Func.xFuncData;
  yFuncData = Func.yFuncData;
  return *this;
}
//---------------------------------------------------------------------------
/** Assigns Func to the parameter function
 *  \param F: Functon to copy
 *  \throw EFuncError: If the function is not of type TParamfunc
 */
void TParamFunc::Assign(const TBaseFunc &F)
{
  if(const TParamFunc *Func = dynamic_cast<const TParamFunc*>(&F))
    *this = *Func;
  else
    throw EFuncError(ecErrorType);
}
//---------------------------------------------------------------------------
//! The function returns a TFunc that is Func1 and Func2 added.
const TParamFunc operator+(TParamFunc Func1, const TParamFunc &Func2)
{
  Func1 += Func2;
  return Func1;
}
//---------------------------------------------------------------------------
//! The function returns a TFunc that is Func1 and Func2 subtracted.
const TParamFunc operator-(TParamFunc Func1, const TParamFunc &Func2)
{
  Func1 -= Func2;
  return Func1;
}
//---------------------------------------------------------------------------
//! Multiplies a value with a parameter function and returns the result.
const TParamFunc operator*(long double Value, const TParamFunc &Func)
{
  TParamFunc Temp;
  Temp.xFuncData->Add(CodeMul);
  Temp.yFuncData->Add(CodeMul);
  Temp.xFuncData->Add(Value);
  Temp.yFuncData->Add(Value);
  Temp.xFuncData->Add(*Func.xFuncData);
  Temp.yFuncData->Add(*Func.yFuncData);
  return Temp;
}
//---------------------------------------------------------------------------
//! Divides a value with a parameter function and returns the result.
const TParamFunc operator/(long double Value, const TParamFunc &Func)
{
  TParamFunc Temp;
  Temp.xFuncData->Add(CodeDiv);
  Temp.yFuncData->Add(CodeDiv);
  Temp.xFuncData->Add(Value);
  Temp.yFuncData->Add(Value);
  Temp.xFuncData->Add(*Func.xFuncData);
  Temp.yFuncData->Add(*Func.yFuncData);
  return Temp;
}
//---------------------------------------------------------------------------
//! Multiplies this object with a value and returns the result
const TParamFunc TParamFunc::operator*(long double Value) const
{
  TParamFunc Temp(*this);
  return Temp *= Value;
}
//---------------------------------------------------------------------------
//! Divides this object with a value and returns the result
const TParamFunc TParamFunc::operator/(long double Value) const
{
  TParamFunc Temp(*this);
  return Temp /= Value;
}
//---------------------------------------------------------------------------
//! Adds another parameter function to this object
TParamFunc& TParamFunc::operator+=(const TParamFunc &Func)
{
  Unique();
  xFuncData->AddFront(CodeAdd);
  xFuncData->Add(*Func.xFuncData);
  yFuncData->AddFront(CodeAdd);
  yFuncData->Add(*Func.yFuncData);
  return *this;
}
//---------------------------------------------------------------------------
//! Subtracts another parameter function from this object
TParamFunc& TParamFunc::operator-=(const TParamFunc &Func)
{
  Unique();
  xFuncData->AddFront(CodeSub);
  xFuncData->Add(*Func.xFuncData);
  yFuncData->AddFront(CodeSub);
  yFuncData->Add(*Func.yFuncData);
  return *this;
}
//---------------------------------------------------------------------------
//! Multiplies this object with a value
TParamFunc& TParamFunc::operator*=(long double Value)
{
  Unique();
  xFuncData->AddFront(CodeMul);
  xFuncData->Add(Value);
  yFuncData->AddFront(CodeMul);
  yFuncData->Add(Value);
  return *this;
}
//---------------------------------------------------------------------------
//! Divides this object with a value
TParamFunc& TParamFunc::operator/=(long double Value)
{
  Unique();
  xFuncData->AddFront(CodeDiv);
  xFuncData->Add(Value);
  yFuncData->AddFront(CodeDiv);
  yFuncData->Add(Value);
  return *this;
}
//---------------------------------------------------------------------------
//! Compares this object to another parameter function and returns true if their content is equal
bool TParamFunc::operator ==(const TParamFunc &Func) const
{
  return (xFuncData == Func.xFuncData || *xFuncData == *Func.xFuncData) &&
    (yFuncData == Func.yFuncData || *yFuncData == *Func.yFuncData);
}
//---------------------------------------------------------------------------
//! Compares this object to another parameter function and returns true if their content is different
bool TParamFunc::operator !=(const TParamFunc &Func) const
{
  return !(*this == Func);
}
//---------------------------------------------------------------------------
//Return complex function value x(t)
TComplex TParamFunc::CalcX(TComplex t, ECalcError &E) const
{
  return xFuncData->Calc(&t, Trigonometry, E);
}
//---------------------------------------------------------------------------
//Return complex function value y(t)
TComplex TParamFunc::CalcY(TComplex t, ECalcError &E) const
{
  return yFuncData->Calc(&t, Trigonometry, E);
}
//---------------------------------------------------------------------------
/** Converts the x(t) part of the parameter function to a TFunc.
 */
TFunc TParamFunc::ConvXToFunc() const
{
  return TFunc(xFuncData, Trigonometry);
}
//---------------------------------------------------------------------------
/** Converts the y(t) part of the parameter function to a TFunc.
 */
TFunc TParamFunc::ConvYToFunc() const
{
  return TFunc(yFuncData, Trigonometry);
}
//---------------------------------------------------------------------------
/** Optimize the internal data for the function.
 */
void TParamFunc::Simplify()
{
  Unique();
  xFuncData->Simplify();
  yFuncData->Simplify();
}
//---------------------------------------------------------------------------
//! Swap the contents of the object with the content of Func. This cannot throw.
void TParamFunc::Swap(TParamFunc &Func)
{
  SwapBase(Func);
  xFuncData.swap(Func.xFuncData);
  yFuncData.swap(Func.yFuncData);
}
//---------------------------------------------------------------------------
/** Calculate the slope as an angle at the given t-parameter.
 *  \param t: t-parameter to calculate slope at.
 *  \return Angle in radians. The trigonometry setting is ignored.
 *  \throw EFuncError: Thrown if the function cannot be differentiated.
 *  \throw ECalcError: Thrown if evaluation fails.
 */
long double TParamFunc::CalcAngleSlope(long double t) const
{
  TParamFunc FuncDif = MakeDif();
  long double dx = FuncDif.CalcX(t);
  long double dy = FuncDif.CalcY(t);
  return std::atan2(dy, dx);
}
//---------------------------------------------------------------------------
/** Calculates the area under curve using Simpson's rule between xMin and xMax
 *  The area will be negative when the function travels from right to left.
 *  \param xMin: Start of range
 *  \param xMax: End of range
 *  \param n: The number of steps; n must be even
 */
long double TParamFunc::CalcArea(long double tMin, long double tMax, unsigned n) const
{
  if(!xDifData)
    xDifData = xFuncData->MakeDif(CodeVariable, Trigonometry);

  TFuncData Temp;
  Temp.Add(CodeMul);
  Temp.Add(*yFuncData);
  Temp.Add(*xDifData);
  return Temp.Integrate(tMin, tMax, n, Trigonometry);
}
//---------------------------------------------------------------------------
/** Returns the length of the curve between t=tMin and t=tMax made by the function.
 *  \param tMin: Start parameter
 *  \param tMax: End parameter
 *  \param n: The number of steps; n must be even.
 *  \return Length of curve.
 *  \throw EFuncError: If the function cannot be differentiated.
 *  \throw ECalcError: If Calculation fails.
 */
long double TParamFunc::CalcArc(long double tMin, long double tMax, unsigned n) const
{
  return sqrt(pow(ConvXToFunc().MakeDif(), 2) + pow(ConvYToFunc().MakeDif(), 2)).CalcArea(tMin, tMax, n);
}
//---------------------------------------------------------------------------
/** Calculate the slope at the given t-parameter.
 *  \param t: t-parameter to calculate slope at.
 *  \return The slope at the given parameter.
 *  \throw EFuncError: Thrown if the function cannot be differentiated.
 *  \throw ECalcError: Thrown if evaluation fails.
 */
long double TParamFunc::CalcSlope(long double t) const
{
  EnsureDif();
  long double dx = xDifData->Calc(&t, Trigonometry);
  long double dy = yDifData->Calc(&t, Trigonometry);
  if(dx)
    return dy/dx;
  return dy > 0 ? +std::numeric_limits<long double>::infinity() : -std::numeric_limits<long double>::infinity();
}
//---------------------------------------------------------------------------
/** Evaluate (x,y) pair for the function.
 *  \param t: parameter-coordinate to evaluate at.
 *  \param E: Contains error information on return.
 *  \return Structure with the (x,y) pair.
 */
TCoord<long double> TParamFunc::Calc(long double t, ECalcError &E) const
{
  TCoord<long double> Result;
  Result.x = xFuncData->Calc(&t, Trigonometry, E);
  if(!E.ErrorCode)
    Result.y = yFuncData->Calc(&t, Trigonometry, E);
  return Result;
}
//---------------------------------------------------------------------------
/** Evaluate (x,y) pair for the function evaluated using complex numbers.
 *  \param t: parameter-coordinate to evaluate at.
 *  \param E: Contains error information on return.
 *  \return Structure with the (x,y) pair.
 */
TCoord<TComplex> TParamFunc::Calc(TComplex t, ECalcError &E) const
{
  TCoord<TComplex> Result;
  Result.x = xFuncData->Calc(&t, Trigonometry, E);
  if(!E.ErrorCode)
    Result.y = yFuncData->Calc(&t, Trigonometry, E);
  return Result;
}
//---------------------------------------------------------------------------
/** Update function from symbol list.
 *  \param SymbolList: List of custom functions/constants.
 */
bool TParamFunc::Update(const TSymbolList &SymbolList)
{
  Unique();
  bool Result = xFuncData->Update(SymbolList);
  return !yFuncData->Update(SymbolList) ? false : Result;
}
//---------------------------------------------------------------------------
} //namespace Func32

