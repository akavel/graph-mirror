/* Graph (http://sourceforge.net/projects/graph)
 * Copyright 2006 Ivan Johansen
 *
 * Graph is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 */
//---------------------------------------------------------------------------
#ifndef Unit9H
#define Unit9H
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include "TStdFuncFrame.h"
#include "TTanFrame.h"
#include "TParFuncFrame.h"
#include "TPolFuncFrame.h"
#include "TAreaFrame.h"
#include "TntStdCtrls.hpp"
//---------------------------------------------------------------------------
enum TEvalType {etEval, etArea, etArc};
class TForm9 : public TTntForm
{
__published:	// IDE-managed Components
  TStdFuncFrame *StdFuncFrame1;
  TTanFrame *TanFrame1;
  TParFuncFrame *ParFuncFrame1;
  TTntLabel *Label1;
  TPolFuncFrame *PolFuncFrame1;
  TAreaFrame *AreaFrame1;
  void __fastcall FormHide(TObject *Sender);
  void __fastcall Edit1Change(TObject *Sender);
  void __fastcall FormShortCut(TWMKey &Msg, bool &Handled);
  void __fastcall FormStartDock(TObject *Sender,
  TDragDockObject *&DragObject);
  void __fastcall FormEndDock(TObject *Sender, TObject *Target, int X, int Y);
  void __fastcall FormResize(TObject *Sender);

private:	// User declarations
    boost::shared_ptr<TGraphElem> Elem;
    TEvalType EvalType;
    int SizeDif; //Difference between Height and ClientHeight
    TVclObject<TTntStringList> StdFuncStrings, ParFuncStrings, PolFuncStrings; 

    void __fastcall Loaded() {VisibleFrame=NULL; TForm::Loaded();} //Prevent crash when resources are reloaded
    void ShowFrame(TFrame *Frame);

public:		// User declarations
    TFrame *VisibleFrame;

    __fastcall TForm9(TComponent* Owner);
    void FuncChanged(const boost::shared_ptr<TGraphElem> &AElem);
    void StartValueChanged(int X, int Y);
    void EndValueChanged(int X, int Y);
    void Clear();
    void SetEvalType(TEvalType AEvalType);
    void Translate();
};
//---------------------------------------------------------------------------
#endif
