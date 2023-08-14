{**
 * templates/frontend/pages/indexSite.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site index.
 *
 *}
{include file="frontend/components/header.tpl"}

<div id="main-site" class="page_index_site">
	{* <h1>index site</h1> *}
	<div class="journals">
		<div class="header_line col-md-12">
			About Journal
		</div>
		<div class="col-md-12 site_description" style="margin-bottom: 1em">
			<div class="about_site">
				{if $about}
					<div class="about_site">
						{$about|nl2br}
					</div>
				{/if}
			</div>
			<div class="page-header">
				<h2>
					{translate key="journal.journals"}
				</h2>
			</div>
		</div>


		{if ($journalVersion <= '32')}
			{include file="legacy/indexSite_journal_list_3.2.tpl"}
		{else}
			{include file="legacy/indexSite_journal_list_3.3.tpl"}
		{/if}
	</div>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
