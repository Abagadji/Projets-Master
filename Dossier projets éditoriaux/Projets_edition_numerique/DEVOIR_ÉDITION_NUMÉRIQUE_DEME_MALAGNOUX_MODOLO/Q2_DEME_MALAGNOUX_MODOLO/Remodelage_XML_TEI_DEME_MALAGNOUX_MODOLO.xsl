<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"
    xmlns:rels="http://schemas.openxmlformats.org/package/2006/relationships"
    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    xmlns:sml="http://schemas.openxmlformats.org/spreadsheetml/2006/main"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:tei-spreadsheet="https://github.com/oucs/tei-spreadsheet"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="#all">
    <!--  Cette en-tête nous permet de générer à la sortie un fichier conforme à l'XML-TEI -->

    <!--1. Définition du type de document que nous souhaitons créer : un fichier XML, encodé en UTF-8, en langue française (fr) et indenté-->
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <!--2. Création d'une template qui copie tous les éléments (qui ne sont pas visés par les autres templates), leurs attributs et leur contenu-->
    
    <xsl:template match="*"><!-- Template de traitement de tous les éléments sans mode (donc appelé par un <xsl:apply-template> ne portant pas non plus de mode) -->
        <xsl:element name="{local-name()}">
            <xsl:for-each select="@*">
                <xsl:attribute name="{local-name()}">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:for-each>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <!--3. Création d'une templace qui génère, à la racine du document source, les instructions permettant de définir les instructions du traitement (pour produire un document conforme aux schéma TEI)-->
    <xsl:template match="/">
        <xsl:processing-instruction name="model"> href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
        <xsl:processing-instruction name="model"> href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
        <xsl:apply-templates/>
    </xsl:template>

    <!--4. Remplacement de l'élément <document> par <TEI>. Ajout de <teiHeader> qui contiendra des métadonnées administratives, etc. Enrichir et compléter la <teiHeader>-->
    <xsl:template match="document">
        <xsl:element name="TEI">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Title</title>
                    </titleStmt>
                    <publicationStmt>
                        <p>Publication Information</p>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Information about the source</p>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <xsl:apply-templates/>
                </body>
            </text>
        </xsl:element>
    </xsl:template>

    <!-- style_de_paragraphe -->
    <xsl:template match="style_rubrique">
        <xsl:element name="label">
            <xsl:attribute name="type">
                <xsl:attribute name="nom">rubrique</xsl:attribute>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="style_paragraphe">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="style_strophe">
        <xsl:element name="lg">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <!-- Fin_des_styles_de_paragraphe -->

    <!-- style_de_caractère -->
    <xsl:template match="style_abréviation_contraction">
        <xsl:element name="abbr">
            <xsl:attribute name="type">
                <xsl:attribute name="nom">contraction</xsl:attribute>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="style_abréviation_résolue">
        <xsl:element name="expan">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="style_abréviation_signes_spéciaux">
        <xsl:element name="abbr">
            <xsl:attribute name="type">
                <xsl:attribute name="nom">signeSpecial</xsl:attribute>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>







    <xsl:template match="ajout_apostrophe">
        <xsl:element name="choice">
            <xsl:attribute name="change">
                <xsl:attribute name="nom">desagglutination</xsl:attribute>
            </xsl:attribute>
            <xsl:element name="reg">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="style_ajout_editeur">
        <xsl:element name="choice">
            <xsl:element name="corr">
                <xsl:attribute name="resp">
                    <xsl:attribute name="nom">editor</xsl:attribute>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    

    <!--<xsl:template match="style_séparation_mot">
        <xsl:element name="choice">
            <xsl:attribute name="change">
                <xsl:attribute name="nom">desagglutination</xsl:attribute>
            </xsl:attribute>
            <xsl:element name="reg"><xsl:apply-templates/></xsl:element>
        </xsl:element>
    </xsl:template>-->

    <xsl:template match="style_ajout_ponctuation">
        <xsl:element name="pc">
            <xsl:attribute name="type">
                <xsl:attribute name="nom">PONfrt</xsl:attribute>
            </xsl:attribute>
            <xsl:element name="choice">
                <xsl:element name="reg">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="style_cesure">
        <xsl:element name="pc">
            <xsl:attribute name="type">
                <xsl:attribute name="nom">marqueCesure</xsl:attribute>
            </xsl:attribute>
            <xsl:element name="choice">
                <xsl:element name="orig">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="style_lettrine">
        <xsl:element name="seg">
            <xsl:attribute name="type">
                <xsl:attribute name="nom">initial</xsl:attribute>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="style_fin_de_ligne">
        <xsl:element name="lb">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="style_imparfait_moyen_fr">
        <xsl:element name="m">
            <xsl:attribute name="type">
                <xsl:attribute name="nom">desinence</xsl:attribute>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="style_trace_cas">
        <xsl:element name="m">
            <xsl:attribute name="type">
                <xsl:attribute name="nom">diacritique</xsl:attribute>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="style_lx">
        <xsl:element name="m">
            <xsl:attribute name="type">
                <xsl:attribute name="nom">pluriel</xsl:attribute>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="style_lettre_ramiste">
        <xsl:element name="orig">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="style_remplacement_lettre_ramiste">
        <xsl:element name="reg">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="style_s_long">
        <xsl:element name="orig">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="style_remplacement_s_long">
        <xsl:element name="reg">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="style_e_inital">
        <xsl:element name="orig">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="style_ajout_accent_aigu">
        <xsl:element name="reg">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="style_c_initial">
        <xsl:element name="orig">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="style_ajout_cedille">
        <xsl:element name="reg">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="style_séparation_mot">
        <xsl:element name="choice">
            <xsl:attribute name="change">
                <xsl:attribute name="nom">desagglutination</xsl:attribute>
            </xsl:attribute>
            <xsl:element name="reg">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    
    <xsl:template match="style_initial_">
        <xsl:element name="abbr">
            <xsl:attribute name="type">
                <xsl:attribute name="nom">remplacementET</xsl:attribute>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="style_remplacement_">
        <xsl:element name="expan">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>










    <!-- fin_des_styles_de_caractère -->









    <!--   5. Traitement de l'élément <figure> pour le restructurer conformement au schéma TEI et notre usage particulier :
    a. Le contenu de l'élément <note>, qui décrit la minature, doit être généré au sein de l'attribut @ana
    b. Le contenu de <figure> dans le document source spécifie sa nature, puis son numéro (ex. "Miniature 1"). Générez ce qui précède l'espace ("Miniature") dans l'attribut @type, et ce qui suit l'espace (le numéro) dans l'attribut @n
    c. L'élément graphic doit avoir un attribut @url qui renvoie à l'emplacement de l'image dans le dossier img (télécharger et dézipper le dossier "img" et placez-le dans le dossier où se trouvera le fichier XML à générer-->


    <!-- 6. Insértion du contenu de name.key dans l'attribut @key de l'élément name qui le précède
        a. Ne pas re-générer <name.key> par ailleurs-->



    <!--  7. Traitement des différentes cas de figure de <choice> 
        a. Traitement des éléments de la version imitative, orig, abbr et sic, qui précèdent les éléments de la version normalisée reg, expan et corr.
        b. Traitement des cas de figure :  <choice><orig>X</orig></choice><choice><orig>Y</orig></choice>                                           -> <choice><orig>X</orig><reg>Y</reg></choice>
        c. Traitement des cas de figure :                                                                           <pc><choice><orig>X</orig></choice></pc><pc><choice><orig>Y</orig></choice></pc> ->                        <pc><choice><orig>X</orig><reg>Y</reg></choice></pc>
        d. Traitement des éléments présents uniquement dans la version normalisée
      NB. Ce traitement est complèxe et demande la création de plusieurs templates (en différents modes), et de plusieurs conditions. En fonction de votre aisance en XSLT, vous pouvez préférer, dans le cadre de vos traitements individuels, de passer par plusieurs transformations successives. Ce n'est pas une mauvaise solution (contrairement à l'abandon ou à la réutilisation des templates qu'on ne comprend pas)
    -->


</xsl:stylesheet>
