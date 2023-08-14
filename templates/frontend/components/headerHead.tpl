<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>
		{$pageTitleTranslated|strip_tags}{* Add the journal name to the end of page titles *}{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
			| {$currentContext->getLocalizedName()}
		{/if}
	</title>
	<meta name="generator" content="{$pageTitleTranslated|strip_tags}{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
			| {$currentContext->getLocalizedName()}{/if} - Academic Free ver 3.3 by openjournaltheme.com">
	{* enable google scholar plugin *}
	{load_header context="frontend"}
	{load_stylesheet context="frontend"}
</head>
