//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "ICompCommon.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
static TTranslateFunc TranslateFunc = NULL;

WideString TranslateCompText(const WideString &Str)
{
  if(TranslateFunc)
    return TranslateFunc(Str);
  return Str;
}
//---------------------------------------------------------------------------
void SetCompTranslateFunc(TTranslateFunc Func)
{
  TranslateFunc = Func;
}
//---------------------------------------------------------------------------

