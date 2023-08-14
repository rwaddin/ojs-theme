{if ($journals && !count($journals))}
    <div class="no_journals">
        {translate key="site.noJournals"}
    </div>
{else}
    <ul class="media-list row">
        {foreach from=$journals item=journal}
            {capture assign="url"}{url journal=$journal->getPath()}{/capture}
            {assign var="thumb" value=$journal->getLocalizedSetting('journalThumbnail')}
            {assign var="description" value=$journal->getLocalizedDescription()}
            <li class="media col-md-6 col-xs-12">
                {if $thumb}
                    {assign var="altText" value=$journal->getLocalizedSetting('journalThumbnailAltText')}
                    <div class="col-xs-12 col-md-4">
                        <a href="{$url|escape}">
                            <img class="media-object img-responsive" src="{$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"}"{if $altText} alt="{$altText|escape}"{/if}>
                        </a>
                    </div>
                {else}
                    <div class="col-md-4">
                        <a href="#">
                            <img class="media-object center-block img-responsive" src="{$pluginImageDir}logo.png">
                        </a>
                    </div>
                {/if}

                <div class="media_body col-md-8 col-xs-12">
                    <h3 class="media-heading">
                        <a href="{$url|escape}" rel="bookmark">
                            {$journal->getLocalizedName()}
                        </a>
                    </h3>
                    {if $description}
                        <div class="description">
                            {$description|nl2br}
                        </div>
                    {/if}
                    <ul class="nav nav-pills">
                        <li class="view">
                            <a href="{$url|escape}">
                                {translate key="site.journalView"}
                            </a>
                        </li>
                        <li class="current">
                            <a href="{url|escape journal=$journal->getPath() page="issue" op="current"}">
                                {translate key="site.journalCurrent"}
                            </a>
                        </li>
                    </ul>
                </div>


                <div class="clearfix"></div>

                <div class="or-spacer">
                <div class="mask"></div>
                </div>


            </li>
        {/foreach}
    </ul>

    {/if}
