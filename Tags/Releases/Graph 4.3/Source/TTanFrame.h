/* Graph (http://sourceforge.net/projects/graph)
 * Copyright 2007 Ivan Johansen
 *
 * Graph is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 */
//---------------------------------------------------------------------------
#ifndef TTanFrameH
#define TTanFrameH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "MyEdit.h"
#include "TntStdCtrls.hpp"
#include "TStdFuncFrame.h"
//---------------------------------------------------------------------------
class TTanFrame : public TFrame, public TEvalFrame
{
__published:	// IDE-managed Components
  TTntEdit *Edit2;
  TLabel *Label1;
  TLabel *Label2;
  TMyEdit *Edit1;
private:	// User declarations
  void EvalTan(const TTan *Tan);
  void EvalSeries(const TPointSeries *Series);
  void SetPoint(const TTan *Tan, int X);
  void SetPoint(const TPointSeries *Series, int X);

public:		// User declarations
  __fastcall TTanFrame(TComponent* Owner);
  void Eval(const TGraphElem *Elem);
  void SetPoint(const TGraphElem *Elem, int X, int Y);
  std::string GetErrorPrefix() {return std::string();}
  TFrame* GetFrame() {return this;} //Workaround for nasty compiler bug
};
//---------------------------------------------------------------------------
#endif
