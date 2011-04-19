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
#include <Rtti.hpp>
#include "PyVcl.h"
#include <ActnMan.hpp>
#undef _DEBUG
#include <python.h>
#include <structmember.h>
#include "PyVclConvert.h"
#include "ExtColorBox.h"
#include "FindClass.hpp"
#include <OleCtrls.hpp>
#include <clipbrd.hpp>
#include "PyVClMethod.h"
#include "PyVclObject.h"
#include "PyVClType.h"
#include "PyVclFunction.h"
#include "PyVclArrayProperty.h"
#include <RTLConsts.hpp>
#include "PyVclRef.h"

namespace Python
{
//---------------------------------------------------------------------------
struct TGlobalObjectEntry
{
	const char *Name;
	TObject *Object;
};
TGlobalObjectEntry GlobalObjectList[] =
{
	"Application", Application,
	"Mouse", Mouse,
	"Clipboard", Clipboard(),
	"Screen", Screen,
};
//---------------------------------------------------------------------------
static PyObject* GlobalVcl_Dir(TVclObject *self, PyObject *arg)
{
	unsigned GlobalCount = sizeof(GlobalObjectList)/sizeof(GlobalObjectList[0]);
	unsigned GlobalFunctionCount = GetVclFunctionCount();
	TStrings *TypeList = GetTypeList();
	PyObject *List = PyList_New(TypeList->Count + GlobalCount + GlobalFunctionCount);
	int Index;
	for(Index = 0; Index < TypeList->Count; Index++)
		PyList_SET_ITEM(List, Index, ToPyObject(TypeList->Strings[Index]));
	for(unsigned I = 0; I < GlobalCount; I++, Index++)
		PyList_SET_ITEM(List, Index, ToPyObject(GlobalObjectList[I].Name));
	for(unsigned I = 0; I < GlobalFunctionCount; I++, Index++)
		PyList_SET_ITEM(List, Index, ToPyObject(GetVclFunctionName(I)));
	return List;
}
//---------------------------------------------------------------------------
static PyObject* GlobalVcl_GetAttro(PyObject *self, PyObject *attr_name)
{
	try
	{
		PyObject *Result = PyObject_GenericGetAttr(self, attr_name);
		if(Result != NULL)
			return Result;

		PyErr_Clear();
		String Name = PyUnicode_AsUnicode(attr_name);
		TRttiType *Type = Context.GetType(LookUpClass(Name));
		if(Type == NULL)
		{
			TClass Class = GetClass(Name);
			if(Class)
				Type = Context.GetType(Class);
    }
		if(Type != NULL)
		{
//		if(Class->InheritsFrom(__classid(Exception)))
			Result = VclType_Create(Type);
		}
		else
			Result = VclFunction_Create(Name);
		if(Result == NULL)
			throw EPyVclError("VCL has no global attribute '" + Name + "'");

		PyObject_GenericSetAttr(self, attr_name, Result);
		return Result;
	}
	catch(...)
	{
		return PyVclHandleException();
	}
}
//---------------------------------------------------------------------------
struct TGlobalVcl
{
	PyObject_HEAD
	PyObject *Dict;
};
//---------------------------------------------------------------------------
static PyMemberDef GlobalVcl_Members[] =
{
	{"__dict__", T_OBJECT, offsetof(TGlobalVcl, Dict), READONLY},
	{NULL, 0, 0, 0}
};
//---------------------------------------------------------------------------
static PyMethodDef GlobalVcl_Methods[] =
{
	{"__dir__", (PyCFunction)GlobalVcl_Dir, METH_NOARGS, ""},
	{NULL, NULL, 0, NULL}
};
//---------------------------------------------------------------------------
static PyTypeObject GlobalVclType =
{
	PyObject_HEAD_INIT(NULL)
	"vcl.Vcl",        	 			 /* tp_name */
	sizeof(TGlobalVcl), 			 /* tp_basicsize */
	0,                         /* tp_itemsize */
	0, 												 /* tp_dealloc */
	0,                         /* tp_print */
	0,                         /* tp_getattr */
	0,                         /* tp_setattr */
	0,                         /* tp_compare */
	0,  											 /* tp_repr */
	0,                         /* tp_as_number */
	0,                         /* tp_as_sequence */
	0,                         /* tp_as_mapping */
	0,                         /* tp_hash */
	0, 												 /* tp_call */
	0,                         /* tp_str */
	GlobalVcl_GetAttro,   		 /* tp_getattro */
	PyObject_GenericSetAttr,	 /* tp_setattro */
	0,                         /* tp_as_buffer */
	Py_TPFLAGS_DEFAULT, 			 /* tp_flags */
	"Global VCL types and methods", /* tp_doc */
	0,		                     /* tp_traverse */
	0,		                     /* tp_clear */
	0,		                     /* tp_richcompare */
	0,		                     /* tp_weaklistoffset */
	0,		                     /* tp_iter */
	0,		                     /* tp_iternext */
	GlobalVcl_Methods,         /* tp_methods */
	GlobalVcl_Members,         /* tp_members */
	0,       									 /* tp_getset */
	0,                         /* tp_base */
	0,                         /* tp_dict */
	0,                         /* tp_descr_get */
	0,                         /* tp_descr_set */
	offsetof(TGlobalVcl, Dict),/* tp_dictoffset */
	0,						             /* tp_init */
	0,                         /* tp_alloc */
	0,						             /* tp_new */
};
//---------------------------------------------------------------------------
static PyModuleDef PyVclModuleDef =
{
	PyModuleDef_HEAD_INIT,
	"PyVcl",           //m_name
	"Module wrapping the Visual Component Library (VCL)", //m_doc
	-1, //m_size
	NULL, //m_methods
	NULL, //m_reload
	NULL, //m_traverse
	NULL, //m_clear
	NULL, //m_free
};
//---------------------------------------------------------------------------
PyObject* GlobalVcl_Create()
{
	TGlobalVcl *vcl = PyObject_New(TGlobalVcl, &GlobalVclType);
	vcl->Dict = NULL;
	PyObject *self = reinterpret_cast<PyObject*>(vcl);
	for(unsigned I = 0; I < sizeof(GlobalObjectList)/sizeof(GlobalObjectList[0]); I++)
	{
		PyObject *NewObject = VclObject_Create(GlobalObjectList[I].Object, false);
		PyObject_SetAttrString(self, GlobalObjectList[I].Name, NewObject);
		Py_DECREF(NewObject);
	}
	return self;
}
//---------------------------------------------------------------------------
PyObject* InitPyVcl()
{
	PyObject *PyVclModule = PyModule_Create(&PyVclModuleDef);
	if(PyType_Ready(&GlobalVclType) < 0 || PyType_Ready(&VclMethodType) < 0 ||
		PyType_Ready(&VclObjectType) < 0 || PyType_Ready(&VclFunctionType) < 0 ||
		PyType_Ready(&VclArrayPropertyType) < 0 || PyType_Ready(&VclRefType) < 0)
		return NULL;
	PyVclException = PyErr_NewException("vcl.VclError", NULL, NULL);
	PyModule_AddObject(PyVclModule, "VclError", PyVclException);

	PyObject *Modules = PyImport_GetModuleDict();
	PyObject *vcl = GlobalVcl_Create();
	PyDict_SetItemString(Modules, "vcl", vcl);
	Py_DECREF(vcl);
	return PyVclModule;
}
//---------------------------------------------------------------------------
} //Namespace Python

//Workaround: Instead of registering all classes with RegisterClass() we change
//TStream::ReadComponent() to call TComponentFinder::FindComponentClass() to
//retrieve the meta class.
class TComponentFinder
{
public:
	void __fastcall FindComponentClass(TReader *Reader, String ClassName, TComponentClass &ComponentClass)
	{
		if(ComponentClass == NULL)
		{
			TTypeInfo *TypeInfo = LookUpClass(ClassName);
			if(TypeInfo != NULL && TypeInfo->Kind == tkClass)
				ComponentClass = GetTypeData(TypeInfo)->ClassType;
		}
	}
};
TComponentFinder *ComponentFinder = new TComponentFinder;
namespace Classes
{
TComponent* __fastcall TStream::ReadComponent(TComponent *Instance)
{
	std::auto_ptr<TReader> Reader(new TReader(this, 4096));
	Reader->OnFindComponentClass = ComponentFinder->FindComponentClass;
	return Reader->ReadRootComponent(Instance);
}
}
//---------------------------------------------------------------------------
