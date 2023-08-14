{**
 * templates/frontend/components/navigationMenu.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Primary navigation menu list for OJS
 *
 * @uses navigationMenu array Hierarchical array of navigation menu item assignments
 * @uses id string Element ID to assign the outer <ul>
 * @uses ulClass string Class name(s) to assign the outer <ul>
 * @uses liClass string Class name(s) to assign all <li> elements
 *}

{assign var=smarty_version value=$smarty.version|substr:0:1}

{* make compatible with ojs 3.1.2 *}
	{if $smarty_version == '2'} 
		{include file="legacy/navigationMenu_3.1.1.tpl"}
	{else}
		{include file="legacy/navigationMenu_3.1.2.tpl"}
	{/if}
	{* end compatible check *}