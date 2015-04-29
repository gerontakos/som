<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:template match="/">       
            <xsl:for-each select="root/row">
                <xsl:variable name="dirname" select="./filename/text()"/>
                <xsl:variable name="pdfname" select="filename"/>
                <xsl:result-document href="results/{filename}/dublin_core.xml">
                <dublin_core>
                    <xsl:apply-templates select="node()"/>
                </dublin_core>
                </xsl:result-document>
            </xsl:for-each>    
    </xsl:template>

    <xsl:template match="node()">
        <xsl:if test="node()">
            <xsl:choose>
                <xsl:when test="contains(name(),'.')">
                    <dcvalue element="{substring-before(name(),'.')}"
                        qualifier="{substring-after(name(),'.')}">
                        <xsl:value-of select="."/>
                    </dcvalue>
                </xsl:when>
                <xsl:when test="name()='filename'"/>
                <xsl:when test="name()='date'">
                    <dcvalue element="{name()}" qualifier="none">
                       <xsl:choose> 
                           <xsl:when test="not(contains(.,'-')) and contains(.,'/')">
                        <xsl:value-of select="substring-after(substring-after(.,'/'),'/')"/>
                        <xsl:text>-</xsl:text>
                      <xsl:choose> 
                          <xsl:when test="string-length(substring-before(.,'/'))=1">
                              <xsl:text>0</xsl:text>
                              <xsl:value-of select="substring-before(.,'/')"/>
                          </xsl:when>
                          <xsl:when test="string-length(substring-before(.,'/'))&gt;1">
                              <xsl:value-of select="substring-before(.,'/')"/>
                          </xsl:when>
                        </xsl:choose>
                        <xsl:text>-</xsl:text>
                        <xsl:choose>
                            <xsl:when test="string-length(substring-before(substring-after(.,'/'),'/'))=1">
                                <xsl:text>0</xsl:text>
                                <xsl:value-of select="substring-before(substring-after(.,'/'),'/')"/>
                            </xsl:when>
                            <xsl:when test="string-length(substring-before(substring-after(.,'/'),'/'))&gt;1">
                                <xsl:value-of select="substring-before(substring-after(.,'/'),'/')"/>
                            </xsl:when>
                        </xsl:choose>
                           </xsl:when>
                           <xsl:when test="contains(.,'-')">
                               <xsl:value-of select="."></xsl:value-of>
                           </xsl:when>
                           <xsl:when test="not(contains(.,'/'))">
                               <xsl:value-of select="."/>
                           </xsl:when>
                        </xsl:choose>
                    </dcvalue>
                </xsl:when>
                <xsl:when test="not(contains(name(),'.'))">
                    <dcvalue element="{name()}" qualifier="none">
                        <xsl:value-of select="."/>
                    </dcvalue>
                </xsl:when>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>