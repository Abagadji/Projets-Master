<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Feb 2, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> deme</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
 
    
    <xsl:template match="recette">
        <xsl:element name="html">
            <xsl:element name="head">
                <xsl:element name="title">
                    <xsl:text>Recette_cuisine</xsl:text>
                </xsl:element>
                <xsl:element name="link">
                    <xsl:attribute name="href">recette_DEME_MALAGNOUX_MODOLO.css</xsl:attribute>
                    <xsl:attribute name="rel">stylesheet</xsl:attribute>
                    <xsl:attribute name="type">text/css</xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:element name="body">
                <xsl:attribute name="class">body</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
   
    
    <xsl:template match="titre">
        <xsl:element name="h1">
            <xsl:attribute name="class">titre</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="image">
        <img src="gateau.jpg"></img>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="caractéristiques">
        <xsl:element name="p">
            <xsl:attribute name="class">caractéristiques</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="ingrédients">
        <xsl:element name="ul">
            <xsl:attribute name="class">ingrédients</xsl:attribute>
        </xsl:element>
     <xsl:element name="h2">
         <xsl:text>Liste de courses</xsl:text>
         <xsl:element name="span">
             <xsl:attribute name="style">font-weight: bold;font-size : 40%; </xsl:attribute>
         </xsl:element>
     </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ingrédient_quantifié">
        <xsl:element name="li">
            <xsl:attribute name="class">ingrédient_quantifié</xsl:attribute>
             <xsl:apply-templates/> 
        </xsl:element>          
    </xsl:template>
    
    
    <xsl:template match="durées">
        <xsl:element name="p">
            <xsl:attribute name="class">durées</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="degré_de_difficulté|coût[not(following-sibling::degré_de_difficulté|coût)]">
         <xsl:element name="span">
             <xsl:attribute name="span">degré_de_difficulté|coût</xsl:attribute>
           <xsl:text >  ● </xsl:text>
          <xsl:apply-templates/>
         </xsl:element>
    </xsl:template>
    
    <xsl:template match="durée_quantifiée">
        <xsl:apply-templates/>
        <xsl:choose>
            <xsl:when test="following-sibling::durée_quantifiée"><xsl:text>  ● </xsl:text></xsl:when>
            <xsl:otherwise><xsl:text></xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
   
    
    <xsl:template match="étapes">
        <xsl:element name="p">
            <xsl:attribute name="class">étapes</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="titre_d_étape">
        <xsl:element name="h3">
            <xsl:attribute name="class">titre_d_étape</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="consigne">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    
    
   
    
    
   
    
    
   
</xsl:stylesheet>

