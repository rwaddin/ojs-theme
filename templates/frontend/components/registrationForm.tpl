{**
 * templates/frontend/components/registrationForm.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the basic registration form fields
 *
 * @uses $locale string Locale key to use in the affiliate field
 * @uses $firstName string First name input entry if available
 * @uses $middleName string Middle name input entry if available
 * @uses $lastName string Last name input entry if available
 * @uses $countries array List of country options
 * @uses $country string The selected country if available
 * @uses $email string Email input entry if available
 * @uses $username string Username input entry if available
 *}

{assign var=smarty_version value=$smarty.version|substr:0:1}

{* make compatible with ojs 3.1.2 *}
	{if $smarty_version == '2'} 
		{include file="legacy/registrationForm_3.1.1.tpl"}
	{else}
		{include file="legacy/registrationForm_3.1.2.tpl"}
	{/if}
{* end compatible check *}
