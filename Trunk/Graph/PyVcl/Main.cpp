//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "Python.hpp"
#include "PyVcl.h"
#include "PythonBind.h"
#include <Math.hpp>
//---------------------------------------------------------------------------
#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void* lpReserved)
{
  return 1;
}
//---------------------------------------------------------------------------
PyMODINIT_FUNC __stdcall PyInit_vcl(void)
{
  //We need to mask the InvalidOp SSE exception to prevent math.sqrt(-1) in Python from
  //raising a C++ exception. It only seems to be a problem with 64 bit Python.
  SetExceptionMask(GetExceptionMask() << exInvalidOp);
  Application->Initialize();
  return Python::InitPyVcl();
}
//---------------------------------------------------------------------------
/* Replacement for TWinControl::DestroyWindowHandle() in Controls.pas.
 * This does not throw an exception if the window handle cannot be destroyed.
 * This prevents a crash when the console is closed by pressing Ctrl+C or using the
 * button with a cross in top right corner.
 */
void __fastcall TWinControl::DestroyWindowHandle()
{
  if(Touch->GestureEngine != NULL)
    Touch->GestureEngine->Active = false;
  ControlState = ControlState << csDestroyingHandle;
  DestroyWindow(WindowHandle);
  ControlState = ControlState >> csDestroyingHandle;
  WindowHandle = 0;
}
//---------------------------------------------------------------------------
