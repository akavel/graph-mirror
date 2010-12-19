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
#undef _DEBUG
#include "Python.h"
#define private public
#include <Rtti.hpp>
#undef private
#include "PyVclObject.h"
#include "PyVclMethod.h"
#include "PyVcl.h"
#include "PythonBind.h"
#include "PyVclArrayProperty.h"

namespace Python
{
//---------------------------------------------------------------------------
static PyObject *VclObject_Repr(TVclObject* self)
{
	String Str;
	TComponent *Component = dynamic_cast<TComponent*>(self->Instance);
	if(Component != NULL)
		Str = "<object '" + Component->Name + "' of type '" + Component->ClassName() + "'>";
	else
		Str = "<object of type '" + self->Instance->ClassName() + "'>";
	return PyUnicode_FromUnicode(Str.c_str(), Str.Length());
}
//---------------------------------------------------------------------------
static void VclObject_Dealloc(TVclObject* self)
{
	if(self->Owned)
		delete self->Instance;
	Py_TYPE(self)->tp_free(reinterpret_cast<PyObject*>(self));
}
//---------------------------------------------------------------------------
PyObject* VclObject_GetAttro(TVclObject *self, PyObject *attr_name)
{
	try
	{
		TObject *Object = self->Instance;
		String Name = PyUnicode_AsUnicode(attr_name);
		TRttiType *Type = Context.GetType(Object->ClassType());
		if(Type == NULL)
			throw EPyVclError("Type not found.");
		TRttiProperty *Property = Type->GetProperty(Name);
		if(Property == NULL)
		{
			DynamicArray<TRttiMethod*> Methods = Type->GetMethods(Name);
			if(Methods.get_length() != 0)
				return VclMethod_Create(Object, Methods);

			TRttiField *Field = Type->GetField(Name);
			if(Field == NULL || Field->Visibility != mvPublic)
			{
				PyObject *ArrayProperty = VclArrayProperty_Create(Object, Name);
				if(ArrayProperty != NULL)
				  return ArrayProperty;
				SetErrorString(PyExc_AttributeError, "'" + Type->Name + "' object has not attribute '" + Name + "'");
				return NULL;
			}
			TValue Result = Field->GetValue(Object);
			return ToPyObject(Result);
		}
		TValue Result = Property->GetValue(Object);
		return ToPyObject(Result);
	}
	catch(EListError &E)
	{
		PyErr_SetString(PyExc_IndexError, AnsiString(E.Message).c_str());
		return NULL;
	}
	catch(Exception &E)
	{
		SetErrorString(PyVclException, E.Message);
		return NULL;
	}
}
//---------------------------------------------------------------------------
int VclObject_SetAttro(TVclObject *self, PyObject *attr_name, PyObject *v)
{
	try
	{
		String Name = PyUnicode_AsUnicode(attr_name);
		TRttiType *Type = Context.GetType(self->Instance->ClassType());
		TRttiProperty *Property = Type->GetProperty(Name);
		if(Property == NULL)
			throw EPyVclError("Property " + Name + " not found in " + Type->Name);
		Property->SetValue(self->Instance, ToValue(v, Property->PropertyType->Handle));
		return 0;
	}
	catch(Exception &E)
	{
		SetErrorString(PyVclException, E.Message);
		return -1;
	}
}
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
	0, 								         /* tp_methods */
	0,                         /* tp_members */
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
