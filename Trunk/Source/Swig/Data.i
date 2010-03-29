%module Data
#define SWIG_NO_EXPORT_ITERATOR_METHODS

%include "stl.i"
%include "std_string.i"
%include "std_wstring.i"
%include "boost_shared_ptr.i"
%include "attribute.i"
%include "Types.i"

%pythonnondynamic;

%template(PointVector) std::vector<TPoint>;
%template(CoordSetVector) std::vector<Func32::TCoordSet<> >;
%template(UnsignedVector) std::vector<unsigned>;
%template(StringMap) std::map<std::wstring,std::wstring>;

%begin %{
#include "Graph.h"
#include "Unit1.h"
#undef _DEBUG
#include <Python.h>
#define WRAP_PYOBJECTS
#include "PythonBind.h"
#include "PyGraph.h"
#include "PythonBind.h"
#pragma warn -8060
%}

%define CHECK_GRAPH_ELEM(TType)
  if(dynamic_cast<TType*>(Ptr))
    return SWIG_NewPointerObj(new boost::shared_ptr<TType>(boost::static_pointer_cast<TType>(Elem)), SWIGTYPE_p_boost__shared_ptrT_##TType##_t, SWIG_POINTER_OWN |  0 );
%enddef

%header {
PyObject* DownCastSharedPtr(const boost::shared_ptr<TGraphElem> &Elem)
{
  TGraphElem *Ptr = Elem.get();
  if(Ptr == NULL)
    return SWIG_Py_Void();
  CHECK_GRAPH_ELEM(TStdFunc)
  CHECK_GRAPH_ELEM(TParFunc)
  CHECK_GRAPH_ELEM(TPolFunc)
  CHECK_GRAPH_ELEM(TTan)
  CHECK_GRAPH_ELEM(TPointSeries)
  CHECK_GRAPH_ELEM(TTextLabel)
  CHECK_GRAPH_ELEM(TShading)
  CHECK_GRAPH_ELEM(TRelation)
  CHECK_GRAPH_ELEM(TAxesView)
  CHECK_GRAPH_ELEM(TTopGraphElem)
  return SWIG_NewPointerObj(new boost::shared_ptr< TGraphElem >(Elem), SWIGTYPE_p_boost__shared_ptrT_TGraphElem_t, SWIG_POINTER_OWN |  0 );
}
}

HANDLE_FPU(Redraw)
HANDLE_FPU(InsertDblPoint)
HANDLE_FPU(ReplaceDblPoint)
HANDLE_FPU(TStdFunc::TStdFunc)
HANDLE_FPU(TParFunc::TParFunc)
HANDLE_FPU(TPolFunc::TPolFunc)

typedef boost::shared_ptr<class TGraphElem> TGraphElemPtr;

%inline %{
static void AbortUpdate() {Form1->Data.AbortUpdate();}
static void Redraw() {Form1->Redraw();}
static TGraphElemPtr GetSelected() {return Form1->GetSelected();}
static void SetSelected(const TGraphElemPtr &Elem) {Form1->SetSelected(Elem);}

static unsigned ChildCount(const TGraphElemPtr &Elem) {return Elem->ChildCount();}
static TGraphElemPtr GetChild(const TGraphElemPtr &Elem, unsigned Index) {return Elem->GetChild(Index);}
static void RemoveChild(const TGraphElemPtr &Elem, unsigned Index) {Elem->RemoveChild(Index); Form1->UpdateTreeView();}
static void InsertChild(TGraphElemPtr Elem, TGraphElemPtr Child, int Index) {Elem->InsertChild(Child, Index); Form1->UpdateTreeView();}
static void ReplaceChild(const TGraphElemPtr &Elem, unsigned Index, const TGraphElemPtr &Child) {Elem->ReplaceChild(Index, Child); Form1->UpdateTreeView();}
static bool CompareElem(const TGraphElemPtr &E1, const TGraphElemPtr &E2) {return E1.get() == E2.get();}
static std::map<std::wstring,std::wstring>& GetPluginData() {return Form1->Data.PluginData;}
static const boost::shared_ptr<TTopGraphElem>& GetTopElem() {return Form1->Data.GetTopElem();}
%}

SWIG_SHARED_PTR(TGraphElem, TGraphElem)
SWIG_SHARED_PTR_DERIVED(TTopGraphElem, TGraphElem, TTopGraphElem)
SWIG_SHARED_PTR_DERIVED(TBaseFuncType, TGraphElem, TBaseFuncType)
SWIG_SHARED_PTR_DERIVED(TStdFunc, TBaseFuncType, TStdFunc)
SWIG_SHARED_PTR_DERIVED(TParFunc, TBaseFuncType, TParFunc)
SWIG_SHARED_PTR_DERIVED(TPolFunc, TBaseFuncType, TPolFunc)
SWIG_SHARED_PTR_DERIVED(TTan, TBaseFuncType, TTan)
SWIG_SHARED_PTR_DERIVED(TPointSeries, TGraphElem, TPointSeries)
SWIG_SHARED_PTR_DERIVED(TTextLabel, TGraphElem, TTextLabel)
SWIG_SHARED_PTR_DERIVED(TShading, TGraphElem, TShading)
SWIG_SHARED_PTR_DERIVED(TRelation, TGraphElem, TRelation)
SWIG_SHARED_PTR_DERIVED(TAxesView, TGraphElem, TAxesView)

%nodefaultctor TGraphElem;
%attribute(TGraphElem, int, Visible, GetVisible, SetVisible);
%attribute(TGraphElem, bool, ShowInLegend, GetShowInLegend, SetShowInLegend);
%attributestring(TGraphElem, std::wstring, LegendText, GetLegendText, SetLegendText);
%attributestring(TGraphElem, TGraphElemPtr, Parent, GetParent);
%rename(_PluginData) PluginData;
class TGraphElem
{
public:
  std::map<std::wstring,std::wstring> PluginData;
  std::wstring MakeLegendText() const;
  std::wstring MakeText() const;
};

%extend TGraphElem
{
  int ThisPtr() const {return reinterpret_cast<int>(self);}
  %pythoncode %{
    def __eq__(self, rhs):
      if not isinstance(rhs, TGraphElem): return False
      return self.ThisPtr() == rhs.ThisPtr()
  %}
}


enum TDrawType {dtAuto, dtDots, dtLines};
typedef unsigned TPenStyle;

%nodefaultctor TBaseFuncType;
%attributeval(TBaseFuncType, %arg(std::pair<double,double>), CurrentRange, GetCurrentRange);
%attributestring(TBaseFuncType, TTextValue, Steps, GetSteps, SetSteps);
%attributestring(TBaseFuncType, std::wstring, Variable, GetVariable);
class TBaseFuncType : public TGraphElem
{
public:
  std::vector<Func32::TCoordSet<> > sList;
  std::vector<TPoint> Points;
  std::vector<unsigned> PointNum;
  TColor Color;
  unsigned Size;
  TPenStyle Style;
  TTextValue From, To;
  unsigned StartPointStyle, EndPointStyle;
  TDrawType DrawType;

  boost::shared_ptr<TBaseFuncType> MakeDifFunc();
  Func32::TCoord<long double> Eval(long double t);
  long double CalcArea(long double From, long double To) const;
};

%nodefaultctor TTopGraphElem;
class TTopGraphElem : public TGraphElem
{
};

%attributestring(TStdFunc, std::wstring, Text, GetText);
class TStdFunc : public TBaseFuncType
{
};

%extend TStdFunc {
  TStdFunc(const std::wstring &Str) throw(Func32::EFuncError)
  {
    return new TStdFunc(Str, Form1->Data.CustomFunctions.SymbolList, Form1->Data.Axes.Trigonometry);
  }
}

%nodefaultctor TParFunc;
%attributestring(TParFunc, std::wstring, xText, GetxText);
%attributestring(TParFunc, std::wstring, yText, GetyText);
class TParFunc : public TBaseFuncType
{
};

%extend TParFunc {
  TParFunc(const std::wstring &xStr, const std::wstring &yStr) throw(Func32::EFuncError)
  {
    return new TParFunc(xStr, yStr, Form1->Data.CustomFunctions.SymbolList, Form1->Data.Axes.Trigonometry);
  }
}

%nodefaultctor TPolFunc;
%attributestring(TPolFunc, std::wstring, Text, GetText);
class TPolFunc : public TBaseFuncType
{
};

%extend TPolFunc {
  TPolFunc(const std::wstring &Str) throw(Func32::EFuncError)
  {
    return new TPolFunc(Str, Form1->Data.CustomFunctions.SymbolList, Form1->Data.Axes.Trigonometry);
  }
}

enum TTangentType {ttTangent, ttNormal};
%attribute(TTan, bool, Valid, IsValid);
class TTan : public TBaseFuncType
{
public:
  TTextValue t;
  TTangentType TangentType;
};

enum TErrorBarType {ebtNone, ebtFixed, ebtRelative, ebtCustom};
enum TInterpolationAlgorithm {iaLinear, iaCubicSpline, iaHalfCosine};
//enum TLabelPosition {lpAbove, lpBelow, lpLeft, lpRight, lpAboveLeft, lpAboveRight, lpBelowLeft, lpBelowRight};
enum TPointType {ptCartesian, ptPolar};

HANDLE_FPU(TPointSeries::GetDblPoint)

%attribute(TPointSeries, TErrorBarType, xErrorBarType, GetxErrorBarType, SetxErrorBarType);
%attribute(TPointSeries, TErrorBarType, yErrorBarType, GetyErrorBarType, SetyErrorBarType);
%attribute(TPointSeries, double, xErrorValue, GetxErrorValue, SetxErrorValue);
%attribute(TPointSeries, double, yErrorValue, GetyErrorValue, SetyErrorBarType);
%attribute(TPointSeries, TColor, FillColor, GetFillColor, SetFillColor);
%attribute(TPointSeries, TColor, LineColor, GetLineColor, SetLineColor);
%attribute(TPointSeries, TColor, FrameColor, GetFrameColor, SetFrameColor);
%attribute(TPointSeries, unsigned, Size, GetSize, SetSize);
%attribute(TPointSeries, unsigned, Style, GetStyle, SetStyle);
%attribute(TPointSeries, unsigned, LineSize, GetLineSize, SetLineSize);
%attribute(TPointSeries, unsigned, LineStyle, GetLineStyle, SetLineStyle);
%attribute(TPointSeries, TInterpolationAlgorithm, Interpolation, GetInterpolation, SetInterpolation);
%attribute(TPointSeries, bool, ShowLabels, GetShowLabels, SetShowLabels);
%attribute(TPointSeries, TFont*, Font, GetFont);
%attribute(TPointSeries, unsigned, LabelPosition, GetLabelPosition, SetLabelPosition);
%attribute(TPointSeries, TPointType, PointType, GetPointType, SetPointType);
class TPointSeries : public TGraphElem
{
public:
  void InsertDblPoint(const Func32::TDblPoint &Point, int Index) throw(std::out_of_range);
  void InsertPoint(TPointSeriesPoint Point, int Index) throw(std::out_of_range);
  void ReplaceDblPoint(const Func32::TDblPoint &Point, unsigned Index) throw(std::out_of_range);
  void ReplacePoint(TPointSeriesPoint Point, unsigned Index) throw(std::out_of_range);
  void DeletePoint(unsigned Index) throw(std::out_of_range);
  const Func32::TDblPoint& GetDblPoint(unsigned Index) const throw(std::out_of_range);
  const TPointSeriesPoint& GetPoint(unsigned Index) const throw(std::out_of_range);
  unsigned PointCount() const;
};

enum TLabelPlacement {lpUserTopLeft, lpAboveX, lpBelowX, lpLeftOfY, lpRightOfY, lpUserTopRight, lpUserBottomLeft, lpUserBottomRight};

%attribute(TTextLabel, TRect, Rect, GetRect);
%attribute(TTextLabel, TTextValue, xPos, GetXPos, SetXPos);
%attribute(TTextLabel, TTextValue, yPos, GetYPos, SetYPos);
%attributestring(TTextLabel, std::string, Text, GetText, SetText);
%attribute(TTextLabel, TColor, BackgroundColor, GetBackgroundColor, SetBackgroundColor);
%attribute(TTextLabel, TLabelPlacement, Placement, GetPlacement, SetPlacement);
%attribute(TTextLabel, unsigned, Rotation, GetRotation, SetRotation);
class TTextLabel : public TGraphElem
{
public:
  void Scale(double xSizeMul, double ySizeMul);
  TMetafile* GetImage() const {return Metafile;}
};

enum TShadeStyle {ssAbove, ssBelow, ssXAxis, ssYAxis, ssBetween, ssInside};
class TShading : public TGraphElem
{
public:
  TShadeStyle ShadeStyle;
  TBrushStyle BrushStyle;
  TColor Color;
  boost::shared_ptr<TBaseFuncType> Func2;
  TTextValue sMin;
  TTextValue sMax;
  TTextValue sMin2;
  TTextValue sMax2;
  bool ExtendMinToIntercept;
  bool ExtendMaxToIntercept;
  bool ExtendMin2ToIntercept;
  bool ExtendMax2ToIntercept;
  bool MarkBorder;
};

enum TRelationType {rtEquation, rtInequality};

%attribute(TRelation, TColor, Color, GetColor, SetColor);
%attribute(TRelation, TBrushStyle, BrushStyle, GetBrushStyle, SetBrushStyle);
%attribute(TRelation, TRelationType, RelationType, GetRelationType);
%attributestring(TRelation, std::wstring, Text, GetText);
%attributestring(TRelation, std::wstring, Constraints, GetConstraints);
%attribute(TRelation, unsigned, Size, GetSize, SetSize);
class TRelation : public TGraphElem
{
public:
  long double Eval(long double x, long double y) throw(Func32::EFuncError);
};

%extend TRelation {
  TRelation(const std::wstring &Str, const std::wstring &ConstraintsStr) throw(Func32::EFuncError)
  {
    return new TRelation(Str, ConstraintsStr, Form1->Data.CustomFunctions.SymbolList, Form1->Data.Axes.Trigonometry);
  }
  TRelation(const std::wstring &Str) throw(Func32::EFuncError)
  {
    return new TRelation(Str, L"", Form1->Data.CustomFunctions.SymbolList, Form1->Data.Axes.Trigonometry);
  }
}

%nodefaultctor TAxesView;
class TAxesView : public TGraphElem
{
};

%nodefaultctor TData;
%nodefaultdtor TData;
struct TData
{
  const TAxes Axes;
};

%{
  PyObject* ToPyObject(TData &Data)
  {
    Python::TLockGIL Dummy;
    return Python::IsPythonInstalled() ? SWIG_NewPointerObj(SWIG_as_voidptr(&Data), SWIGTYPE_p_TData, 0) : NULL;
  }
%}

%pythoncode
{
  import vcl
  def GraphElemRepr(self):
    return '%s("%s")' % (self.__class__.__name__, self.MakeText())
  TStdFunc.__repr__ = GraphElemRepr
  TParFunc.__repr__ = GraphElemRepr
  TPolFunc.__repr__ = GraphElemRepr
  TTan.__repr__ = GraphElemRepr
  TPointSeries.__repr__ = GraphElemRepr
  TRelation.__repr__ = GraphElemRepr
  TTextLabel.__repr__ = GraphElemRepr
  TShading.__repr__ = GraphElemRepr
  TAxesView.__repr__ = GraphElemRepr
  TTopGraphElem.__repr__ = GraphElemRepr
  TPointSeries.Font = property(lambda self: vcl.TObject(handle=_Data.TPointSeries_Font_get(self), owned=False))
  def SetPoints(self, L):
    while len(self.Points) > 0: del self.Points[0]
    for n in L: self.Points.append(n)
  TPointSeries.__swig_setmethods__["Points"] = SetPoints
  TPointSeries.__swig_getmethods__["Points"] = lambda self: TPointDataList(self)
  TPointSeries.__swig_getmethods__["PointData"] = lambda self: TPointList(self)

  import collections
  class TPointList(collections.MutableSequence):
      def __init__(self, PointSeries):
          self.PointSeries = PointSeries
      def __getitem__(self, key):
          return self.PointSeries.GetPoint(key)
      def __len__(self):
          return self.PointSeries.PointCount()
      def insert(self, key, value):
          self.PointSeries.InsertPoint(value, key)
      def __setitem__(self, key, value):
          self.PointSeries.ReplacePoint(value, key)
      def append(self, value):
          self.PointSeries.InsertPoint(value, -1)
      def __delitem__(self, key):
          self.PointSeries.DeletePoint(key)
      def __repr__(self):
          return repr(list(self))

  class TPointDataList(collections.MutableSequence):
      def __init__(self, PointSeries):
          self.PointSeries = PointSeries
      def __getitem__(self, key):
          return self.PointSeries.GetDblPoint(key)
      def __len__(self):
          return self.PointSeries.PointCount()
      def insert(self, key, value):
          self.PointSeries.InsertDblPoint(value, key)
      def __setitem__(self, key, value):
          self.PointSeries.ReplaceDblPoint(value, key)
      def append(self, value):
          self.PointSeries.InsertDblPoint(value, -1)
      def __delitem__(self, key):
          self.PointSeries.DeletePoint(key)
      def __repr__(self):
          return repr(list(self))
}


