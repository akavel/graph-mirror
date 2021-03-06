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
#include "Python.hpp"
#include <structmember.h>
#define private public
#include <Rtti.hpp>
#undef private
#include "PyVclObject.h"
#include "PyVclMethod.h"
#include "PyVcl.h"
#include "PyVclConvert.h"
#include "PyVclArrayProperty.h"
#include "PyVclRef.h"

namespace Python
{
//---------------------------------------------------------------------------
class TObjectDeleteHandler : public TComponent
{
	std::deque<TVclObject*> Objects;
public:
	__fastcall TObjectDeleteHandler(TComponent *AOwner) : TComponent(AOwner)
	{
		Name = L"ObjectDeleteHandler";
	}

	__fastcall ~TObjectDeleteHandler()
	{
		for(std::deque<TVclObject*>::iterator Iter = Objects.begin(); Iter != Objects.end(); ++Iter)
		{
			(*Iter)->Instance = NULL;
			(*Iter)->Owned = false;
    }
	}

	void Register(TVclObject *VclObject) {Objects.push_back(VclObject);}
	void Unregister(TVclObject *VclObject)
	{
		std::deque<TVclObject*>::iterator Iter = std::find(Objects.begin(), Objects.end(), VclObject);
		if(Iter != Objects.end())
		  Objects.erase(Iter);
	}
};
//---------------------------------------------------------------------------
void CreateDeleteHandler(TVclObject *VclObject)
{
	if(TComponent *Component = dynamic_cast<TComponent*>(VclObject->Instance))
	{
		TObjectDeleteHandler *DeleteHandler =
			dynamic_cast<TObjectDeleteHandler*>(Component->FindComponent("ObjectDeleteHandler"));
		if(DeleteHandler == NULL)
			DeleteHandler = new TObjectDeleteHandler(Component);
		DeleteHandler->Register(VclObject);
	}
}
//---------------------------------------------------------------------------
void RemoveDeleteHandler(TVclObject *VclObject)
{
	if(TComponent *Component = dynamic_cast<TComponent*>(VclObject->Instance))
	{
		if(TObjectDeleteHandler *DeleteHandler =
			dynamic_cast<TObjectDeleteHandler*>(Component->FindComponent("ObjectDeleteHandler")))
				DeleteHandler->Unregister(VclObject);
  }
}
//---------------------------------------------------------------------------
struct TPythonCallback : public TCppInterfacedObject<TMethodImplementationCallback>
{
	void __fastcall Invoke(void * UserData, System::DynamicArray<TValue> Args, TValue &Result);
};
TPythonCallback *PythonCallback = new TPythonCallback;
//---------------------------------------------------------------------------
void __fastcall TPythonCallback::Invoke(void * UserData, System::DynamicArray<TValue> Args, TValue &Result)
{
	TLockGIL Dummy;
	TMethodImplementation *Impl = static_cast<TMethodImplementation*>(Args[0].AsObject());
	TMethodImplementation::TInvokeInfo *InvokeInfo = Impl->FInvokeInfo;
	DynamicArray<TMethodImplementation::TParamLoc> Params = InvokeInfo->GetParamLocs();
	PyObject *Object = static_cast<PyObject*>(UserData);
	int Count = Args.get_length() - 1;
	PyObject *PyArgs = Count != 0 ? PyTuple_New(Count) : NULL;
	for(int I = 0; I < Count; I++)
		PyTuple_SET_ITEM(PyArgs, I, Params[I+1].FByRefParam ? VclRef_Create(&Args[I+1]) : ToPyObject(Args[I+1]));
	PyObject *PyResult = PyObject_CallObject(Object, PyArgs);
	Py_XDECREF(PyArgs);
	if(PyResult != NULL && PyResult != Py_None)
		Result = ToValue(PyResult, NULL); //Bug: Type of result missing
	Py_XDECREF(PyResult);
	if(PyResult == NULL)
	  PyErr_Print();
}
//---------------------------------------------------------------------------
class TImplementationOwner : public TComponent
{
	TMethodImplementation *Impl;
public:
	TImplementationOwner(TComponent *AOwner, TMethodImplementation *AImpl)
		: TComponent(AOwner), Impl(AImpl) {}
	__fastcall ~TImplementationOwner()
	{
    Py_DECREF(static_cast<PyObject*>(Impl->FUserData));
		delete Impl->FInvokeInfo;
   	delete Impl;
	}
};
//---------------------------------------------------------------------------
TMethodImplementation::TInvokeInfo* CreateInvokeInfo(TTypeInfo *TypeInfo)
{
	TTypeData *TypeData = reinterpret_cast<TTypeData*>(&TypeInfo->Name[TypeInfo->Name[0]+1]);
	int Index = 0;
	std::vector<Typinfo::TParamFlags> ParamFlags;
	for(int I = 0; I < TypeData->ParamCount; I++)
	{
		ParamFlags.push_back(reinterpret_cast<Typinfo::TParamFlags&>(TypeData->ParamList[Index++]));
		Index += TypeData->ParamList[Index] + 1;
		Index += TypeData->ParamList[Index] + 1;
	}
	if(TypeData->MethodKind == mkFunction)
	{
		Index += TypeData->ParamList[Index] + 1;
		Index += 4;
	}
	Typinfo::TCallConv CallConv = static_cast<Typinfo::TCallConv>(TypeData->ParamList[Index]);
	Index++;
	TMethodImplementation::TInvokeInfo *InvokeInfo = new TMethodImplementation::TInvokeInfo(CallConv, true);
	InvokeInfo->AddParameter(__delphirtti(TObject), false);
	for(int I = 0; I < TypeData->ParamCount; I++)
	{
		TTypeInfo *ParamType = **(TTypeInfo***)&TypeData->ParamList[Index];
		InvokeInfo->AddParameter(ParamType, ParamFlags[I].Contains(Typinfo::pfVar));
		Index += 4;
	}
	InvokeInfo->Seal();
	return InvokeInfo;
}
//---------------------------------------------------------------------------
static PyObject *VclObject_Repr(TVclObject* self)
{
	try
	{
		String Str;
		TComponent *Component = dynamic_cast<TComponent*>(self->Instance);
		if(self->Instance == NULL)
			Str = "<Reference to released object>";
		else if(Component != NULL)
			Str = "<object '" + Component->Name + "' of type '" + Component->ClassName() + "'>";
		else
			Str = "<object of type '" + self->Instance->ClassName() + "'>";
		return PyUnicode_FromUnicode(Str.c_str(), Str.Length());
	}
	catch(...)
	{
		return PyVclHandleException();
	}
}
//---------------------------------------------------------------------------
static PyObject* VclObject_Dir(TVclObject *self, PyObject *arg)
{
	PyObject *List = PyList_New(0);
	if(self->Instance != NULL)
	{
		TRttiType *Type = Context.GetType(self->Instance->ClassType());
		DynamicArray<TRttiProperty*> Properties = Type->GetProperties();
		DynamicArray<TRttiMethod*> Methods = Type->GetMethods();
		DynamicArray<TRttiField*> Fields = Type->GetFields();
		int PropertyCount = Properties.Length;
		int MethodCount = Methods.Length;
		int FieldCount = Fields.Length;
		PyObject *Value;
		for(int I = 0; I < PropertyCount; I++)
		{
			Value = ToPyObject(Properties[I]->Name);
			if(!PySequence_Contains(List, Value))
				PyList_Append(List, Value);
			Py_DECREF(Value);
		}
		for(int I = 0; I < MethodCount; I++)
		{
			Value = ToPyObject(Methods[I]->Name);
			if(!PySequence_Contains(List, Value))
				PyList_Append(List, Value);
			Py_DECREF(Value);
		}
		for(int I = 0; I < FieldCount; I++)
			if(Fields[I]->Visibility == mvPublic)
			{
				Value = ToPyObject(Fields[I]->Name);
				PyList_Append(List, Value);
				Py_DECREF(Value);
			}
	}
	return List;
}
//---------------------------------------------------------------------------
static void VclObject_Dealloc(TVclObject* self)
{
	if(self->Owned)
	{
		if(TWinControl *Control = dynamic_cast<TWinControl*>(self->Instance))
			while(Control->ControlCount)
				Control->Controls[Control->ControlCount-1]->Parent = NULL;
		delete self->Instance;
	}
	else if(TComponent *Component = dynamic_cast<TComponent*>(self->Instance))
		RemoveDeleteHandler(self);
	Py_TYPE(self)->tp_free(reinterpret_cast<PyObject*>(self));
}
//---------------------------------------------------------------------------
PyObject* VclObject_GetAttro(TVclObject *self, PyObject *attr_name)
{
	try
	{
		if(self->Instance == NULL)
			throw EPyVclError("Referenced object has been deleted.");

		TObject *Object = self->Instance;
		String Name = PyUnicode_AsUnicode(attr_name);
		TRttiType *Type = Context.GetType(Object->ClassType());
		if(Type == NULL)
			throw EPyVclError("Type not found.");
		TRttiProperty *Property = Type->GetProperty(Name);
		if(Property == NULL)
		{
			DynamicArray<TRttiMethod*> Methods = Type->GetMethods(Name);
			if(Methods.Length != 0 && !Methods[0]->IsDestructor)
				return VclMethod_Create(Object, Methods);

			TRttiField *Field = Type->GetField(Name);
			if(Field == NULL || Field->Visibility != mvPublic)
			{
				PyObject *ArrayProperty = VclArrayProperty_Create(Object, Name);
				if(ArrayProperty != NULL)
					return ArrayProperty;
				PyObject *Result = PyObject_GenericGetAttr(reinterpret_cast<PyObject*>(self), attr_name);
				if(Result == NULL)
					SetErrorString(PyExc_AttributeError, "'" + Type->Name + "' object has no attribute '" + Name + "'");
				return Result;
			}
			TValue Result = Field->GetValue(Object);
			return ToPyObject(Result);
		}
		TValue Result = Property->GetValue(Object);
		return ToPyObject(Result);
	}
	catch(...)
	{
		return PyVclHandleException();
	}
}
//---------------------------------------------------------------------------
int VclObject_SetAttro(TVclObject *self, PyObject *attr_name, PyObject *v)
{
	try
	{
		if(self->Instance == NULL)
			throw EPyVclError("Referenced object has been deleted.");

		String Name = PyUnicode_AsUnicode(attr_name);
		TRttiType *Type = Context.GetType(self->Instance->ClassType());
		TRttiProperty *Property = Type->GetProperty(Name);
		if(Property == NULL)
		{
			int Result = PyObject_GenericSetAttr(reinterpret_cast<PyObject*>(self), attr_name, v);
			if(Result == -1)
				SetErrorString(PyExc_AttributeError, "'" + Type->Name + "' object has no attribute '" + Name + "'");
			return Result;
		}

		TTypeInfo *TypeInfo = Property->PropertyType->Handle;
		TValue Value;
		if(TypeInfo->Kind == tkMethod)
		{
			if(v == Py_None)
				Value = TValue::From<TObject*>(NULL);
			else
			{
				Py_INCREF(v);
				TMethodImplementation::TInvokeInfo *InvokeInfo = CreateInvokeInfo(TypeInfo);
				TMethodImplementation *Implementation = new TMethodImplementation(v, InvokeInfo, PythonCallback);
				TMethod Method = {Implementation->CodeAddress, Implementation}; //Pass InvokeInfo in this, which can be used as another data pointer
				TValue::Make(&Method, TypeInfo, Value);
				if(TComponent *Component = dynamic_cast<TComponent*>(self->Instance))
					new TImplementationOwner(Component, Implementation);
			}
		}
		else
			Value = ToValue(v, TypeInfo);
		Property->SetValue(self->Instance, Value);
		return 0;
	}
	catch(...)
	{
		PyVclHandleException();
		return -1;
	}
}
//---------------------------------------------------------------------------
static PyMemberDef VclObject_Members[] =
{
	{"_owned", T_BOOL, offsetof(TVclObject, Owned), 0, "Indicates if the VCL object is freed when the proxy is destroyed"},
	{NULL, 0, 0, 0, NULL}
};
//---------------------------------------------------------------------------
static PyMethodDef VclObject_Methods[] =
{
	{"__dir__", (PyCFunction)VclObject_Dir, METH_NOARGS, ""},
	{NULL, NULL, 0, NULL}
};
//---------------------------------------------------------------------------
PyTypeObject VclObjectType =
{
	PyObject_HEAD_INIT(NULL)
	"vcl.VclObject",        	 /* tp_name */
	sizeof(TVclObject),        /* tp_basicsize */
	0,                         /* tp_itemsize */
	(destructor)VclObject_Dealloc, /* tp_dealloc */
	0,                         /* tp_print */
	0,                         /* tp_getattr */
	0,                         /* tp_setattr */
	0,                         /* tp_compare */
	(reprfunc)VclObject_Repr,  /* tp_repr */
	0,                         /* tp_as_number */
	0,                         /* tp_as_sequence */
	0,                         /* tp_as_mapping */
	0,                         /* tp_hash */
	0, 												 /* tp_call */
	0,                         /* tp_str */
	(getattrofunc)VclObject_GetAttro, /* tp_getattro */
	(setattrofunc)VclObject_SetAttro, /* tp_setattro */
	0,                         /* tp_as_buffer */
	Py_TPFLAGS_DEFAULT, 			 /* tp_flags */
	"VCL object",       			 /* tp_doc */
	0,		                     /* tp_traverse */
	0,		                     /* tp_clear */
	0,		                     /* tp_richcompare */
	0,		                     /* tp_weaklistoffset */
	0,		                     /* tp_iter */
	0,		                     /* tp_iternext */
	VclObject_Methods,         /* tp_methods */
	VclObject_Members,         /* tp_members */
	0,       									 /* tp_getset */
	0,                         /* tp_base */
	0,                         /* tp_dict */
	0,                         /* tp_descr_get */
	0,                         /* tp_descr_set */
	0,                         /* tp_dictoffset */
	0,                         /* tp_init */
	0,                         /* tp_alloc */
	0,						             /* tp_new */
};
//---------------------------------------------------------------------------
PyObject* VclObject_Create(TObject *Instance, bool Owned)
{
	TVclObject *VclObject = PyObject_New(TVclObject, &VclObjectType);
	VclObject->Instance = Instance;
	VclObject->Owned = Owned;
	CreateDeleteHandler(VclObject);
	return reinterpret_cast<PyObject*>(VclObject);
}
//---------------------------------------------------------------------------
bool VclObject_Check(PyObject *O)
{
	return O->ob_type->tp_repr == VclObjectType.tp_repr;
}
//---------------------------------------------------------------------------
TObject* VclObject_AsObject(PyObject *O)
{
	if(O->ob_type->tp_repr != VclObjectType.tp_repr)
		throw EPyVclError("Object is not a VclObject type");
	return reinterpret_cast<TVclObject*>(O)->Instance;
}
//---------------------------------------------------------------------------
} //namespace Python
