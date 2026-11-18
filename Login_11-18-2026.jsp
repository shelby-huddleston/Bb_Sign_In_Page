<%-- Customizations updated 2023 Nov 17
    Tested with release ver 3900.80
	shelby.huddleston@cowley.edu and jeff.kelley@anthology.com
	
	Updated 11/25/2026
	comment outted lines 608-614 for removing Direct login
	add back in if SSO breaks
	added 615 - 619 per Jeff.  
	
	Updated 11/18/2026
	Added new backgound image
	Adjusted the boxes
	Mobile Friendly View
	WCAG 2.2 AA compliant
 --%>

<%@ include file="/webapis/ui/doctype.jspf" %>
<%@ page import="blackboard.servlet.util.CourseCatalogUtil" %>
<%@ taglib uri="/bbNG" prefix="bbNG" %>
<%@ taglib uri="/loginUI" prefix="loginUI" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="productName" value="${ loginUI:getProductName() }" />

<fmt:message var="viewCourseCatalogLinkText" key="gatewayButtons.view.course.catalog" bundle="${bundles.tags}"/>

<bbNG:genericPage authentication="N" wrapper="false" onLoad="loadLoginPage()" bodyClass="bb-login hide-focus-outline" globalNavigation="false" skipCoreCss="true">
  <bbNG:cssFile href="/ui-ultra/css/ultra.css" />
  <bbNG:jsFile href="/ui-ultra/js/hide-focus-outline.js" />
  <bbNG:jsFile href="/ui-ultra/js/login-page.js" />

  <bbNG:jsBlock>
    <script type="text/javascript">
      function loadLoginPage() {      
        if(document.forms.login.user_id != undefined)
        {
          verify_username_password(document.forms.login);
        }
        setTimeout("triggerScreenreaderAlert()", 500);
      }

      function triggerScreenreaderAlert() {
        if (document.getElementById('loginErrorMessage')) {
          $('loginErrorMessage').update($('loginErrorMessage').innerHTML);
        }
      }
    </script>

    <script type="text/javascript">
      //This custom script grabs the dynamic links from the 3rd party drop down
      //and then inserts them as button styled links in a div with id = 3rdPartyLinks
      //links with text that start with a colon : are not displayed.
      var providerList = document.querySelectorAll("ul#loginRedirectProviderList li");
      destContainer = document.getElementById("3rdPartyLinks");
      for (p in providerList) {
		  if (providerList[p].firstElementChild.innerText.charAt(0) != ':') {
		      var newElement = document.createElement('a');
			  newElement.id = 'providerLink' + [p];
		      newElement.className = "button expand inverse outline provlink";
		      newElement.href = providerList[p].firstElementChild.href;
		      newElement.innerText = providerList[p].firstElementChild.innerText;
              // Cowley v12: apply the accessible SSO label styling directly
              // to the generated link, avoiding Blackboard theme overrides.
              newElement.style.setProperty('color', '#171717', 'important');
              newElement.style.setProperty('font-weight', '700', 'important');
              newElement.style.setProperty('font-size', '18px', 'important');
              newElement.style.setProperty('background-color', '#f57622', 'important');
		      destContainer.appendChild(newElement);
		  }
	}
    </script>
	
	<script type='text/javascript'>
  //This custom script creates a toggle function to show/hide the login form div.
  function buttonToggle(where, pval, nval) {
    var table = document.getElementById(where.attributes.rel.value);
    where.value = (where.value == pval) ? nval : pval;
    table.style.display = (table.style.display == 'block') ? 'none' : 'block';
  }
</script>
    <script type="text/javascript">
      // Cowley v13: correct HTML language tags in Blackboard's locale links.
      // Keep loadLocale('en_US') and other Blackboard locale IDs unchanged.
      document.addEventListener('DOMContentLoaded', function () {
        var localeLinks = document.querySelectorAll('#lang-list [lang]');
        for (var i = 0; i < localeLinks.length; i++) {
          var language = localeLinks[i].getAttribute('lang');
          if (language && language.indexOf('_') !== -1) {
            localeLinks[i].setAttribute('lang', language.replace(/_/g, '-'));
          }
        }
      });
    </script>
  </bbNG:jsBlock>

  <bbNG:cssBlock>
<style type="text/css">

/* Mods for SSO workflow */

	/*Hide the redirect providers.*/
	#loginRedirectProviders {
		display:none;
	}

	/*Hide the login form fields*/
	#loginFormFields {
		display:none;
	}
	
	/*Provider link button style*/
	.provlink {
		zoom: 1.5; /* Avoid also scaling in Firefox: recent Firefox supports zoom. */
		background-color:#f57622!important;
	}


/* General design mods start here */

html {
    height: 100%;
}
video {
    position: fixed;
    top: 50%;
    left: 50%;
    min-width: 100%;
    min-height: 100%;
    width: auto;
    height: auto;
    transform: translatex(-50%) translatey(-50%);
}
.row {
    width: 100%;
    max-width: 100%;
}
.small-12.small-centered.text-center.columns.footerblock {
    width: 100%;
    max-width: 100%;
}
#loginHeader {
    position: absolute;
    right: 0;
    top: 0;
    background-color: #f57622;
    width: 100%;
}
body#learn-oe-body {
    position: relative;
    min-height: 100%;
    background: url(https://cowley.blackboard.com/bbcswebdav/xid-22395196_1) no-repeat center center fixed;
    background-size: cover;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    height: auto;
}
.login-form-footer.row.collapse a {
    text-decoration: underline;
}
div#ultraCourseCatalogLink a {
    text-decoration: none !important;
}
div.loginBody {
    background-position: center 25%;
    width:90%;
}
input#entry-login {
    width: 100%;
    min-width: 100% !important;
    max-width: 100%;
    display: block;
}
ul#loginFormList {
    width:100%;
    background-color: transparent;
    padding: 0;
    margin: 0;
}
input#entry-login {
    background-color: #f57622;
    border: 0;
    border-radius: 5px;
    color: white;
    padding: 1em 0;
}
.forgot a {
    border-bottom: 1px solid #f57622;
    color: #c76dd5;
    margin-bottom: 10px;
}
#loginOptions ul li a, #loginOptions ul li.subOption a {
    color: white !important;
}
.login-page #copyright .newCopyright {
     width: 100%;
    padding: 1em;
    background: #E8E3DB;
    bottom: -20px;
    border-bottom: 10px solid #f57622;
}
.login-page #copyright{
    width:100%;
}
.additionalInfo p:first-child a {
    border-bottom: 1px solid;
    padding-right: 0;
}
#loginBox input[type="text"], #loginBox input[type="password"], #loginRedirectProviders button {
    -moz-border-radius: 5px 5px 5px 5px;
    -webkit-border-radius: 5px 5px 5px 5px;
    border-radius: 5px 5px 5px 5px;
    background: white;
    padding: 6px;
    border: 0px solid #777;
    color: #666;
    margin: 0;
    box-sizing: border-box;
}
#loginBox li label, .portlet #loginBoxFull li label {
    color: white;
    display: block;
    font-size: 120%;
    letter-spacing: 1px;
    padding: 0 0 3px;
    text-align: left;
    text-transform: uppercase;
    width: 100%;
    font-weight: 200;
    margin-bottom: 0.5em;
    margin-top: 0.8em;
}
#loginPageContainer{
  width:100%;
  position:absolute;

}
a, .portlet .subCategories li a, .blockGroups .itemHead, .blockGroups .itemHeadOpen {
    color: #f57622;
}

.bbResources, .systemAnnouncementsLogin, div#login-form {
    width: 31%;
}
.systemAnnouncementsLogin {
    margin: 0 2% 4% 2%;
}
.bb-login #gatewayButtons .inline-list {
    float: right;
    display: inline-block;
}
.bbResources, .systemAnnouncementsLogin, div#login-form {
    background-color: rgba(0, 0, 0, .8);
    display: inline-block;
    vertical-align: top;
    padding: 2%;
    min-height: 465px;
}
div#login-form h1 {
}
#loginBox form li+li+li {
  margin-top:2em;
    width: 100%;
}
.systemAnnouncementsLogin h1, .systemAnnouncementsLogin p {
    color: white;
    text-align: center;
    margin-top: 0;
    margin-bottom: 15px;
}
div#login-form h1 {
    margin-top: 0;
    color: white;
    text-align: center;
}
.blockBTNlogin p {
    color: white;
    text-align: center;
    margin-bottom: 5px;
    font-size: 12.4px;
}
.loginBTN {
    text-align: center;
    padding: 0.5em 1em;
    border-radius: 5px;
    background-color: #f57622;
}
.loginBTN a {
    color: white;
}
.blockBTNlogin {
    padding: 0.8em 0;
    border-top: 1px solid white;
}
img.btnblocks {
    margin-right: 2em;
}
div#loginBox img {
    width: 100%;
}
div.loginBody {
    padding:190px 0 0;
    background: none;
}
p.hashtag {
    font-size: 30px;
    color: #985ca5;
    font-weight: bold;
}
.systemAnnouncementsLogin ul li {
    color: white;
    text-align: center;
    margin-bottom: 0px;
    font-size:13px;
}
.systemAnnouncementsLogin ul li b {
    font-size: 20px;
    margin: 0px 5px;
}

.bb-login .new-logo.customized-logo img {
    width: 100%;
    height: auto;
    border-radius: 0;
}
.bb-login .new-logo{
    margin-top:0;
}
.bb-login #login-block {
    padding:0;
    margin-top: 7%;
    min-width: 15rem;
    max-width: 90%;
    margin-bottom: 0;
}
.systemAnnouncementsLogin h1, .bbResources h1 {
    font-family: "Open Sans",sans-serif;
    font-size: 22px;
    font-weight: bold;
}
.systemAnnouncementsLogin ul {
    list-style: none;
    margin-left: 0;
    margin-bottom: 0;
  margin-left: 0;
}
.systemAnnouncementsLogin p {
    font-size: 13px;
}
.bbResources h1 {
    color: white;
}
.bb-login .login-form .button {
    background-color: transparent;
    box-shadow: 0 0 0 0px #fff inset;
    margin-top: 1.8rem;
    margin-bottom: .3125rem;
}
.footerblock {
    width: 100%;
    padding: 1em !important;
    background: rgba(0, 0, 0, .8);
    border-bottom: 0px solid #f57622;
    margin-top: 6em;
    bottom: 0;
}
.legal {
    color: white;
}
div#gatewayButtons ul {
    margin-bottom: 0;
}
i#help-link a {
    color: #f57622;
}
.bb-login #copyright {
    font-size: .75rem;
    color: black;
    margin-top: 0;
}
div#login-form h1.login-logo.new-logo.customized-logo, .systemAnnouncementsLogin h1.welcome {
    display: none;
}
h1.welcome {
    font-family: "Open Sans",sans-serif;
    font-size: 22px;
    font-weight: bold;
    color: white;
}
.systemAnnouncementsLogin img {
    width: 100%;
    max-width: 400px;
    margin-bottom: 1em;
}
.systemAnnouncementsLogin h1.login-logo.new-logo.customized-logo {
    margin-bottom: 0;
}
.trial-registration {
    margin-top: 0.5em;
}
img.monumentLogo {
    width: 50%;
    max-width: 160px;
}
#login-form img.monumentLogo{
  display:none;
}
a.appimg img {
    width: 28%;
    margin: 0 2% !important;
}
input#user_id {
    margin-bottom: 0;
}
div#ultraCourseCatalogLink a {
    color: white !important;
    background-color: transparent;
    width: 100%;
    display: block;
    padding: 1em;
    border: 1px solid;
}
div#ultraCourseCatalogLink {
    margin-top: 15px !important;
}
.small-12.small-centered.text-center.columns {
    padding: 0;
}
.login-form-footer.row.collapse .small-6 {
    width: 100%;
    text-align: center !important;
}
.round-border {
      border: 1px solid #eee;
      border: 1px solid rgba(0, 0, 0, 0.05);
      -webkit-border-radius: 4px;
      -moz-border-radius: 4px;
      border-radius: 4px;
      padding: 10px;
      margin-bottom: 5px;
    }
div#collapse1{
    margin-top:-11px;
    margin-left: -11px;
    background-color:white;
    z-index: 9999999;
    position: absolute;
    width: 100%;
}
.buttoncolapsed{
position: absolute;
    z-index: 9999999999;
    margin: 20px 35%;
    left: 0;
    right: 0;
    width: 30%;
}
button.nav-toggle {
    background-color: #f57622;
    width: 100%;
    color: white;
    border-radius: 5px;
    box-shadow: inset 0 0 0 0 #333;
    font-size: 22px;
}
.accessblock{
  margin: 0 0 4% 2% !important;
}
div#copyright, #loginOptions {
    width: 50%;
    vertical-align: top;
    display: inline-block;
}
div#copyright {
    text-align: left;
}
.bb-login #gatewayButtons{
    margin-bottom: 0 !important;
}
.login-form-footer {
    margin-top: 2.5em !important;
}
.bb-login .login-form #loginRedirectProviders .button.dropdown {
    background-color: transparent;
    box-shadow: none;
    color: #fff;
    font-family: "Open Sans";
    font-size: .8rem;
    margin-bottom: .375rem;
    margin-top: 1.8em;
    padding: 0.8em 1.5em;
    text-align: left;
    border: 1px solid white;
    border-radius: 0;
}
.bb-login .login-form #loginRedirectProviderList {
    background-color: #f57622;
    position: relative;
}
.login-form-footer {
    margin-top: 1em !important;
}
.bb-login .login-form-footer{
  padding-top:0;
}
div#pagefooter {
    position: absolute;
    bottom: 0;
}
/* Cowley: compact desktop login panel, with room for logo, SSO link, and help text.
   Preserve the original form and SSO markup. Use natural height on narrow screens. */
@media (min-width: 801px) {
  div#login-form {
    min-height: 270px !important;
    height: auto !important; /* Let Firefox size the panel to its content. */
    box-sizing: border-box;
  }
}

/*-----------Announcements-----------*/
div#loginAnnouncements ul li {
    border-bottom: 1px solid #cdcdcd;
    background-color:transparent !important;
    width: 100%;
    display: inline-block !important;
    padding: 1em !important;
    margin: 1%;
}

div#loginAnnouncements ul li:first-child {
    margin-left: 0;
}
div#loginAnnouncements ul li:nth-child(3n) {
    margin-right: 0;
}
div#loginAnnouncements {
      background: rgba(0,0,0,0.8);
    width: 100%;
    max-width: 88% !important;
    padding: 0 2em;
}
.bb-login .login-page-announcements{
      margin-bottom: 6em;
}

@media (max-width: 800px){
  /*-----------Announcements-----------*/
div#loginAnnouncements ul li {
    width: 100%;
    display: inline-block !important;
    padding: 1em !important;
    margin: 0%;
}

div#loginAnnouncements ul li:first-child {
    margin-left: 0;
}
div#loginAnnouncements ul li:nth-child(3n) {
    margin-right: 0;
}
div#loginAnnouncements {
    width: 100%;
    max-width: 90% !important;
    padding: 0 2em;
}

.systemAnnouncementsLogin .Coursecataloguespace {
    display: block;
}
.bbResources, .systemAnnouncementsLogin, div#login-form{
    width:100%;
    padding: 10%;
    min-height:auto !important;
    margin-top:2em;
}

.bb-login .new-logo.customized-logo img {
    max-width: 400px;
}
div#login-form h1.welcome, .systemAnnouncementsLogin img {
    display:none;
  }
div#login-form h1.login-logo.new-logo.customized-logo, .systemAnnouncementsLogin h1.welcome {
    display: block;
}
.systemAnnouncementsLogin{
  margin: 2em 0;
}
#login-form img.monumentLogo {
    display: block;
    margin: 0 auto;
    width: 30%;
}
}

@media (max-width: 420px){

  #login-form img.monumentLogo{
  display:block;
  margin:0 auto;
}
.bbResources, .systemAnnouncementsLogin{
    width:100%;
    padding: 10%;
}
div#loginBox {
    width: 81%;
}
.systemAnnouncementsLogin {
    margin: 20px 0;
}
video {
    position: fixed;
    top: 79%
}
.systemAnnouncementsLogin {
    margin: 2em 0;
}
}
/* Cowley mobile refinements: CSS only. Preserve desktop layout and SSO. */
@media screen and (max-width: 800px) {
  html, body#learn-oe-body {
    height: auto !important;
    min-height: 100% !important;
    overflow-x: hidden;
  }
  body#learn-oe-body {
    background-attachment: scroll !important;
    background-position: center top !important;
  }
  #loginPageContainer {
    position: relative !important;
    width: 100%;
  }
  div.loginBody {
    padding: 12px 0 0 !important;
    width: 100% !important;
  }
  .bb-login #login-block {
    width: 100% !important;
    max-width: 100% !important;
    min-width: 0 !important;
    padding: 0 12px !important;
    margin: 12px auto 0 !important;
    box-sizing: border-box;
  }
  .bbResources, .systemAnnouncementsLogin, div#login-form {
    box-sizing: border-box;
    min-height: 0 !important;
    height: auto !important;
  }
  div#login-form {
    width: 100% !important;
    max-width: 520px !important;
    margin: 0 auto !important;
    padding: 20px 18px 18px !important;
    display: block !important;
  }
  div#login-form > img {
    display: block;
    width: 100% !important;
    max-width: 340px !important;
    height: auto !important;
    margin: 0 auto 14px !important;
  }
  div#login-form #3rdPartyLinks {
    width: 100%;
  }
  div#login-form .provlink,
  div#login-form #3rdPartyLinks a {
    zoom: 1 !important;
    transform: none !important;
    -moz-transform: none !important;
    display: block;
    box-sizing: border-box;
    width: 100% !important;
    max-width: 100% !important;
    font-size: 18px !important;
    line-height: 1.3 !important;
    padding: 13px 10px !important;
    margin: 0 0 10px !important;
  }
  div#login-form p {
    font-size: 14px !important;
    line-height: 1.5 !important;
    overflow-wrap: anywhere;
    margin: 0 !important;
    text-align: center;
  }
  .bb-login .login-page-announcements {
    width: 100% !important;
    margin: 18px 0 24px !important;
    padding: 0 12px !important;
    box-sizing: border-box;
  }
  div#loginAnnouncements {
    box-sizing: border-box;
    width: 100% !important;
    max-width: 520px !important;
    padding: 12px 14px !important;
    margin: 0 auto !important;
    height: auto !important;
    overflow: visible !important;
  }
  div#loginAnnouncements ul li {
    box-sizing: border-box;
    width: 100% !important;
    padding: 8px 0 !important;
    margin: 0 !important;
    overflow-wrap: anywhere;
    word-break: normal;
  }
  div#loginAnnouncements p,
  div#loginAnnouncements li,
  div#loginAnnouncements a {
    overflow-wrap: anywhere;
  }
  div#pagefooter {
    position: relative !important;
    bottom: auto !important;
  }
}
/* Cowley v7: Compact phone landscape. Keep touch targets accessible.
   Portrait and conventional desktop viewports do not match this query.
   Preserve vertical scrolling for announcements and large text. */
@media screen and (orientation: landscape) and (min-width: 650px) and (max-width: 1200px) and (max-height: 650px) {
  html, body#learn-oe-body {
    height: auto !important;
    min-height: 100% !important;
    overflow-x: hidden !important;
  }
  body#learn-oe-body { background-attachment: scroll !important; }
  #loginPageContainer { position: relative !important; width: 100% !important; }
  div.loginBody { width: 100% !important; padding: 4px 0 0 !important; }
  .bb-login #login-block {
    float: none !important;
    width: 100% !important;
    max-width: 100% !important;
    min-width: 0 !important;
    margin: 4px auto 0 !important;
    padding: 0 10px !important;
    box-sizing: border-box !important;
  }
  .bb-login div#login-form {
    float: none !important;
    display: block !important;
    box-sizing: border-box !important;
    width: 100% !important;
    max-width: 340px !important;
    min-height: 0 !important;
    height: auto !important;
    margin: 0 auto !important;
    padding: 8px 12px 9px !important;
  }
  .bb-login div#login-form > img {
    display: block !important;
    width: auto !important;
    max-width: min(148px, 100%) !important;
    height: auto !important;
    margin: 0 auto 5px !important;
  }
  .bb-login div#login-form #3rdPartyLinks { width: 100% !important; }
  .bb-login div#login-form .provlink,
  .bb-login div#login-form #3rdPartyLinks a {
    display: block !important;
    box-sizing: border-box !important;
    width: 100% !important;
    max-width: 100% !important;
    min-height: 44px !important;
    zoom: 1 !important;
    transform: none !important;
    -moz-transform: none !important;
    font-size: 14px !important;
    line-height: 1.3 !important;
    padding: 9px 12px !important;
    margin: 0 0 5px !important;
  }
  .bb-login div#login-form p {
    font-size: 13px !important;
    line-height: 1.4 !important;
    margin: 0 !important;
    text-align: center !important;
    overflow-wrap: anywhere;
  }
  .bb-login .login-page-announcements {
    float: none !important;
    clear: both !important;
    box-sizing: border-box !important;
    width: 100% !important;
    padding: 0 10px !important;
    margin: 8px 0 16px !important;
  }
  .bb-login div#loginAnnouncements {
    box-sizing: border-box !important;
    width: 100% !important;
    max-width: 440px !important;
    height: auto !important;
    overflow: visible !important;
    margin: 0 auto !important;
    padding: 8px 12px !important;
  }
  .bb-login div#loginAnnouncements ul li {
    display: block !important;
    box-sizing: border-box !important;
    width: 100% !important;
    margin: 0 !important;
    padding: 7px 0 !important;
    overflow-wrap: anywhere;
  }
  div#pagefooter { position: relative !important; bottom: auto !important; }
}
/* Cowley v7: modestly compact portrait phones only. Keep readable text and
   44px minimum SSO touch target; don't affect tablet/desktop or landscape. */
@media screen and (orientation: portrait) and (max-width: 600px) {
  .bb-login #login-block {
    margin-top: 6px !important;
    padding: 0 12px !important;
  }
  .bb-login div#login-form {
    max-width: 420px !important;
    padding: 14px 16px 14px !important;
  }
  .bb-login div#login-form > img {
    max-width: 270px !important;
    margin-bottom: 9px !important;
  }
  .bb-login div#login-form .provlink,
  .bb-login div#login-form #3rdPartyLinks a {
    min-height: 44px !important;
    font-size: 16px !important;
    line-height: 1.3 !important;
    padding: 11px 10px !important;
    margin-bottom: 7px !important;
  }
  .bb-login div#login-form p {
    font-size: 14px !important;
    line-height: 1.45 !important;
  }
  .bb-login .login-page-announcements {
    margin-top: 12px !important;
    margin-bottom: 18px !important;
  }
  .bb-login div#loginAnnouncements {
    max-width: 420px !important;
    padding: 10px 12px !important;
  }
}

/* Cowley v8: narrow-screen overflow and compact portrait refinements.
   Scope deliberately excludes desktop (>= 801px) and leaves JSP/SSO intact. */
@media screen and (max-width: 800px) {
  html, body, body#learn-oe-body, #loginPageContainer,
  #bodyContent, .bb-login .login-page-announcements {
    max-width: 100% !important;
    box-sizing: border-box !important;
  }
  #bodyContent, .bb-login #login-block, .bb-login div.loginBody,
  .bb-login div#login-form, .bb-login div#loginAnnouncements {
    min-width: 0 !important;
    box-sizing: border-box !important;
  }
  .bb-login div#loginAnnouncements ul {
    box-sizing: border-box !important;
    max-width: 100% !important;
    padding-left: 1.25rem !important;
    margin-right: 0 !important;
  }
  .bb-login div#loginAnnouncements img,
  .bb-login div#login-form img { max-width: 100%; height: auto; }
}
@media screen and (orientation: portrait) and (max-width: 600px) {
  .bb-login #login-block {
    padding: 0 10px !important;
    margin-top: 4px !important;
  }
  .bb-login div#login-form {
    width: 100% !important;
    max-width: 380px !important;
    padding: 12px 14px !important;
  }
  .bb-login div#login-form > img {
    width: 100% !important;
    max-width: 235px !important;
    margin: 0 auto 8px !important;
  }
  .bb-login div#login-form .provlink,
  .bb-login div#login-form #3rdPartyLinks a {
    min-height: 44px !important;
    padding: 10px 12px !important;
    margin-bottom: 6px !important;
    font-size: 16px !important;
    zoom: 1 !important;
    transform: none !important;
  }
  .bb-login div#login-form p {
    margin: 0 !important;
    font-size: 14px !important;
    line-height: 1.4 !important;
  }
  .bb-login .login-page-announcements {
    margin: 10px 0 18px !important;
    padding: 0 10px !important;
  }
  .bb-login div#loginAnnouncements {
    width: 100% !important;
    max-width: 380px !important;
    padding: 10px 12px !important;
  }
  .bb-login div#loginAnnouncements ul li {
    padding: 6px 0 !important;
    margin: 0 !important;
  }
}


/* Cowley v9: final phone spacing pass. Mobile only; no SSO/JSP changes.
   Override legacy .login-form .button margin-top: 1.8rem that
   creates unnecessary space between the logo and SSO button. */
@media screen and (orientation: portrait) and (max-width: 600px) {
  .bb-login div#login-form {
    padding: 10px 14px 12px !important;
  }
  .bb-login div#login-form > img {
    margin-top: 0 !important;
    margin-bottom: 3px !important;
  }
  .bb-login div#login-form #3rdPartyLinks {
    margin-top: 0 !important;
    padding-top: 0 !important;
  }
  .bb-login div#login-form #3rdPartyLinks .button,
  .bb-login div#login-form #3rdPartyLinks .provlink {
    margin-top: 0 !important;
    margin-bottom: 5px !important;
    min-height: 44px !important;
  }
}
@media screen and (orientation: landscape) and (min-width: 650px) and (max-width: 1200px) and (max-height: 650px) {
  .bb-login div#login-form {
    max-width: 310px !important;
    padding: 7px 12px 8px !important;
  }
  .bb-login div#login-form > img {
    max-width: 140px !important;
    margin-top: 0 !important;
    margin-bottom: 3px !important;
  }
  .bb-login div#login-form #3rdPartyLinks {
    margin-top: 0 !important;
    padding-top: 0 !important;
  }
  .bb-login div#login-form #3rdPartyLinks .button,
  .bb-login div#login-form #3rdPartyLinks .provlink {
    margin-top: 0 !important;
    margin-bottom: 4px !important;
    min-height: 44px !important;
  }
}


/* Cowley v10: final conservative iPhone refinements.
   Keep the original SSO markup, announcements, and desktop presentation.
   The small negative offsets reduce visually empty space in the logo asset;
   they only affect mobile portrait or short-screen landscape. */
@media screen and (orientation: portrait) and (max-width: 600px) {
  .bb-login div#login-form #3rdPartyLinks {
    margin-top: -14px !important;
  }
}
@media screen and (orientation: landscape) and (min-width: 650px) and (max-width: 1200px) and (max-height: 650px) {
  .bb-login div#login-form #3rdPartyLinks {
    margin-top: -12px !important;
  }
  .bb-login div#login-form #3rdPartyLinks .button,
  .bb-login div#login-form #3rdPartyLinks .provlink {
    min-height: 44px !important;
    padding: 7px 10px !important;
    line-height: 1.25 !important;
  }
}


/* Cowley v12: CSS fallback for accessible SSO styling.
   Version 12 also styles the generated link directly in the existing script. */
/* Cowley v11: WCAG 2.2 AA SSO button contrast improvement.
   Preserve the existing branded orange background and SSO destination.
   Dark foreground is necessary: increasing font weight/size alone does not
   resolve the reported 2.63:1 contrast for normal text. */
.bb-login div#login-form #3rdPartyLinks a.provlink,
.bb-login div#login-form #3rdPartyLinks a.provlink:link,
.bb-login div#login-form #3rdPartyLinks a.provlink:visited,
.bb-login div#login-form #3rdPartyLinks a.provlink:hover,
.bb-login div#login-form #3rdPartyLinks a.provlink:focus,
.bb-login div#login-form #3rdPartyLinks a.provlink:active {
  background-color: #f57622 !important;
  color: #171717 !important;
  font-weight: 700 !important;
  font-size: 18px !important;
  text-decoration: none !important;
}
.bb-login div#login-form #3rdPartyLinks a.provlink:focus-visible {
  outline: 3px solid #ffffff !important;
  outline-offset: 3px !important;
}
@media screen and (max-width: 800px) {
  .bb-login div#login-form #3rdPartyLinks a.provlink {
    font-size: 18px !important;
    line-height: 1.35 !important;
  }
}

</style>
</bbNG:cssBlock>

  <%@ include file="/webapis/ui/cookie-disclosure-login.jspf"%>

 
  <div id="loginLang" class="clearfix">
    <loginUI:localePicker />
  </div>

  <div class="row" id="bodyContent">
  	<div id="login-block" class="accesibilitylogin small-11 small-centered medium-12 medium-centered text-center columns">
  		<loginUI:errorMessage />

  		<c:if test="${ ( param.isSuccessfulPasswordUpdate eq 'true' ) && ( param.action eq 'relogin' )  }">
  	      <%@ include file="/passwordSuccessConfirmationReceipt.jspf"%>
  		</c:if>



  		<div id="login-form" class="login-form loginBox" data-cowley-login-version="responsive-v13-wcag-language-20261117">
         <img src="https://cowley.blackboard.com/bbcswebdav/xid-13080612_1" alt="Cowley Online Logo">
		 
		<div id="3rdPartyLinks"></div>
	  
		  <!--  Remove the direct login option
		  <div id="toggle_login_form">
			 	
			<input type="button" name="button1" id="nextbt" class="button expand inverse outline" rel="loginFormFields" value="Click for Direct Login" onclick="buttonToggle(this,' Click to Hide Direct Login ',' Click for Direct Login ')">
			
		  </div>
		  -->
	 
	  <div><FONT Color=#ffffff><p>If you need assistance with your credentials, please contact us at <a href="mailto:helpdesk@cowley.edu">helpdesk@cowley.edu </a>.</P></div>
    <!-- END custom HTML --> 
  			<loginUI:loginForm />

  		</div>

	<div class="bbResources" style="display:none;">
		<h1>Get Mobile</h1>

		<div class="blockBTNlogin">
			<p>Access grades, course content, and more - right from the Blackboard app on your phone.</p>
			<p><b>Available today on iOS, Android, or Windows:</b></p>
			<p>
				<a class="appimg" href="https://itunes.apple.com/app/blackboard-app/id950424861?mt=8" target="_blank">
					<img src="https://s3.amazonaws.com/bb-student/images/appstore.png" alt="iTunes" width="70" height="25" style="margin: 5px;">
				</a>
				<a class="appimg" href="https://play.google.com/store/apps/details?id=com.blackboard.android.bbstudent&hl=en" target="_blank">
					<img src="https://s3.amazonaws.com/bb-student/images/google-play.png" alt="Google Play" width="70" height="25" style="margin: 5px;">
				</a>
				<a class="appimg" href="https://www.microsoft.com/store/p/blackboard/9nblggh08j8w?rtc=1" target="_blank">
					<img src="https://s3.amazonaws.com/bb-student/images/ms-store.png" alt="Microsoft Store" width="70" height="25" style="margin: 5px;">
				</a>
			</p>
		</div>

		<div class="blockBTNlogin">
			<h1>Blackboard Instructor</h1>
			<p>Blackboard Instructor is Blackboard's brand new mobile application that gives instructors a quick and easy way to manage courses, interact with students, and view content.</p>
			<p><b>Available today on iOS, Android, or Windows:</b></p>
			<p>
				<a class="appimg" href="https://itunes.apple.com/app/blackboard-instructor/id1088457824?ls=1&mt=8" target="_blank">
					<img src="https://s3.amazonaws.com/bb-student/images/appstore.png" alt="iTunes" width="70" height="25" style="margin: 5px;">
				</a>
				<a class="appimg" href="https://play.google.com/store/apps/details?id=com.blackboard.android.bbinstructor" target="_blank">
					<img src="https://s3.amazonaws.com/bb-student/images/google-play.png" alt="Google Play" width="70" height="25" style="margin: 5px;">
				</a>
				<a class="appimg" href="https://www.microsoft.com/store/apps/9n0p65p3g4fv?rtc=1" target="_blank">
					<img src="https://s3.amazonaws.com/bb-student/images/ms-store.png" alt="Microsoft Store" width="70" height="25" style="margin: 5px;">
				</a>
			</p>
		</div>
	</div>


  	</div>
    
    <div class="login-page-announcements">
      <loginUI:systemAnnouncements maxItems="5" />
    </div>
</div>

<div class="small-12 small-centered text-center columns footerblock" id="pagefooter">
      <bbNG:copyright />
      <div id="loginOptions">
        <loginUI:gatewayButtons />
      </div>
    </div>

</bbNG:genericPage>

