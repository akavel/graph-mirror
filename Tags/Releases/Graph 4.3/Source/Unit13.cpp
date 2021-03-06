/* Graph (http://sourceforge.net/projects/graph)
 * Copyright 2007 Ivan Johansen
 *
 * Graph is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 */
//---------------------------------------------------------------------------
#include "Graph.h"
#pragma hdrstop
#include "Unit13.h"
#include "Unit8.h"
//---------------------------------------------------------------------------
#pragma link "LineSelect"
#pragma link "MyRadioButton"
#pragma link "MyEdit"
#pragma link "ExtColorBox"
#pragma link "TntComCtrls"
#pragma link "TntExtCtrls"
#pragma link "TntStdCtrls"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TForm13::TForm13(TComponent* Owner, TData &AData)
        : TTntForm(Owner), Data(AData)
{
  ScaleForm(this);
  TranslateProperties(this);
  TranslateStrings(ExtColorBox1->Items);
  SetAccelerators(this);
  int LabelWidth = TMaxWidth(Label5)(Label6)(Label7);
  if(LabelWidth > 32)
    Width = Width + LabelWidth - 32;
  PageControl1->ActivePage = TabSheet1;
}
//---------------------------------------------------------------------------
void __fastcall TForm13::ImageClick(TObject *Sender)
{
  if(Sender == Image1)
  {
    if(RadioButton1->CanFocus())
      RadioButton1->SetFocus();
  }
  else if(Sender == Image2)
  {
    if(RadioButton2->CanFocus())
      RadioButton2->SetFocus();
  }
  else if(Sender == Image3)
  {
    if(RadioButton3->CanFocus())
      RadioButton3->SetFocus();
  }
  else if(Sender == Image4)
  {
    if(RadioButton4->CanFocus())
      RadioButton4->SetFocus();
  }
  else if(Sender == Image5)
  {
    if(RadioButton5->CanFocus())
      RadioButton5->SetFocus();
  }
  else if(Sender == Image6)
  {
    if(RadioButton6->CanFocus())
      RadioButton6->SetFocus();
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm13::EditKeyPress(TObject *Sender, char &Key)
{
  if(!isdigit(Key) && Key != '\b')
    Key = 0;
}
//---------------------------------------------------------------------------
void __fastcall TForm13::Button1Click(TObject *Sender)
{
  if(ToIntDef(Edit1->Text, -1) < 0)
  {
    Edit1->SetFocus();
    MessageBox(LoadRes(RES_LIMIT_ZERO, StaticText1->Caption), LoadRes(RES_ERROR_IN_VALUE));
    return;
  }

  if(ToIntDef(Edit2->Text, -1) < 1)
  {
    Edit2->SetFocus();
    MessageBox(LoadRes(RES_INT_GREATER_ZERO, Label5->Caption), LoadRes(RES_ERROR_IN_VALUE));
    return;
  }

  try
  {
    boost::shared_ptr<TBaseFuncType> BaseFunc;

    //We need to create a copy to be compatible with the Regression(), MovingAverage() and TrendLine() functions
    std::vector<Func32::TDblPoint> Points;
    Points.reserve(Series->PointList.size());
    for(std::vector<TPointSeriesPoint>::const_iterator Iter = Series->PointList.begin(); Iter != Series->PointList.end(); ++Iter)
      Points.push_back(Func32::TDblPoint(Iter->x.Value, Iter->y.Value));

    if(PageControl1->TabIndex == 1)
    {
      std::vector<std::string> Arguments = Func32::FindUnknowns(ToString(Edit3->Text));
      std::vector<long double> Values(Arguments.size(), 1);

      if(ListBox1->ItemIndex != -1)
      {
        for(unsigned I = 0; I < Data.UserModels[ListBox1->ItemIndex].Defaults.size(); I++)
          Values[I] = Data.UserModels[ListBox1->ItemIndex].Defaults[I].second;
      }

      Arguments.insert(Arguments.begin(), "x");
      Func32::TCustomFunc TempFunc(ToString(Edit3->Text), Arguments, Data.CustomFunctions.SymbolList, Data.Axes.Trigonometry);
      Regression(Points, TempFunc, Values);

      boost::shared_ptr<TStdFunc> Func(new TStdFunc(TempFunc.ConvToFunc(Values, 0)));
      Func->SetLegendText(Func->MakeText() + L"; R�=" + ToWString(RoundToString(Correlation(Points, Func->GetFunc()), Data)));
      Func->From.Value = -INF;
      Func->To.Value = +INF;
      Func->SetSteps(TTextValue(0, ""));
      BaseFunc = Func;
    }
    else if(RadioButton6->Checked) //Moving average
    {
      if(ToInt(Edit4->Text) == 0)
      {
        MessageBox(LoadRes(RES_INT_GREATER_ZERO, StaticText2->Caption), LoadRes(RES_ERROR_IN_VALUE));
        return;
      }

      unsigned N = ToInt(Edit4->Text);
      boost::shared_ptr<TParFunc> Func(new TParFunc(Func32::MovingAverage(Points, N)));
      Func->From.Value = 0;
      Func->From.Text = "0";
      Func->To.Value = Points.size() - N;
      Func->To.Text = ToString(Func->To.Value);
      Func->SetSteps(TTextValue(1000));
      BaseFunc = Func;
    }
    else
    {
      Func32::TTrendType Type;
      if(RadioButton1->Checked)
        Type = Func32::ttLinear;
      else if(RadioButton2->Checked)
        Type = Func32::ttLogarithmic;
      else if(RadioButton3->Checked)
        Type = Func32::ttPolynomial;
      else if(RadioButton4->Checked)
        Type = Func32::ttPower;
      else if(RadioButton5->Checked)
        Type = Func32::ttExponential;
      else
        throw Exception("No radio button selected!");

      unsigned N = ToInt(Edit1->Text);
      //WARNING: Do not initialize Func with pointer. It will crash if Trendline() fails because of bug in Bcc 5.6.4
      boost::shared_ptr<TStdFunc> Func;
      if(CheckBox1->Checked)
        Func.reset(new TStdFunc(TrendLine(Type, Points, N, MakeFloat(Edit5))));
      else
        Func.reset(new TStdFunc(TrendLine(Type, Points, N)));
      Func->SetLegendText(Func->MakeText() + L"; R�=" + ToWString(RoundToString(Correlation(Points, Func->GetFunc()), Data)));
      Func->From.Value = -INF;
      Func->To.Value = +INF;
      Func->SetSteps(TTextValue(0, ""));
      BaseFunc = Func;
    }

    BaseFunc->Color = ExtColorBox1->Selected;
    BaseFunc->Size = ToInt(Edit2->Text);
    BaseFunc->Style = LineSelect1->LineStyle;
    Data.Add(BaseFunc);
    UndoList.Push(TUndoAdd(BaseFunc));
  }
  catch(Func32::EFuncError &Error)
  {
    if(PageControl1->TabIndex == 1)
      ShowErrorMsg(Error, Edit3);
    else
      ShowErrorMsg(Error);
    return;
  }

  Data.Property.DefaultTrendline.Set(LineSelect1->LineStyle, ExtColorBox1->Selected, ToInt(Edit2->Text));
  ModalResult = mrOk;
}
//---------------------------------------------------------------------------
void __fastcall TForm13::Button3Click(TObject *Sender)
{
  Application->HelpContext(HelpContext);
}
//---------------------------------------------------------------------------
void TForm13::ShowUserModels()
{
  for(unsigned I = 0; I < Data.UserModels.size(); I++)
    ListBox1->AddItem(Data.UserModels[I].Name.c_str(), NULL);
}
//---------------------------------------------------------------------------
void __fastcall TForm13::ListBox1Click(TObject *Sender)
{
  Edit3->Text = Data.UserModels[ListBox1->ItemIndex].Model.c_str();
  Button5->Enabled = true;
  Button6->Enabled = true;
}
//---------------------------------------------------------------------------
void __fastcall TForm13::Button4Click(TObject *Sender)
{
  try
  {
    TUserModel UserModel;
    UserModel.Model = ToString(Edit3->Text);
    Func32::TSymbolList SymbolList;
    std::vector<std::string> Unknowns = Func32::FindUnknowns(ToString(Edit3->Text));

    std::auto_ptr<TForm8> Form8(new TForm8(Application, Data, -1));
    for(unsigned I = 0; I < Unknowns.size(); I++)
    {
      Form8->ValueListEditor1->Values[Unknowns[I].c_str()] = 1;
      SymbolList.Add(Unknowns[I]);
    }

    Func32::TFunc Func(ToString(Edit3->Text), "x", SymbolList);
    if(Form8->ShowModal() == mrOk)
    {
      for(Func32::TSymbolList::TIterator Iter = SymbolList.Begin(); Iter != SymbolList.End(); ++Iter)
        UserModel.Defaults.push_back(std::make_pair(Iter->first, Form8->ValueListEditor1->Values[Iter->first.c_str()].ToDouble()));

      UserModel.Name = ToWString(Form8->Edit1->Text);
      Data.UserModels.push_back(UserModel);
      ListBox1->Items->Add(UserModel.Name.c_str());
      ListBox1->ItemIndex = ListBox1->Items->Count - 1;
    }
  }
  catch(Func32::EFuncError &Error)
  {
    Edit3->SetFocus();
    ShowErrorMsg(Error, Edit3);
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm13::Button6Click(TObject *Sender)
{
  if(ListBox1->ItemIndex == -1)
    return;

  TForm8 *Form8 = new TForm8(Application, Data, ListBox1->ItemIndex);
  TUserModel &UserModel = Data.UserModels[ListBox1->ItemIndex];

  Form8->Caption = LoadRes(503);
  Form8->Edit1->Text = UserModel.Name.c_str();
  for(unsigned I = 0; I < UserModel.Defaults.size(); I++)
    Form8->ValueListEditor1->Values[UserModel.Defaults[I].first.c_str()] = UserModel.Defaults[I].second;

  if(Form8->ShowModal() == mrOk)
  {
    for(unsigned I = 0; I < UserModel.Defaults.size(); I++)
    UserModel.Defaults[I].second = Form8->ValueListEditor1->Values[UserModel.Defaults[I].first.c_str()].ToDouble();

    UserModel.Name = ToWString(Form8->Edit1->Text);
    ListBox1->Items->Strings[ListBox1->ItemIndex] = UserModel.Name.c_str();
  }
  delete Form8;
}
//---------------------------------------------------------------------------
void __fastcall TForm13::Button5Click(TObject *Sender)
{
  if(ListBox1->ItemIndex == -1)
    return;

  if(MessageBox(LoadRes(RES_DELETE_MODEL, ListBox1->Items->Strings[ListBox1->ItemIndex]), LoadRes(RES_CAPTION_DELETE), MB_ICONQUESTION | MB_YESNO) == IDYES)
  {
    Data.UserModels.erase(Data.UserModels.begin() + ListBox1->ItemIndex);
    ListBox1->Items->Delete(ListBox1->ItemIndex);
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm13::Edit3Change(TObject *Sender)
{
  if(Edit3->Focused())
  {
    ListBox1->ItemIndex = -1;
    Button5->Enabled = false;
    Button6->Enabled = false;
  }
}
//---------------------------------------------------------------------------
int TForm13::InsertTrendline(const boost::shared_ptr<TPointSeries> &ASeries)
{
  Series = ASeries;

  bool NegXFound = false;
  bool NegYFound = false;

  for(std::vector<TPointSeriesPoint>::const_iterator i = Series->PointList.begin(); i != Series->PointList.end(); ++i)
  {
    if(i->x <= 0)
    {
      NegXFound = true;
      if(NegYFound)
        break;
    }
    if(i->y <= 0)
    {
      NegYFound = true;
      if(NegXFound)
        break;
    }
  }

  if(NegXFound)
  {
    RadioButton2->Enabled = false;
    RadioButton4->Enabled = false;
  }
  if(NegYFound)
  {
    RadioButton4->Enabled = false;
    RadioButton5->Enabled = false;
  }

  LineSelect1->LineStyle = static_cast<TPenStyle>(Data.Property.DefaultTrendline.Style);
  ExtColorBox1->Selected = Data.Property.DefaultTrendline.Color;
  UpDown1->Position = Data.Property.DefaultTrendline.Size;

  UpDown2->Max = Series->PointList.size() - 1;
  UpDown3->Max = Series->PointList.size() - 1;

  ShowUserModels();
  return ShowModal();
}
//---------------------------------------------------------------------------
void __fastcall TForm13::RadioButtonClick(TObject *Sender)
{
  Edit1->Enabled = RadioButton3->Checked;
  UpDown2->Enabled = RadioButton3->Checked;

  Edit4->Enabled = RadioButton6->Checked;
  UpDown3->Enabled = RadioButton6->Checked;

  if((RadioButton1->Checked || RadioButton3->Checked || RadioButton5->Checked) && PageControl1->ActivePage == TabSheet1)
  {
    CheckBox1->Enabled = true;
    Edit5->Enabled = true;
    Edit5->Color = clWindow;
  }
  else
  {
    CheckBox1->Enabled = false;
    Edit5->Enabled = false;
    Edit5->Color = clBtnFace;
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm13::Edit5Change(TObject *Sender)
{
  CheckBox1->Checked = true;
}
//---------------------------------------------------------------------------
void __fastcall TForm13::CheckBox1Click(TObject *Sender)
{
  //This check is needed because this function may be called as part of the form initialization
  if(Series)
  {
    if(CheckBox1->Checked)
      UpDown2->Max = Series->PointList.size();
    else
      UpDown2->Max = Series->PointList.size() - 1;
  }
}
//---------------------------------------------------------------------------


