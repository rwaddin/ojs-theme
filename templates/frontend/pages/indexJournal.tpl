{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * UPDATED/CHANGED/MODIFIED: Marc Behiels - marc@elemental.ca - 250416
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $journalThumbnail
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $issue Issue Current issue
 * @uses $article

 *}
 
{assign var=smarty_version value=$smarty.version|substr:0:1}
 
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}
<h1>index journal</h1>
<div id="main-content" class="page_index_journal" role="content">

	{call_hook name="Templates::Index::journal"}

	{if $homepageImage}
		<div class="homepage-image">
			<img class="img-responsive" src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImageAltText|escape}">
		</div>
	{/if}

	{if $journalDescription}
	
		{capture assign="url"}{url journal=$currentJournal->getPath()}{/capture}
		{assign var="thumb" value=$currentJournal->getLocalizedSetting('journalThumbnail')}
		{assign var="description" value=$currentJournal->getLocalizedDescription()}	


		<div class="col-md-4">
				<img class="media-object" width="200px" src="{$publicFilesDir}/{$journalFilesPath}/{$thumb.uploadName|escape:"url"}"{if $altText} alt="{$altText|escape}"{/if}>
		</div>
		<div class="journal-description col-md-8" style="margin-top: 15px">	
			{* {$journalDescription} *}
			{$description|nl2br}
		</div>
	{/if}


		{* Additional Homepage Content *}
	{if $additionalHomeContent}
		<section class="additional_content col-md-12">
			{$additionalHomeContent}
		</section>
	{/if}

		<div class="clearfix"></div>

						<div class="or-spacer">
						<div class="mask"></div>
						</div>

	{* Announcements *}
	{* make compatible with ojs 3.1.2 *}
	{if $smarty_version == '2'} 
		{include file="legacy/indexJournal_announcements_3.1.1.tpl"}
	{else}
		{include file="legacy/indexJournal_announcements_3.1.2.tpl"}
	{/if}
	{* end compatible check *}


	{* Latest issue *}
	{if $issue}
		<section class="current_issue col-md-12">
			<header class="page-header">
				<h2>
					{translate key="journal.currentIssue"}
				</h2>
			</header>
			<p class="current_issue_title ">
				{$issue->getIssueIdentification()|strip_unsafe_html}
			</p>
			{include file="frontend/objects/issue_toc.tpl"}
			<a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}" class="btn btn-info pull-right read-more">
				{translate key="journal.viewAllIssues"}
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</section>
	{/if}


</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
