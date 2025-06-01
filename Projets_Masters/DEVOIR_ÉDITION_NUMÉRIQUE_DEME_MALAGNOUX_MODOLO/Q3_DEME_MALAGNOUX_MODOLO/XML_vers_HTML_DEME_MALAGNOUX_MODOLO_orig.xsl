<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Mar 30, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> DEME_MALAGNOU_MODOLO</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>

    <xsl:strip-space elements="*"/>

    <xsl:output method="xhtml"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="TEI">
        <xsl:element name="html">
            <xsl:element name="head">
                <xsl:element name="title">
                    <xsl:text>Le grand Olympe des histoires poétiques du prince de poésie Ovide Naso en sa Métamorphose [extrait]</xsl:text>
                </xsl:element>
                <xsl:element name="link">
                    <xsl:attribute name="href">ORIG_DEME_MALAGNOUX_MODOLO.css</xsl:attribute>
                    <xsl:attribute name="rel">stylesheet</xsl:attribute>
                    <xsl:attribute name="type">text/css</xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:element name="body">
                <xsl:element name="div">
                    <xsl:attribute name="class">
                        <xsl:text>index</xsl:text>
                    </xsl:attribute>
                    <a href="XML_vers_HTML_DEME_MALAGNOUX_DEME_reg.html">Version normalisée</a>
                    <xsl:text>
                        
                        
                    </xsl:text>
                    <a href="https://gallica.bnf.fr/ark:/12148/btv1b8600297j?fbclid=IwAR1al_x61HFmtoQm4dqxaOc2tGIy6Sjn-ilJvTyCqdU5Ea_ncyuT_bHZzco">Lien vers Gallica</a>
                </xsl:element>
                <xsl:element name="div">
                    <xsl:attribute name="class">texte_complet</xsl:attribute>
                    <xsl:apply-templates select="child::*[local-name() != 'teiHeader']"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="titlePart[@type = 'main']">
        <xsl:element name="p">
            <xsl:attribute name="class">titre_oeuvre</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="titlePart[@type = 'desc']">
        <xsl:element name="p">
            <xsl:attribute name="class">titre_secondaire</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="docAuthor">
        <xsl:element name="p">
            <xsl:attribute name="class">auteur</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="label">
        <xsl:element name="p">
            <xsl:attribute name="class">contexte</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="p">
        <xsl:element name="p">
            <xsl:attribute name="class">p</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>


    <!-- <xsl:template match="pb [@n='1']">
        <xsl:element name="span">
            <img src="morin1532_facsimile_page-0001.jpg"/>
            <xsl:attribute name="class">pagination</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="pb [@n='2']">
        <xsl:element name="span">
            <img src="morin1532_facsimile_page-0002.jpg"/>
            <xsl:attribute name="class">pagination</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>-->

    <xsl:template match="label">
        <xsl:element name="p">
            <xsl:attribute name="class">p</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="lg">
        <xsl:element name="div">
            <xsl:attribute name="class">p</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="l">
        <xsl:element name="p">
            <xsl:attribute name="class">p</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="lb">
        <xsl:element name="br">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="figure[@type = 'page_1']">
        <xsl:element name="span">
            <img src="morin1532_facsimile_page-0001.jpg"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="figure[@type = 'page_2']">
        <xsl:element name="span">
            <img src="morin1532_facsimile_page-0002.jpg"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="figure[@type = 'page_3']">
        <xsl:element name="span">

            <img src="morin1532_facsimile_page-0003.jpg"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="figure[@type = 'page_3']">
        <xsl:element name="span">
            <img src="morin1532_facsimile_page-0003.jpg"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="figure[@type = 'page_4']">
        <xsl:element name="span">
            <img src="morin1532_facsimile_page-0004.jpg"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="figure[@type = 'page_5']">
        <xsl:element name="span">
            <img src="morin1532_facsimile_page-0005.jpg"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="figure[@type = 'page_6']">
        <xsl:element name="span">
            <img src="morin1532_facsimile_page-0006.jpg"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="figure[@type = 'page_7']">
        <xsl:element name="span">
            <img src="morin1532_facsimile_page-0007.jpg"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

   <!-- <xsl:template match="figure[@type = 'page_8']">
        <xsl:element name="span">
            <img src="morin1532_facsimile_page-0008.jpg"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>--> <!-- Nous avions voulu mettre une dernière image qui correspond au dernier paragraphe de la version fascimilaire, mais cette image en pleine page dépassait du cadre, et nous n'avons pas trouvé de solution autre que de la retirer  -->



    <xsl:template match="reg"/>
    <xsl:template match="expan"/>
    <xsl:template match="corr"/>


</xsl:stylesheet>
