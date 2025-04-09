<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:soap="http://www.w3.org/2003/05/soap-envelope" 
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> 

  <xsl:template match="/">
    <Results> 
      <xsl:for-each select="//Results">
        <xsl:copy-of select="."/>
      </xsl:for-each>
    </Results>
  </xsl:template>

</xsl:stylesheet>