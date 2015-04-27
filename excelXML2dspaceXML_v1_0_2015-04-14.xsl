<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- The names of the spreadsheet columns should be:
    (1) title.none
    (2) filename is OK: this should not be output - the last template should handle this.
    (3) contributor.other
    (4) date [no qualifier; DSpace doesn't use date.other]
    (5) identifier.other
    (6) description.abstract
    -->

    <xsl:template match="/">
        
            <xsl:for-each select="som_programs/program">
                <xsl:variable name="dirname" select="substring-before(filename,'.')"/>
                <xsl:variable name="pdfname" select="filename"/>
                <xsl:result-document href="results/{$dirname}/dublin_core.xml">
                <dublin_core>
                    <xsl:apply-templates select="node()"/>
                </dublin_core>
                </xsl:result-document>
                <xsl:apply-templates select="date.none"/>
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
                <xsl:when test="not(contains(name(),'.'))">
                    <dcvalue element="{name()}" qualifier="none">
                        <xsl:value-of select="."/>
                    </dcvalue>
                </xsl:when>
                <xsl:when test="name()='filename'"/>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- date template: did not output ISO 8601 dates; repair. -->
    <xsl:template match="date">
        <dcvalue element="{name()}" qualifier="none">
            <!--<xsl:value-of select="format-dateTime(.,'[Y]-[M,2]-[D,2]')"/>-->
            <xsl:value-of select="."/>
        </dcvalue>
    </xsl:template>
    
    <xsl:template match="filename"/>
    
</xsl:stylesheet>