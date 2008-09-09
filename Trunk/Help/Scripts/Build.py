import os
import shutil

ToolsDir = "..\\..\\Tools\\"
Languages = ["Danish", "Spanish"]

print "Copying image files..."
os.system("XCopy ..\\Images\\Common\\*.* ..\\Temp\\Images /I /Q /Y")
os.system("XCopy ..\\Images\\English\\*.* ..\\Temp\\Images /I /Q /Y")
os.system("XCopy ..\\Source\\*.css ..\\Temp /Q /Y")

os.chdir("..\\Source")
print
print "Creating English PDF file..."
os.system(ToolsDir + "xsltproc.exe --nonet --xinclude --output ..\\Temp\\Graph.fo ..\\xsl\\pdfdoc.xsl Graph.xml")
os.system(ToolsDir + "fop\\fop.bat -q -fo ..\\Temp\\Graph.fo -pdf ..\\Graph-English.pdf")

print
print "Creating English CHM file..."
os.system(ToolsDir + "xsltproc.exe --nonet --xinclude --output ..\\Temp\\Graph ..\\xsl\\htmlhelp.xsl Graph.xml")
os.system(ToolsDir + "hhc.exe ..\\Temp\\htmlhelp.hhp")

os.system(ToolsDir + "xmllint --nonet --xinclude --output Graph.tmp Graph.xml")

for Language in Languages:
    print
    print "Creating %s translation" % (Language,)
    os.system("..\\Scripts\\xml2po.py -p ..\\po\\GraphHelp_%s.po -l da -o Graph2.tmp Graph.tmp" % (Language,))
    os.system("XCopy ..\\Images\\%s\\*.* ..\\Temp\\Images /I /Q /Y" % (Language,))

    print "Creating %s PDF file..." % (Language,)
    os.system(ToolsDir + "xsltproc.exe --nonet --xinclude --output ..\\Temp\\Graph.fo ..\\xsl\\pdfdoc.xsl Graph2.tmp")
    os.system(ToolsDir + "fop\\fop.bat -q -fo ..\\Temp\\Graph.fo -pdf ..\\Graph-%s.pdf" % (Language,))

    print "Creating %s CHM file..." % (Language,)
    os.system(ToolsDir + "xsltproc.exe --nonet --xinclude --stringparam htmlhelp.chm ..\\Graph-%s.chm --output ..\\Temp\\Graph ..\\xsl\\htmlhelp.xsl Graph2.tmp" % (Language,))
    os.system(ToolsDir + "hhc.exe ..\\Temp\\htmlhelp.hhp")

os.remove(".xml2po.mo")
os.remove("Graph.tmp")
os.remove("Graph2.tmp")
