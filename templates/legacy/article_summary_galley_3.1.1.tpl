


{foreach from=$article->getGalleys() item=galley}
	{if $primaryGenreIds}
		{assign var="file" value=$galley->getFile()}
		{if !$galley->getRemoteUrl() && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
			{php}continue;{/php}
		{/if}
	{/if}
	
	{assign var="hasArticleAccess" value=$hasAccess}
	{if ($article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN)}
		{assign var="hasArticleAccess" value=1}
	{/if}
	{include file="frontend/objects/galley_link.tpl" parent=$article hasAccess=$hasArticleAccess}

	
{/foreach}