<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xdmp="http://marklogic.com/xdmp" version="2.0">
	<xsl:output method="xml" encoding="utf-8" indent="yes"
		omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="//BizObject[@Class='NStein.CONDENAST.Business.Article']">
		<cnp:asset class="article" xmlns:xdmp="http://marklogic.com/xdmp"
			xmlns:prism="http://prismstandard.org/namespaces/basic/1.2/"
			xmlns:pim="http://prismstandard.org/namespaces/pim/1.2/" xmlns:pam="http://prismstandard.org/namespaces/pam/1.0/"
			xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"
			xmlns:prl="http://prismstandard.org/namespaces/prl/1.2/" xmlns:cnp="reserve path">

			<!-- CNP Metadata -->
			<cnp:metadata>
				<cnp:id>
					<xsl:value-of select="./Id" />
				</cnp:id>

				<cnp:createdOn>
					<xsl:value-of select="./CreatedAt" />
				</cnp:createdOn>

				<cnp:createdBy>
					<xsl:value-of select="./CreatedBy" />
				</cnp:createdBy>

				<cnp:modifedOn>
					<xsl:value-of select="./ModifiedAt" />
				</cnp:modifedOn>

				<cnp:modifedBy>
					<xsl:value-of select="./ModifiedBy" />
				</cnp:modifedBy>

				<cnp:state>
					<xsl:attribute name="id">
                <xsl:value-of select="./Status/@Id" />
              </xsl:attribute>
					<xsl:value-of select="./Status" />
				</cnp:state>

				<cnp:liveDate>
					<xsl:value-of select="./Content/Metadata/LiveDate" />
				</cnp:liveDate>

				<cnp:thirdPartyLicnensor>
					<xsl:value-of select="./Content/Metadata/ThirdParties" />
				</cnp:thirdPartyLicnensor>

				<cnp:assetComments>
					<xsl:value-of select="./Content/Metadata/AssetComments" />
				</cnp:assetComments>

				<cnp:sectionCode>
					<xsl:value-of select="./Content/Metadata/SectionCode" />
				</cnp:sectionCode>

				<cnp:fileSize>
					<xsl:value-of select="./Content/Metadata/FileSize" />
				</cnp:fileSize>

				<cnp:assignmentNumberText>
					<xsl:value-of select="./Content/Metadata/AssignmentNumber" />
				</cnp:assignmentNumberText>

				<cnp:assignmentContribClass>
					<xsl:value-of select="./Content/Metadata/CreatorStatus" />
				</cnp:assignmentContribClass>

				<cnp:assignmentContributor>
					<xsl:value-of select="./Content/Metadata/RightsCredit" />
				</cnp:assignmentContributor>

				<cnp:accountingIssueDate>
					<xsl:value-of select="./Content/Metadata/AcctDate" />
				</cnp:accountingIssueDate>

				<cnp:onSaleDate>
					<xsl:value-of select="./Content/Metadata/OnSaleDate" />
				</cnp:onSaleDate>

				<cnp:offSaleDate>
					<xsl:value-of select="./Content/Metadata/OffSaleDate" />
				</cnp:offSaleDate>

				<cnp:fileName>
					<xsl:value-of select="./Content/Metadata/FileName" />
				</cnp:fileName>

				<cnp:filePath>
					<xsl:value-of select="./Content/Metadata/FilePath" />
				</cnp:filePath>

				<cnp:pageNumbers>
					<xsl:for-each select="./Content/Metadata/ArticlePages/ArticlePage">
						<cnp:pageNumber>
							<xsl:attribute name="logical">
                    <xsl:value-of select="./@Id" />
                  </xsl:attribute>
							<!-- If there is an alterante page overwrite the in book page -->
							<xsl:variable name="alternatePage">
								<xsl:value-of
									select="./Content/Metadata/AlternatePageVersion[position()]" />
							</xsl:variable>
							<xsl:attribute name="inBook">
                    <xsl:choose>
                      <xsl:when test="$alternatePage">
                        <xsl:value-of select="$alternatePage" />
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="." />
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
						</cnp:pageNumber>
					</xsl:for-each>
				</cnp:pageNumbers>

				<cnp:articleKeywords>
					<xsl:variable name="internalKeywords">
						<xsl:value-of select="./Content/Metadata/KeywordsInternal" />
					</xsl:variable>
					<xsl:variable name="externalKeywords">
						<xsl:value-of select="./Content/Metadata/KeywordsExternal" />
					</xsl:variable>
					<!-- Iterate over the tokens for the internal keywords and check that 
						the keyword is not in the external keywords. If they are not then output 
						them to the keywords -->
					<xsl:for-each select="tokenize($internalKeywords,',')">
						<xsl:if test="not(. = tokenize($externalKeywords,','))">
							<cnp:articleKeyword>
								<xsl:value-of select="." />
							</cnp:articleKeyword>
						</xsl:if>
					</xsl:for-each>
				</cnp:articleKeywords>
			</cnp:metadata>

			<cnp:content>
				<pam:article xml:lang="en-US">
					<head>
						<!-- Relations -->
						<xsl:for-each select="//BizRelation">
							<dc:relation>
								<xsl:variable name="kind">
									<xsl:value-of select="./@Kind" />
								</xsl:variable>
								<xsl:if test="$kind = 'LINKED_TO'">
									<dcterms:hasPart>
										<xsl:value-of select="./Id" />
									</dcterms:hasPart>
								</xsl:if>
								<xsl:if test="$kind = 'BELONGS_TO'">
									<dcterms:isPartOf>
										<xsl:value-of select="./Id" />
									</dcterms:isPartOf>
								</xsl:if>
								<cnp:relationType>
									<xsl:value-of
										select="substring-after(./ClassName,'NStein.CONDENAST.Business.')" />
								</cnp:relationType>
								<cnp:bestRepresentation>
									<xsl:value-of select="./Best" />
								</cnp:bestRepresentation>
							</dc:relation>
						</xsl:for-each>
						<!-- Relations End -->

						<!-- Dublin Core Elements -->
						<dc:identifier>
							<xsl:value-of select="./Content/Metadata/IssueIdentifier" />
						</dc:identifier>

						<dc:publisher>
							<xsl:value-of select="./Content/Metadata/Publisher" />
						</dc:publisher>

						<dc:title>
							<xsl:value-of select="./Content/Metadata/Title" />
						</dc:title>

						<dc:creator>
							<xsl:value-of select="./Content/Metadata/Creator" />
						</dc:creator>

						<xsl:for-each select="./Content/Metadata/Contributors/Contributor">
							<dc:contributor>
								<xsl:value-of select="." />
							</dc:contributor>
						</xsl:for-each>

						<dc:type>
							<xsl:value-of
								select="substring-after(./@Class,'NStein.CONDENAST.Business.')" />
						</dc:type>

						<xsl:for-each select="./Sources/SourceId">
							<dc:source>
								<xsl:value-of select="." />
							</dc:source>
						</xsl:for-each>
						<dc:description>
							<xsl:value-of select="./Content/Metadata/Abstract" />
						</dc:description>

						<dc:subject>
							<xsl:value-of select="./Content/Metadata/KeywordsInternal" />
						</dc:subject>

						<!-- Prism Elements -->
						<prism:publicationName>
							<xsl:value-of select="./Content/Metadata/Publication" />
						</prism:publicationName>

						<prism:issn>
							<xsl:value-of select="./Content/Metadata/ISSN" />
						</prism:issn>

						<prism:coverDate>
							<xsl:value-of select="./Content/Metadata/CoverDate" />
						</prism:coverDate>

						<prism:coverDisplayDate>
							<xsl:value-of select="./Content/Metadata/CoverDisplayDate" />
						</prism:coverDisplayDate>

						<prism:volume>
							<xsl:value-of select="./Content/Metadata/Volume" />
						</prism:volume>

						<prism:number>
							<xsl:value-of select="./Content/Metadata/Number" />
						</prism:number>

						<prism:startingPage>
							<xsl:value-of select="./Content/Metadata/StartingPage" />
						</prism:startingPage>

						<prism:section>
							<xsl:value-of select="./Content/Metadata/Section" />
						</prism:section>

						<xsl:for-each select="./Content/Metadata/Categories/Category">
							<prism:category>
								<xsl:value-of select="." />
							</prism:category>
						</xsl:for-each>

						<prism:copyright>
							<xsl:value-of select="./Content/Metadata/CopyrightNotice" />
						</prism:copyright>

						<prism:wordCount>
							<xsl:value-of select="./Content/Metadata/WordCount" />
						</prism:wordCount>

						<prism:subsection1>
							<xsl:value-of select="./Content/Metadata/Subsection" />
						</prism:subsection1>

					</head>
					<body>
						<xsl:variable name="body">
							<xsl:value-of select="./Content/Metadata/FullText"
								disable-output-escaping="yes" />
						</xsl:variable>
						<xsl:value-of select="xdmp:unquote($body)"  />
					</body>
				</pam:article>
			</cnp:content>
		</cnp:asset>
	</xsl:template>
</xsl:stylesheet>
