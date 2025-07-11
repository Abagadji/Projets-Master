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
                    <xsl:attribute name="href">REG_DEME_MALAGNOUX_MODOLO.css</xsl:attribute>
                    <xsl:attribute name="rel">stylesheet</xsl:attribute>
                    <xsl:attribute name="type">text/css</xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:element name="body">
                <xsl:element name="div">
                    <xsl:attribute name="class">
                        <xsl:text>index</xsl:text>
                    </xsl:attribute>
                    <a href="XML_vers_HTML_DEME_MALAGNOUX_DEME_orig.html">Version_fascimilaire</a>
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



    <xsl:template match="p">
        <xsl:element name="p">
            <xsl:attribute name="class">p</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="label">
        <xsl:element name="p">
            <xsl:attribute name="class">contexte</xsl:attribute>
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
            <xsl:attribute name="class">vers</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    
    
    <!--<xsl:template match="figure [@type = 'portrait']">
        <xsl:element name="span">
            <xsl:attribute name="class">portrait</xsl:attribute>
            <img src="auteur.png"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>-->
    
    
    <xsl:template match="figure [@type = 'lettrine_dieux']">
        <xsl:element name="span">
            <xsl:attribute name="class">lettrine</xsl:attribute>
            <img src="lettrine_Dieux.png"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="figure [@type = 'lettrine_Deffus']">
        <xsl:element name="span">
            <xsl:attribute name="class">lettrine</xsl:attribute>
            <img src="lettrine_Deffus.png"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    
    
    <xsl:template match="figure [@type = 'lettrine_p']">
        <xsl:element name="span">
            <xsl:attribute name="class">lettrine</xsl:attribute>
            <img src="lettrine_P.png"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    

    
    
    <xsl:template match="figure [@type = 'lettrine_o']">
        <xsl:element name="span">
            <xsl:attribute name="class">lettrine</xsl:attribute>
            <img src="lettrine_O.png"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="figure [@type = 'lettrine_a']">
        
        <xsl:element name="span">
            <xsl:attribute name="class">lettrine</xsl:attribute>
            <img src="lettrine_A.png"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- Nous nous sommes confrontés à une difficulté quant au contenu de nos info-bulles. En effet, comme vous pouvez le constater dans la sortie HTML, le texte à l'intérieur de nos bulles s'affiche de façon étroite à l'horizontale. Nous avons essayé de modifier l'xsl avec de <xsl:texte> et aussi avec la création d'éléments <br> entre les lignes et la css mais nous n'avons pas réussi.   -->
    <xsl:template match="m [@type = 'desinence']">
        <xsl:element name="span">
            <xsl:attribute name="class">info_bulle</xsl:attribute>
            <xsl:attribute name="aria-label">L’imparfait
                L’imparfait de l’indicatif est un tiroir verbal descendant du latin classique et est modifié à l’oral par le latin vulgaire.
                
                <xsl:element name="n">En ancien français du XIIe au XIIIe siècle l’imparfait se conjugue de cette façon. :</xsl:element>
                • Oie
                • Oies
                • Oit
                • Iions
                • Iiez 
                • Oient 
                
                En moyen français le e final de la première et la deuxième personne se désarticule (c’est-à-dire qu’il ne se prononce plus), cela donne une disparition du e dans la graphie. Par ailleurs, à la première personne le e est remplacé par un s. Les consonnes finales étant muettes, elles ne sont pas prononcées. 
                Le digramme (= le groupe de deux lettres) oi tente de se prononcer [é]. 
                On trouve donc un décalage important entre la graphie et la prononciation. C’est pourquoi, les auteurs dont Voltaire, vont dénoncer ce décalage au XVIIIe s et proposent de remplacer oi par ai. Donc : 
                • Ais 
                • Ais 
                • Ait
                • Ions 
                • Iez
                • Aient </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="m [@type = 'diacritique']">
        <xsl:element name="span">
            <xsl:attribute name="class">info_bulle</xsl:attribute>
            <xsl:attribute name="aria-label">Trace de cas 
                Ung 
                Le g présent à la fin du un permet de le différencier l’article indéfini « un » ici écrit ung et le chiffre 1. </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="m [@type = 'pluriel']">
        <xsl:element name="span">
            <xsl:attribute name="class">info_bulle</xsl:attribute>
            <xsl:attribute name="aria-label">
                Lx 
                En ancien français, les fins de mots en -al, -ol, -el, vont subir une altération du radical au contact du pluriel -s. 
                -Al ou -ol + s deviens -aus ou -ous 
                
                Nous avons donc ici une vocalisation du -l en -u qui entraine l’apparition d’une diphtongue de coalescence.
                
                -el + s = eus ou eaus 
                
                Dans notre cas, le mot se termine en lx, c’est une évolution de l’ancien français vers le français moderne, le singulier noté -l coexiste avec le pluriel en -u et -x. 
            
            
            On trouve ici une altération du radical au contact du pluriel noté -s. 
            En fin de mot, les consonnes -d, -t, -l, n se combinent avec -s et donnent un son affriquée [ts] notée -z 
            
            
            Cependant dans ce texte nous sommes au XVIe siècle et la langue évolue. Nous trouvons donc ici une disparition progressive des déclinaisons dont on en trouve plus que quelques rares reliquats. 
            Le -dz est également présent pour montrer que l’on est savant, on écrit de manière à faire ressortir le radical latin, le d ici vient du latin. 
            
            
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="titlePart [@type='main']">
        <xsl:element name="p">
            <xsl:attribute name="class">titre_oeuvre</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="titlePart [@type='desc']">
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
    
    
    <xsl:template match="orig"/>
    <xsl:template match="abbr"/>
    <xsl:template match="lb"/>



</xsl:stylesheet>
