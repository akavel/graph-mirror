<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 

<xsl:import href="./db_htmlhelp.xsl"/> 
<xsl:import href="./defaults.xsl"/> 
 
<xsl:param name="suppress.navigation" select="0"/> 
<xsl:param name="toc.section.depth" select="4"/> 
<xsl:param name="htmlhelp.force.map.and.alias" select="1"/> 
<xsl:param name="htmlhelp.show.menu" select="1"/> 
<xsl:param name="htmlhelp.show.advanced.search" select="1"/> 
<xsl:param name="htmlhelp.hhc.folders.instead.books" select="1"></xsl:param>
<xsl:param name="htmlhelp.hhc.binary" select="0"></xsl:param>
<xsl:param name="htmlhelp.use.hhk" select="0"></xsl:param>
<xsl:param name="htmlhelp.hhp.tail">
[FILES]
</xsl:param>

<xsl:param name="img.src.path">Images/</xsl:param>
<xsl:param name="glossterm.auto.link" select="1"/>
<xsl:param name="htmlhelp.display.progress" select="0"/>
<xsl:param name="htmlhelp.chm">..\Graph.chm</xsl:param>
<xsl:param name="generate.toc"></xsl:param>
<xsl:param name="chunk.section.depth" select="2"/> 
<xsl:param name="section.autolabel" select="0"/>
<xsl:param name="generate.index" select="1"/>
<xsl:param name="htmlhelp.hhc.show.root" select="0"/>

</xsl:stylesheet> 
