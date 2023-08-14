{**
 * templates/content.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display Static Page content
 *}

{include file="frontend/components/header.tpl" isFullWidth=true pageTitleTranslated=$title}

<div class="page-static">
	<div class="row page-header justify-content-md-center">
		<div class="col-md-8">
			<h1>{$title|escape}</h1>
		</div>
	</div>
	<div class="row justify-content-md-center">
		<div class="col-md-8">
			<div class="page-content">
				{$content}
			</div>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl" isFullWidth=true}
