{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article.
 *  Expected to be primary object on the page.
 *
 * @uses $article Article This article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $keywords array List of keywords assigned to this article
 * @uses $citationFactory @todo
 * @uses $pubIdPlugins @todo
 *}

 {assign var=smarty_version value=$smarty.version|substr:0:1}
 
<article class="article-details">
	<header>
		<h1 class="page-header">
			{$article->getLocalizedTitle()|escape}
			{if $article->getLocalizedSubtitle()}
				<small>
					{$article->getLocalizedSubtitle()|escape}
						{if $section} <span class="pull-right">{translate key="section.section"}	{$section->getLocalizedTitle()|escape}</span> {/if}
				</small>
			{/if}

		
		</h1>
	</header>

	<div class="row">


		<section class="article-sidebar col-md-4">

		

			{* Screen-reader heading for easier navigation jumps *}
			<h2 class="sr-only">{translate key="plugins.themes.academic_pro.article.sidebar"}</h2>

			{* Article/Issue cover image *}
			{if $article->getLocalizedCoverImage() || $issue->getLocalizedCoverImage()}
				<div class="cover-image">
					{if $article->getLocalizedCoverImage()}
						<img class="img-responsive" src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText()} alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
					{else}
						<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
							<img class="img-responsive" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText()} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
						</a>
					{/if}
				</div>
			{/if}

			

		

			<div class="list-group">

				{* Published date *}
				{if $article->getDatePublished()}
					<div class="list-group-item date-published">
						<strong>{translate key="submissions.published"}</strong>
						{$article->getDatePublished()|date_format}
					</div>
				{/if}

				{* DOI (requires plugin) *}
				{* make compatible with ojs 3.1.2 *}
					{if $smarty_version == '2'} 
						{include file="legacy/article_detail_doi_3.1.1.tpl"}
					{else}
						{include file="legacy/article_detail_doi_3.1.2.tpl"}
					{/if}
				{* end compatible check *}
			</div>

			
				{* Galleys *}
				<div class="panel panel-default galley_list">
						<div class="panel-heading">
							<i class="fa fa-download"> </i> Download
						</div>
						<div class="panel-body">
								{* Article Galleys *}
								{if $primaryGalleys || $supplementaryGalleys}
									<div class="download">
										{if $primaryGalleys}
											{foreach from=$primaryGalleys item=galley}
												{include file="frontend/objects/galley_link.tpl" parent=$article purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
											{/foreach}
										{/if}
										{if $supplementaryGalleys}
											{foreach from=$supplementaryGalleys item=galley}
												{include file="frontend/objects/galley_link.tpl" parent=$article isSupplementary="1"}
											{/foreach}
										{/if}
									</div>
								{/if}
						</div>
				</div>

				{* Stat *}
				{if $enableStatistic != 'no'}
				<div class="panel panel-default galley_list">
						<div class="panel-heading">
							<i class="fa fa-bar-chart"> </i> Statistic
						</div>
						<div class="panel-body">					
							{call_hook name="Templates::Article::Main"}
						</div>
				</div>
				{/if}

			
		

		</section><!-- .article-sidebar -->

		<div class="col-md-8">
			<section class="article-main">
				
				{* Issue *}
				<div class="issue_detail">			
				<a class="title" href="{url page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}">
				{$issue->getIssueIdentification()}
				</a>
				</div>


				{* Screen-reader heading for easier navigation jumps *}
				<h2 class="sr-only">{translate key="plugins.themes.academic_pro.article.main"}</h2>

				{if $article->getAuthors()}
					<div class="authors">
						{foreach from=$article->getAuthors() item=author}
							<div class="author">
							<i class="fa fa-user"> </i>
								<strong>{$author->getFullName()|escape}</strong>
								{if $author->getLocalizedAffiliation()}
									<div class="article-author-affilitation">
										{$author->getLocalizedAffiliation()|escape}
									</div>
								{/if}
								{if $author->getOrcid()}
									<div class="orcid">									
										<a href="{$author->getOrcid()|escape}" target="_blank">
											{$author->getOrcid()|escape}
										</a>
									</div>
								{/if}
							</div>
						{/foreach}
					</div>
				{/if}

				{* Article abstract *}
				{if $article->getLocalizedAbstract()}
					<div class="article-summary" id="summary">
						<h2>{translate key="article.abstract"}</h2>
						<div class="article-abstract">
							{$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}
						</div>
					</div>
				{/if}

				{* Keywords *}
				{* @todo keywords not yet implemented *}

				

			</section><!-- .article-main -->

			<section class="article-more-details">

				{* Screen-reader heading for easier navigation jumps *}
				<h2 class="sr-only">{translate key="plugins.themes.academic_pro.article.details"}</h2>

			
				{* PubIds (requires plugins) *}
				{* make compatible with ojs 3.1.2 *}
				{if $smarty_version == '2'} 
					{include file="legacy/article_detail_pubs_3.1.1.tpl"}
				{else}
					{include file="legacy/article_detail_pubs_3.1.2.tpl"}
				{/if}
				{* end compatible check *}



				{* Article Subject *}
				{if $article->getLocalizedSubject()}
					<div class="panel panel-default subject">
						<div class="panel-heading">
							{translate key="article.subject"}
						</div>
						<div class="panel-body">
							{$article->getLocalizedSubject()|escape}
						</div>
					</div>
				{/if}


			

				{* Licensing info *}
				{if $copyright || $licenseUrl}
					<div class="panel panel-default copyright">
						<div class="panel-body">
							{if $licenseUrl}
								{if $ccLicenseBadge}
									{$ccLicenseBadge}
								{else}
									<a href="{$licenseUrl|escape}" class="copyright">
										{if $copyrightHolder}
											{translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder copyrightYear=$copyrightYear}
										{else}
											{translate key="submission.license"}
										{/if}
									</a>
								{/if}
							{/if}
							{$copyright}
						</div>
					</div>
				{/if}

				{* Author biographies *}
				{assign var="hasBiographies" value=0}
				{foreach from=$article->getAuthors() item=author}
					{if $author->getLocalizedBiography()}
						{assign var="hasBiographies" value=$hasBiographies+1}
					{/if}
				{/foreach}
				{if $hasBiographies}
					<div class="panel panel-default author-bios">
						<div class="panel-heading">
							
							{if $hasBiographies > 1}
								<i class="fa fa-users"> </i>{translate key="submission.authorBiographies"}
							{else}
								<i class="fa fa-user"> </i>{translate key="submission.authorBiography"}
							{/if}
						</div>
						<div class="panel-body">
							{foreach from=$article->getAuthors() item=author}
								{if $author->getLocalizedBiography()}
									<div class="media biography">
										<div class="media-body">
											<h3 class="media-heading biography-author">
												{if $author->getLocalizedAffiliation()}
													{capture assign="authorName"}{$author->getFullName()|escape}{/capture}
													{capture assign="authorAffiliation"}<span class="affiliation">{$author->getLocalizedAffiliation()|escape}</span>{/capture}
													{translate key="submission.authorWithAffiliation" name=$authorName affiliation=$authorAffiliation}
												{else}
													{$author->getFullName()|escape}
												{/if}
											</h3>
											{$author->getLocalizedBiography()|strip_unsafe_html}
										</div>
									</div>
								{/if}
							{/foreach}
						</div>
					</div>
				{/if}

					{* How to cite *}
				{if $citation}
					<div class="panel panel-default how-to-cite">
						<div class="panel-heading">
							<i class="fa fa-file-text"> </i>  {translate key="submission.howToCite"}
						</div>
						<div class="panel-body">
							<div id="citationOutput" role="region" aria-live="polite">
								{$citation}
							</div>
							<div class="btn-group">
							  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-controls="cslCitationFormats">
							    {translate key="submission.howToCite.citationFormats"}
									<span class="caret"></span>
							  </button>
							  <ul class="dropdown-menu" role="menu">
									{foreach from=$citationStyles item="citationStyle"}
										<li>
											<a
												aria-controls="citationOutput"
												href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
												data-load-citation
												data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}"
											>
												{$citationStyle.title|escape}
											</a>
										</li>
									{/foreach}
							  </ul>
							</div>
						</div>
					</div>
				{/if}


				{call_hook name="Templates::Article::Details"}

				{* References *}
				{if $article->getCitations()}
					<div class="article-references">
						<h2><i class="fa fa-bookmark-o text-primary"> </i> {translate key="submission.citations"}</h2>
						<div class="article-references-content">
							 <ol>
							{if $parsedCitations}
							{foreach from=$parsedCitations item="parsedCitation"}
								<li>{$parsedCitation->getCitationWithLinks()|strip_unsafe_html} {call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}</li>
							{/foreach}
							{else}
							{$publication->getData('citationsRaw')|escape|nl2br}
							{/if}
						 </ol>
						</div>
					</div>
				{/if}

			</section><!-- .article-details -->
		</div><!-- .col-md-8 -->
	</div><!-- .row -->

</article>
