<?php

/**
 * @file plugins/themes/default/AcademicFreeThemePlugin.inc.php
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Modified by openjournaltheme.com
 * contact : openjournaltheme@gmail.com
 *
 *
 * @class AcademicFreeThemePlugin
 * @ingroup plugins_themes_bootstrap3
 *
 * @brief Default theme
 */

import('lib.pkp.classes.plugins.ThemePlugin');
class AcademicFreeThemePlugin extends ThemePlugin
{

    public $pluginDir;

    public function __construct()
    {
        $this->pluginDir = $this->getPluginPath();
    }

    /**
     * Initialize the theme
     *
     * @return null
     */
    public function init()
    {

        HookRegistry::register('TemplateManager::display', array($this, 'loadTemplateData'));

        // Register option for bootstrap themes
        $this->addOption('bootstrapTheme', 'radio', array(
            'label'       => 'plugins.themes.academic_free.options.academicFree.label',
            'description' => 'plugins.themes.academic_free.options.academicFree.description',
            'options'     => array(
                'yeti' => 'plugins.themes.academic_free.options.academicFree.yeti',
            ),
        ));

        //header option
        $this->addOption('headerTheme', 'radio', array(
            'label'       => 'plugins.themes.academic_free.headerTheme.name',
            'description' => 'plugins.themes.academic_free.headerTheme.description',
            'options'     => array(
                'red'     => 'plugins.themes.academic_free.headerTheme.red',
                'edu'     => 'plugins.themes.academic_free.headerTheme.edu',
                'dots'    => 'plugins.themes.academic_free.headerTheme.dots',
                'diamond' => 'plugins.themes.academic_free.headerTheme.diamond',
                'blue'    => 'plugins.themes.academic_free.headerTheme.blue',

            ),
        ));

        //logo feature
        // Show or hide the statistic
        $this->addOption('logoStyleBig', 'FieldOptions', array(
            'label'       => __('plugins.themes.academic_free.logo_style') . "(Pro Version Only)",
            'description' => __('plugins.themes.academic_free.logo_style_description'),
            'options'     => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.academic_pro.enable'),
                ],

            ],
        ));

        // Add theme options
        $this->addOption('baseColour', 'FieldColor', array(
            'label'       => __('plugins.themes.academic_free.theme_color') . "(Pro Version Only)",
            'description' => __('plugins.themes.academic_free.theme_color_desc'),
            'default'     => '#8a0493',
        ));

        // Show or hide the statistic
        $this->addOption('statistics', 'FieldOptions', [
            'label'       => __('plugins.themes.academic_free.stat_label') . "(Pro Version Only)",
            'description' => __('plugins.themes.academic_free.stat.desc'),
            'options'     => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.academic_free.enable'),
                ],

            ],
            'default'     => true,
        ]);

        // Show or hide the article tracking date
        $this->addOption('article_tracking_date', 'FieldOptions', [
            'label'       => __('plugins.themes.academic_free.article_tracking_date') . "(Pro Version Only)",
            'description' => __('plugins.themes.academic_free.article_tracking_date.desc'),
            'options'     => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.academic_free.enable'),
                ],

            ],
            'default'     => true,
        ]);

        // Show or hide the galley link on journal index
        $this->addOption('galley_link_on_index', 'FieldOptions', [
            'label'       => __('plugins.themes.academic_free.galley_link_on_index') . "(Pro Version Only)",
            'description' => __('plugins.themes.academic_free.galley_link_on_index_desc'),
            'options'     => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.academic_free.enable'),
                ],

            ],
            'default'     => false,
        ]);

        // Show or hide dimension badge
        $this->addOption('dimension_badge', 'FieldOptions', [
            'label'       => __('plugins.themes.academic_free.dimension_badge_label') . "(Pro Version Only)",
            'description' => __('plugins.themes.academic_free.dimension_badge_desc'),
            'options'     => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.academic_free.enable'),
                ],

            ],
            'default'     => false,
        ]);

        // Show or hide the galley link on journal index
        $this->addOption('doi_on_index', 'FieldOptions', [
            'label'       => __('plugins.themes.academic_free.doi_on_index') . "(Pro Version Only)",
            'description' => __('plugins.themes.academic_free.doi_on_index_desc'),
            'options'     => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.academic_free.enable'),
                ],

            ],
            'default'     => true,
        ]);

        // Enable crossmark on article page
        $this->addOption('crossmark_button', 'FieldOptions', [
            'label'       => __('plugins.themes.academic_free.crossmark_label') . "(Pro Version Only)",
            'description' => __('plugins.themes.academic_free.crossmark_button_desc'),
            'options'     => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.academic_free.enable'),
                ],

            ],
            'default'     => false,
        ]);

        $this->addOption('maintenance_mode', 'FieldOptions', [
            'label'       => __('plugins.themes.academic_free.maintenance_label') . "(Pro Version Only)",
            'description' => __('plugins.themes.academic_free.maintenance_desc'),
            'options'     => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.academic_free.enable'),
                ],
            ],
            'default'     => false,
        ]);

        // default style is paper
        $bootstrapTheme = $this->getOption('bootstrapTheme');
        $this->addStyle('bootstrap', 'styles/yeti.less');

        $locale = AppLocale::getLocale();
        if (AppLocale::getLocaleDirection($locale) === 'rtl') {
            if (Config::getVar('general', 'enable_cdn')) {
                $this->addStyle('bootstrap-rtl', '//cdn.rawgit.com/morteza/bootstrap-rtl/v3.3.4/dist/css/bootstrap-rtl.min.css', array('baseUrl' => ''));
            } else {
                $this->addStyle('bootstrap-rtl', 'styles/bootstrap-rtl.min.css');
            }
        }

        // Load jQuery from a CDN or, if CDNs are disabled, from a local copy.
        $min     = Config::getVar('general', 'enable_minified') ? '.min' : '';
        $request =  Application::get()->getRequest();
        if (Config::getVar('general', 'enable_cdn')) {
            $jquery   = '//ajax.googleapis.com/ajax/libs/jquery/' . CDN_JQUERY_VERSION . '/jquery' . $min . '.js';
            $jqueryUI = '//ajax.googleapis.com/ajax/libs/jqueryui/' . CDN_JQUERY_UI_VERSION . '/jquery-ui' . $min . '.js';
        } else {
            // Use OJS's built-in jQuery files
            $jquery   = $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jquery/jquery' . $min . '.js';
            $jqueryUI = $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jqueryui/jquery-ui' . $min . '.js';
        }
        // Use an empty `baseUrl` argument to prevent the theme from looking for
        // the files within the theme directory
        $this->addScript('jQuery', $jquery, array('baseUrl' => ''));
        $this->addScript('jQueryUI', $jqueryUI, array('baseUrl' => ''));
        $this->addScript('jQueryTagIt', $request->getBaseUrl() . '/lib/pkp/js/lib/jquery/plugins/jquery.tag-it.js', array('baseUrl' => ''));

        // Load Bootstrap
        $this->addScript('bootstrap', 'bootstrap/js/bootstrap.min.js');

        // Add navigation menu areas for this theme
        $this->addMenuArea(array('primary', 'user'));

        $this->addStyle('main', 'styles/academic_free.min.css?t='.time());
        $this->addStyle('classy', 'styles/responsive.css?t='.time());
        $this->addStyle('awesome', '//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css', array('baseUrl' => ''));
        $this->addStyle('custom1', 'styles/custom/bootstrap.css');
        $this->addStyle('custom2', 'styles/custom/custom.css?t='.time());
        $this->addStyle('custom1', 'styles/custom/mobile_responsive.css');
        
        
        
        $headerTheme = $this->getOption('headerTheme');
        $this->addStyle('headerTheme', 'styles/header/blue.css');
    }

    /**
     * Get the display name of this plugin
     * @return string
     */
    public function getDisplayName()
    {
        return __('plugins.themes.academic_free.name');
    }

    /**
     * Get the description of this plugin
     * @return string
     */
    public function getDescription()
    {
        return __('plugins.themes.academic_free.description');
    }

    private function getVersionNumber()
    {
        $versionDao = DAORegistry::getDAO('VersionDAO');
        $version    = $versionDao->getCurrentVersion();
        $data       = $version->_data;
        return $data['major'] . $data['minor'];
    }

    /**
     * Fired when the `TemplateManager::display` hook is called.
     *
     * @param string $hookname
     * @param array $args [$templateMgr, $template, $sendContentType, $charset, $output]
     */
    public function loadTemplateData($hookName, $args)
    {

        // Retrieve the TemplateManager
        $templateMgr = $args[0];

        $baseUrl = Config::getVar('general', 'base_url');

        // Attach a custom piece of data to the TemplateManager
        $myCustomData = 'This is my custom data. It could be any PHP variable.';
        $templateMgr->assign('journalVersion', $this->getVersionNumber());
        $templateMgr->assign('pluginDir', $this->getPluginPath());
        $templateMgr->assign('pluginImageDir', $baseUrl . '/' . $this->getPluginPath() . '/images/');
        $templateMgr->assign('themeTag', '<small class="pull-right" style="margin-top: 20px"> By <a https://mtsmaarifnu1kemranjen.sch.id/"> MTs Maarif NU 1 Kemranjen.com </a> </small>');
    }
}
