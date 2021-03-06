//---------------------------------------------------------------------------
#include "Config.h"
#include <vcl.h>
#pragma hdrstop
#include "HandleCSV.h"
#include <algorithm>
#include <sstream>
#include <fstream>
#include "ICompCommon.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
//Returns separator used for line ('\t', ';', ' ', ',')
//Check for separator in priority order. A space cannot be a separator if comes
//after a comma.
char GetSeparator(const std::string &Str2)
{
  const char *Separators = "\t; ,";
  std::string Str = Trim(Str2);
  for(const char* Ch = Separators; *Ch; Ch++)
  {
    unsigned n = Str.find(*Ch);
    if(n != std::string::npos && n != 0 && Str[n-1] != ',')
      return *Ch;
  }
  return 0;
}
//---------------------------------------------------------------------------
unsigned CountCols(const std::string &Str, char Separator)
{
	unsigned Count = 1;
  unsigned Pos = 0;
  unsigned NextPos;
  while((NextPos = Str.find(Separator, Pos)) != std::string::npos)
  {
    if(NextPos != Pos)
      Count++;
    Pos = NextPos + 1;
  }
	return Count;
}
//---------------------------------------------------------------------------
bool ImportCsv(std::istream &Stream, TCsvGrid &CsvGrid, char Separator)
{
	std::string Line;
	while(Stream && Line.empty())
		std::getline(Stream, Line);
	if(Separator == 0)
	  Separator = GetSeparator(Line);
	unsigned LineNo = 1;

	do
	{
		if(!Line.empty() && Line[Line.size()-1] == '\r')
			Line.erase(Line.size()-1);
		//Ignore empty lines
		if(Line.empty())
			continue;

		//Several separators after each other (eg. spaces) are ignored
		unsigned FirstPos = Line.find_first_not_of(Separator);
		unsigned Pos = Line.find(Separator, FirstPos);
		std::string xText = Trim(Line.substr(FirstPos, Pos - FirstPos));
		TCsvRow CsvRow;
		CsvRow.push_back(xText);
		for(unsigned LastPos = Line.find_first_not_of(Separator, Pos);
				Pos != std::string::npos; LastPos = Pos + 1)
		{
			Pos = Line.find(Separator, LastPos);

			//Ignore empty entries
			if(Pos == LastPos || LastPos == Line.size())
				continue;

			std::string yText = Trim(Line.substr(LastPos, Pos - LastPos));
			CsvRow.push_back(yText);
		}

		LineNo++;
    CsvGrid.push_back(CsvRow);
  }
  while(std::getline(Stream, Line));
  return true;
}
//---------------------------------------------------------------------------
bool ImportCsv(const std::string &Str, TCsvGrid &CsvGrid, char Separator)
{
	std::istringstream Stream(Str);
	return ImportCsv(Stream, CsvGrid, Separator);
}
//---------------------------------------------------------------------------
bool ImportCsvFromFile(const std::wstring &FileName, TCsvGrid &CsvGrid, char Separator)
{
	std::ifstream Stream(FileName.c_str());
	if(!Stream)
		return false;
	return ImportCsv(Stream, CsvGrid, Separator);
}
//---------------------------------------------------------------------------

