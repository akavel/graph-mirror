//---------------------------------------------------------------------------
#include "Config.h"
#include <vcl.h>
#pragma hdrstop
#include "Debug.h"
#include <fstream>
#include <sstream>
#include <iostream>
#include <oledlg.h>
//---------------------------------------------------------------------------
const TNameValue OleUIResultList[] =
{
  NAME_VALUE_ENTRY(OLEUI_FALSE),
  NAME_VALUE_ENTRY(OLEUI_SUCCESS),
  NAME_VALUE_ENTRY(OLEUI_OK),
  NAME_VALUE_ENTRY(OLEUI_CANCEL),
  NAME_VALUE_ENTRY(OLEUI_ERR_STANDARDMIN),
  NAME_VALUE_ENTRY(OLEUI_ERR_OLEMEMALLOC),
  NAME_VALUE_ENTRY(OLEUI_ERR_STRUCTURENULL),
  NAME_VALUE_ENTRY(OLEUI_ERR_STRUCTUREINVALID),
  NAME_VALUE_ENTRY(OLEUI_ERR_CBSTRUCTINCORRECT),
  NAME_VALUE_ENTRY(OLEUI_ERR_HWNDOWNERINVALID),
  NAME_VALUE_ENTRY(OLEUI_ERR_LPSZCAPTIONINVALID),
  NAME_VALUE_ENTRY(OLEUI_ERR_LPFNHOOKINVALID),
  NAME_VALUE_ENTRY(OLEUI_ERR_HINSTANCEINVALID),
  NAME_VALUE_ENTRY(OLEUI_ERR_LPSZTEMPLATEINVALID),
  NAME_VALUE_ENTRY(OLEUI_ERR_HRESOURCEINVALID),
  NAME_VALUE_ENTRY(OLEUI_ERR_FINDTEMPLATEFAILURE),
  NAME_VALUE_ENTRY(OLEUI_ERR_LOADTEMPLATEFAILURE),
  NAME_VALUE_ENTRY(OLEUI_ERR_DIALOGFAILURE),
  NAME_VALUE_ENTRY(OLEUI_ERR_LOCALMEMALLOC),
  NAME_VALUE_ENTRY(OLEUI_ERR_GLOBALMEMALLOC),
  NAME_VALUE_ENTRY(OLEUI_ERR_LOADSTRING),
  NAME_VALUE_ENTRY(OLEUI_ERR_STANDARDMAX+0),
  NAME_VALUE_ENTRY(OLEUI_ERR_STANDARDMAX+1),
  NAME_VALUE_ENTRY(OLEUI_ERR_STANDARDMAX+2),
  NAME_VALUE_ENTRY(OLEUI_ERR_STANDARDMAX+3),
  NAME_VALUE_ENTRY(OLEUI_ERR_STANDARDMAX+4),
  NAME_VALUE_ENTRY(OLEUI_ERR_STANDARDMAX+4),
  NAME_VALUE_ENTRY(OLEUI_ERR_STANDARDMAX+6),
  NAME_VALUE_ENTRY(OLEUI_ERR_STANDARDMAX+7),
  NAME_VALUE_ENTRY(OLEUI_ERR_STANDARDMAX+8),
  NAME_VALUE_ENTRY(OLEUI_ERR_STANDARDMAX+9),
  NAME_VALUE_END
};

const TNameValue HResultList[] =
{
  NAME_VALUE_ENTRY(S_OK),
  NAME_VALUE_ENTRY(DV_E_DVASPECT),
  NAME_VALUE_ENTRY(OLE_S_USEREG),
  NAME_VALUE_ENTRY(E_FAIL),
  NAME_VALUE_ENTRY(E_OUTOFMEMORY),
  NAME_VALUE_ENTRY(DV_E_TYMED),
  NAME_VALUE_ENTRY(STG_E_MEDIUMFULL),
  NAME_VALUE_ENTRY(DV_E_FORMATETC),
  NAME_VALUE_ENTRY(OLEOBJ_S_INVALIDVERB),
  NAME_VALUE_ENTRY(DATA_S_SAMEFORMATETC),
  NAME_VALUE_ENTRY(OLE_E_NOCONNECTION),
  NAME_VALUE_ENTRY(E_UNEXPECTED),
  NAME_VALUE_ENTRY(STG_E_INVALIDFLAG),
  NAME_VALUE_ENTRY(STG_E_FILEALREADYEXISTS),
  NAME_VALUE_ENTRY(STG_E_INVALIDFUNCTION),
  NAME_VALUE_ENTRY(S_FALSE),
  NAME_VALUE_ENTRY(E_NOTIMPL),
  NAME_VALUE_ENTRY(E_INVALIDARG),
  NAME_VALUE_ENTRY(E_NOINTERFACE),
  NAME_VALUE_ENTRY(RPC_E_SERVERFAULT),
  NAME_VALUE_END
};
//---------------------------------------------------------------------------
HRESULT DebugLogFunctionCall(const char *Name, const TNameValue List[], HRESULT Result)
{
#ifndef _DEBUG
  if(FAILED(Result))
#endif
  {
    std::ofstream out(ChangeFileExt(Application->ExeName, ".log").c_str(), std::ios_base::app);
    if(out)
      out << "\n  {" << Name << " : " << ValueToStr(List, Result).c_str() << "} " << std::flush;
  }
  return Result;
}
//---------------------------------------------------------------------------
extern void __stdcall OutputDebugStringA(const char* lpOutputString);
class TDebugStreamBuf : public std::stringbuf
{
protected:
  int sync()
  {
    OutputDebugStringA(str().c_str());
    str("");
    return std::stringbuf::sync();
  }
};
//---------------------------------------------------------------------------
void InitDebug()
{
  static TDebugStreamBuf DebugStreamBuf;
  std::clog.rdbuf(&DebugStreamBuf);
}
//---------------------------------------------------------------------------
AnsiString ValueToStr(const TNameValue List[], unsigned Value)
{
  for(unsigned I = 0; List[I].Name != NULL; I++)
    if(Value == List[I].Value)
      return List[I].Name;
  return "0x" + IntToHex(static_cast<int>(Value), 8);
}
//---------------------------------------------------------------------------
AnsiString FlagsToStr(const TNameValue List[], unsigned Value)
{
  AnsiString Str;
  for(unsigned I = 0; List[I].Name != NULL; I++)
    if(Value & List[I].Value)
      Str += List[I].Name + AnsiString('|');
  return Str.IsEmpty() ? AnsiString(0) : Str;
}
//---------------------------------------------------------------------------

