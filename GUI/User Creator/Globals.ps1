﻿#--------------------------------------------
# Declare Global Variables and Functions here
#--------------------------------------------
function Get-ScriptDirectory {
<#
	.SYNOPSIS
		Get-ScriptDirectory returns the proper location of the script.

	.OUTPUTS
		System.String
	
	.NOTES
		Returns the correct path within a packaged executable.
#>
	[OutputType([string])]
	param ()
	if ($null -ne $hostinvocation) {
		Split-Path $hostinvocation.MyCommand.path
	} else {
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}
#Sample variable that provides the location of the script
[string]$ScriptDirectory = Get-ScriptDirectory
$Global:Config_file = $ScriptDirectory + "\Config.txt"
$Global:AD_Config_File = $ScriptDirectory + "\AD_Config.txt"
$Global:OU_Config_File = $ScriptDirectory + "\OU_Config_File.csv"
function Load_Config {
	$Global:ConfigKeys = @{ }
	Get-Content $Config_file | ForEach-Object {
		$Global:Keys = $_ -split "="
		$Global:ConfigKey += @{ $Global:Keys[0] = $Global:Keys[1] }
	}
}
Load_Config
function Loading_Config_First_Form {
	##
	## Add the following line just before show dialog
	## Loading_Config_First_Form
	##
	#########################################
	#			Select Fields				#
	#########################################
	if ($ConfigKey.Listbox -like '*Copy from username*') {
		$labelCopyFromUsername.Visible = $True
		$textbox_Copy_From.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Copy ALL attributes like when copying user*') {
	}
	if ($ConfigKey.Listbox -like '*Description*') {
		$labelDescription.Visible = $True
		$textbox_Description.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Telephone*') {
		$labelTelephone.Visible = $True
		$textbox_Telephone.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Web page*') {
		$labelWebPage.Visible = $True
		$textbox_Web_Page.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Address street*') {
		$labelAddressStreet.Visible = $True
		$textbox_Address_street.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*City*') {
		$labelCity.Visible = $True
		$textbox_City.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*State/Province*') {
		$labelStateProvince.Visible = $True
		$textbox_State_Province.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*ZIP/Postal Code*') {
		$labelZIPPostalCode.Visible = $True
		$textbox_ZIP_Postal_Code.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Profile path*') {
		$labelProfile.Visible = $True
		$labelProfilePath.Visible = $True
		$textbox_Profile_Path.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Logon script*') {
		$labelProfile.Visible = $True
		$labelLogonScript.Visible = $True
		$textbox_Logon_Script.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Local path*') {
		$labelProfile.Visible = $True
		$labelLocalPath.Visible = $True
		$textbox_Local_Path.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Connect x-path*') {
		$labelProfile.Visible = $True
		$labelConnectXpath.Visible = $True
		$textbox_Connect_X_Path.Visible = $True
		$labelDrive.Visible = $True
		$combobox_Drive.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Home*') {
		$labelTelephones.Visible = $True
		$labelHome.Visible = $True
		$textbox_Home.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Mobile*') {
		$labelTelephones.Visible = $True
		$labelMobile.Visible = $True
		$textbox_Mobile.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Fax*') {
		$labelTelephones.Visible = $True
		$labelFax.Visible = $True
		$textbox_Fax.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Job title*') {
		$labelOrganization.Visible = $True
		$labelJob_Title.Visible = $True
		$textbox_Job_Title.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Department*') {
		$labelOrganization.Visible = $True
		$labelDepartment.Visible = $True
		$textbox_Department.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Company*') {
		$labelOrganization.Visible = $True
		$labelCompany.Visible = $True
		$textbox_Company.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*Manager initials*') {
		$labelOrganization.Visible = $True
		$labelManagerInitials.Visible = $True
		$textbox_Manager_initials.Visible = $True
	}
	if ($ConfigKey.Listbox -like '*O365 Licenses*') {
		$labelSelectLicenses.Visible = $true
		$checkedlistbox_licenses.Visible = $true
	}
	if ($checkboxCheckThisBoxToShowAv.Checked) {
		$labelSelectADGroups.Visible = $true
		$checkedlistbox1.Visible = $true
	}
	if ($ConfigKey.checkboxCheckThisBoxIfADGrou -eq "True") {
		$labelSelectADGroups.Visible = $true
		$checkedlistbox_ADgroups.Visible = $true
	}
	$Global:plength = $ConfigKey.Pass_Lenght
}
function Loading_Config {
	#########################################
	#			Select Fields				#
	#########################################
	if ($ConfigKey.Listbox -like '*Copy from username*') {
		$checkedlistbox1.SetItemChecked(0, $true)
	}
	if ($ConfigKey.Listbox -like '*Copy ALL attributes like when copying user*') {
		$checkedlistbox1.SetItemChecked(1, $true)
	}
	if ($ConfigKey.Listbox -like '*Description*') {
		$checkedlistbox1.SetItemChecked(2, $true)
	}
	if ($ConfigKey.Listbox -like '*Telephone*') {
		$checkedlistbox1.SetItemChecked(3, $true)
	}
	if ($ConfigKey.Listbox -like '*Web page*') {
		$checkedlistbox1.SetItemChecked(4, $true)
	}
	if ($ConfigKey.Listbox -like '*Address street*') {
		$checkedlistbox1.SetItemChecked(5, $true)
	}
	if ($ConfigKey.Listbox -like '*City*') {
		$checkedlistbox1.SetItemChecked(6, $true)
	}
	if ($ConfigKey.Listbox -like '*State/Province*') {
		$checkedlistbox1.SetItemChecked(7, $true)
	}
	if ($ConfigKey.Listbox -like '*ZIP/Postal Code*') {
		$checkedlistbox1.SetItemChecked(8, $true)
	}
	if ($ConfigKey.Listbox -like '*Profile path*') {
		$checkedlistbox1.SetItemChecked(9, $true)
	}
	if ($ConfigKey.Listbox -like '*Logon script*') {
		$checkedlistbox1.SetItemChecked(10, $true)
	}
	if ($ConfigKey.Listbox -like '*Local path*') {
		$checkedlistbox1.SetItemChecked(11, $true)
	}
	if ($ConfigKey.Listbox -like '*Connect x-path*') {
		$checkedlistbox1.SetItemChecked(12, $true)
	}
	if ($ConfigKey.Listbox -like '*Home*') {
		$checkedlistbox1.SetItemChecked(13, $true)
	}
	if ($ConfigKey.Listbox -like '*Mobile*') {
		$checkedlistbox1.SetItemChecked(14, $true)
	}
	if ($ConfigKey.Listbox -like '*Fax*') {
		$checkedlistbox1.SetItemChecked(15, $true)
	}
	if ($ConfigKey.Listbox -like '*Job title*') {
		$checkedlistbox1.SetItemChecked(16, $true)
	}
	if ($ConfigKey.Listbox -like '*Department*') {
		$checkedlistbox1.SetItemChecked(17, $true)
	}
	if ($ConfigKey.Listbox -like '*Company*') {
		$checkedlistbox1.SetItemChecked(18, $true)
	}
	if ($ConfigKey.Listbox -like '*Manager initials*') {
		$checkedlistbox1.SetItemChecked(19, $true)
	}
	if ($ConfigKey.Listbox -like '*O365 Licenses*') {
		$checkedlistbox1.SetItemChecked(20, $true)
	}
	$combobox_Password_Length.SelectedItem = $ConfigKey.Pass_Lenght
	#########################################
	#			Mail Solution				#
	#########################################
	if ($ConfigKey.checkboxOffice365 -eq "True") {
		$checkboxOffice365.Checked = $true
		$labelO365Admin.Visible = $true
		$textbox_O365_admin.Visible = $true
		$labelADFSServer.Visible = $true
		$textbox_ADFS_Server.Visible = $true
	}
	if ($ConfigKey.checkboxExchange -eq "True") {
		$checkboxExchange.Checked = $true
		$labelExchangeServer.Visible = $true
		$textbox_Exchange_Server.Visible = $true
	}
	if ($ConfigKey.checkboxExchangeHybridO365 -eq "True") {
		$checkboxExchangeHybridO365.Checked = $true
		$labelO365Admin.Visible = $true
		$textbox_O365_admin.Visible = $true
		$labelADFSServer.Visible = $true
		$textbox_ADFS_Server.Visible = $true
	}
	if ($ConfigKey.checkboxCheckThisBoxIfYouWou -eq "True") {
		$checkboxCheckThisBoxIfYouWou.Checked = $true
	}
	$combobox_cal_perm.SelectedItem = $ConfigKey.cal_perm
	$textbox_O365_admin.Text = $ConfigKey.O365Admin
	$textbox_ADFS_Server.Text = $ConfigKey.ADFS_Server
	$textbox_Exchange_Server.Text = $ConfigKey.EXCH_Server
	#########################################
	#			Active Directory			#
	#########################################
	if ($ConfigKey.checkboxCheckThisBoxToShowAv -eq "True") {
		$checkboxCheckThisBoxToShowAv.Checked = $true
		$labelSelectADGroups.Visible = $true
		$checkedlistbox_ADgroups.Visible = $true
	}
	#########################################
	#					OU					#
	#########################################
	$Global:OU_Conf = Import-Csv $OU_Config_File | Select-Object OU, Name
	$datagridview1.DataSource = ConvertTo-DataTable $Global:OU_Conf
	if ($ConfigKey.Custom_OU -eq "True") {
		$checkboxCheckThisBoxToOnlyUs.Checked = $true
	}
	
}
$global:Country_Name = @{
	"Afghanistan"										   = "AF,004"
	"Aaland Islands"									   = "AX,248"
	"Albania"											   = "AL,008"
	"Algeria"											   = "DZ,012"
	"American Samoa"									   = "AS,016"
	"Andorra"											   = "AD,020"
	"Angola"											   = "AO,024"
	"Anguilla"											   = "AI,660"
	"Antarctica"										   = "AQ,010"
	"Antigua and Barbuda"								   = "AG,028"
	"Argentina"										       = "AR,032"
	"Armenia"											   = "AM,051"
	"Aruba"											       = "AW,533"
	"Australia"										       = "AU,036"
	"Austria"											   = "AT,040"
	"Azerbaijan"										   = "AZ,031"
	"Bahamas"											   = "BS,044"
	"Bahrain"											   = "BH,048"
	"Bangladesh"										   = "BD,050"
	"Barbados"											   = "BB,052"
	"Belarus"											   = "BY,112"
	"Belgium"											   = "BE,056"
	"Belize"											   = "BZ,084"
	"Benin"											       = "BJ,204"
	"Bermuda"											   = "BM,060"
	"Bhutan"											   = "BT,064"
	"Bolivia (Plurinational State of)"					   = "BO,068"
	"Bonaire, Sint Eustatius and Saba"					   = "BQ,535"
	"Bosnia and Herzegovina"							   = "BA,070"
	"Botswana"											   = "BW,072"
	"Bouvet Island"									       = "BV,074"
	"Brazil"											   = "BR,076"
	"British Indian Ocean Territory"					   = "IO,086"
	"Brunei Darussalam"								       = "BN,096"
	"Bulgaria"											   = "BG,100"
	"Burkina Faso"										   = "BF,854"
	"Burundi"											   = "BI,108"
	"Cabo Verde"										   = "CV,132"
	"Cambodia"											   = "KH,116"
	"Cameroon"											   = "CM,120"
	"Canada"											   = "CA,124"
	"Cayman Islands"									   = "KY,136"
	"Central African Republic"							   = "CF,140"
	"Chad"												   = "TD,148"
	"Chile"											       = "CL,152"
	"China"											       = "CN,156"
	"Christmas Island"									   = "CX,162"
	"Cocos (Keeling) Islands"							   = "CC,166"
	"Colombia"											   = "CO,170"
	"Comoros"											   = "KM,174"
	"Congo"											       = "CG,178"
	"Congo (Democratic Republic of the)"				   = "CD,180"
	"Cook Islands"										   = "CK,184"
	"Costa Rica"										   = "CR,188"
	"CÃƒÂ´te d Ivoire"									   = "CI,384"
	"Croatia"											   = "HR,191"
	"Cuba"												   = "CU,192"
	"CuraÃƒÂ§ao"										   = "CW,531"
	"Cyprus"											   = "CY,196"
	"Czechia"											   = "CZ,203"
	"Denmark"											   = "DK,208"
	"Djibouti"											   = "DJ,262"
	"Dominica"											   = "DM,212"
	"Dominican Republic"								   = "DO,214"
	"Ecuador"											   = "EC,218"
	"Egypt"											       = "EG,818"
	"El Salvador"										   = "SV,222"
	"Equatorial Guinea"								       = "GQ,226"
	"Eritrea"											   = "ER,232"
	"Estonia"											   = "EE,233"
	"Eswatini"											   = "SZ,748"
	"Ethiopia"											   = "ET,231"
	"Falkland Islands (Malvinas)"						   = "FK,2387"
	"Faroe Islands"									       = "FO,234"
	"Fiji"												   = "FJ,242"
	"Finland"											   = "FI,246"
	"France"											   = "FR,250"
	"French Guiana"									       = "GF,254"
	"French Polynesia"									   = "PF,258"
	"French Southern Territories"						   = "TF,260"
	"Gabon"											       = "GA,266"
	"Gambia"											   = "GM,270"
	"Georgia"											   = "GE,268"
	"Germany"											   = "DE,276"
	"Ghana"											       = "GH,288"
	"Gibraltar"										       = "GI,292"
	"Greece"											   = "GR,300"
	"Greenland"										       = "GL,304"
	"Grenada"											   = "GD,308"
	"Guadeloupe"										   = "GP,312"
	"Guam"												   = "GU,316"
	"Guatemala"										       = "GT,320"
	"Guernsey"											   = "GG,831"
	"Guinea"											   = "GN,324"
	"Guinea-Bissau"									       = "GW,624"
	"Guyana"											   = "GY,328"
	"Haiti"											       = "HT,332"
	"Heard Island and McDonald Islands"				       = "HM,334"
	"Holy See"											   = "VA,336"
	"Honduras"											   = "HN,340"
	"Hong Kong"										       = "HK,344"
	"Hungary"											   = "HU,348"
	"Iceland"											   = "IS,352"
	"India"											       = "IN,356"
	"Indonesia"										       = "ID,360"
	"Iran (Islamic Republic of)"						   = "IR,364"
	"Iraq"												   = "IQ,364"
	"Ireland"											   = "IE,372"
	"Isle of Man"										   = "IM,833"
	"Israel"											   = "IL,376"
	"Italy"											       = "IT,380"
	"Jamaica"											   = "JM,388"
	"Japan"											       = "JP,392"
	"Jersey"											   = "JE,832"
	"Jordan"											   = "JO,400"
	"Kazakhstan"										   = "KZ,398"
	"Kenya"											       = "KE,404"
	"Kiribati"											   = "KI,296"
	"Korea (Democratic Peoples Republic of)"			   = "KP,4087"
	"Korea (Republic of)"								   = "KR,410"
	"Kuwait"											   = "KW,414"
	"Kyrgyzstan"										   = "KG,417"
	"Lao Peoples Democratic Republic"					   = "LA,418"
	"Latvia"											   = "LV,428"
	"Lebanon"											   = "LB,422"
	"Lesotho"											   = "LS,426"
	"Liberia"											   = "LR,430"
	"Libya"											       = "LY,434"
	"Liechtenstein"									       = "LI,438"
	"Lithuania"										       = "LT,440"
	"Luxembourg"										   = "LU,442"
	"Macao"											       = "MO,446"
	"Macedonia (the former Yugoslav Republic of)"		   = "MK,807"
	"Madagascar"										   = "MG,450"
	"Malawi"											   = "MW,454"
	"Malaysia"											   = "MY,458"
	"Maldives"											   = "MV,462"
	"Mali"												   = "ML,466"
	"Malta"											       = "MT,470"
	"Marshall Islands"									   = "MH,584"
	"Martinique"										   = "MQ,474"
	"Mauritania"										   = "MR,478"
	"Mauritius"										       = "MU,480"
	"Mayotte"											   = "YT,170"
	"Mexico"											   = "MX,484"
	"Micronesia (Federated States of)"					   = "FM,583"
	"Moldova (Republic of)"							       = "MD,498"
	"Monaco"											   = "MC,492"
	"Mongolia"											   = "MN,496"
	"Montenegro"										   = "ME,499"
	"Montserrat"										   = "MS,500"
	"Morocco"											   = "MA,504"
	"Mozambique"										   = "MZ,508"
	"Myanmar"											   = "MM,104"
	"Namibia"											   = "NA,516"
	"Nauru"											       = "NR,520"
	"Nepal"											       = "NP,524"
	"Netherlands"										   = "NL,528"
	"New Caledonia"									       = "NC,540"
	"New Zealand"										   = "NZ,554"
	"Nicaragua"										       = "NI,558"
	"Niger"											       = "NE,562"
	"Nigeria"											   = "NG,566"
	"Niue"												   = "NU,570"
	"Norfolk Island"									   = "NF,574"
	"Northern Mariana Islands"							   = "MP,580"
	"Norway"											   = "NO,578"
	"Oman"												   = "OM,512"
	"Pakistan"											   = "PK,586"
	"Palau"											       = "PW,585"
	"Palestine, State of"								   = "PS,275"
	"Panama"											   = "PA,591"
	"Papua New Guinea"									   = "PG,598"
	"Paraguay"											   = "PY,600"
	"Peru"												   = "PE,604"
	"Philippines"										   = "PH,608"
	"Pitcairn"											   = "PN,612"
	"Poland"											   = "PL,161"
	"Portugal"											   = "PT,620"
	"Puerto Rico"										   = "PR,630"
	"Qatar"											       = "QA,634"
	"RÃƒÂ©union"										   = "RE,638"
	"Romania"											   = "RO,642"
	"Russian Federation"								   = "RU,643"
	"Rwanda"											   = "RW,646"
	"Saint BarthÃƒÂ©lemy"								   = "BL,652"
	"Saint Helena, Ascension and Tristan da Cunha"		   = "SH,654"
	"Saint Kitts and Nevis"							       = "KN,659"
	"Saint Lucia"										   = "LC,662"
	"Saint Martin (French part)"						   = "MF,663"
	"Saint Pierre and Miquelon"						       = "PM,666"
	"Saint Vincent and the Grenadines"					   = "VC,670"
	"Samoa"											       = "WS,882"
	"San Marino"										   = "SM,674"
	"Sao Tome and Principe"							       = "ST,678"
	"Saudi Arabia"										   = "SA,682"
	"Senegal"											   = "SN,686"
	"Serbia"											   = "RS,688"
	"Seychelles"										   = "SC,690"
	"Sierra Leone"										   = "SL,694"
	"Singapore"										       = "SG,702"
	"Sint Maarten (Dutch part)"						       = "SX,534"
	"Slovakia"											   = "SK,703"
	"Slovenia"											   = "SI,705"
	"Solomon Islands"									   = "SB,090"
	"Somalia"											   = "SO,706"
	"South Africa"										   = "ZA,710"
	"South Georgia and the South Sandwich Islands"		   = "GS,239"
	"South Sudan"										   = "SS,728"
	"Spain"											       = "ES,724"
	"Sri Lanka"										       = "LK,144"
	"Sudan"											       = "SD,729"
	"Suriname"											   = "SR,740"
	"Svalbard and Jan Mayen"							   = "SJ,744"
	"Sweden"											   = "SE,752"
	"Switzerland"										   = "CH,756"
	"Syrian Arab Republic"								   = "SY,760"
	"Taiwan, Province of China[a]"						   = "TW,158"
	"Tajikistan"										   = "TJ,762"
	"Tanzania, United Republic of"						   = "TZ,834"
	"Thailand"											   = "TH,764"
	"Timor-Leste"										   = "TL,626"
	"Togo"												   = "TG,768"
	"Tokelau"											   = "TK,772"
	"Tonga"											       = "TO,776"
	"Trinidad and Tobago"								   = "TT,780"
	"Tunisia"											   = "TN,788"
	"Turkey"											   = "TR,792"
	"Turkmenistan"										   = "TM,795"
	"Turks and Caicos Islands"							   = "TC,796"
	"Tuvalu"											   = "TV,798"
	"Uganda"											   = "UG,800"
	"Ukraine"											   = "UA,804"
	"United Arab Emirates"								   = "AE,784"
	"United Kingdom of Great Britain and Northern Ireland" = "GB,826"
	"United States of America"							   = "US,840"
	"United States Minor Outlying Islands"				   = "UM,581"
	"Uruguay"											   = "UY,858"
	"Uzbekistan"										   = "UZ,860"
	"Vanuatu"											   = "VU,548"
	"Venezuela (Bolivarian Republic of)"				   = "VE,862"
	"Viet Nam"											   = "VN,704"
	"Virgin Islands (British)"							   = "VG,092"
	"Virgin Islands (U.S.)"							       = "VI,850"
	"Wallis and Futuna"								       = "WF,876"
	"Western Sahara"									   = "EH,732"
	"Yemen"											       = "YE,887"
	"Zambia"											   = "ZM,894"
	"Zimbabwe"											   = "ZW,716"
}
$Global:Sku = @{
	'AAD_BASIC'																     = 'Azure Active Directory Basic';
	'AAD_BASIC_AAD_BASIC'													     = 'Azure AD Basic - Azure Active Directory Basic';
	'AAD_BASIC_EDU'															     = 'Azure Active Directory Basic for EDU';
	'AAD_EDU'																     = 'Azure Active Directory for Education';
	'AAD_PREMIUM'															     = 'Azure Active Directory Premium P1';
	'AAD_PREMIUM_AAD_PREMIUM'												     = 'Azure AD Premium P1 - Azure AD Premium P1';
	'AAD_PREMIUM_MFA_PREMIUM'												     = 'Azure AD Premium P1 - Azure Multi-Factor Authentication';
	'AAD_PREMIUM_P2'															 = 'Azure Active Directory Premium P2';
	'AAD_PREMIUM_P2_AAD_PREMIUM'												 = 'Azure AD Premium P2 - Azure AD Premium P1';
	'AAD_PREMIUM_P2_AAD_PREMIUM_P2'											     = 'Azure AD Premium P2 - Azure AD Premium P2';
	'AAD_PREMIUM_P2_ADALLOM_S_DISCOVERY'										 = 'Azure AD Premium P2 - Cloud App Security Discovery';
	'AAD_PREMIUM_P2_MFA_PREMIUM'												 = 'Azure AD Premium P2 - Azure Multi-Factor Authentication';
	'AAD_SMB'																     = 'Azure Active Directory';
	'ADALLOM_S_DISCOVERY'													     = 'Cloud App Security Discovery';
	'ADALLOM_S_O365'															 = 'Office 365 Advanced Security Management';
	'ADALLOM_S_STANDALONE'													     = 'Microsoft Cloud App Security';
	'ADALLOM_STANDALONE'														 = 'Microsoft Cloud App Security';
	'ADV_COMMS'																     = 'Advanced Communications add-on for Microsoft Teams';
	'ATA'																	     = 'Azure Advanced Threat Protection';
	'ATP_ENTERPRISE'															 = 'Office 365 Advanced Threat Protection (Plan 1)';
	'ATP_ENTERPRISE_FACULTY'													 = 'Exchange Online Advanced Threat Protection';
	'AX_ENTERPRISE_USER'														 = 'Microsoft Dynamics AX Enterprise';
	'AX_SELF-SERVE_USER'														 = 'Microsoft Dynamics AX Self-Serve';
	'AX7_USER_TRIAL'															 = 'Microsoft Dynamics AX7 User Trial';
	'BI_AZURE_P0'															     = 'Power BI (free)';
	'BI_AZURE_P1'															     = 'Microsoft Power BI Reporting And Analytics Plan 1';
	'BI_AZURE_P2'															     = 'Power BI Pro';
	'BPOS_S_TODO_1'															     = 'To-do (Plan 1)';
	'BPOS_S_TODO_2'															     = 'To-do (Plan 2)';
	'BPOS_S_TODO_3'															     = 'To-do (Plan 3)';
	'BPOS_S_TODO_FIRSTLINE'													     = 'To-do (Firstline)';
	'CCIBOTS_PRIVPREV_VIRAL'													 = 'Power Virtual Agents Viral Trial';
	'CCIBOTS_PRIVPREV_VIRAL_CCIBOTS_PRIVPREV_VIRAL'							     = 'Dynamics Bots Trial';
	'CCIBOTS_PRIVPREV_VIRAL_DYN365_CDS_CCI_BOTS'								 = 'Dynamics Bots Trial - Common Data Service';
	'CCIBOTS_PRIVPREV_VIRAL_FLOW_CCI_BOTS'									     = 'Dynamics Bots Trial - Microsoft Flow';
	'CDS_DB_CAPACITY'														     = 'CDS DB Capacity';
	'COMMUNICATIONS_COMPLIANCE'												     = 'Microsoft Communications Compliance';
	'COMMUNICATIONS_DLP'														 = 'Microsoft Communications Dlp';
	'CRM_HYBRIDCONNECTOR'													     = 'CRM Hybrid Connector';
	'CRMENTERPRISE'															     = 'Microsoft Dynamics CRM Online Enterprise';
	'CRMIUR'																	 = 'CRM for Partners';
	'CRMPLAN2'																     = 'Microsoft Dynamics CRM Online Basic';
	'CRMPLAN2_CRMPLAN2'														     = 'Microsoft Dynamics CRM Online Basic';
	'CRMPLAN2_FLOW_DYN_APPS'													 = 'MS Dynamics CRM Online Basic  - Flow for Dynamics 365';
	'CRMPLAN2_POWERAPPS_DYN_APPS'											     = 'MS Dynamics CRM Online Basic  - PowerApps for Office 365';
	'CRMSTANDARD'															     = 'Microsoft Dynamics CRM Online';
	'CRMSTANDARD_CRMSTANDARD'												     = 'Microsoft Dynamics CRM Online';
	'CRMSTANDARD_FLOW_DYN_APPS'												     = 'MS Dynamics CRM Online - Flow for Dynamics 365     ';
	'CRMSTANDARD_GCC'														     = 'Microsoft Dynamics CRM Online Government Professional';
	'CRMSTANDARD_MDM_SALES_COLLABORATION'									     = 'MS Dynamics CRM Online - MS Dynamics Marketing Sales Collaboration';
	'CRMSTANDARD_NBPROFESSIONALFORCRM'										     = 'MS Dynamics CRM Online - MS Social Engagement Professional';
	'CRMSTANDARD_POWERAPPS_DYN_APPS'											 = 'MS Dynamics CRM Online - PowerApps for Office 365';
	'CRMSTORAGE'																 = 'Microsoft Dynamics CRM Storage';
	'CRMTESTINSTANCE'														     = 'Microsoft Dynamics CRM Test Instance';
	'CUSTOMER_KEY'															     = 'Microsoft Customer Key';
	'DATA_INVESTIGATIONS'													     = 'Microsoft Data Investigations';
	'DDYN365_CDS_DYN_P2'														 = 'Common Data Service';
	'Deskless'																     = 'Microsoft Staffhub';
	'DESKLESSPACK'															     = 'Office 365 F3';
	'DESKLESSPACK_BPOS_S_TODO_FIRSTLINE'										 = 'O365 F1 - To-do (Firstline)';
	'DESKLESSPACK_DESKLESS'													     = 'O365 F1 - Microsoft StaffHub';
	'DESKLESSPACK_DYN365_CDS_O365_F1'										     = 'O365 F1 - Common Data Service';
	'DESKLESSPACK_EXCHANGE_S_DESKLESS'										     = 'O365 F1 - Exchange Online Kiosk';
	'DESKLESSPACK_FLOW_O365_S1'												     = 'O365 F1 - Flow for Office 365 K1';
	'DESKLESSPACK_FORMS_PLAN_K'												     = 'O365 F1 - Microsoft Forms (Plan F1)';
	'DESKLESSPACK_GOV'														     = 'Office 365 F1 for Government';
	'DESKLESSPACK_KAIZALA_O365_P1'											     = 'O365 F1 - Microsoft Kaizala Pro';
	'DESKLESSPACK_MCOIMP'													     = 'O365 F1 - Skype for Business Online (P1)';
	'DESKLESSPACK_OFFICEMOBILE_SUBSCRIPTION'									 = 'O365 F1 - Mobile Apps for Office 365';
	'DESKLESSPACK_POWERAPPS_O365_S1'											 = 'O365 F1 - Powerapps for Office 365 K1';
	'DESKLESSPACK_PROJECTWORKMANAGEMENT'										 = 'O365 F1 - Microsoft Planner';
	'DESKLESSPACK_SHAREPOINTDESKLESS'										     = 'O365 F1 - SharePoint Online Kiosk';
	'DESKLESSPACK_SHAREPOINTWAC'												 = 'O365 F1 - Office for web';
	'DESKLESSPACK_STREAM_O365_K'												 = 'O365 F1 - Microsoft Stream for O365 K SKU';
	'DESKLESSPACK_SWAY'														     = 'O365 F1 - Sway';
	'DESKLESSPACK_TEAMS1'													     = 'O365 F1 - Microsoft Teams';
	'DESKLESSPACK_WHITEBOARD_FIRSTLINE1'										 = 'O365 F1 - Whiteboard (Firstline)';
	'DESKLESSPACK_YAMMER'													     = 'Office 365 F1 with Yammer';
	'DESKLESSPACK_YAMMER_ENTERPRISE'											 = 'O365 F1 - Yammer Enterprise';
	'DESKLESSWOFFPACK'														     = 'Office 365 Kiosk P2';
	'DESKLESSWOFFPACK_GOV'													     = 'Office 365 Kiosk P2 for Government';
	'DEVELOPERPACK'															     = 'Office 365 E3 Developer';
	'DEVELOPERPACK_EXCHANGE_S_ENTERPRISE'									     = 'O365 E3 Developer - Exchange Online (P2)';
	'DEVELOPERPACK_FLOW_O365_P2'												 = 'O365 E3 Developer - Flow for Office 365';
	'DEVELOPERPACK_FORMS_PLAN_E5'											     = 'O365 E3 Developer - Microsft Forms (Plan E5)';
	'DEVELOPERPACK_GOV'														     = 'Office 365 Developer for Government';
	'DEVELOPERPACK_MCOSTANDARD'												     = 'O365 E3 Developer - Skype for Business Online (P2)';
	'DEVELOPERPACK_OFFICESUBSCRIPTION'										     = 'O365 E3 Developer - Office 365 ProPlus';
	'DEVELOPERPACK_POWERAPPS_O365_P2'										     = 'O365 E3 Developer - PowerApps for Office 365';
	'DEVELOPERPACK_PROJECTWORKMANAGEMENT'									     = 'O365 E3 Developer - Microsoft Planner';
	'DEVELOPERPACK_SHAREPOINT_S_DEVELOPER'									     = 'O365 E3 Developer - SharePoint (P2)';
	'DEVELOPERPACK_SHAREPOINTWAC_DEVELOPER'									     = 'O365 E3 Developer - Office for web';
	'DEVELOPERPACK_STREAM_O365_E5'											     = 'O365 E3 Developer - Stream for Office 365';
	'DEVELOPERPACK_SWAY'														 = 'O365 E3 Developer - Sway';
	'DEVELOPERPACK_TEAMS1'													     = 'O365 E3 Developer - Microsoft Teams';
	'DMENTERPRISE'															     = 'Microsoft Dynamics Marketing Online Enterprise';
	'DYN365_AI_SERVICE_INSIGHTS_DYN365_AI_SERVICE_INSIGHTS'					     = 'Dynamics 365 Customer Service Insights';
	'DYN365_BUSINESS_MARKETING'												     = 'Dynamics 365 for Marketing';
	'DYN365_CDS_DYN_APPS'													     = 'Common Data Service';
	'DYN365_CDS_PROJECT'														 = 'Common Data Service for Project';
	'DYN365_CDS_VIRAL'														     = 'Common Data Service';
	'DYN365_ENTERPRISE_CUSTOMER_SERVICE'										 = 'Dynamics 365 for Customer Service Enterprise Edition';
	'DYN365_ENTERPRISE_P1'													     = 'Dynamics 365 Customer Engagement Plan';
	'DYN365_ENTERPRISE_P1_IW'												     = 'Dynamics 365 P1 Trial for Information Workers';
	'DYN365_ENTERPRISE_P1_IW_DYN365_ENTERPRISE_P1_IW'						     = 'Dynamics 365 P1 Trial for Information Workers';
	'DYN365_ENTERPRISE_PLAN1'												     = 'Dynamics 365 Customer Engagement Plan Enterprise Edition';
	'DYN365_ENTERPRISE_PLAN1_DYN365_ENTERPRISE_P1'							     = 'D365 Customer Engagement Plan Ent Edition - Dynamics 365 Customer Engagement Plan';
	'DYN365_ENTERPRISE_PLAN1_FLOW_DYN_P2'									     = 'D365 Customer Engagement Plan Ent Edition - Flow for Dynamics 365';
	'DYN365_ENTERPRISE_PLAN1_NBENTERPRISE'									     = 'D365 Customer Engagement Plan Ent Edition - MS Social Engagement - Service Discontinuation';
	'DYN365_ENTERPRISE_PLAN1_POWERAPPS_DYN_P2'								     = 'D365 Customer Engagement Plan Ent Edition - Powerapps for Dynamics 365';
	'DYN365_ENTERPRISE_PLAN1_PROJECT_CLIENT_SUBSCRIPTION'					     = 'D365 Customer Engagement Plan Ent Edition - Project Online Desktop Client';
	'DYN365_ENTERPRISE_PLAN1_SHAREPOINT_PROJECT'								 = 'D365 Customer Engagement Plan Ent Edition - Project Online Service';
	'DYN365_ENTERPRISE_PLAN1_SHAREPOINTENTERPRISE'							     = 'D365 Customer Engagement Plan Ent Edition - SharePoint (P2)';
	'DYN365_ENTERPRISE_PLAN1_SHAREPOINTWAC'									     = 'D365 Customer Engagement Plan Ent Edition - Office for web';
	'DYN365_ENTERPRISE_SALES'												     = 'Dynamics 365 for Sales Enterprise Edition';
	'DYN365_ENTERPRISE_SALES_CUSTOMERSERVICE'								     = 'Dynamics 365 for Sales And Customer Service Enterprise Edition';
	'DYN365_ENTERPRISE_SALES_DYN365_ENTERPRISE_SALES'						     = 'D365 for Sales Enterprise Edition - Dynamics 365 for Sales Enterprise Edition';
	'DYN365_ENTERPRISE_SALES_FLOW_DYN_APPS'									     = 'D365 for Sales Enterprise Edition - Flow for Dynamics 365';
	'DYN365_ENTERPRISE_SALES_NBENTERPRISE'									     = 'D365 for Sales Enterprise Edition - MS Social Engagement - Service Discontinuation';
	'DYN365_ENTERPRISE_SALES_POWERAPPS_DYN_APPS'								 = 'D365 for Sales Enterprise Edition - PowerApps for Office 365';
	'DYN365_ENTERPRISE_SALES_PROJECT_ESSENTIALS'								 = 'D365 for Sales Enterprise Edition - Project Online Essential';
	'DYN365_ENTERPRISE_SALES_SHAREPOINTENTERPRISE'							     = 'D365 for Sales Enterprise Edition - SharePoint (P2)';
	'DYN365_ENTERPRISE_SALES_SHAREPOINTWAC'									     = 'D365 for Sales Enterprise Edition - Office for web';
	'DYN365_Enterprise_Talent_Attract_TeamMember'							     = 'Dynamics 365 for Talent - Attract Experience Team Member';
	'DYN365_Enterprise_Talent_Onboard_TeamMember'							     = 'Dynamics 365 for Talent - Onboard Experience';
	'DYN365_ENTERPRISE_TEAM_MEMBERS'											 = 'Dynamics 365 for Team Members Enterprise Edition';
	'DYN365_ENTERPRISE_TEAM_MEMBERS_DYN365_ENTERPRISE_TALENT_ATTRACT_TEAMMEMBER' = 'D365 for Team Members Ent Edition - D365 for Talent - Attract Experience Team Member';
	'DYN365_ENTERPRISE_TEAM_MEMBERS_DYN365_ENTERPRISE_TALENT_ONBOARD_TEAMMEMBER' = 'D365 for Team Members Ent Edition - D365 for Talent - Onboard Experience';
	'DYN365_ENTERPRISE_TEAM_MEMBERS_DYN365_ENTERPRISE_TEAM_MEMBERS'			     = 'Dynamics 365 for Team Members Enterprise Edition';
	'DYN365_ENTERPRISE_TEAM_MEMBERS_DYNAMICS_365_FOR_OPERATIONS_TEAM_MEMBERS'    = 'D365 for Team Members Ent Edition - Dynamics 365 for Operations Member';
	'DYN365_ENTERPRISE_TEAM_MEMBERS_DYNAMICS_365_FOR_RETAIL_TEAM_MEMBERS'	     = 'D365 for Team Members Ent Edition - Dynamics 365 for Retail Member';
	'DYN365_ENTERPRISE_TEAM_MEMBERS_DYNAMICS_365_FOR_TALENT_TEAM_MEMBERS'	     = 'D365 for Team Members Ent Edition - Dynamics 365 for Talent Member';
	'DYN365_ENTERPRISE_TEAM_MEMBERS_FLOW_DYN_TEAM'							     = 'D365 for Team Members Ent Edition - Flow for Office 365';
	'DYN365_ENTERPRISE_TEAM_MEMBERS_POWERAPPS_DYN_TEAM'						     = 'D365 for Team Members Ent Edition - PowerApps for Office 365';
	'DYN365_ENTERPRISE_TEAM_MEMBERS_PROJECT_ESSENTIALS'						     = 'D365 for Team Members Ent Edition - Project Online Essential';
	'DYN365_ENTERPRISE_TEAM_MEMBERS_SHAREPOINTENTERPRISE'					     = 'D365 for Team Members Ent Edition - SharePoint (P2)';
	'DYN365_ENTERPRISE_TEAM_MEMBERS_SHAREPOINTWAC'							     = 'D365 for Team Members Ent Edition - Office for web';
	'DYN365_FINANCE'															 = 'Dynamics 365 Finance';
	'DYN365_FINANCIALS_BUSINESS'												 = 'Dynamics 365 for Financials';
	'DYN365_FINANCIALS_BUSINESS_SKU'											 = 'Dynamics 365 for Financials Business Edition';
	'DYN365_FINANCIALS_BUSINESS_SKU_DYN365_FINANCIALS_BUSINESS'				     = 'Dynamics 365 for Financials Business Edition';
	'DYN365_FINANCIALS_BUSINESS_SKU_FLOW_DYN_APPS'							     = 'D365 for Financials Business Edition - Flow for Dynamics 365';
	'DYN365_FINANCIALS_BUSINESS_SKU_POWERAPPS_DYN_APPS'						     = 'D365 for Financials Business Edition - PowerApps for Office 365';
	'DYN365_FINANCIALS_TEAM_MEMBERS_SKU'										 = 'Dynamics 365 for Team Members Business Edition';
	'DYN365_RETAIL_TRIAL'													     = 'Dynamics 365 for Retail Trial';
	'DYN365_SCM'																 = 'Dynamics 365 for Supply Chain Management';
	'DYN365_SCM_ATTACH'														     = 'Dynamics 365 Supply Chain Management Attach to Qualifying Dynamics 365 Base Offer';
	'DYN365_TALENT_ENTERPRISE'												     = 'Dynamics 365 for Talent';
	'DYN365_TEAM_MEMBERS'													     = 'Dynamics 365 Team Members';
	'Dyn365_Operations_Activity'												 = 'Dyn365 fÃ¼r Operations Activity Enterprise Edition';
	'Dynamics_365_for_Operations'											     = 'Dynamics 365 Unf Ops Plan Ent Edition';
	'Dynamics_365_for_Retail'												     = 'Dynamics 365 for Retail';
	'Dynamics_365_for_Retail_Team_members'									     = 'Dynamics 365 for Retail Team Members';
	'Dynamics_365_for_Talent_Team_members'									     = 'Dynamics 365 for Talent Team Members';
	'Dynamics_365_Onboarding_Free_PLAN'										     = 'Dynamics 365 for Talent: Onboard';
	'Dynamics_365_Onboarding_SKU'											     = 'Dynamics 365 for Talent: Onboard';
	'DYNAMICS_365_ONBOARDING_SKU_DYN365_CDS_DYN_APPS'						     = 'Dynamics 365 for Talent: Onboard - Common Data Service';
	'DYNAMICS_365_ONBOARDING_SKU_DYNAMICS_365_ONBOARDING_FREE_PLAN'			     = 'Dynamics 365 for Talent: Onboard';
	'DYNAMICS_365_ONBOARDING_SKU_DYNAMICS_365_TALENT_ONBOARD'				     = 'Dynamics 365 for Talent: Onboard - Dynamics 365 for Talent: Onboard';
	'Dynamics_365_for_Operations_Sandbox_Tier2_SKU'							     = 'Dynamics 365 Operations â€" Sandbox Tier 2:Standard Acceptance Testing';
	'ECAL_SERVICES'															     = 'ECAL Services (EOA, EOP, DLP)';
	'EducationAnalyticsP1'													     = 'Education Analytics';
	'EDUPACK_FACULTY'														     = 'Office 365 Education E3 for Faculty';
	'EDUPACK_STUDENT'														     = 'Office 365 Education for Students';
	'EMS'																	     = 'Enterprise Mobility + Security E3';
	'EMS_AAD_PREMIUM'														     = 'Ent Mobility + Security E3 - Azure AD Premium P1';
	'EMS_ADALLOM_S_DISCOVERY'												     = 'Ent Mobility + Security E3 - Cloud App Security Discovery';
	'EMS_EDU_STUUSBNFT'														     = 'Enterprise Mobility + Security A3';
	'EMS_INTUNE_A'															     = 'Ent Mobility + Security E3 - Microsoft Intune';
	'EMS_MFA_PREMIUM'														     = 'Ent Mobility + Security E3 - Azure Multi-Factor Authentication';
	'EMS_RMS_S_ENTERPRISE'													     = 'Ent Mobility + Security E3 - Azure Rights Management';
	'EMS_RMS_S_PREMIUM'														     = 'Ent Mobility + Security E3 - Azure Information Protection P1';
	'EMSPREMIUM'																 = 'Enterprise Mobility + Security E5';
	'EMSPREMIUM_AAD_PREMIUM'													 = 'Ent Mobility + Security E5 - Azure AD Premium P1';
	'EMSPREMIUM_AAD_PREMIUM_P2'												     = 'Ent Mobility + Security E5 - Azure AD Premium P2';
	'EMSPREMIUM_ADALLOM_S_STANDALONE'										     = 'Ent Mobility + Security E5 - Microsoft Cloud App Security';
	'EMSPREMIUM_ATA'															 = 'Ent Mobility + Security E5 - Azure Advanced Threat Protection';
	'EMSPREMIUM_INTUNE_A'													     = 'Ent Mobility + Security E5 - Microsoft Intune';
	'EMSPREMIUM_MFA_PREMIUM'													 = 'Ent Mobility + Security E5 - Azure Multi-Factor Authentication';
	'EMSPREMIUM_RMS_S_ENTERPRISE'											     = 'Ent Mobility + Security E5 - Azure Rights Management';
	'EMSPREMIUM_RMS_S_PREMIUM'												     = 'Ent Mobility + Security E5 - Azure Information Protection P1';
	'EMSPREMIUM_RMS_S_PREMIUM2'												     = 'Ent Mobility + Security E5 - Azure Information Protection P2';
	'ENTERPRISEPACK'															 = 'Office 365 E3';
	'ENTERPRISEPACK_BPOS_S_TODO_2'											     = 'O365 E3 - To-do (P2)';
	'ENTERPRISEPACK_DESKLESS'												     = 'O365 E3 - Microsoft StaffHub';
	'ENTERPRISEPACK_EXCHANGE_S_ENTERPRISE'									     = 'O365 E3 - Exchange Online (P2)';
	'ENTERPRISEPACK_FACULTY'													 = 'Office 365 Education E3 for Faculty';
	'ENTERPRISEPACK_FLOW_O365_P2'											     = 'O365 E3 - Flow for Office 365';
	'ENTERPRISEPACK_FORMS_PLAN_E3'											     = 'O365 E3 - Microsft Forms (Plan E3)';
	'ENTERPRISEPACK_GOV'														 = 'Office 365 Enterprise E3 for Government';
	'ENTERPRISEPACK_KAIZALA_O365_P3'											 = 'O365 E3 - Microsoft Kaizala Pro';
	'ENTERPRISEPACK_MCOSTANDARD'												 = 'O365 E3 - Skype for Business Online (P2)';
	'ENTERPRISEPACK_MIP_S_CLP1'												     = 'O365 E3 - Information Protection for Office 365 - Standard';
	'ENTERPRISEPACK_MYANALYTICS_P2'											     = 'O365 E3 - Insights by MyAnalytics';
	'ENTERPRISEPACK_OFFICESUBSCRIPTION'										     = 'O365 E3 - Office 365 ProPlus';
	'ENTERPRISEPACK_POWERAPPS_O365_P2'										     = 'O365 E3 - PowerApps for Office 365';
	'ENTERPRISEPACK_PROJECTWORKMANAGEMENT'									     = 'O365 E3 - Microsoft Planner';
	'ENTERPRISEPACK_RMS_S_ENTERPRISE'										     = 'O365 E3 - Azure Rights Management';
	'ENTERPRISEPACK_SHAREPOINTENTERPRISE'									     = 'O365 E3 - SharePoint (P2)';
	'ENTERPRISEPACK_SHAREPOINTWAC'											     = 'O365 E3 - Office for web';
	'ENTERPRISEPACK_STREAM_O365_E3'											     = 'O365 E3 - Stream for Office 365';
	'ENTERPRISEPACK_STUDENT'													 = 'Office 365 Education E3 for Students';
	'ENTERPRISEPACK_SWAY'													     = 'O365 E3 - Sway';
	'ENTERPRISEPACK_TEAMS1'													     = 'O365 E3 - Microsoft Teams';
	'ENTERPRISEPACK_USGOV_DOD '												     = 'Office 365 E3 US GOV DoD';
	'ENTERPRISEPACK_USGOV_GCCHIGH '											     = 'Office 365 E3 US GOV GCC High';
	'ENTERPRISEPACK_WHITEBOARD_PLAN2'										     = 'O365 E3 - Whiteboard (P2)';
	'ENTERPRISEPACK_YAMMER_ENTERPRISE'										     = 'O365 E3 - Yammer Enterprise';
	'ENTERPRISEPACKLRG'														     = 'Office 365 (Plan E3)';
	'ENTERPRISEPACKPLUS_FACULTY'												 = 'Office 365 A3 for faculty';
	'ENTERPRISEPACKWITHOUTPROPLUS'											     = 'Office 365 Enterprise E3 without ProPlus Add-on';
	'ENTERPRISEPACKWSCAL'													     = 'Office 365 Enterprise E4';
	'ENTERPRISEPREMIUM'														     = 'Office 365 E5';
	'ENTERPRISEPREMIUM_ADALLOM_S_O365'										     = 'O365 E5 - Office 365 Advanced Security Management';
	'ENTERPRISEPREMIUM_ATP_ENTERPRISE'										     = 'O365 E5 - Office 365 Advanced Threat Protection (P1)';
	'ENTERPRISEPREMIUM_BI_AZURE_P2'											     = 'O365 E5 - Power BI Pro';
	'ENTERPRISEPREMIUM_BPOS_S_TODO_3'										     = 'O365 E5 - To-do (P3)';
	'ENTERPRISEPREMIUM_COMMUNICATIONS_COMPLIANCE'							     = 'O365 E5 - Microsoft Communications Compliance';
	'ENTERPRISEPREMIUM_COMMUNICATIONS_DLP'									     = 'O365 E5 - Microsoft Communications Dlp';
	'ENTERPRISEPREMIUM_CUSTOMER_KEY'											 = 'O365 E5 - Microsoft Customer Key';
	'ENTERPRISEPREMIUM_DATA_INVESTIGATIONS'									     = 'O365 E5 - Microsoft Data Investigations';
	'ENTERPRISEPREMIUM_DESKLESS'												 = 'O365 E5 - Microsoft StaffHub';
	'ENTERPRISEPREMIUM_DYN365_CDS_O365_P3'									     = 'O365 E5 - Common Data Service';
	'ENTERPRISEPREMIUM_EQUIVIO_ANALYTICS'									     = 'O365 E5 - Office 365 Advanced eDiscovery';
	'ENTERPRISEPREMIUM_EXCHANGE_ANALYTICS'									     = 'O365 E5 - Delve Analytics';
	'ENTERPRISEPREMIUM_EXCHANGE_S_ENTERPRISE'								     = 'O365 E5 - Exchange Online (P2)';
	'ENTERPRISEPREMIUM_FACULTY'												     = 'Office 365 A5 for Faculty';
	'ENTERPRISEPREMIUM_FLOW_O365_P3'											 = 'O365 E5 - Flow for Office 365';
	'ENTERPRISEPREMIUM_FORMS_PLAN_E5'										     = 'O365 E5 - Microsoft Forms (Plan E5)';
	'ENTERPRISEPREMIUM_INFO_GOVERNANCE'										     = 'O365 E5 - Microsoft Information Governance';
	'ENTERPRISEPREMIUM_INFORMATION_BARRIERS'									 = 'O365 E5 - Information Barriers';
	'ENTERPRISEPREMIUM_INTUNE_O365'											     = 'O365 E5 - Microsoft Intune';
	'ENTERPRISEPREMIUM_KAIZALA_STANDALONE'									     = 'O365 E5 - Microsoft Kaizala Pro';
	'ENTERPRISEPREMIUM_LOCKBOX_ENTERPRISE'									     = 'O365 E5 - Customer Lockbox';
	'ENTERPRISEPREMIUM_M365_ADVANCED_AUDITING'								     = 'O365 E5 - Microsoft 365 Advanced Auditing';
	'ENTERPRISEPREMIUM_MCOEV'												     = 'O365 E5 - Microsoft Phone System';
	'ENTERPRISEPREMIUM_MCOMEETADV'											     = 'O365 E5 - Audio Conferencing';
	'ENTERPRISEPREMIUM_MCOSTANDARD'											     = 'O365 E5 - Skype for Business Online (P2)';
	'ENTERPRISEPREMIUM_MICROSOFTBOOKINGS'									     = 'O365 E5 - Microsoft Bookings';
	'ENTERPRISEPREMIUM_MIP_S_CLP1'											     = 'O365 E5 - Information Protection for Office 365 - Standard';
	'ENTERPRISEPREMIUM_MIP_S_CLP2'											     = 'O365 E5 - Information Protection for Office 365 - Premium';
	'ENTERPRISEPREMIUM_MTP'													     = 'O365 E5 - Microsoft Threat Protection';
	'ENTERPRISEPREMIUM_MYANALYTICS_P2'										     = 'O365 E5 - Insights by MyAnalytics';
	'ENTERPRISEPREMIUM_NOPSTNCONF'											     = 'Office 365 E5 Without Audio Conferencing';
	'ENTERPRISEPREMIUM_NOPSTNCONF_ADALLOM_S_O365'							     = 'O365 E5 Without Audio Conferencing - Office 365 Advanced Security Management';
	'ENTERPRISEPREMIUM_NOPSTNCONF_BI_AZURE_P2'								     = 'O365 E5 Without Audio Conferencing - Power BI Pro';
	'ENTERPRISEPREMIUM_NOPSTNCONF_DESKLESS'									     = 'O365 E5 Without Audio Conferencing - Microsoft StaffHub';
	'ENTERPRISEPREMIUM_NOPSTNCONF_EQUIVIO_ANALYTICS'							 = 'O365 E5 Without Audio Conferencing - Office 365 Advanced eDiscovery';
	'ENTERPRISEPREMIUM_NOPSTNCONF_EXCHANGE_ANALYTICS'						     = 'O365 E5 Without Audio Conferencing - Delve Analytics';
	'ENTERPRISEPREMIUM_NOPSTNCONF_EXCHANGE_S_ENTERPRISE'						 = 'O365 E5 Without Audio Conferencing - Exchange Online (P2)';
	'ENTERPRISEPREMIUM_NOPSTNCONF_FLOW_O365_P3'								     = 'O365 E5 Without Audio Conferencing - Flow for Office 365';
	'ENTERPRISEPREMIUM_NOPSTNCONF_FORMS_PLAN_E5'								 = 'O365 E5 Without Audio Conferencing - Microsft Forms (Plan E5)';
	'ENTERPRISEPREMIUM_NOPSTNCONF_LOCKBOX_ENTERPRISE'						     = 'O365 E5 Without Audio Conferencing - Customer Lockbox';
	'ENTERPRISEPREMIUM_NOPSTNCONF_MCOEV'										 = 'O365 E5 Without Audio Conferencing - Microsoft Phone System';
	'ENTERPRISEPREMIUM_NOPSTNCONF_MCOSTANDARD'								     = 'O365 E5 Without Audio Conferencing - Skype for Business Online (P2)';
	'ENTERPRISEPREMIUM_NOPSTNCONF_OFFICESUBSCRIPTION'						     = 'O365 E5 Without Audio Conferencing - Office 365 ProPlus';
	'ENTERPRISEPREMIUM_NOPSTNCONF_POWERAPPS_O365_P3'							 = 'O365 E5 Without Audio Conferencing - PowerApps for Office 365';
	'ENTERPRISEPREMIUM_NOPSTNCONF_PROJECTWORKMANAGEMENT'						 = 'O365 E5 Without Audio Conferencing - Microsoft Planner';
	'ENTERPRISEPREMIUM_NOPSTNCONF_RMS_S_ENTERPRISE'							     = 'O365 E5 Without Audio Conferencing - Azure Rights Management';
	'ENTERPRISEPREMIUM_NOPSTNCONF_SHAREPOINTENTERPRISE'						     = 'O365 E5 Without Audio Conferencing - SharePoint (P2)';
	'ENTERPRISEPREMIUM_NOPSTNCONF_SHAREPOINTWAC'								 = 'O365 E5 Without Audio Conferencing - Office for web';
	'ENTERPRISEPREMIUM_NOPSTNCONF_STREAM_O365_E5'							     = 'O365 E5 Without Audio Conferencing - Stream for Office 365';
	'ENTERPRISEPREMIUM_NOPSTNCONF_SWAY'										     = 'O365 E5 Without Audio Conferencing - Sway';
	'ENTERPRISEPREMIUM_NOPSTNCONF_TEAMS1'									     = 'O365 E5 Without Audio Conferencing - Microsoft Teams';
	'ENTERPRISEPREMIUM_NOPSTNCONF_THREAT_INTELLIGENCE'						     = 'O365 E5 Without Audio Conferencing - Office 365 Threat Intelligence';
	'ENTERPRISEPREMIUM_NOPSTNCONF_YAMMER_ENTERPRISE'							 = 'O365 E5 Without Audio Conferencing - Yammer Enterprise';
	'ENTERPRISEPREMIUM_OFFICESUBSCRIPTION'									     = 'O365 E5 - Office 365 ProPlus';
	'ENTERPRISEPREMIUM_PAM_ENTERPRISE'										     = 'O365 E5 - Office 365 Privileged Access Management';
	'ENTERPRISEPREMIUM_POWERAPPS_O365_P3'									     = 'O365 E5 - PowerApps for Office 365';
	'ENTERPRISEPREMIUM_PREMIUM_ENCRYPTION'									     = 'O365 E5 - Premium Encryption in Office 365';
	'ENTERPRISEPREMIUM_PROJECTWORKMANAGEMENT'								     = 'O365 E5 - Microsoft Planner';
	'ENTERPRISEPREMIUM_RECORDS_MANAGEMENT'									     = 'O365 E5 - Microsoft Records Management';
	'ENTERPRISEPREMIUM_RMS_S_ENTERPRISE'										 = 'O365 E5 - Azure Rights Management';
	'ENTERPRISEPREMIUM_SHAREPOINTWAC'										     = 'O365 E5 - SharePoint (P2)';
	'ENTERPRISEPREMIUM_STREAM_O365_E5'										     = 'O365 E5 - Stream for Office 365';
	'ENTERPRISEPREMIUM_STUDENT'												     = 'Office 365 A5 for Students';
	'ENTERPRISEPREMIUM_SWAY'													 = 'O365 E5 - Sway';
	'ENTERPRISEPREMIUM_TEAMS1'												     = 'O365 E5 - Microsoft Teams';
	'ENTERPRISEPREMIUM_THREAT_INTELLIGENCE'									     = 'O365 E5 - Office 365 Threat Intelligence';
	'ENTERPRISEPREMIUM_WHITEBOARD_PLAN3'										 = 'O365 E5 - Whiteboard (P3)';
	'ENTERPRISEPREMIUM_YAMMER_ENTERPRISE'									     = 'O365 E5 - Yammer Enterprise';
	'ENTERPRISEWITHSCAL'														 = 'Office 365 E4';
	'ENTERPRISEWITHSCAL '													     = 'Office 365 Enterprise E4';
	'ENTERPRISEWITHSCAL_DESKLESS'											     = 'O365 E4 - Microsoft StaffHub';
	'ENTERPRISEWITHSCAL_EXCHANGE_S_ENTERPRISE'								     = 'O365 E4 - Exchange Online (P2)';
	'ENTERPRISEWITHSCAL_FACULTY'												 = 'Office 365 Education E4 for Faculty';
	'ENTERPRISEWITHSCAL_FLOW_O365_P2'										     = 'O365 E4 - Flow for Office 365';
	'ENTERPRISEWITHSCAL_FORMS_PLAN_E3'										     = 'O365 E4 - Microsft Forms (Plan E3)';
	'ENTERPRISEWITHSCAL_GOV'													 = 'Office 365 Enterprise E4 for Government';
	'ENTERPRISEWITHSCAL_MCOSTANDARD'											 = 'O365 E4 - Skype for Business Online (P2)';
	'ENTERPRISEWITHSCAL_MCOVOICECONF'										     = 'O365 E4 - Audio Conferencing';
	'ENTERPRISEWITHSCAL_OFFICESUBSCRIPTION'									     = 'O365 E4 - Office 365 ProPlus';
	'ENTERPRISEWITHSCAL_POWERAPPS_O365_P2'									     = 'O365 E4 - PowerApps for Office 365';
	'ENTERPRISEWITHSCAL_PROJECTWORKMANAGEMENT'								     = 'O365 E4 - Microsoft Planner';
	'ENTERPRISEWITHSCAL_RMS_S_ENTERPRISE'									     = 'O365 E4 - Azure Rights Management';
	'ENTERPRISEWITHSCAL_SHAREPOINTENTERPRISE'								     = 'O365 E4 - SharePoint (P2)';
	'ENTERPRISEWITHSCAL_SHAREPOINTWAC'										     = 'O365 E4 - Office for web';
	'ENTERPRISEWITHSCAL_STREAM_O365_E3'										     = 'O365 E4 - Stream for Office 365';
	'ENTERPRISEWITHSCAL_STUDENT'												 = 'Office 365 Education E4 for Students';
	'ENTERPRISEWITHSCAL_SWAY'												     = 'O365 E4 - Sway';
	'ENTERPRISEWITHSCAL_TEAMS1'												     = 'O365 E4 - Microsoft Teams';
	'ENTERPRISEWITHSCAL_YAMMER_ENTERPRISE'									     = 'O365 E4 - Yammer Enterprise';
	'EOP_ENTERPRISE'															 = 'Exchange Online Protection';
	'EOP_ENTERPRISE_FACULTY'													 = 'Exchange Online Protection for Faculty';
	'EOP_ENTERPRISE_GOV'														 = 'Exchange Protection for Government';
	'EOP_ENTERPRISE_PREMIUM'													 = 'Exchange Enterprise CAL Services (EOP, DLP)';
	'EOP_ENTERPRISE_STUDENT'													 = 'Exchange Protection for Student';
	'EQUIVIO_ANALYTICS'														     = 'Office 365 Advanced Compliance';
	'EQUIVIO_ANALYTICS_FACULTY'												     = 'Office 365 Advanced Compliance for Faculty';
	'EXCHANGE_ANALYTICS'														 = 'Microsoft Myanalytics (full)';
	'EXCHANGE_B_STANDARD'													     = 'Exchange Online Pop';
	'EXCHANGE_L_STANDARD'													     = 'Exchange Online (P1)';
	'EXCHANGE_ONLINE_WITH_ONEDRIVE_LITE'										 = 'Exchange with OneDrive for Business';
	'EXCHANGE_S_ARCHIVE'														 = 'Exchange Online Archiving for Exchange Server';
	'EXCHANGE_S_ARCHIVE_ADDON'												     = 'Exchange Online Archiving for Exchange Online';
	'EXCHANGE_S_ARCHIVE_ADDON_GOV'											     = 'Exchange Online Archiving';
	'EXCHANGE_S_DESKLESS'													     = 'Exchange Online Kiosk';
	'EXCHANGE_S_DESKLESS_GOV'												     = 'Exchange Online Kiosk for Government';
	'EXCHANGE_S_ENTERPRISE'													     = 'Exchange Online (Plan 2)';
	'EXCHANGE_S_ENTERPRISE_GOV'												     = 'Exchange Online P2 for Government';
	'EXCHANGE_S_ESSENTIALS'													     = 'Exchange Online Essentials';
	'EXCHANGE_S_ESSENTIALS_EXCHANGE_S_ESSENTIALS'							     = 'Exchange Online Essentials';
	'EXCHANGE_S_FOUNDATION'													     = 'Exchange Foundation';
	'EXCHANGE_S_STANDARD'													     = 'Exchange Online (Plan 1)';
	'EXCHANGE_S_STANDARD_MIDMARKET'											     = 'Exchange Online Plan 1';
	'EXCHANGE_STANDARD_ALUMNI'												     = 'Exchange Online (Plan 1) for alumni';
	'EXCHANGEARCHIVE'														     = 'Exchange Online Archiving for Exchange Server';
	'EXCHANGEARCHIVE_ADDON'													     = 'Exchange Online Archiving for Exchange Online';
	'EXCHANGEARCHIVE_ADDON_EXCHANGE_S_ARCHIVE_ADDON'							 = 'Exchange Online Archiving for Exchange Online';
	'EXCHANGEARCHIVE_EXCHANGE_S_ARCHIVE'										 = 'Exchange Online Archiving for Exchange Server';
	'EXCHANGEARCHIVE_FACULTY'												     = 'Exchange Archiving for Faculty';
	'EXCHANGEARCHIVE_GOV'													     = 'Exchange Archiving for Government';
	'EXCHANGEARCHIVE_STUDENT'												     = 'Exchange Archiving for Students';
	'EXCHANGEDESKLESS'														     = 'Exchange Online Kiosk';
	'EXCHANGEDESKLESS '														     = 'Exchange Online Kiosk';
	'EXCHANGEDESKLESS_EXCHANGE_S_DESKLESS'									     = 'Exchange Online Kiosk';
	'EXCHANGEDESKLESS_GOV'													     = 'Exchange Kiosk for Government';
	'EXCHANGEENTERPRISE'														 = 'Exchange Online (Plan 2)';
	'EXCHANGEENTERPRISE '													     = 'Exchange Online Plan 2';
	'EXCHANGEENTERPRISE_BPOS_S_TODO_1'										     = 'Exchange Online (P2) - To-do (P1)';
	'EXCHANGEENTERPRISE_EXCHANGE_S_ENTERPRISE'								     = 'Exchange Online (P2) - Exchange Online (P2)';
	'EXCHANGEENTERPRISE_FACULTY'												 = 'Exchange Online (Plan 2) for Faculty';
	'EXCHANGEENTERPRISE_GOV'													 = 'Exchange Online Plan 2 for Government';
	'EXCHANGEENTERPRISE_STUDENT'												 = 'Exchange Online (Plan 2) for Student';
	'EXCHANGEESSENTIALS'														 = 'Exchange Online Essentials';
	'EXCHANGEESSENTIALS_EXCHANGE_S_STANDARD'									 = 'Exchange Online Essentials';
	'EXCHANGESTANDARD'														     = 'Exchange Online (Plan 1)';
	'EXCHANGESTANDARD_EXCHANGE_S_STANDARD'									     = 'Exchange Online (Plan 1)';
	'EXCHANGESTANDARD_FACULTY'												     = 'Exchange (Plan 1 for Faculty)';
	'EXCHANGESTANDARD_GOV'													     = 'Exchange Online P1 for Government';
	'EXCHANGESTANDARD_STUDENT'												     = 'Exchange Online P1 for Students';
	'EXCHANGETELCO'															     = 'Exchange Online Pop';
	'FLOW_DYN_APPS'															     = 'Flow for Dynamics 365';
	'FLOW_DYN_P2'															     = 'Flow for Dynamics 365';
	'FLOW_DYN_TEAM'															     = 'Flow for Dynamics 365';
	'FLOW_FOR_PROJECT'														     = 'Flow for Project Online';
	'FLOW_FREE'																     = 'Microsoft Power Automate Free';
	'FLOW_FREE_DYN365_CDS_VIRAL'												 = 'Flow Free - Common Data Service';
	'FLOW_FREE_FLOW_P2_VIRAL'												     = ' Flow Free - Flow Free';
	'FLOW_O365_P1'															     = 'Flow for Office 365';
	'FLOW_O365_P2'															     = 'Flow for Office 365';
	'FLOW_O365_P3'															     = 'Flow for Office 365';
	'FLOW_O365_S1'															     = 'Flow for Office 365 K1';
	'FLOW_P1'																     = 'Microsoft Flow Plan 1';
	'FLOW_P2'																     = 'Microsoft Flow Plan 2';
	'FLOW_P2_DYN365_CDS_P2'													     = ' Microsoft Flow Plan 2 - Common Data Service';
	'FLOW_P2_FLOW_P2'														     = 'Microsoft Flow Plan 2';
	'FLOW_P2_VIRAL'															     = 'Flow Free';
	'FLOW_P2_VIRAL_REAL'														 = 'Flow P2 Viral';
	'FLOW_PER_USER'															     = 'Power Automate per user plan';
	'FORMS_PLAN_E1'															     = 'Microsoft Forms (Plan E1)';
	'FORMS_PLAN_E3'															     = 'Microsoft Forms (Plan E3)';
	'FORMS_PLAN_E5'															     = 'Microsoft Forms (Plan E5)';
	'FORMS_PLAN_K'															     = 'Microsoft Forms (Plan F1)';
	'FORMS_PRO'																     = 'Forms Pro Trial';
	'FORMS_PRO_DYN365_CDS_FORMS_PRO'											 = 'Forms Pro Trial - Common Data Service';
	'FORMS_PRO_FLOW_FORMS_PRO'												     = 'Forms Pro Trial- Microsoft Flow';
	'FORMS_PRO_FORMS_PLAN_E5'												     = 'Forms Pro Trial - Microsoft Forms (Plan E5)';
	'FORMS_PRO_FORMS_PRO'													     = 'Forms Pro Trial';
	'Forms_Pro_USL'															     = 'Microsoft Forms Pro (USL)';
	'GLOBAL_SERVICE_MONITOR'													 = 'Global Service Monitor Online Service';
	'GUIDES_USER_DYN365_CDS_GUIDES'											     = 'User Guides - Common Data Service';
	'GUIDES_USER_GUIDES'														 = 'User Guides';
	'GUIDES_USER_POWERAPPS_GUIDES'											     = 'User Guides - PowerApps';
	'IDENTITY_THREAT_PROTECTION'												 = 'Microsoft 365 E5 Security';
	'IDENTITY_THREAT_PROTECTION_FOR_EMS_E5'									     = 'Microsoft 365 E5 Security for EMS E5';
	'INFO_GOVERNANCE'														     = 'Microsoft Information Governance';
	'INFOPROTECTION_P2'														     = 'Azure Information Protection Premium P2';
	'INFORMATION_BARRIERS'													     = 'Information Barriers';
	'INFORMATION_PROTECTION_COMPLIANCE'										     = 'Microsoft 365 E5 Compliance';
	'INTUNE_A'																     = 'Intune';
	'INTUNE_A_D'																 = 'Microsoft Intune Device';
	'INTUNE_A_INTUNE_A'														     = 'Microsoft Intune';
	'INTUNE_A_VL'															     = 'Intune VL';
	'INTUNE_A_VL_INTUNE_A_VL'												     = 'Microsoft Intune VL';
	'INTUNE_EDU'																 = 'Intune for Education';
	'INTUNE_O365'															     = 'Mobile Device Management for Office 365';
	'INTUNE_O365_STANDALONE'													 = 'Mobile Device Management for Office 365';
	'INTUNE_SMB'																 = 'Microsoft Intune SMB';
	'INTUNE_SMBIZ'															     = 'Microsoft Intune SMBIZ';
	'IT_ACADEMY_AD'															     = 'Ms Imagine Academy';
	'IT_ACADEMY_AD_IT_ACADEMY_AD'											     = 'Ms Imagine Academy';
	'IWs PROJECT_MADEIRA_PREVIEW_IW_SKU'										 = 'Dynamics 365 Business Central for';
	'KAIZALA_O365_P1'														     = 'Microsoft Kaizala Pro Plan 1';
	'KAIZALA_O365_P3'														     = 'Microsoft Kaizala Pro Plan 3';
	'KAIZALA_STANDALONE'														 = 'Microsoft Kaizala';
	'KAIZALA_STUDENT'														     = 'Microsoft Kaizala Pro for students';
	'LITEPACK'																     = 'Office 365 Small Business';
	'LITEPACK_EXCHANGE_L_STANDARD'											     = 'O365 Small Business - Exchange Online (P1)';
	'LITEPACK_MCOLITE'														     = 'O365 Small Business - Skype for Business Online (P1)';
	'LITEPACK_P2'															     = 'Office 365 Small Business Premium';
	'LITEPACK_P2_EXCHANGE_L_STANDARD'										     = 'Office 365 Small Business Premium - Exchange Online (P1)';
	'LITEPACK_P3_MCOLITE'													     = 'Office 365 Small Business Premium - Skype for Business Online (P1)';
	'LITEPACK_P4_OFFICE_PRO_PLUS_SUBSCRIPTION_SMBIZ'							 = 'Office 365 Small Business Premium - Office 365 ProPlus';
	'LITEPACK_P5_SHAREPOINTLITE'												 = 'Office 365 Small Business Premium - Sharepointlite';
	'LITEPACK_P6_SWAY'														     = 'Office 365 Small Business Premium - Sway';
	'LITEPACK_SHAREPOINTLITE'												     = 'O365 Small Business - Sharepointlite';
	'LITEPACK_SWAY'															     = 'O365 Small Business - Sway';
	'LOCKBOX'																     = 'Customer Lockbox';
	'LOCKBOX_ENTERPRISE'														 = 'Customer Lockbox';
	'M365EDU_A3_STUUSEBNFT'													     = 'Microsoft 365 A3 for students use benefit';
	'M365EDU_A5_NOPSTNCONF_FACULTY'											     = 'Microsoft 365 A5 without Audio Conferencing for faculty';
	'M365_ADVANCED_AUDITING'													 = 'Microsoft 365 Advanced Auditing';
	'M365_E5_SUITE_COMPONENTS'												     = 'Microsoft 365 E5 Suite features';
	'M365_F1'																     = 'Microsoft 365 F1';
	'M365_F1_AAD_PREMIUM'													     = 'M365 F1 - Azure AD Premium P1';
	'M365_F1_ADALLOM_S_DISCOVERY'											     = 'M365 F1 - Cloud App Security Discovery';
	'M365_F1_DYN365_CDS_O365_F1'												 = 'M365 F1 - Common Data Service';
	'M365_F1_EXCHANGE_S_DESKLESS'											     = 'M365 F1 - Exchange Online Kiosk';
	'M365_F1_INTUNE_A'														     = 'M365 F1 - Microsoft Intune';
	'M365_F1_MCOIMP'															 = 'M365 F1 - Skype for Business Online (P1)';
	'M365_F1_MFA_PREMIUM'													     = 'M365 F1 - Azure Multi-factor Authentication';
	'M365_F1_PROJECTWORKMANAGEMENT'											     = 'M365 F1 - Microsoft Planner';
	'M365_F1_RMS_S_ENTERPRISE_GOV'											     = 'M365 F1 - Azure Rights Management';
	'M365_F1_RMS_S_PREMIUM'													     = 'M365 F1 - Azure Information Protection P1';
	'M365_F1_SHAREPOINTDESKLESS'												 = 'M365 F1 - Sharepoint Online Kiosk';
	'M365_F1_STREAM_O365_K'													     = 'M365 F1 - Microsoft Stream for O365 K SKU';
	'M365_F1_TEAMS1'															 = 'M365 F1 - Microsoft Teams';
	'M365_F1_YAMMER_ENTERPRISE'												     = 'M365 F1 - Yammer Enterprise';
	'M365_G3_GOV'															     = 'Microsoft 365 G3 GCC';
	'M365_SECURITY_COMPLIANCE_FOR_FLW'										     = 'Microsoft 365 Security and Compliance for FLW';
	'M365EDU_A1'																 = 'Microsoft 365 A1';
	'M365EDU_A3_FACULTY'														 = 'Microsoft 365 A3 for Faculty';
	'M365EDU_A3_STUDENT'														 = 'Microsoft 365 A3 for Students';
	'M365EDU_A5_FACULTY'														 = 'Microsoft 365 A5 for Faculty';
	'M365EDU_A5_STUDENT'														 = 'Microsoft 365 A5 for Students';
	'MCOCAP'																	 = 'Common Area Phone';
	'MCO_TEAMS_IW'															     = 'Microsoft Teams (Conferencing)';
	'MCOCAP_MCOEV'															     = 'Common Area Phone - Microsoft Phone System';
	'MCOCAP_MCOSTANDARD'														 = 'Common Area Phone - Skype for Business Online (P2)';
	'MCOCAP_TEAMS1'															     = 'Common Area Phone - Microsoft Teams';
	'MCOEV'																	     = 'Skype for Business Cloud Pbx';
	'MCOEV_DOD'																     = 'Microsoft 365 Phone System for DoD';
	'MCOEV_FACULTY'															     = 'Microsoft 365 Phone System for Faculty';
	'MCOEV_GCCHIGH'															     = 'Microsoft Phone System';
	'MCOEV_GOV'																     = 'Microsoft 365 Phone System for GCC';
	'MCOEV_MCOEV'															     = 'Microsoft Phone System';
	'MCOEV_STUDENT'															     = 'Microsoft 365 Phone System for Students';
	'MCOEV_TELSTRA'															     = 'Microsoft 365 Phone System for TELSTRA';
	'MCOEV_USGOV_DOD'														     = 'Microsoft 365 Phone System for US GOV DoD';
	'MCOEV_USGOV_GCCHIGH'													     = 'Microsoft 365 Phone System for  US GOV GCC High';
	'MCOEVSMB_1'																 = 'Microsoft 365 Phone System for Small and Medium Business ';
	'MCOIMP'																	 = 'Skype for Business Online (Plan 1)';
	'MCOIMP_FACULTY'															 = 'Lync (Plan 1 for Faculty)';
	'MCOIMP_GOV'																 = 'Lync for Government (Plan 1G)';
	'MCOIMP_MCOIMP'															     = 'Skype for Business Online (Plan 1)';
	'MCOIMP_STUDENT'															 = 'Lync (Plan 1 for Students)';
	'MCOINTERNAL'															     = 'Lync Internal Incubation and Corp to Cloud';
	'MCOLITE'																     = 'Skype for Business Online (Plan P1)';
	'MCOMEETACPEA'															     = 'Audio Conferencing Pay Per Minute';
	'MCOMEETADV'																 = 'Audio Conferencing';
	'MCOMEETADV_GOC'															 = 'Microsoft 365 Audio Conferencing for GCC';
	'MCOMEETADV_MCOMEETADV'													     = 'Audio Conferencing';
	'MCOPSTN_5_MCOPSTN5'														 = 'Domestic Calling Plan (120 min)';
	'MCOPSTN1'																     = 'Skype for Business PSTN Domestic Calling';
	'MCOPSTN1_MCOPSTN1'														     = 'Domestic Calling Plan';
	'MCOPSTN2'																     = 'Skype for Business PSTN Domestic And International Calling';
	'MCOPSTN2_MCOPSTN2'														     = 'Domestic and International Calling Plan';
	'MCOPSTN5'																     = 'Skype for Business PSTN Domestic Calling';
	'MCOPSTN_5'																     = 'Microsoft 365 Domestic Calling Plan (120 Minutes)';
	'MCOPSTNC'																     = 'Communication Credits';
	'MCOPSTNC_MCOPSTNC'														     = 'Skype for Business Communications Credits';
	'MCOPSTNEAU2'															     = 'TELSTRA Calling for O365';
	'MCOPSTNPP'																     = 'Skype for Business Communication Credits - Paid';
	'MCOSTANDARD'															     = 'Skype for Business Online (Plan 2)';
	'MCOSTANDARD_FACULTY'													     = 'Lync (Plan 2 for Faculty)';
	'MCOSTANDARD_GOV'														     = 'Skype for Business Online P2 for Government';
	'MCOSTANDARD_MCOSTANDARD'												     = 'Skype for Business Online (Plan 2)';
	'MCOSTANDARD_MIDMARKET'													     = 'Skype for Business Online (Plan 2) for Midsize';
	'MCOSTANDARD_STUDENT'													     = 'Lync (Plan 2 for Students)';
	'MCOVOICECONF'															     = 'Skype for Business Online (Plan 3)';
	'MCOVOICECONF_FACULTY'													     = 'Lync Plan 3 for Faculty';
	'MCOVOICECONF_GOV'														     = 'Lync for Government (Plan 3G)';
	'MCOVOICECONF_STUDENT'													     = 'Lync Plan 3 for Students';
	'MCVOICECONF'															     = 'Lync/Skype for Business Online P3';
	'MDATP_XPLAT'															     = 'Microsoft Defender For Endpoint';
	'MDM_SALES_COLLABORATION'												     = 'Microsoft Dynamics Marketing Sales Collaboration';
	'MEE_FACULTY'															     = 'Minecraft Education Edition Faculty';
	'MEE_STUDENT'															     = 'Minecraft Education Edition Student';
	'MEETING_ROOM'															     = 'Microsoft Teams Rooms Standard';
	'MEETING_ROOM_INTUNE_A'													     = 'Meeting Room - Microsoft Intune';
	'MEETING_ROOM_MCOEV'														 = 'Meeting Room - Microsoft Phone System';
	'MEETING_ROOM_MCOMEETADV'												     = 'Meeting Room - Audio Conferencing';
	'MEETING_ROOM_MCOSTANDARD'												     = 'Meeting Room - Skype for Business Online (P2)';
	'MEETING_ROOM_TEAMS1'													     = 'Meeting Room - Microsoft Teams';
	'MFA_PREMIUM'															     = 'Microsoft Azure Multi-factor Authentication';
	'MFA_STANDALONE'															 = 'Azure Multi-Factor Authentication Premium Standalone';
	'MICROSOFT_BUSINESS_CENTER'												     = 'Microsoft Business Center';
	'MICROSOFT_REMOTE_ASSIST'												     = 'Dynamics 365 Remote Assist';
	'MICROSOFT_REMOTE_ASSIST_CDS_REMOTE_ASSIST'								     = 'Microsoft Remote Assistant - Common Data Service';
	'MICROSOFT_REMOTE_ASSIST_HOLOLENS'										     = 'Dynamics 365 Remote Assist HoloLens';
	'MICROSOFT_REMOTE_ASSIST_MICROSOFT_REMOTE_ASSIST'						     = 'Microsoft Remote Assistant';
	'MICROSOFT_REMOTE_ASSIST_TEAMS1'											 = 'Microsoft Remote Assistant - Microsft Teams';
	'MICROSOFT_SEARCH'														     = 'Microsoft Search';
	'MICROSOFTBOOKINGS'														     = 'Microsoft Bookings';
	'MIDSIZEPACK'															     = 'Office 365 Midsize Business';
	'MIDSIZEPACK_EXCHANGE_S_STANDARD_MIDMARKET'								     = 'O365 Midsize Business - Exchange Online (P1)';
	'MIDSIZEPACK_MCOSTANDARD_MIDMARKET'										     = 'O365 Midsize Business - Skype for Business Online (P2)';
	'MIDSIZEPACK_OFFICESUBSCRIPTION'											 = 'O365 Midsize Business - Office 365 ProPlus';
	'MIDSIZEPACK_SHAREPOINTENTERPRISE_MIDMARKET'								 = 'O365 Midsize Business - SharePoint Online (P1)';
	'MIDSIZEPACK_SHAREPOINTWAC'												     = 'O365 Midsize Business - Office for web';
	'MIDSIZEPACK_SWAY'														     = 'O365 Midsize Business - Sway';
	'MIDSIZEPACK_YAMMER_MIDSIZE'												 = 'O365 Midsize Business - Yammer Enterprise';
	'MINECRAFT_EDUCATION_EDITION'											     = 'Minecraft Education Edition';
	'MIP_S_CLP1'																 = 'Information Protection for Office 365 - Standard';
	'MIP_S_CLP2'																 = 'Information Protection for Office 365 - Premium';
	'MS_TEAMS_IW'															     = 'Microsoft Team Trial';
	'MTR_PREM_NOAUDIOCONF_FACULTY'											     = 'Teams Rooms Premium without Audio Conferencing for faculty Trial';
	'MYANALYTICS_P2'															 = 'Insights By Myanalytics';
	'NBENTERPRISE'															     = 'Microsoft Social Engagement - Service Discontinuation';
	'NBPROFESSIONALFORCRM'													     = 'Microsoft Social Engagement Professional';
	'NONPROFIT_PORTAL'														     = 'Nonprofit Portal';
	'O365_BUSINESS'															     = 'Microsoft 365 Apps for Business';
	'O365_BUSINESS_ESSENTIALS'												     = 'Microsoft 365 Business Basic';
	'O365_BUSINESS_ESSENTIALS_EXCHANGE_S_STANDARD'							     = 'M365 Business Basic - Exchange Online (P2)';
	'O365_BUSINESS_ESSENTIALS_FLOW_O365_P1'									     = 'M365 Business Basic - Flow for Office 365';
	'O365_BUSINESS_ESSENTIALS_FORMS_PLAN_E1'									 = 'M365 Business Basic - Microsft Forms (Plan E1)';
	'O365_BUSINESS_ESSENTIALS_MCOSTANDARD'									     = 'M365 Business Basic - Skype for Business Online (P2)';
	'O365_BUSINESS_ESSENTIALS_POWERAPPS_O365_P1'								 = 'M365 Business Basic - PowerApps for Office 365';
	'O365_BUSINESS_ESSENTIALS_PROJECTWORKMANAGEMENT'							 = 'M365 Business Basic - Microsoft Planner';
	'O365_BUSINESS_ESSENTIALS_SHAREPOINTSTANDARD'							     = 'M365 Business Basic - SharePoint (P1)';
	'O365_BUSINESS_ESSENTIALS_SHAREPOINTWAC'									 = 'M365 Business Basic - Office for web';
	'O365_BUSINESS_ESSENTIALS_SWAY'											     = 'M365 Business Basic - Sway';
	'O365_BUSINESS_ESSENTIALS_TEAMS1'										     = 'M365 Business Basic - Microsoft Teams';
	'O365_BUSINESS_ESSENTIALS_YAMMER_ENTERPRISE'								 = 'M365 Business Basic - Yammer Enterprise';
	'O365_BUSINESS_FORMS_PLAN_E1'											     = 'M365 Apps for Business - Microsft Forms (Plan E1)';
	'O365_BUSINESS_OFFICE_BUSINESS'											     = 'M365 Apps for Business - Office 365 Business';
	'O365_BUSINESS_ONEDRIVESTANDARD'											 = 'M365 Apps for Business - OneDrive for Business';
	'O365_BUSINESS_PREMIUM'													     = 'Microsoft 365 Business Standard';
	'O365_BUSINESS_PREMIUM_BPOS_S_TODO_1'									     = 'M365 Business Standard - To-do (P1)';
	'O365_BUSINESS_PREMIUM_DESKLESS'											 = 'M365 Business Standard - Microsoft StaffHub';
	'O365_BUSINESS_PREMIUM_DYN365_CDS_O365_P2'								     = 'M365 Business Standard - Common Data Service';
	'O365_BUSINESS_PREMIUM_DYN365BC_MS_INVOICING'							     = 'M365 Business Standard - Microsoft Invoicing';
	'O365_BUSINESS_PREMIUM_EXCHANGE_S_STANDARD'								     = 'M365 Business Standard - Exchange Online (P2)';
	'O365_BUSINESS_PREMIUM_FLOW_O365_P1'										 = 'M365 Business Standard - Flow for Office 365';
	'O365_BUSINESS_PREMIUM_FORMS_PLAN_E1'									     = 'M365 Business Standard - Microsft Forms (Plan E1)';
	'O365_BUSINESS_PREMIUM_KAIZALA_O365_P2'									     = 'M365 Business Standard - Microsoft Kaizala Pro';
	'O365_BUSINESS_PREMIUM_MCOSTANDARD'										     = 'M365 Business Standard - Skype for Business Online (P2)';
	'O365_BUSINESS_PREMIUM_MICROSOFTBOOKINGS'								     = 'M365 Business Standard - Microsoft Bookings';
	'O365_BUSINESS_PREMIUM_MYANALYTICS_P2'									     = 'M365 Business Standard - Insights by MyAnalytics';
	'O365_BUSINESS_PREMIUM_O365_SB_RELATIONSHIP_MANAGEMENT'					     = 'M365 Business Standard - Outlook Customer Manager';
	'O365_BUSINESS_PREMIUM_OFFICE_BUSINESS'									     = 'M365 Business Standard - Office 365 Business';
	'O365_BUSINESS_PREMIUM_POWERAPPS_O365_P1'								     = 'M365 Business Standard - PowerApps for Office 365';
	'O365_BUSINESS_PREMIUM_PROJECTWORKMANAGEMENT'							     = 'M365 Business Standard - Microsoft Planner';
	'O365_BUSINESS_PREMIUM_SHAREPOINTSTANDARD'								     = 'M365 Business Standard - SharePoint (P1)';
	'O365_BUSINESS_PREMIUM_SHAREPOINTWAC'									     = 'M365 Business Standard - Office for web';
	'O365_BUSINESS_PREMIUM_STREAM_O365_SMB'									     = 'M365 Business Standard - Stream for Office 365';
	'O365_BUSINESS_PREMIUM_SWAY'												 = 'M365 Business Standard - Sway';
	'O365_BUSINESS_PREMIUM_TEAMS1'											     = 'M365 Business Standard - Microsoft Teams';
	'O365_BUSINESS_PREMIUM_WHITEBOARD_PLAN1'									 = 'M365 Business Standard - Whiteboard (P1)';
	'O365_BUSINESS_PREMIUM_YAMMER_ENTERPRISE'								     = 'M365 Business Standard - Yammer Enterprise';
	'O365_BUSINESS_SHAREPOINTWAC'											     = 'M365 Apps for Business - Office for web';
	'O365_BUSINESS_SWAY'														 = 'M365 Apps for Business - Sway';
	'O365_SB_Relationship_Management'										     = 'Outlook Customer Manager';
	'OFFICE_BASIC'															     = 'Office 365 Basic';
	'OFFICE_BUSINESS'														     = 'Office 365 Business';
	'OFFICE_FORMS_PLAN_2'													     = 'Microsoft Forms (Plan 2)';
	'OFFICE_FORMS_PLAN_3'													     = 'Microsoft Forms (Plan 3)';
	'OFFICE365_MULTIGEO'														 = 'Multi-Geo Capabilities in Office 365';
	'OFFICEMOBILE_SUBSCRIPTION'												     = 'OFFICEMOBILE_SUBSCRIPTION';
	'OFFICESUBSCRIPTION'														 = 'Microsoft 365 Apps for Enterprise';
	'OFFICESUBSCRIPTION_FACULTY'												 = 'Office 365 ProPlus for Faculty';
	'OFFICESUBSCRIPTION_FORMS_PLAN_E1'										     = 'M365 Apps for Enterprise - Microsft Forms (Plan E1)';
	'OFFICESUBSCRIPTION_GOV'													 = 'Office 365 ProPlus for Government';
	'OFFICESUBSCRIPTION_OFFICESUBSCRIPTION'									     = 'M365 Apps for Enterprise - Office 365 ProPlus';
	'OFFICESUBSCRIPTION_ONEDRIVESTANDARD'									     = 'M365 Apps for Enterprise - OneDrive for Business';
	'OFFICESUBSCRIPTION_SHAREPOINTWAC'										     = 'M365 Apps for Enterprise - Office for web';
	'OFFICESUBSCRIPTION_STUDENT'												 = 'Microsoft 365 Apps for Students';
	'OFFICESUBSCRIPTION_SWAY'												     = 'M365 Apps for Enterprise - Sway';
	'ONEDRIVE_BASIC'															 = 'OneDrive Basic';
	'ONEDRIVEBASIC'															     = 'OneDrive Basic';
	'ONEDRIVEENTERPRISE'														 = 'Onedriveenterprise';
	'ONEDRIVESTANDARD'														     = 'Onedrivestandard';
	'ONEDRIVESTANDARD_GOV'													     = 'OneDrive for Business for Government (Plan 1G)';
	'PAM_ENTERPRISE'															 = 'Office 365 Privileged Access Management';
	'PARATURE_ENTERPRISE'													     = 'Parature Enterprise';
	'PARATURE_ENTERPRISE_GOV'												     = 'Parature Enterprise for Government';
	'PHONESYSTEM_VIRTUALUSER'												     = 'Phone System â€" Virtual User';
	'PHONESYSTEM_VIRTUALUSER_MCOEV_VIRTUALUSER'								     = 'Microsoft 365 Phone System - Virtual User';
	'PLANNERSTANDALONE'														     = 'Planner Standalone';
	'POWER_BI_ADDON'															 = 'Power BI for Office 365 Add-on';
	'POWER_BI_ADDON_BI_AZURE_P1'												 = 'Power BI for O365 Add-on - Microsoft Power BI Reporting And Analytics Plan 1';
	'POWER_BI_ADDON_SQL_IS_SSIM'												 = 'Power BI for O365 Add-on - Microsoft Power BI Information Services Plan 1';
	'POWER_BI_INDIVIDUAL_USE'												     = 'Power BI Individual User';
	'POWER_BI_INDIVIDUAL_USER'												     = 'Power BI for Office 365 Individual';
	'POWER_BI_PRO'															     = 'Power BI Pro';
	'POWER_BI_PRO_BI_AZURE_P2'												     = 'POWER BI PRO - Power BI Pro';
	'POWER_BI_PRO_CE'														     = 'Power BI Pro (Nonprofit Staff Pricing)';
	'POWER_BI_PRO_FACULTY'													     = 'Power BI Pro for faculty';
	'POWER_BI_PRO_STUDENT'													     = 'Power BI Pro for students';
	'POWER_BI_STANDALONE'													     = 'Power BI for Office 365 Standalone';
	'POWER_BI_STANDALONE_FACULTY'											     = 'Power BI for Office 365 for Faculty';
	'POWER_BI_STANDALONE_STUDENT'											     = 'Power BI for Office 365 for Students';
	'POWER_BI_STANDARD'														     = 'Power BI (free)';
	'POWER_BI_STANDARD_BI_AZURE_P0'											     = 'Power BI (free)';
	'POWER_BI_STANDARD_FACULTY'												     = 'Power BI (free) for Faculty';
	'POWER_BI_STANDARD_STUDENT'												     = 'Power BI (free) for Students';
	'POWERAPPS_DEV'															     = 'Power Apps for Developer';
	'POWERAPPS_DYN_APPS'														 = 'Powerapps for Dynamics 365';
	'POWERAPPS_DYN_P2'														     = 'Powerapps for Dynamics 365';
	'POWERAPPS_DYN_TEAM'														 = 'Powerapps for Dynamics 365';
	'POWERAPPS_INDIVIDUAL_USER'												     = 'Microsoft PowerApps and Logic Flows';
	'POWERAPPS_INDIVIDUAL_USER_POWERAPPSFREE'								     = 'Microsoft PowerApps and Logic Flows - Microsoft PowerApps';
	'POWERAPPS_INDIVIDUAL_USER_POWERFLOWSFREE'								     = 'Microsoft PowerApps and Logic Flows - Logic Flows';
	'POWERAPPS_INDIVIDUAL_USER_POWERVIDEOSFREE'								     = 'Microsoft PowerApps and Logic Flows - Microsoft Power Videos Basic';
	'POWERAPPS_O365_P1'														     = 'Powerapps for Office 365';
	'POWERAPPS_O365_P2'														     = 'Powerapps for Office 365';
	'POWERAPPS_O365_P3'														     = 'Powerapps for Office 365 Plan 3';
	'POWERAPPS_O365_S1'														     = 'Powerapps for Office 365 K1';
	'POWERAPPS_P2_VIRAL'														 = 'PowerApps Trial';
	'POWERAPPS_PER_USER'														 = 'PowerApps Per User Plan';
	'POWERAPPS_PER_APP'														     = 'PowerApps Per App Plan '
	'POWERAPPS_PER_APP_IW'													     = 'PowerApps per app baseline access';
	'POWERAPPS_VIRAL'														     = 'Microsoft PowerApps Plan 2 Trial';
	'POWERAPPS_VIRAL_DYN365_CDS_VIRAL'										     = 'MS PowerApps Plan 2 Trial - Common Data Service';
	'POWERAPPS_VIRAL_FLOW_P2_VIRAL'											     = 'MS PowerApps Plan 2 Trial - Flow Free';
	'POWERAPPS_VIRAL_FLOW_P2_VIRAL_REAL'										 = 'MS PowerApps Plan 2 Trial - Flow P2 Viral';
	'POWERAPPS_VIRAL_POWERAPPS_P2_VIRAL'										 = 'MS PowerApps Plan 2 Trial - PowerApps Trial';
	'POWERAPPSFREE'															     = 'Microsoft PowerApps';
	'POWERAUTOMATE_ATTENDED_RPA'												 = 'Power Automate per user plan with attended RPA';
	'POWERFLOW_P2'															     = 'Microsoft PowerApps Plan 2 Trial';
	'POWERFLOW_P2_DYN365_CDS_P2'												 = 'Microsoft PowerApps P2 Trial - Common Data Service';
	'POWERFLOW_P2_FLOW_P2'													     = 'Microsoft PowerApps P2 Trial';
	'POWERFLOW_P2_POWERAPPS_P2'												     = 'Microsoft PowerApps P2 Trial - PowerApps';
	'POWERFLOWSFREE'															 = 'Logic flows';
	'POWERVIDEOSFREE'														     = 'Microsoft Power Videos Basic';
	'PREMIUM_ENCRYPTION'														 = 'Premium Encryption In Office 365';
	'PROJECT_CLIENT_SUBSCRIPTION'											     = 'Project Online Desktop Client';
	'PROJECT_ESSENTIALS'														 = 'Project Online Essentials';
	'PROJECT_MADEIRA_PREVIEW_IW_SKU'											 = 'Dynamics 365 for Financials for IWs';
	'PROJECT_MADEIRA_PREVIEW_IW_SKU_PROJECT_MADEIRA_PREVIEW_IW'				     = 'Microsoft Dynamics 365 Business Preview Iw (deprecated)';
	'PROJECT_P1'																 = 'Project Plan 1';
	'PROJECT_PROFESSIONAL'													     = 'Project Online Professional';
	'PROJECTCLIENT'															     = 'Project for Office 365';
	'PROJECTCLIENT_FACULTY'													     = 'Project Pro for Office 365 for Faculty';
	'PROJECTCLIENT_GOV'														     = 'Project Pro for Office 365 for Government';
	'PROJECTCLIENT_PROJECT_CLIENT_SUBSCRIPTION'								     = 'Project for O365 - Project Online Desktop Client';
	'PROJECTCLIENT_STUDENT'													     = 'Project Pro for Office 365 for Students';
	'PROJECTESSENTIALS'														     = 'Project Online Essentials';
	'PROJECTESSENTIALS_FACULTY'												     = 'Project Online Essentials for Faculty';
	'PROJECTESSENTIALS_FORMS_PLAN_E1'										     = 'Project Online Essentials - Microsft Forms (Plan E1)';
	'PROJECTESSENTIALS_GOV'													     = 'Project Essentials for Government';
	'PROJECTESSENTIALS_PROJECT_ESSENTIALS'									     = 'Project Online Essentials - Project Online Essential';
	'PROJECTESSENTIALS_SHAREPOINTENTERPRISE'									 = 'Project Online Essentials - SharePoint (P2)';
	'PROJECTESSENTIALS_SHAREPOINTWAC'										     = 'Project Online Essentials - Office for web';
	'PROJECTESSENTIALS_STUDENT'												     = 'Project Online Essentials for Students';
	'PROJECTESSENTIALS_SWAY'													 = 'Project Online Essentials - Sway';
	'PROJECTONLINE_PLAN_1'													     = 'Project Online Premium Without Project Client';
	'PROJECTONLINE_PLAN_1_FACULTY'											     = 'Project Online for Faculty Plan 1';
	'PROJECTONLINE_PLAN_1_FORMS_PLAN_E1'										 = 'Project Online Premium Without Project Client - Microsft Forms (Plan E1)';
	'PROJECTONLINE_PLAN_1_GOV'												     = 'Project Plan 1for Government';
	'PROJECTONLINE_PLAN_1_SHAREPOINT_PROJECT'								     = 'Project Online Premium Without Project Client - Project Online Service';
	'PROJECTONLINE_PLAN_1_SHAREPOINTENTERPRISE'								     = 'Project Online Premium Without Project Client - SharePoint (P2)';
	'PROJECTONLINE_PLAN_1_SHAREPOINTWAC'										 = 'Project Online Premium Without Project Client - Office for web';
	'PROJECTONLINE_PLAN_1_STUDENT'											     = 'Project Online for Students Plan 1';
	'PROJECTONLINE_PLAN_1_SWAY'												     = 'Project Online Premium Without Project Client - Sway';
	'PROJECTONLINE_PLAN_2'													     = 'Project Online With Project for Office 365';
	'PROJECTONLINE_PLAN_2_FACULTY'											     = 'Project Online for Faculty Plan 2';
	'PROJECTONLINE_PLAN_2_FORMS_PLAN_E1'										 = 'Project Online With Project for O365 - Microsft Forms (Plan E1)';
	'PROJECTONLINE_PLAN_2_GOV'												     = 'Project Plan 2 for Government';
	'PROJECTONLINE_PLAN_2_SHAREPOINT_PROJECT'								     = 'Project Online With Project for O365 - Project Online Service';
	'PROJECTONLINE_PLAN_2_STUDENT'											     = 'Project Online for Students Plan 2';
	'PROJECTONLINE_PLAN_3_PROJECT_CLIENT_SUBSCRIPTION'						     = 'Project Online With Project for O365 - Project Online Desktop Client';
	'PROJECTONLINE_PLAN_3_SHAREPOINTENTERPRISE'								     = 'Project Online Premium Without Project Client - SharePoint (P2)';
	'PROJECTONLINE_PLAN_4_SHAREPOINT_PROJECT'								     = 'Project Online With Project for O365 - Project Online Service';
	'PROJECTONLINE_PLAN_4_SHAREPOINTWAC'										 = 'Project Online Premium Without Project Client - Office for web';
	'PROJECTONLINE_PLAN_5_SHAREPOINTENTERPRISE'								     = 'Project Online With Project for O365 - SharePoint (P2)';
	'PROJECTONLINE_PLAN_5_SWAY'												     = 'Project Online Premium Without Project Client - Sway';
	'PROJECTONLINE_PLAN_6_SHAREPOINTWAC'										 = 'PProject Online With Project for O365 - Office for web';
	'PROJECTONLINE_PLAN_7_SWAY'												     = 'Project Online With Project for O365 - Sway';
	'PROJECTONLINE_PLAN1_FACULTY'											     = 'Project Online Professional P1 for Faculty';
	'PROJECTONLINE_PLAN1_STUDENT'											     = 'Project Online Professional P1 for Students';
	'PROJECTPREMIUM'															 = 'Project Online Premium';
	'PROJECTPREMIUM_PROJECT_CLIENT_SUBSCRIPTION'								 = 'Project Online Premium - Project Online Desktop Client';
	'PROJECTPREMIUM_SHAREPOINT_PROJECT'										     = 'Project Online Premium - Project Online Service';
	'PROJECTPREMIUM_SHAREPOINTENTERPRISE'									     = 'Project Online Premium - SharePoint (P2)';
	'PROJECTPREMIUM_SHAREPOINTWAC'											     = 'Project Online Premium - Office for web';
	'PROJECTPROFESSIONAL'													     = 'Project Online Professional';
	'PROJECTPROFESSIONAL_DYN365_CDS_PROJECT'									 = 'Project Online Professional - Common Data Service';
	'PROJECTPROFESSIONAL_FLOW_FOR_PROJECT'									     = 'Project Online Professional - Flow for Project Online';
	'PROJECTPROFESSIONAL_PROJECT_CLIENT_SUBSCRIPTION'						     = 'Project Online Professional - Project Online Desktop Client';
	'PROJECTPROFESSIONAL_PROJECT_PROFESSIONAL'								     = 'Project Online Professional - Project Professional';
	'PROJECTPROFESSIONAL_SHAREPOINT_PROJECT'									 = 'Project Online Professional - Project Online Service';
	'PROJECTPROFESSIONAL_SHAREPOINTENTERPRISE'								     = 'Project Online Professional - SharePoint (P2)';
	'PROJECTPROFESSIONAL_SHAREPOINTWAC'										     = 'Project Online Professional - Office for web';
	'PROJECTWORKMANAGEMENT'													     = 'Microsoft Planner';
	'RECORDS_MANAGEMENT'														 = 'Microsoft Records Management';
	'RIGHTSMANAGEMENT'														     = 'Azure Information Protection Plan 1';
	'RIGHTSMANAGEMENT_ADHOC'													 = 'Rights Management Adhoc';
	'RIGHTSMANAGEMENT_ADHOC_RMS_S_ADHOC'										 = 'Rights Management Adhoc';
	'RIGHTSMANAGEMENT_FACULTY'												     = 'Azure Active Directory Rights for Faculty';
	'RIGHTSMANAGEMENT_GOV'													     = 'Azure Active Directory Rights for Government';
	'RIGHTSMANAGEMENT_RMS_S_ENTERPRISE'										     = 'Azure Information Protection Plan 1 - Microsoft Azure AD Rights';
	'RIGHTSMANAGEMENT_RMS_S_PREMIUM'											 = 'Azure Information Protection Plan 1 - Azure Information Protection Premium P1';
	'RIGHTSMANAGEMENT_RMS_S_PREMIUM2'										     = 'Azure Information Protection Plan 1 - Azure Information Protection Premium P2';
	'RIGHTSMANAGEMENT_STANDARD_FACULTY'										     = 'Azure Rights Management for faculty';
	'RIGHTSMANAGEMENT_STANDARD_STUDENT'										     = 'Azure Rights Management for students';
	'RIGHTSMANAGEMENT_STUDENT'												     = 'Azure Active Directory Rights for Students';
	'RMS_S_ADHOC'															     = 'Rights Management Adhoc';
	'RMS_S_ENTERPRISE'														     = 'Microsoft Azure Active Directory Rights';
	'RMS_S_ENTERPRISE_GOV'													     = 'Azure Rights Management';
	'RMS_S_PREMIUM'															     = 'Azure Information Protection Premium P1';
	'RMS_S_PREMIUM2'															 = 'Azure Information Protection Premium P2';
	'RMSBASIC'																     = 'Rights Management Basic';
	'SAFEDOCS'																     = 'Office 365 Safedocs';
	'SCHOOL_DATA_SYNC_P1'													     = 'School Data Sync (Plan 1)';
	'SCHOOL_DATA_SYNC_P2'													     = 'School Data Sync (Plan 2)';
	'SHAREPOINT_PROJECT'														 = 'Project Online Service';
	'SHAREPOINT_PROJECT_EDU'													 = 'Project Online for Education';
	'SHAREPOINT_S_DEVELOPER'													 = 'SHAREPOINT_S_DEVELOPER';
	'SHAREPOINTDESKLESS'														 = 'Sharepoint Online Kiosk';
	'SHAREPOINTDESKLESS_GOV'													 = 'SharePoint Online Kiosk';
	'SHAREPOINTDESKLESS_SHAREPOINTDESKLESS'									     = 'Sharepoint Online Kiosk - Sharepoint Online Kiosk';
	'SHAREPOINTENTERPRISE'													     = 'Sharepoint Online (Plan 2)';
	'SHAREPOINTENTERPRISE_EDU'												     = 'Sharepoint Plan 2 for EDU';
	'SHAREPOINTENTERPRISE_FACULTY'											     = 'SharePoint (Plan 2 for Faculty)';
	'SHAREPOINTENTERPRISE_GOV'												     = 'SharePoint P2 for Government';
	'SHAREPOINTENTERPRISE_SHAREPOINTENTERPRISE'								     = 'Sharepoint Online (Plan 2)';
	'SHAREPOINTENTERPRISE_STUDENT'											     = 'SharePoint (Plan 2 for Students)';
	'SHAREPOINTENTERPRISE_YAMMER'											     = 'SharePoint (Plan 2 with Yammer)';
	'SHAREPOINTLITE'															 = 'Sharepointlite';
	'SHAREPOINTPARTNER'														     = 'SharePoint Online Partner Access';
	'SHAREPOINTSTANDARD'														 = 'Sharepoint Online (Plan 1)';
	'SHAREPOINTSTANDARD_EDU'													 = 'SharePoint Plan 1 for EDU';
	'SHAREPOINTSTANDARD_FACULTY'												 = 'SharePoint (Plan 1 for Faculty)';
	'SHAREPOINTSTANDARD_GOV'													 = 'SharePoint for Government (Plan 1G)';
	'SHAREPOINTSTANDARD_SHAREPOINTSTANDARD'									     = 'Sharepoint Online (Plan 1)';
	'SHAREPOINTSTANDARD_STUDENT'												 = 'SharePoint (Plan 1 for Students)';
	'SHAREPOINTSTANDARD_YAMMER'												     = 'SharePoint (Plan 1 with Yammer)';
	'SHAREPOINTSTORAGE'														     = 'SharePoint Online Storage';
	'SHAREPOINTWAC'															     = 'Office Online';
	'SHAREPOINTWAC_DEVELOPER'												     = 'Office Online for Developer';
	'SHAREPOINTWAC_EDU'														     = 'Office for The Web (Education)';
	'SHAREPOINTWAC_GOV'														     = 'Office Online for Government';
	'SKU ID'																	 = 'Product Name';
	'SKU_Dynamics_365_for_HCM_Trial'											 = 'Dynamics 365 for Talents';
	'SKU_DYNAMICS_365_FOR_HCM_TRIAL_DYN365_CDS_DYN_APPS'						 = 'Dynamics 365 for Talents';
	'SKU_DYNAMICS_365_FOR_HCM_TRIAL_DYNAMICS_365_FOR_HCM_TRIAL'				     = 'Dynamics 365 for Talents';
	'SKU_DYNAMICS_365_FOR_HCM_TRIAL_DYNAMICS_365_HIRING_FREE_PLAN'			     = 'Dynamics 365 for Talents';
	'SKU_DYNAMICS_365_FOR_HCM_TRIAL_DYNAMICS_365_ONBOARDING_FREE_PLAN'		     = 'Dynamics 365 for Talents';
	'SKU_DYNAMICS_365_FOR_HCM_TRIAL_FLOW_DYN_APPS'							     = 'Dynamics 365 for Talents - Flow for Dynamics 365';
	'SKU_DYNAMICS_365_FOR_HCM_TRIAL_POWERAPPS_DYN_APPS'						     = 'Dynamics 365 for Talents';
	'SMB_APPS'																     = 'Microsoft Business Apps';
	'SMB_APPS_DYN365BC_MS_INVOICING'											 = 'Microsoft Business Apps - Microsoft Invoicing';
	'SMB_APPS_MICROSOFTBOOKINGS'												 = 'Microsoft Business Apps - Microsoft Bookings';
	'SMB_BUSINESS'															     = 'Microsoft 365 Apps for Business';
	'SMB_BUSINESS_ESSENTIALS'												     = 'Microsoft 365 Business Basic';
	'SMB_BUSINESS_ESSENTIALS_EXCHANGE_S_STANDARD'							     = 'M365 Business Basic - Exchange Online (P2)';
	'SMB_BUSINESS_ESSENTIALS_FLOW_O365_P1'									     = 'M365 Business Basic - Flow for Office 365';
	'SMB_BUSINESS_ESSENTIALS_FORMS_PLAN_E1'									     = 'M365 Business Basic - Microsft Forms (Plan E1)';
	'SMB_BUSINESS_ESSENTIALS_MCOSTANDARD'									     = 'M365 Business Basic - Skype for Business Online (P2)';
	'SMB_BUSINESS_ESSENTIALS_POWERAPPS_O365_P1'								     = 'M365 Business Basic - PowerApps for Office 365';
	'SMB_BUSINESS_ESSENTIALS_PROJECTWORKMANAGEMENT'							     = 'M365 Business Basic - Microsoft Planner';
	'SMB_BUSINESS_ESSENTIALS_SHAREPOINTSTANDARD'								 = 'M365 Business Basic - SharePoint (P1)';
	'SMB_BUSINESS_ESSENTIALS_SHAREPOINTWAC'									     = 'M365 Business Basic - Office for web';
	'SMB_BUSINESS_ESSENTIALS_SWAY'											     = 'M365 Business Basic - Sway';
	'SMB_BUSINESS_ESSENTIALS_TEAMS1'											 = 'M365 Business Basic - Microsoft Teams';
	'SMB_BUSINESS_ESSENTIALS_YAMMER_MIDSIZE'									 = 'M365 Business Basic - Yammer Enterprise';
	'SMB_BUSINESS_FORMS_PLAN_E1'												 = 'M365 Apps for Business - Microsft Forms (Plan E1)';
	'SMB_BUSINESS_OFFICE_BUSINESS'											     = 'M365 Apps for Business - Office 365 Business';
	'SMB_BUSINESS_ONEDRIVESTANDARD'											     = 'M365 Apps for Business - OneDrive for Business';
	'SMB_BUSINESS_PREMIUM'													     = 'Microsoft 365 Business Standard';
	'SMB_BUSINESS_PREMIUM_EXCHANGE_S_STANDARD'								     = 'M365 Business Standard - Exchange Online (P2)';
	'SMB_BUSINESS_PREMIUM_FLOW_O365_P1'										     = 'M365 Business Standard - Flow for Office 365';
	'SMB_BUSINESS_PREMIUM_FORMS_PLAN_E1'										 = 'M365 Business Standard - Microsft Forms (Plan E1)';
	'SMB_BUSINESS_PREMIUM_MCOSTANDARD'										     = 'M365 Business Standard - Skype for Business Online (P2)';
	'SMB_BUSINESS_PREMIUM_MICROSOFTBOOKINGS'									 = 'M365 Business Standard - Microsoft Bookings';
	'SMB_BUSINESS_PREMIUM_O365_SB_RELATIONSHIP_MANAGEMENT'					     = 'M365 Business Standard -';
	'SMB_BUSINESS_PREMIUM_OFFICE_BUSINESS'									     = 'M365 Business Standard - Office 365 Business';
	'SMB_BUSINESS_PREMIUM_POWERAPPS_O365_P1'									 = 'M365 Business Standard - PowerApps for Office 365';
	'SMB_BUSINESS_PREMIUM_PROJECTWORKMANAGEMENT'								 = 'M365 Business Standard - Microsoft Planner';
	'SMB_BUSINESS_PREMIUM_SHAREPOINTSTANDARD'								     = 'M365 Business Standard - SharePoint (P1)';
	'SMB_BUSINESS_PREMIUM_SHAREPOINTWAC'										 = 'M365 Business Standard - Office for web';
	'SMB_BUSINESS_PREMIUM_SWAY'												     = 'M365 Business Standard - Sway';
	'SMB_BUSINESS_PREMIUM_TEAMS1'											     = 'M365 Business Standard - Microsoft Teams';
	'SMB_BUSINESS_PREMIUM_YAMMER_MIDSIZE'									     = 'M365 Business Standard - Yammer Enterprise';
	'SMB_BUSINESS_SHAREPOINTWAC'												 = 'M365 Apps for Business - Office for web';
	'SMB_BUSINESS_SWAY'														     = 'M365 Apps for Business - Sway';
	'SOCIAL_ENGAGEMENT_APP_USER'												 = 'Dynamics 365 AI for Market Insights';
	'SPB'																	     = 'Microsoft 365 Business Premium';
	'SPE_E3'																	 = 'Microsoft 365 E3';
	'SPE_E3_USGOV_DOD'														     = 'Microsoft 365 E3_USGOV_DOD';
	'SPE_E3_USGOV_GCCHIGH'													     = 'Microsoft 365 E3_USGOV_GCCHIGH';
	'SPE_E5'																	 = 'Microsoft 365 E5';
	'SPE_F1'																	 = 'Microsoft 365 F3';
	'SPE_F1_AAD_PREMIUM'														 = 'M365 F1 - Azure AD Premium P1';
	'SPE_F1_ADALLOM_S_DISCOVERY'												 = 'M365 F1 - Cloud App Security Discovery';
	'SPE_F1_BPOS_S_TODO_FIRSTLINE'											     = 'M365 F1 - To-do (Firstline)';
	'SPE_F1_DESKLESS'														     = 'M365 F1 - Microsoft Staffhub';
	'SPE_F1_DYN365_CDS_O365_F1'												     = 'M365 F1 - Common Data Service';
	'SPE_F1_EXCHANGE_S_DESKLESS'												 = 'M365 F1 - Exchange Online Kiosk';
	'SPE_F1_FLOW_O365_S1'													     = 'M365 F1 - Flow for Office 365 K1';
	'SPE_F1_FORMS_PLAN_K'													     = 'M365 F1 - Microsoft Forms (Plan F1)';
	'SPE_F1_INTUNE_A'														     = 'M365 F1 - Microsoft Intune';
	'SPE_F1_KAIZALA_O365_P1'													 = 'M365 F1 - Microsoft Kaizala';
	'SPE_F1_MCOIMP'															     = 'M365 F1 - Skype for Business Online (P1)';
	'SPE_F1_MFA_PREMIUM'														 = 'M365 F1 - Azure Multi-factor Authentication';
	'SPE_F1_OFFICEMOBILE_SUBSCRIPTION'										     = 'M365 F1 - Office Mobile Apps for Office 365';
	'SPE_F1_POWERAPPS_O365_S1'												     = 'M365 F1 - Powerapps for Office 365 K1';
	'SPE_F1_PROJECTWORKMANAGEMENT'											     = 'M365 F1 - Microsoft Planner';
	'SPE_F1_RMS_S_ENTERPRISE'												     = 'M365 F1 - Azure Rights Management';
	'SPE_F1_RMS_S_PREMIUM'													     = 'M365 F1 - Azure Information Protection P1';
	'SPE_F1_SHAREPOINTDESKLESS'												     = 'M365 F1 - Sharepoint Online Kiosk';
	'SPE_F1_SHAREPOINTWAC'													     = 'M365 F1 - Office for web';
	'SPE_F1_STREAM_O365_K'													     = 'M365 F1 - Microsoft Stream for O365 K SKU';
	'SPE_F1_SWAY'															     = 'M365 F1 - Sway';
	'SPE_F1_TEAMS1'															     = 'M365 F1 - Microsoft Teams';
	'SPE_F1_WHITEBOARD_FIRSTLINE1'											     = 'M365 F1 - Whiteboard (Firstline)';
	'SPE_F1_WIN10_ENT_LOC_F1'												     = 'M365 F1 - Windows 10 Enterprise E3 (local Only)';
	'SPE_F1_YAMMER_ENTERPRISE'												     = 'M365 F1 - Yammer Enterprise';
	'SPZA'																	     = 'App Connect';
	'SPZA_IW'																     = 'App Connect';
	'SPZA_IW_SPZA'															     = 'App Connect Iw';
	'SQL_IS_SSIM'															     = 'Microsoft Power BI Information Services Plan 1';
	'STANDARD_B_PILOT'														     = 'Office 365 (Small Business Preview)';
	'STANDARDPACK'															     = 'Office 365 E1';
	'STANDARDPACK_BPOS_S_TODO_1'												 = 'O365 E1 - To-do (P1)';
	'STANDARDPACK_DESKLESS'													     = 'O365 E1 - Microsoft StaffHub';
	'STANDARDPACK_DYN365_CDS_O365_P1'										     = 'O365 E1 - Common Data Service';
	'STANDARDPACK_EXCHANGE_S_STANDARD'										     = 'O365 E1 - Exchange Online (P2)';
	'STANDARDPACK_FACULTY'													     = 'Office 365 Education E1 for Faculty';
	'STANDARDPACK_FLOW_O365_P1'												     = 'O365 E1 - Flow for Office 365';
	'STANDARDPACK_FORMS_PLAN_E1'												 = 'O365 E1 - Microsft Forms (Plan E1)';
	'STANDARDPACK_GOV'														     = 'Office 365 Enterprise E1 for Government';
	'STANDARDPACK_KAIZALA_O365_P2'											     = 'O365 E1 - Microsoft Kaizala Pro';
	'STANDARDPACK_MCOSTANDARD'												     = 'O365 E1 - Skype for Business Online (P2)';
	'STANDARDPACK_MYANALYTICS_P2'											     = 'O365 E1 - Insights by MyAnalytics';
	'STANDARDPACK_OFFICEMOBILE_SUBSCRIPTION'									 = 'O365 E1 - Office Mobile Apps for Office 365';
	'STANDARDPACK_POWERAPPS_O365_P1'											 = 'O365 E1 - PowerApps for Office 365';
	'STANDARDPACK_PROJECTWORKMANAGEMENT'										 = 'O365 E1 - Microsoft Planner';
	'STANDARDPACK_SHAREPOINTSTANDARD'										     = 'O365 E1 - SharePoint (P1)';
	'STANDARDPACK_SHAREPOINTWAC'												 = 'O365 E1 - Office for web';
	'STANDARDPACK_STREAM_O365_E1'											     = 'O365 E1 - Microsoft Stream for O365 E1 SKU';
	'STANDARDPACK_STUDENT'													     = 'Office 365 Education E1 for Students';
	'STANDARDPACK_SWAY'														     = 'O365 E1 - Sway';
	'STANDARDPACK_TEAMS1'													     = 'O365 E1 - Microsoft Teams';
	'STANDARDPACK_WHITEBOARD_PLAN1'											     = 'O365 E1 - Whiteboard (P1)';
	'STANDARDPACK_YAMMER_ENTERPRISE'											 = 'O365 E1 - Yammer Enterprise';
	'STANDARDWOFFPACK'														     = 'Office 365 E2';
	'STANDARDWOFFPACK_DESKLESS'												     = 'O365 E2 - Microsoft StaffHub';
	'STANDARDWOFFPACK_EXCHANGE_S_STANDARD'									     = 'O365 E2 - Exchange Online (P2)';
	'STANDARDWOFFPACK_FACULTY'												     = 'Office 365 A1 for faculty';
	'STANDARDWOFFPACK_FLOW_O365_P1'											     = 'O365 E2 - Flow for Office 365';
	'STANDARDWOFFPACK_FORMS_PLAN_E1'											 = 'O365 E2 - Microsft Forms (Plan E1)';
	'STANDARDWOFFPACK_GOV'													     = 'Office 365 Enterprise E2 for Government';
	'STANDARDWOFFPACK_IW_FACULTY'											     = 'Office 365 Education E2 for Faculty';
	'STANDARDWOFFPACK_IW_STUDENT'											     = 'Office 365 Education E2 for Students';
	'STANDARDWOFFPACK_MCOSTANDARD'											     = 'O365 E2 - Skype for Business Online (P2)';
	'STANDARDWOFFPACK_POWERAPPS_O365_P1'										 = 'O365 E2 - PowerApps for Office 365';
	'STANDARDWOFFPACK_PROJECTWORKMANAGEMENT'									 = 'O365 E2 - Microsoft Planner';
	'STANDARDWOFFPACK_SHAREPOINTSTANDARD'									     = 'O365 E2 - SharePoint (P1)';
	'STANDARDWOFFPACK_SHAREPOINTWAC'											 = 'O365 E2 - Office for web';
	'STANDARDWOFFPACK_STREAM_O365_E1'										     = 'O365 E2 - Stream for Office 365';
	'STANDARDWOFFPACK_STUDENT'												     = 'Office 365 A1 for students';
	'STANDARDWOFFPACK_SWAY'													     = 'O365 E2 - Sway';
	'STANDARDWOFFPACK_TEAMS1'												     = 'O365 E2 - Microsoft Teams';
	'STANDARDWOFFPACK_YAMMER_ENTERPRISE'										 = 'O365 E2 - Yammer Enterprise';
	'STANDARDWOFFPACKPACK_FACULTY'											     = 'Office 365 Plan A2 for Faculty';
	'STANDARDWOFFPACKPACK_STUDENT'											     = 'Office 365 Plan A2 for Students';
	'STREAM'																	 = 'Microsoft Stream Trial';
	'STREAM_MICROSOFT STREAM'												     = 'Microsoft Stream Trial';
	'STREAM_O365_E1'															 = 'Microsoft Stream for O365 E1 SKU';
	'STREAM_O365_E3'															 = 'Microsoft Stream for O365 E3 SKU';
	'STREAM_O365_E5'															 = 'Microsoft Stream for O365 E5 SKU';
	'STREAM_O365_K'															     = 'Microsoft Stream for O365 K SKU';
	'SWAY'																	     = 'Sway';
	'TEAMS_AR_DOD'															     = 'Microsoft Teams for DoD (ar)';
	'TEAMS_AR_GCCHIGH'														     = 'Microsoft Teams for GCC High (ar)';
	'TEAMS_COMMERCIAL_TRIAL_FLOW_O365_P1'									     = 'Microsoft Teams Commercial Cloud - Flow for Office 365';
	'TEAMS_COMMERCIAL_TRIAL_FORMS_PLAN_E1'									     = 'Microsoft Teams Commercial Cloud - Microsoft Forms (P1)';
	'TEAMS_COMMERCIAL_TRIAL_MCO_TEAMS_IW'									     = 'Microsoft Teams Commercial Cloud - Microsoft Teams';
	'TEAMS_COMMERCIAL_TRIAL_POWERAPPS_O365_P1'								     = 'Microsoft Teams Commercial Cloud - PowerApps for Office 365';
	'TEAMS_COMMERCIAL_TRIAL_PROJECTWORKMANAGEMENT'							     = 'Microsoft Teams Commercial Cloud - Microsoft Planner';
	'TEAMS_COMMERCIAL_TRIAL_SHAREPOINTDESKLESS'								     = 'Microsoft Teams Commercial Cloud - SharePoint Kiosk';
	'TEAMS_COMMERCIAL_TRIAL_SHAREPOINTWAC'									     = 'Microsoft Teams Commercial Cloud - Office for the web';
	'TEAMS_COMMERCIAL_TRIAL_STREAM_O365_E1'									     = 'Microsoft Teams Commercial Cloud - Microsoft Stream for O365 E1 SKU';
	'TEAMS_COMMERCIAL_TRIAL_SWAY'											     = 'Microsoft Teams Commercial Cloud - Sway';
	'TEAMS_COMMERCIAL_TRIAL_TEAMS1'											     = 'Microsoft Teams Commercial Cloud - Microsoft Teams';
	'TEAMS_COMMERCIAL_TRIAL_WHITEBOARD_PLAN1'								     = 'Microsoft Teams Commercial Cloud - Whiteboard (P1)';
	'TEAMS_COMMERCIAL_TRIAL_YAMMER_ENTERPRISE'								     = 'Microsoft Teams Commercial Cloud - Yammer Enterprise';
	'TEAMS_EXPLORATORY'														     = 'Teams Exploratory Trial';
	'TEAMS_FREE'																 = 'Microsoft Teams (Free)';
	'TEAMS1'																	 = 'Microsoft Teams';
	'THREAT_INTELLIGENCE'													     = 'Office 365 Advanced Threat Protection (Plan 2)';
	'TOPIC_EXPERIENCES'														     = 'Topic Experiences';
	'UNIVERSAL_PRINT_M365'													     = 'Universal Print';
	'UNIVERSAL_PRINT_EDU_M365'												     = 'Universal Print for Education Trial';
	'Trial DYN365_AI_SERVICE_INSIGHTS'										     = 'Dynamics 365 Customer Service Insights';
	'VIDEO_INTEROP'															     = 'Polycom Skype Meeting Video Interop for Skype for Business';
	'VIDEO_INTEROP_VIDEO_INTEROP'											     = 'Polycom Skype Meeting Video Interop for Skype for Business';
	'Virtualization Rights for Windows 10 (E3/E5+VDA)'						     = 'Windows 10 Enterprise (new)';
	'VISIO_CLIENT_SUBSCRIPTION'												     = 'Visio Online';
	'VISIOCLIENT'															     = 'Visio Online Plan 2';
	'VISIOCLIENT_FACULTY'													     = 'Visio Pro for Office 365 for Faculty';
	'VISIOCLIENT_GOV'														     = 'Visio Pro for Office 365 for Government';
	'VISIOCLIENT_ONEDRIVE_BASIC'												 = 'Visio Online P2 - OneDrive Basic';
	'VISIOCLIENT_STUDENT'													     = 'Visio Pro for Office 365 for Students';
	'VISIOCLIENT_VISIO_CLIENT_SUBSCRIPTION'									     = 'Visio Online P2 - Visio Online Desktop Client';
	'VISIOCLIENT_VISIOONLINE'												     = 'Visio Online P2 - Vision Online';
	'VISIOONLINE'															     = 'Visioonline';
	'VISIOONLINE_PLAN1'														     = 'Visio Online Plan 1';
	'VISIOONLINE_PLAN1_ONEDRIVE_BASIC'										     = 'Visio Online P1 - OneDrive Basic';
	'VISIOONLINE_PLAN1_VISIOONLINE'											     = 'Visio Online P1 - Visio Online';
	'WACONEDRIVEENTERPRISE'													     = 'Onedrive for Business (Plan 2)';
	'WACONEDRIVEENTERPRISE_ONEDRIVEENTERPRISE'								     = 'Onedrive for Business (P2) - OneDrive for Business P2';
	'WACONEDRIVEENTERPRISE_SHAREPOINTWAC'									     = 'Onedrive for Business (P2) - Office for web';
	'WACONEDRIVESTANDARD'													     = 'Onedrive for Business (Plan 1)';
	'WACONEDRIVESTANDARD_FORMS_PLAN_E1'										     = 'Onedrive for Business (P1) - Microsft Forms (Plan E1)';
	'WACONEDRIVESTANDARD_GOV'												     = 'OneDrive for Business with Office Web Apps for Government';
	'WACONEDRIVESTANDARD_ONEDRIVESTANDARD'									     = 'Onedrive for Business (P1) - OneDrive for Business';
	'WACONEDRIVESTANDARD_SHAREPOINTWAC'										     = 'Onedrive for Business (P1) - Office for web';
	'WACONEDRIVESTANDARD_SWAY'												     = 'Onedrive for Business (P1) - Sway';
	'WACSHAREPOINTENT'														     = 'Office Web Apps with SharePoint Plan 2';
	'WACSHAREPOINTENT_FACULTY'												     = 'Office Web Apps (Plan 2 For Faculty)';
	'WACSHAREPOINTENT_GOV'													     = 'Office Web Apps (Plan 2G for Government)';
	'WACSHAREPOINTENT_STUDENT'												     = 'Office Web Apps (Plan 2 For Students)';
	'WACSHAREPOINTSTD'														     = 'Office Online';
	'WACSHAREPOINTSTD_FACULTY'												     = 'Office Web Apps (Plan 1 For Faculty)';
	'WACSHAREPOINTSTD_GOV'													     = 'Office Web Apps (Plan 1G for Government)';
	'WACSHAREPOINTSTD_STUDENT'												     = 'Office Web Apps (Plan 1 For Students)';
	'WHITEBOARD_FIRSTLINE1'													     = 'Whiteboard (Firstline)';
	'WHITEBOARD_PLAN2'														     = 'Whiteboard (Plan 2)';
	'WHITEBOARD_PLAN3'														     = 'Whiteboard (Plan 3)';
	'WIN_DEF_ATP'															     = 'Microsoft Defender Advanced Threat Protection';
	'WIN_DEF_ATP_WINDEFATP'													     = 'Microsoft Defender Advanced Threat Protection';
	'WIN10_ENT_LOC_F1'														     = 'Windows 10 Enterprise E3 (local Only)';
	'WIN10_PRO_ENT_SUB'														     = 'Windows 10 Enterprise E3';
	'WIN10_PRO_ENT_SUB_WIN10_PRO_ENT_SUB'									     = 'Windows 10 Enterprise E3';
	'WIN10_VDA_E3'															     = 'Windows 10 Enterprise E3';
	'WIN10_VDA_E3_VIRTUALIZATION RIGHTS FOR WINDOWS 10 (E3/E5+VDA)'			     = 'Windows 10 Enterprise E3 - Windows 10 Enterprise';
	'WIN10_VDA_E5'															     = 'Windows 10 Enterprise E5';
	'WIN10_VDA_E5_VIRTUALIZATION RIGHTS FOR WINDOWS 10 (E3/E5+VDA)'			     = 'Windows 10 Enterprise E5 - Windows 10 Enterprise';
	'WIN10_VDA_E5_WINDEFATP'													 = 'Windows 10 Enterprise E5 - Microsoft Defender Advanced Threat Protection';
	'WINBIZ'																	 = 'Windows 10 Business';
	'WINDEFATP'																     = 'Microsoft Defender Advanced Threat Protection';
	'WORKPLACE_ANALYTICS'													     = 'Microsoft Workplace Analytics';
	'WORKPLACE_ANALYTICS_WORKPLACE_ANALYTICS'								     = 'Microsoft Workplace Analytics';
	'WSfB_EDU_Faculty'														     = 'Windows Store for Business EDU Faculty';
	'YAMMER_EDU'																 = 'Yammer for Academic';
	'YAMMER_ENTERPRISE'														     = 'Yammer Enterprise';
	'YAMMER_ENTERPRISE_STANDALONE'											     = 'Yammer Enterprise Standalone';
	'YAMMER_MIDSIZE'															 = 'Yammer Midsize'
}
function Copy_From_User {
	$Global:Copy_From = $textbox_Copy_From.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
	try {
		$Global:Cp = Get-ADUser -identity $Global:Copy_From
		$try = "Success"
	} catch {
		$try = "Failed"
	}
	if ($try -eq "Success") {
		$labelCopyFromInitials.Forecolor = "white"
		$copy = Get-ADUser -identity $global:Copy_From -Properties * | Select-Object City, PostalCode, State, Company, Department, Manager, Profilepath, ScriptPath, HomeDirectory, HomeDrive, HomePage, UserPrincipalName, co, DistinguishedName
		$textbox_Web_Page.Text = $copy.HomePage
		$DistinguishedName = $copy.DistinguishedName
		$splitted = $DistinguishedName.split(",")
		$combobox_OU.SelectedIndex = $combobox_OU.Items.IndexOf(($splitted[1 .. ($splitted.Length + 1)] -join (",")))
		$domain = $copy.UserPrincipalName
		$domain_splitted = $domain.IndexOf("@") + 1
		$domain_length = $domain.Length - $domain_splitted
		$domain_sub = $domain.Substring($domain_splitted, $domain_length)
		$select_domain = $combobox_domain.Items.where({ $_ -eq $domain_sub })
		$combobox_domain.SelectedItem = $select_domain.Item(0)
		$textbox_City.Text = $copy.City
		$textbox_State_Province.Text = $copy.State
		$textbox_ZIP_Postal_Code.Text = $copy.PostalCode
		$co = $copy.co
		$chosen_country = $Country_Name.Keys.where({ $_ -eq $co })
		$combobox_Country.SelectedItem = $chosen_country.Item(0)
		$textbox_Profile_Path.Text = $copy.Profilepath
		$textbox_Logon_Script.Text = $copy.ScriptPath
		$textbox_Local_Path.Text = $copy.HomeDirectory
		$textbox_Department.Text = $copy.Department
		$textbox_Company.Text = $copy.Company
		$man = $copy.Manager
		try { $get_manager = (Get-ADUser "$man") | Select-Object SamAccountName, DistinguishedName } catch { Write-Host "No manager found" }
		$textbox_Manager_initials.Text = $get_manager.SamAccountName
	} else {
		$labelCopyFromInitials.Forecolor = "red"
	}
}
function GUI {
	Loading_Config
	$Global:plength = $combobox_Password_Length.SelectedItem
	if ($checkedlistbox1.CheckedItems -match "Copy from username") {
		$labelCopyFromInitials.Visible = $True
		$textbox_Copy_From.Visible = $True
	} else {
		$labelCopyFromInitials.Visible = $False
		$textbox_Copy_From.Visible = $False
	}
	if ($checkedlistbox1.CheckedItems -match "Description") {
		$labelDescription.Visible = $True
		$textbox_Description.Visible = $True
	} else {
		$labelDescription.Visible = $false
		$textbox_Description.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Telephone") {
		$labelTelephone.Visible = $True
		$textbox_Telephone.Visible = $True
	} else {
		$labelTelephone.Visible = $false
		$textbox_Telephone.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Web page") {
		$labelWebPage.Visible = $True
		$textbox_Web_Page.Visible = $True
	} else {
		$labelWebPage.Visible = $false
		$textbox_Web_Page.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Address street") {
		$labelAddressStreet.Visible = $True
		$textbox_Address_street.Visible = $True
	} else {
		$labelAddressStreet.Visible = $false
		$textbox_Address_street.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "City") {
		$labelCity.Visible = $True
		$textbox_City.Visible = $True
	} else {
		$labelCity.Visible = $false
		$textbox_City.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "State/Province") {
		$labelStateProvince.Visible = $True
		$textbox_State_Province.Visible = $True
	} else {
		$labelStateProvince.Visible = $false
		$textbox_State_Province.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "ZIP/Postal Code") {
		$labelZIPPostalCode.Visible = $True
		$textbox_ZIP_Postal_Code.Visible = $True
	} else {
		$labelZIPPostalCode.Visible = $false
		$textbox_ZIP_Postal_Code.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Profile path") {
		$labelProfile.Visible = $True
		$labelProfilePath.Visible = $True
		$textbox_Profile_Path.Visible = $True
	} else {
		$labelProfilePath.Visible = $false
		$textbox_Profile_Path.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Logon script") {
		$labelProfile.Visible = $True
		$labelLogonScript.Visible = $True
		$textbox_Logon_Script.Visible = $True
	} else {
		$labelLogonScript.Visible = $false
		$textbox_Logon_Script.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Local path") {
		$labelProfile.Visible = $True
		$labelLocalPath.Visible = $True
		$textbox_Local_Path.Visible = $True
	} else {
		$labelLocalPath.Visible = $false
		$textbox_Local_Path.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Connect x-path") {
		$labelProfile.Visible = $True
		$labelConnectXpath.Visible = $True
		$textbox_Connect_X_Path.Visible = $True
		$labelDrive.Visible = $True
		$combobox_Drive.Visible = $True
	} else {
		$labelConnectXpath.Visible = $false
		$textbox_Connect_X_Path.Visible = $false
		$labelDrive.Visible = $false
		$combobox_Drive.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Home") {
		$labelTelephones.Visible = $True
		$labelHome.Visible = $True
		$textbox_Home.Visible = $True
	} else {
		$labelHome.Visible = $false
		$textbox_Home.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Mobile") {
		$labelTelephones.Visible = $True
		$labelMobile.Visible = $True
		$textbox_Mobile.Visible = $True
	} else {
		$labelMobile.Visible = $false
		$textbox_Mobile.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Fax") {
		$labelTelephones.Visible = $True
		$labelFax.Visible = $True
		$textbox_Fax.Visible = $True
	} else {
		$labelFax.Visible = $false
		$textbox_Fax.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Job title") {
		$labelOrganization.Visible = $True
		$labelJob_Title.Visible = $True
		$textbox_Job_Title.Visible = $True
	} else {
		$labelJob_Title.Visible = $false
		$textbox_Job_Title.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Department") {
		$labelOrganization.Visible = $True
		$labelDepartment.Visible = $True
		$textbox_Department.Visible = $True
	} else {
		$labelDepartment.Visible = $false
		$textbox_Department.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Company") {
		$labelOrganization.Visible = $True
		$labelCompany.Visible = $True
		$textbox_Company.Visible = $True
	} else {
		$labelCompany.Visible = $false
		$textbox_Company.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "Manager initials") {
		$labelOrganization.Visible = $True
		$labelManagerInitials.Visible = $True
		$textbox_Manager_initials.Visible = $True
	} else {
		$labelManagerInitials.Visible = $false
		$textbox_Manager_initials.Visible = $false
	}
	if ($checkedlistbox1.CheckedItems -match "O365 Licenses") {
		$labelSelectLicenses.Visible = $true
		$checkedlistbox_licenses.Visible = $true
	} else {
		$labelSelectLicenses.Visible = $false
		$checkedlistbox_licenses.Visible = $false
	}
	if ($checkboxCheckThisBoxToShowAv.Checked) {
		$labelSelectADGroups.Visible = $true
		$checkedlistbox_ADgroups.Visible = $true
	} else {
		$labelSelectADGroups.Visible = $false
		$checkedlistbox_ADgroups.Visible = $false
	}
}
function Domains {
	$combobox_domain.Items.Clear()
	$combobox_domain.Items.Add('-- Please select one --')
	$UPN_Name = Get-adforest | select-Object RootDomain, UPNSuffixes
	$get_domain = @($UPN_Name.RootDomain) + @($UPN_Name.UPNSuffixes)
	@($get_domain) | ForEach-Object { [void]$combobox_domain.Items.Add($_) }
	$combobox_domain.SelectedIndex = 0
}
function OU {
	if ($ConfigKey.Custom_OU -eq "True") {
		$combobox_OU.Items.Clear()
		$combobox_OU.Items.Add('-- Please select one --')
		$Global:OU_Conf = Import-Csv $OU_Config_File | Select-Object OU, Name
		$Global:OU_Conf.Name | ForEach-Object { [void]$combobox_OU.Items.Add($_) }
		$combobox_OU.SelectedIndex = 0
	} else {
		$combobox_OU.Items.Clear()
		$combobox_OU.Items.Add('-- Please select one --')
		Get-ADOrganizationalUnit -filter * | Select-Object DistinguishedName | ForEach-Object { [void]$combobox_OU.Items.Add($_.DistinguishedName) }
		$combobox_OU.SelectedIndex = 0
	}
	Loading_Config_First_Form
}

function Countries {
	$combobox_Country.Items.Clear()
	$combobox_Country.Items.Add('-- Please select one --')
	$Country_Name.Keys | sort-object | ForEach-Object { [void]$combobox_Country.Items.Add($_) }
	$combobox_Country.SelectedIndex = 0
}
function RandomPassword {
	param (
		[Parameter(Mandatory)][ValidateRange(4, [int]::MaxValue)][int]$length,
		[int]$upper = 1,
		[int]$lower = 1,
		[int]$numeric = 1,
		[int]$special = 1
	)
	if ($upper + $lower + $numeric + $special -gt $length) {
		throw "number of upper/lower/numeric/special char must be lower or equal to length"
	}
	$uCharSet = "ABCDEFGHJKMNPQRSTUWXYZ"
	$lCharSet = "abcdfhjkmnrstuwxyz"
	$nCharSet = "23456789"
	$sCharSet = "/*-+!?=@_"
	$charSet = ""
	if ($upper -gt 0) { $charSet += $uCharSet }
	if ($lower -gt 0) { $charSet += $lCharSet }
	if ($numeric -gt 0) { $charSet += $nCharSet }
	if ($special -gt 0) { $charSet += $sCharSet }
	$charSet = $charSet.ToCharArray()
	$rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
	$bytes = New-Object byte[]($length)
	$rng.GetBytes($bytes)
	$result = New-Object char[]($length)
	for ($i = 0; $i -lt $length; $i++) {
		$result[$i] = $charSet[$bytes[$i] % $charSet.Length]
	}
	$password = (-join $result)
	$valid = $true
	if ($upper -gt ($password.ToCharArray() | Where-Object { $_ - cin $uCharSet.ToCharArray() }).Count) { $valid = $false }
	if ($lower -gt ($password.ToCharArray() | Where-Object { $_ - cin $lCharSet.ToCharArray() }).Count) { $valid = $false }
	if ($numeric -gt ($password.ToCharArray() | Where-Object { $_ - cin $nCharSet.ToCharArray() }).Count) { $valid = $false }
	if ($special -gt ($password.ToCharArray() | Where-Object { $_ - cin $sCharSet.ToCharArray() }).Count) { $valid = $false }
	if (!$valid) {
		$password = RandomPassword $length $upper $lower $numeric $special
	}
	return $password
}
function Pass {
	$maskedtextbox_Password.text = RandomPassword $plength
}
function O365_GUI {
	$Global:Avaialble = Get-MsolAccountSku | Where-Object { $_.ActiveUnits -ne $_.ConsumedUnits }
	$LicenseArray = @()
	foreach ($item in $Avaialble) {
		$RemoveDomain = ($item).AccountSkuId
		$LicenseItem = $RemoveDomain -split ":" | Select-Object -Last 1
		$AddDomain = $RemoveDomain -split ":" | Select-Object -First 1
		$Global:FullDomain = $AddDomain + ":"
		$TextLic = $Sku.Item("$LicenseItem")
		If (!($TextLic)) {
			$LicenseArray += $LicenseItem
		} Else {
			$LicenseArray += $TextLic
		}
	}
	$checkedlistbox_licenses.Items.AddRange($LicenseArray)
}
function AD_Groups_Function {
	[string[]]$AD_Groups_Array = Get-Content -Path $Global:AD_Config_File
	$checkedlistbox_ADgroups.Items.AddRange($AD_Groups_Array)
}
function Check_Domain {
	if ($combobox_domain.SelectedItem -eq "-- Please select one --") {
		$label_Domain.Forecolor = "red"
	} else {
		$label_Domain.Forecolor = "white"
	}
}
function Check_OU {
	if ($combobox_OU.SelectedItem -eq "-- Please select one --") {
		$labelOULocation.Forecolor = "red"
	} else {
		$labelOULocation.Forecolor = "white"
	}
}
function Check_Country {
	if ($combobox_Country.SelectedItem -eq "-- Please select one --") {
		$labelCountry.Forecolor = "red"
	} else {
		$labelCountry.Forecolor = "white"
	}
}
function Check_Initials {
	$Check_Initials = $textbox_Initials.Text
	try {
		$Check_Initials_AD = Get-ADUser $Check_Initials
		$AD_Check = "User Exists"
	} catch {
		$AD_Check = "No User with these intials"
	}
	if ($AD_Check -eq "No User with these intials") {
		$labelInitials.Forecolor = "white"
	} else {
		$labelInitials.Forecolor = "red"
	}
	
	
	
}
function Create_User {
	$progressbar1.Visible = $True
	$initials1 = $textbox_Initials.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
	$FirstName1 = $textbox_First_Name.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
	$LastName1 = $textbox_Last_Name.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
	$FullName1 = $FirstName1 + ' ' + $LastName1
	$CheckFN = Get-ADUser -filter { DisplayName -eq $FullName1 } -Properties displayName
	$progressbar1.Value = 5
	$Global:Copy_From = $textbox_Copy_From.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
	if ($null -eq $CheckFN) {
		$Check_Initials = Get-ADUser $initials1 -ErrorAction SilentlyContinue
		if ($null -eq $Check_Initials) {
			$progressbar1.Value = 10
			Clear-Host
			$domain1 = '@' + $combobox_domain.SelectedItem
			$UPN1 = $initials1 + $domain1
			$progressbar1.Value = 15
			$Description1 = $textbox_Description.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Telephone1 = $textbox_Telephone.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Web_page1 = $textbox_Web_Page.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Country_Region1 = $Country_Name.get_item($combobox_Country.SelectedItem)
			$Country_c = $Country_Region1.Substring(0, 2)
			$Country_CountryCode = $Country_Region1.Substring(3, 3)
			$Country_co = $combobox_Country.SelectedItem
			$Address_street1 = $textbox_Address_street.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$City1 = $textbox_City.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$State_Province1 = $textbox_State_Province.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$ZIP_Postal_Code1 = $textbox_ZIP_Postal_Code.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Profile_path1 = $textbox_Profile_Path.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Logon_script1 = $textbox_Logon_Script.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Local_path1 = $textbox_Local_Path.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Home1 = $textbox_Home.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Mobile1 = $textbox_Mobile.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Fax1 = $textbox_Fax.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Job_Title1 = $textbox_Job_Title.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Department1 = $textbox_Department.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Company1 = $textbox_Company.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$Manager1 = $textbox_Manager_initials.Text -replace '(^\s+|\s+$)', '' -replace '\s+', ' '
			$pass = $maskedtextbox_Password.Text
			$secstr = $pass | ConvertTo-SecureString -AsPlainText -Force
			if ($ConfigKey.Custom_OU -eq "True") {
				$compare = Import-Csv $OU_Config_File | Select-Object OU, Name
				foreach ($OUs in $compare) {
					if ($combobox_OU.SelectedItem -eq $OUs.Name) {
						$Path = $OUs.OU
					}
					
				}
			} else {
				$Path = $combobox_OU.SelectedItem
			}
			New-ADUser -GivenName $FirstName1 -Surname $LastName1 -DisplayName $Fullname1 -Name $Fullname1 -AccountPassword $secstr -SamAccountName $initials1 -UserPrincipalName $UPN1 -Enabled $True -EmailAddress $UPN1 -path $Path
			if ($Description1 -ne "") {
				Set-ADUser $initials1 -Replace @{ Description = $Description1 }
			}
			if ($Telephone1 -ne "") {
				Set-ADUser $initials1 -OfficePhone $Telephone1
			}
			if ($Web_page1 -ne "") {
				Set-ADUser $initials1 -HomePage $Web_page1
			}
			if ($Address_street1 -ne "") {
				Set-ADUser $initials1 -StreetAddress $Address_street1
			}
			if ($City1 -ne "") {
				Set-ADUser $initials1 -City $City1
			}
			if ($State_Province1 -ne "") {
				Set-ADUser $initials1 -State $State_Province1
			}
			if ($ZIP_Postal_Code1 -ne "") {
				Set-ADUser $initials1 -PostalCode $ZIP_Postal_Code1
			}
			if ($Profile_path1 -ne "") {
				Set-ADUser $initials1 -Profilepath $Profile_path1
			}
			if ($Logon_script1 -ne "") {
				Set-ADUser $initials1 -ScriptPath $Logon_script1
			}
			if ($Home1 -ne "") {
				Set-ADUser $initials1 -HomePhone $Home1
			}
			if ($Mobile1 -ne "") {
				Set-ADUser $initials1 -MobilePhone $Mobile1
			}
			if ($Fax1 -ne "") {
				Set-ADUser $initials1 -Fax $Fax1
			}
			if ($Job_Title1 -ne "") {
				Set-ADUser $initials1 -Title $Job_Title1
			}
			if ($Department1 -ne "") {
				Set-ADUser $initials1 -Department $Department1
			}
			if ($Company1 -ne "") {
				Set-ADUser $initials1 -Company $Company1
			}
			if ($Manager1 -ne "") {
				set-aduser $initials1 -Manager $Manager1
				
				set-aduser $initials1 -Replace @{ co = $Country_co; c = $Country_c; CountryCode = $Country_CountryCode }
			}
			if ($Local_path1 -ne "") {
				Set-ADUser -Identity $initials1 -HomeDirectory $Local_path1
			}
			if ($ConfigKey.checkboxOffice365 -eq "True" -or $ConfigKey.checkboxExchangeHybridO365 -eq "True") {
				Get-ADUser -Identity $initials1 | set-aduser -replace @{ mailNickname = $initials1 }
			}
			if ($ConfigKey.checkboxCheckThisBoxIfADGrou -eq "True") {
				foreach ($Group in $checkedlistbox_ADgroups.CheckedItems) {
					Add-ADGroupMember -identity $Group -members $initials1
				}
			}
			$progressbar1.Value = 20
			if ($null -ne $Cp) {
				$Copy_Groups = Get-ADUser -Identity $Global:Copy_From -Properties memberof
				$Copy_Groups_To = Get-ADUser -Identity $initials1 -Properties MemberOf
				$Copy_Groups.MemberOf | Where-Object{ $Copy_Groups_To.MemberOf -notcontains $_ } | Add-ADGroupMember -Members $Copy_Groups_To
			}
			$counter = 0
			while ($counter -lt 1) {
				$ErrorActionPreference = "SilentlyContinue"
				$getaduser = Get-Aduser $initials1
				if ($null -ne $getaduser) {
					if ($ConfigKey.checkboxOffice365 -eq "True" -or $ConfigKey.checkboxExchangeHybridO365 -eq "True") {
						if ($ConfigKey.checkboxExchangeHybridO365 -eq "True") {
							$msoldomain = Get-MsolDomain | Where-Object IsInitial -eq $true
							Invoke-command -session $Global:PSSExch -scriptblock { enable-RemoteMailbox $args[0] -RemoteRoutingAddress $args[1] } -ArgumentList "$initials1", "$initials1@$msoldomain.Name" -ErrorAction SilentlyContinue | Out-Null
							$ProgressBar.Value = 25
							Start-Sleep 15
							$Remote = Invoke-command -session $Global:PSSExch -scriptblock { get-remotemailbox -identity $args[0] } -ArgumentList "$initials1"
						}
						#Invoke-Command -computername "Pc man kan invoke command til server fra" -scriptblock {Invoke-Command -computername "ADFS server" -scriptblock {start-adsyncsynccycle}}
						Invoke-Command -computername $ConfigKey.ADFS_Server -scriptblock { start-adsyncsynccycle }
						Start-Sleep 5
						$progressbar1.Value = 30
						Start-Sleep 5
						$progressbar1.Value = 35
						Start-Sleep 5
						$progressbar1.Value = 40
						Start-Sleep 10
						$progressbar1.Value = 45
						Start-Sleep 5
						$progressbar1.Value = 50
						Start-Sleep 5
						$progressbar1.Value = 55
						Start-Sleep 10
						$progressbar1.Value = 60
						Start-Sleep 5
						$progressbar1.Value = 65
						Start-Sleep 5
						$progressbar1.Value = 70
						Start-Sleep 5
					}
					if ($ConfigKey.checkboxExchange -eq "True") {
						Import-PSSession $PSSExch
						Enable-Mailbox -Identity $initials1
						$progressbar1.Value = 50
						Start-Sleep 15
					}
				}
				$counter++
				$ErrorActionPreference = "Continue"
			}
			if ($ConfigKey.Listbox -match "O365 Licenses") {
				$getuser365 = get-MsolUser -UserPrincipalName "$UPN1" -ErrorAction SilentlyContinue
				if ($null -ne $getuser365) {
					$progressbar1.Value = 85
					Set-MsolUser -UserPrincipalName "$UPN1" -UsageLocation "$Country_c"
					Start-Sleep 10
					foreach ($lic in $checkedlistbox_licenses.CheckedItems) {
						$hashvalue = $Sku.keys | Where-Object { $Sku["$_"] -eq $lic }
						foreach ($hash in $hashvalue) {
							$key = $FullDomain + $hash
							foreach ($s in $Avaialble.AccountSkuId) {
								if ($key -eq $s) {
									Set-MsolUserLicense -UserPrincipalName "$UPN1" -AddLicenses "$key"
									$progressbar1.Value = 90
								}
							}
						}
					}
				}
			}
			function Calendar {
				$progressbar1.Value = 95
				if ($ConfigKey.checkboxOffice365 -eq "True" -or $ConfigKey.checkboxExchangeHybridO365 -eq "True") {
					$calendarFolder = Get-EXOMailboxFolderStatistics -Identity $UPN1 -FolderScope Calendar | Where-Object { $_.FolderType -eq 'Calendar' } | Select-Object Name, FolderId
				}
				if ($ConfigKey.checkboxExchange -eq "True") {
					$calendarFolder = Get-MailboxFolderStatistics -Identity $UPN1 -FolderScope Calendar | Where-Object { $_.FolderType -eq 'Calendar' } | Select-Object Name, FolderId
				}
				$calendar = $UPN1 + ':\' + $calendarFolder.name
				$calendar
				#Add-MailboxFolderPermission -identity $calendar -user "User that needs access"  -Accessrights "Wished accessrights"
				$Cal_Access = $ConfigKey.cal_perm
				Set-MailboxFolderPermission -Identity $calendar -User Default -AccessRights $Cal_Access
			}
			if ($ConfigKey.checkboxCheckThisBoxIfYouWou -eq "True") {
				$mailboxcounter = 0
				while ($mailboxcounter -lt 1) {
					$getmail = Get-Mailbox -identity "$UPN1" -ErrorAction SilentlyContinue
					if ($null -ne $getmail) {
						Start-Sleep 10
						Calendar
						$mailboxcounter++
					} else {
						Start-Sleep 30
					}
				}
			}
		}
	}
	$Check_AD_User_Created = Get-ADUser $initials1 -ErrorAction SilentlyContinue
	if ($null -ne $Check_AD_User_Created) {
		$Check_For_Mail_O365 = get-mailbox -identity $UPN1
		if ($null -ne $Check_For_Mail_O365) {
			$labelSUCCESSTHEUSERHASNOW.Visible = $true
		} else {
			$labelSUCCESSTHEUSERHASNOW.text = "Warning: The user email was not found/created please check the mail solution and see if the mail is created. If it is a hybrid environment please make sure the user has access to remote powershell to the exchange server"
			$labelSUCCESSTHEUSERHASNOW.Forecolor = "yellow"
			$labelSUCCESSTHEUSERHASNOW.Visible = $true
		}
	} else {
		$labelSUCCESSTHEUSERHASNOW.text = "Error: The AD User was not found, please check that the AD User has been created"
		$labelSUCCESSTHEUSERHASNOW.Forecolor = "red"
		$labelSUCCESSTHEUSERHASNOW.Visible = $true
	}
	$progressbar1.Value = 100
}