/* Graph (http://sourceforge.net/projects/graph)
 * Copyright 2007 Ivan Johansen
 *
 * Graph is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 */
//---------------------------------------------------------------------------
#ifndef PyVclH
#define PyVclH
//---------------------------------------------------------------------------
struct _object;
namespace Python
{
	class EPyVclError : public Exception
	{
	public:
		EPyVclError(const String &Str) : Exception(Str) {}
  };

  extern _object *PyPropertyException;
  extern _object *PyVclException;
  _object* InitPyVcl();
}
#endif
