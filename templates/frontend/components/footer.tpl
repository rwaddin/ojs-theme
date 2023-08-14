{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
* @uses $currentContext Journal|Press The current journal or press
* @uses $about 
 * @uses $mailingAddress string Mailing address for the journal/press
 * @uses $contactName string Primary contact name
 * @uses $contactTitle string Primary contact title
 * @uses $contactAffiliation string Primary contact affiliation
 * @uses $contactPhone string Primary contact phone number
 * @uses $contactEmail string Primary contact email address
 * @uses $supportName string Support contact name
 * @uses $supportPhone string Support contact phone number
 * @uses $supportEmail string Support contact email address
 *}

	</main>

	{* Sidebars *}
	{if empty($isFullWidth)}
		{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
		{if $sidebarCode}
			<aside id="sidebar" class="pkp_structure_sidebar left col-xs-12 col-sm-2 col-md-4" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
				{$sidebarCode}
			</aside><!-- pkp_sidebar.left -->
		{/if}
	{/if}
	</div><!-- pkp_structure_content -->
	<div class="container list_of_index">
		<div class="col-md-12 indexed_by hidden">

		</div>
	</div>
	<div class="footer_border"></div>
	<footer id="footer" class="footer" role="contentinfo">
		<div class="container-fluid no-padding-left no-padding-right">
			<div class="container footer-contact">
				<div class="row">
					<div class="col-md-5">
						{* Show site Logo *}
						{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
						<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if}>
						{else}
							<img  style='width:100%; border="1px solid #e5e5e5"; border-radius: 4px;' alt="site_logo" src="{$pluginImageDir}logo_banner.png" />
						{/if}
					</div>

					<div class="col-md-3">
						<h4><em class="fa fa-envelope-o">&nbsp;</em>Address</h4>
						<p>Jl. KH. Moh. Muqri, RT.02/RW.02, Cijeruk, Sirau, Kec. Kemranjen, Kabupaten Banyumas, Jawa Tengah 53194</p>
						<div class="social_media_list">EMail: journal.mts@gmail.com</div>
					</div>

					<div class="col-md-4 contact_detail">
						<h4><em class="fa fa-user-o">&nbsp;</em> Contact Info</h4>
						<p><strong>Akhul Syaifudin</strong> <br>
						Phone: 6285-xxxx-xxx-xxx <br>
						Email:&nbsp;<a href="mailto:akhul.syaifudin@gmial.com">akhul.syaifudin@gmial.com</a></p>
					</div>
				</div>
			</div>
			<div class="copyright-wrapper">
				<div class="container">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12">
							<div class="copy-right">
								<p>
									<a href="http://creativecommons.org/licenses/by-sa/4.0/" rel="license"><img src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" alt="Lisensi Creative Commons" /></a><br />
									EJournal <a href="http://ojs.mtsmaarifnu1kemranjen.sch.id/" target="_blank" rel="noopener">https://ojs.mtsmaarifnu1kemranjen.sch.id</a>&nbsp;is licensed under a&nbsp;
									<a href="http://creativecommons.org/licenses/by-sa/4.0/" rel="license">Lisensi Creative Commons Atribusi-BerbagiSerupa 4.0 Internasional</a>.
								</p>
								<div id="standardFooter">
									Copyright @ 2023 <strong><a href="https://mtsmaarifnu1kemranjen.sch.id/">MTs MA'ARIF NU 1 Kemranjen</a>,</strong> powered by <a href="http://pkp.sfu.ca/ojs/" target="_blank" rel="noopener">Open Journal Systems</a> theme by
									<a href="https://openjournaltheme.com/" target="_blank" rel="noopener">Open Journal Theme</a> and custom by <a href="https://addin.my.id/" target="_blank" rel="noopener">Akhul Syaifudin</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>


</div><!-- pkp_structure_page -->

{load_script context="frontend" scripts=$scripts}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
