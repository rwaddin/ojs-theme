{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 * @uses $currentContext Journal|Press The current journal or press
 *}

{* Determine whether a logo or title string is being displayed *}
{assign var="showingLogo" value=true}
{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
	{assign var="showingLogo" value=false}
{/if}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{* {include file="core:frontend/components/headerHead.tpl"} *}
{include file="frontend/components/headerHead.tpl"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}">
	<div class="pkp_structure_page">

		<nav id="accessibility-nav" class="sr-only" role="navigation" aria-labelled-by="accessible-menu-label">
			<div id="accessible-menu-label">
				{translate|escape key="plugins.themes.academic_free.accessible_menu.label"}
			</div>
			<ul>
			  <li><a href="#main-navigation">{translate|escape key="plugins.themes.academic_free.accessible_menu.main_navigation"}</a></li>
			  <li><a href="#main-content">{translate|escape key="plugins.themes.academic_free.accessible_menu.main_content"}</a></li>
			  <li><a href="#sidebar">{translate|escape key="plugins.themes.academic_free.accessible_menu.sidebar"}</a></li>
			</ul>
		</nav>

		{* Header *}
		<header class="navbar navbar-default" id="headerNavigationContainer" role="banner">

			{* User profile, login, etc, navigation menu*}
			<div class="user_navigation">
			<div class="container">
				<div class="row">
					<nav aria-label="{translate|escape key="common.navigation.user"}">
						{load_menu name="user" id="navigationUser" ulClass="nav nav-pills tab-list pull-right" linkClass="btn btn-info btn-sm"}
					</nav>
				</div><!-- .row -->
			</div><!-- .container-fluid -->
			</div>


			<div class="site_header">
			<div class="container">

				<div class="navbar-header">

					{* Mobile hamburger menu *}
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-menu" aria-expanded="false" aria-controls="navbar">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>

					{* Logo or site title. Only use <h1> heading on the homepage.
					   Otherwise that should go to the page title. *}
					{if $requestedOp == 'index'}
						<h1 class="site-name">
					{else}
						<div class="site-name">
					{/if}
						{capture assign="homeUrl"}
							{if $currentJournal && $multipleContexts}
								{url page="index" router=$smarty.const.ROUTE_PAGE}
							{else}
								{url context="index" router=$smarty.const.ROUTE_PAGE}
							{/if}
						{/capture}

							<span class="logo_small">
								<img src="{$pluginImageDir}logo.png" alt="Header Logo">
							</span>
						{if $displayPageHeaderTitle  && is_string($displayPageHeaderTitle)}
							<a href="{$homeUrl}" class="navbar-brand">{$displayPageHeaderTitle}</a>
						{elseif $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
							<a href="{$homeUrl}" class="navbar-brand navbar-brand-logo">
								<a href="{$homeUrl}" class="navbar-brand">{$pageTitleTranslated}</a>
							</a>
						{else}
							<a href="{$homeUrl}" class="navbar-brand">
								OJS Site Name
							</a>
						{/if}
					{if $requestedOp == 'index'}
						</h1>
					{else}
						</div>
					{/if}

				</div>

				{* Primary site navigation *}
				{capture assign="primaryMenu"}
					{load_menu name="primary" id="main-navigation" ulClass="nav navbar-nav"}
				{/capture}

				{if !empty(trim($primaryMenu)) || !$noContextsConfigured}
					<nav id="nav-menu" class="navbar-collapse collapse" aria-label="{translate|escape key="common.navigation.site"}">
						{* Primary navigation menu for current application *}
						{$primaryMenu}

						{* Search form *}
						{if !$noContextsConfigured}
							<div class="pull-md-right">
								{include file="frontend/components/searchForm_simple.tpl"}
							</div>
						{/if}
					</nav>
				{/if}

			</div><!-- .pkp_head_wrapper -->

			</div>


		</header><!-- .pkp_structure_head -->



{*		<div class="row journal_index">*}


{*			<div class="container">*}
{*				<div class="col-md-5 site_logo">*}
{*					*}
{*					*}{* Show site Logo *}
{*					{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}*}
{*					<img style='width:100%; border="0"' src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if}>*}
{*					{else}*}
{*						<img  style='width:100%; border="0"' alt="site_logo" src="{$pluginImageDir}top_logo.jpg" /> *}
{*					{/if}*}
{*				</div>	*}
{*				*}
{*				{if $about}*}
{*				<div class="col-md-6 site_description">*}
{*							*}
{*								<div class="about_site">*}
{*									{$about|nl2br}*}
{*								</div>*}
{*						*}
{*				</div>	*}
{*				{/if}*}

{*			</div>	*}



{*			{if $currentContext }*}

{*				<div class="container">*}
{*					<div class="col-md-12 about_journal">*}
{*						<h1>About Journal </h1>*}
{*						<p>*}
{*						{$currentContext->getLocalizedSetting('about')}*}
{*						</p>*}
{*					</div>*}
{*				</div>*}

{*				*}
{*			{/if}*}



{*		</div>	*}

		{* Wrapper for page content and sidebars *}
		<div class="pkp_structure_content container main_content">
			{if $site}
				<main class="pkp_structure_main col-xs-12 col-sm-12  col-md-12 index_page " role="main">
			{else}
				<main class="pkp_structure_main col-xs-12 col-sm-7 col-md-8 " role="main">
			{/if}
{if $currentContext}
					contexxt
	{/if}