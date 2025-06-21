<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	exclude-result-prefixes="xs xd" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
	version="2.0">
	<!-- Ajout à <xsl:stylesheet> de l'attribut « xpath-default-namespace="http://www.tei-c.org/ns/1.0" » afin de traiter les éléments de la TEI -->
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Dec 2, 2021</xd:p>
			<xd:p><xd:b>Author:</xd:b> Gasiglia</xd:p>
			<xd:p>XSLT pour convertir un XML de Sarrasine en HTML avec CSS, en y ajoutant un index
				de toutes les occurrences de &lt;persName&gt; (ici employé pour les noms ou
				dénominations de personnes ou personnages).</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:output method="xhtml"/>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="TEI">
		<xsl:element name="html">
			<xsl:element name="head">
				<xsl:element name="title">
					<xsl:text>Sarrasine [extrait]</xsl:text>
				</xsl:element>
				<xsl:element name="link">
					<xsl:attribute name="href">Sarrasine_DEME_MALAGNOUX_MODOLO.css</xsl:attribute>
					<xsl:attribute name="rel">stylesheet</xsl:attribute>
					<xsl:attribute name="type">text/css</xsl:attribute>
				</xsl:element>
			</xsl:element>
			<xsl:element name="body">
				<xsl:element name="div">
					<xsl:attribute name="class">
						<xsl:text>index</xsl:text>
					</xsl:attribute>
					<a href="Sarrasine_houssiaux_DEME_MALAGNOUX_MODOLO.html">Édition Houssiaux</a>
					<xsl:element name="ul">
						<xsl:element name="h1">
							<xsl:text>Lieux</xsl:text>
						</xsl:element>
						<xsl:apply-templates select="descendant::placeName" mode="index_liste_principale">
							<xsl:sort select="upper-case(.)" order="descending"/><!-- sensible à la case -->
						</xsl:apply-templates>
					</xsl:element>
					
					<xsl:element name="ul">
						<xsl:element name="h1">
							<xsl:text>Date</xsl:text>
						</xsl:element>
						<xsl:apply-templates select="descendant::date" mode="index_liste_principale">
							<xsl:sort select="upper-case(.)" order="descending"/><!-- sensible à la case -->
						</xsl:apply-templates>
					</xsl:element>
					<xsl:element name="ul">
						<xsl:element name="h1">
							<xsl:text>Temps</xsl:text>
						</xsl:element>
						<xsl:apply-templates select="descendant::time" mode="index_liste_principale">
							<xsl:sort select="upper-case(.)" order="descending"/><!-- sensible à la case -->
						</xsl:apply-templates>
					</xsl:element>
					
					
					<xsl:element name="ul">
						<xsl:element name="h1">
							<xsl:text>Objets</xsl:text>
						</xsl:element>
						<xsl:apply-templates select="descendant::objectName" mode="index_liste_principale">
							<xsl:sort select="upper-case(.)" order="descending"/><!-- sensible à la case -->
						</xsl:apply-templates>
					</xsl:element>

					<!-- Nous voulons la listes des <persName>. En HTML une liste est un élément <ul> et les items de la liste sont des éléments <li>. -->
					<xsl:element name="ul">
						<xsl:element name="h1">
							<xsl:text>Personnages</xsl:text>
						</xsl:element>
						<xsl:apply-templates select="//persName" mode="index_liste_principale">
							<xsl:sort select="@key"/> 
						</xsl:apply-templates>
					</xsl:element>
				</xsl:element>
				<xsl:element name="div">
					<xsl:attribute name="class">texte_complet</xsl:attribute>
					<xsl:apply-templates select="child::*[local-name() != 'teiHeader']"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="placeName" mode="index_liste_principale">
		<xsl:element name="li">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	
	<xsl:template match="objectName" mode="index_liste_principale">
		<xsl:element name="li">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="time" mode="index_liste_principale">
		<xsl:element name="li">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="date" mode="index_liste_principale">
		<xsl:element name="li">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	
	<xsl:template match="persName" mode="index_liste_principale"> <!-- ce template va gérer l'affichage de tous les éléments persName pour avoir un regroupement -->
		<xsl:variable name="key" select="@key"/> 
		<xsl:if test="not(preceding::persName[@key = $key])">
			<xsl:element name="li"> <!-- élément de la liste principale -->
				<xsl:element name="h2">
					<xsl:text>Personnage : </xsl:text>
					<xsl:element name="span">
						<xsl:attribute name="style">font-style: italic;font-size : 60%</xsl:attribute>
						
						<xsl:value-of select="@key"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="ul"> <!-- élement sous liste -->
					<xsl:apply-templates select=". | following::persName[@key = $key]"
						mode="index_sous_listes">
						<xsl:sort select="."/>
						<!-- ou "." pour trier par ordre alphabétique les contenus des éléments <persName> sélectionnés -->
					</xsl:apply-templates>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="persName" mode="index_sous_listes"> <!-- template quand il s'agit de l'afficher   -->
		<xsl:element name="li">
			<xsl:attribute name="class">
				<xsl:value-of select="local-name()"/>
			</xsl:attribute>
			<xsl:element name="a">
				<!-- on lui donne une encre pour avoir une navigation avec des liens hypertextes -->
				<xsl:attribute name="class">persName</xsl:attribute>
				<xsl:attribute name="href"> <!-- une encre de depzt qui permet de pointer vers le texte complet -->
					<xsl:text>#</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:attribute name="id">
					<xsl:text>index_</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	
	<xsl:template match="placeName" mode="index_liste_principale">
		<xsl:element name="li">
			<xsl:attribute name="class">
				<xsl:value-of select="local-name()"/>
			</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">PlaceName</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:text>#</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:attribute name="id">
					<xsl:text>index_</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	
	<xsl:template match="placeName"> <!-- template pour créer un lien du texte vers l'index  -->
		<xsl:element name="span">
			<xsl:attribute name="class">
				<xsl:value-of select="local-name()"/>
			</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">PlaceName</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:text>#index_</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:attribute name="id">
					<xsl:text/>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
<!--	Quand la création de l'index sera incluse dans la transformation qui affichera l'index (en marge gauche, selon les instructions de la CSS) et le texte (à la droite de l'index, selon la CSS toujours), il faudra que le template ci-dessous crée des ancres pour les <persName> du texte principal (celui dont les templates ne porte pas de mode). -\->-->
				<xsl:template match="persName">
			<xsl:element name="span">
				<xsl:attribute name="class">
					<xsl:value-of select="local-name()"/>
				</xsl:attribute>
				<xsl:element name="a">
					<xsl:attribute name="class">persName</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:text>#index_</xsl:text>
						<xsl:value-of select="generate-id()"/>
					</xsl:attribute>
					<xsl:attribute name="id">
						<xsl:text/>
						<xsl:value-of select="generate-id()"/>
					</xsl:attribute>
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:element>
		</xsl:template>
	
	
	
	
	<xsl:template match="date" mode="index_liste_principale">
		<xsl:element name="li">
			<xsl:attribute name="class">
				<xsl:value-of select="local-name()"/>
			</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">date</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:text>#</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:attribute name="id">
					<xsl:text>index_</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="date"> <!-- template pour créer un lien du texte vers l'index  -->
		<xsl:element name="span">
			<xsl:attribute name="class">
				<xsl:value-of select="local-name()"/>
			</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">date</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:text>#index_</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:attribute name="id">
					<xsl:text/>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="time" mode="index_liste_principale">
		<xsl:element name="li">
			<xsl:attribute name="class">
				<xsl:value-of select="local-name()"/>
			</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">time</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:text>#</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:attribute name="id">
					<xsl:text>index_</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="time"> <!-- template pour créer un lien du texte vers l'index  -->
		<xsl:element name="span">
			<xsl:attribute name="class">
				<xsl:value-of select="local-name()"/>
			</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">time</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:text>#index_</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:attribute name="id">
					<xsl:text/>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	
	<xsl:template match="objectName" mode="index_liste_principale">
		<xsl:element name="li">
			<xsl:attribute name="class">
				<xsl:value-of select="local-name()"/>
			</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">objectName</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:text>#</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:attribute name="id">
					<xsl:text>index_</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="objectName"> <!-- template pour créer un lien du texte vers l'index  -->
		<xsl:element name="span">
			<xsl:attribute name="class">
				<xsl:value-of select="local-name()"/>
			</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">objectName</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:text>#index_</xsl:text>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:attribute name="id">
					<xsl:text/>
					<xsl:value-of select="generate-id()"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	
	
	


	<!--<xsl:template match="teiHeader">
		<xsl:element name="p">
			<xsl:attribute name="class"></xsl:attribute>
			<!-\-<xsl:apply-templates/>-\->
		</xsl:element>
	</xsl:template>-->


	<xsl:template match="back">
		<xsl:element name="p">
			<xsl:attribute name="class">back</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>


	<xsl:template match="docAuthor">
		<xsl:element name="p">
			<xsl:attribute name="class">auteur</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	
	
	<xsl:template match="epigraph">
		<xsl:element name="p">
			<xsl:attribute name="class">epigraph</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="docTitle">
		<xsl:element name="p">
			<xsl:attribute name="class">titre</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="said">
		<xsl:element name="p">		
				<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="p">
		<xsl:element name="p">
			<xsl:attribute name="class">p</xsl:attribute>			
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	

<xsl:template match="reg"/>
	
		
	
		
	
	



	








</xsl:stylesheet>
