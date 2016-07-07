component {

	property name="presideObjectService"       inject="presideObjectService";
	property name="systemConfigurationService" inject="systemConfigurationService";
	property name="taskmanagerService"         inject="taskmanagerService";

	private string function datamanager( event, rc, prc, args={} ) {
		var action       = args.action            ?: "";
		var known_as     = args.known_as          ?: "";
		var userLink     = args.userLink          ?: "";
		var record_id    = args.record_id         ?: "";
		var objectName   = args.detail.objectName ?: "";
		var labelField   = objectName.len() ? presideObjectService.getObjectAttribute( objectName, "labelField" ) : "";
		var userLink     = '<a href="#args.userLink#">#args.known_as#</a>';
		var objectTitle  = translateResource( uri="preside-objects.#objectName#:title.singular" );
		var objectUrl    = event.buildAdminLink( linkTo="datamanager.object", queryString="id=" & objectName );
		var objectLink   = '<a href="#objectUrl#">#objectTitle#</a>';
		var recordLabel  = args.detail[ labelField ] ?: renderLabel( objectName=objectName, recordId=record_id );
		var recordUrl    = event.buildAdminLink( linkTo="datamanager.viewRecord", queryString="object=#objectName#&id=#args.record_id#" );
		var recordLink   = '<a href="#recordUrl#">#recordLabel#</a>';

		switch( action ) {
			case "datamanager_translate_record":
				var language = renderLabel( "multilingual_language", args.detail.languageId ?: "" );
				return translateResource( uri="auditlog.datamanager:#args.action#.message", data=[ userLink, objectLink, recordLink, language ] );
			case "datamanager_batch_edit_record":
				var field = args.detail.fieldName ?: "";
				var fieldName = translateResource( "preside-objects.#objectName#:field.#field#.title", field );
				return translateResource( uri="auditlog.datamanager:#args.action#.message", data=[ userLink, objectLink, recordLink, fieldName ] );
		}


		return translateResource( uri="auditlog.datamanager:#args.action#.message", data=[ userLink, objectLink, recordLink ] );
	}

	private string function userManager( event, rc, prc, args={} ) {
		var action     = args.action            ?: "";
		var known_as   = args.known_as          ?: "";
		var userLink   = '<a href="#args.userLink#">#args.known_as#</a>';
		var recordId   = args.record_id         ?: "";
		var type       = action.find( "_group" ) ? "group" : "user";
		var labelField = type == "group" ? "label" : "known_as";
		var label      = args.detail[ labelField ] ?: "unknown";
		var recordUrl  = event.buildAdminLink( linkTo="usermanager.#( type == 'group' ? 'editGroup' : 'editUser' )#", queryString="id=" & recordId );
		var recordLink = '<a href="#recordUrl#">#label#</a>';

		return translateResource( uri="auditlog.usermanager:#action#.message", data=[ userLink, recordLink ] );
	}

	private string function sysconfig( event, rc, prc ) {
		var action       = args.action    ?: "";
		var known_as     = args.known_as  ?: "";
		var userLink     = '<a href="#args.userLink#">#args.known_as#</a>';
		var category     = translateResource( systemConfigurationService.getConfigCategory( args.record_id ?: "" ).getName() );
		var categoryUrl  = event.buildAdminLink( linkTo="sysconfig.category", queryString="id=" & ( args.record_id ?: "" ) )
		var categoryLink = '<a href="#categoryUrl#">#category#</a>';

		return translateResource( uri="auditlog.sysconfig:#action#.message", data=[ userLink, categoryLink ] );
	}

	private string function sitemanager( event, rc, prc ) {
		var action   = args.action    ?: "";
		var known_as = args.known_as  ?: "";
		var userLink = '<a href="#args.userLink#">#args.known_as#</a>';
		var siteId   = args.record_id;
		var siteName = args.detail.name ?: "unknown";
		var siteUrl  = event.buildAdminLink( linkTo="sites.editSite", queryString="id=" & ( args.record_id ?: "" ) )
		var siteLink = '<a href="#siteUrl#">#siteName#</a>';

		return translateResource( uri="auditlog.sitemanager:#action#.message", data=[ userLink, siteLink ] );
	}

	private string function passwordpolicies( event, rc, prc ) {
		var action      = args.action    ?: "";
		var known_as    = args.known_as  ?: "";
		var userLink    = '<a href="#args.userLink#">#args.known_as#</a>';
		var context     = args.record_id;
		var contextName = translateResource( "cms:passwordpolicycontext.#context#.title" );
		var contextUrl  = event.buildAdminLink( linkTo="passwordpolicymanager", queryString="context=" & context );
		var contextLink = '<a href="#contextUrl#">#contextName#</a>';

		return translateResource( uri="auditlog.passwordpolicies:#action#.message", data=[ userLink, contextLink ] );
	}

	private string function urlredirects( event, rc, prc ) {
		var action   = args.action    ?: "";
		var known_as = args.known_as  ?: "";
		var userLink = '<a href="#args.userLink#">#args.known_as#</a>';
		var rule     = args.record_id;
		var ruleName = args.detail.label ?: "unknown";
		var ruleUrl  = event.buildAdminLink( linkTo="urlredirects.editrule", queryString="id=" & rule );
		var ruleLink = '<a href="#ruleUrl#">#ruleName#</a>';

		return translateResource( uri="auditlog.urlredirects:#action#.message", data=[ userLink, ruleLink ] );
	}

	private string function websiteusermanager( event, rc, prc ) {
		var action      = args.action    ?: "";
		var known_as    = args.known_as  ?: "";
		var userLink    = '<a href="#args.userLink#">#args.known_as#</a>';
		var webUser     = args.record_id;
		var webUserName = args.detail.display_name ?: "unknown";
		var webUserUrl  = event.buildAdminLink( linkTo="websiteusermanager.edituser", queryString="id=" & webUser );
		var webUserLink = '<a href="#webUserUrl#">#webUserName#</a>';

		return translateResource( uri="auditlog.websiteusermanager:#action#.message", data=[ userLink, webUserLink ] );
	}

	private string function websitebenefitsmanager( event, rc, prc ) {
		var action   = args.action    ?: "";
		var known_as = args.known_as  ?: "";
		var userLink = '<a href="#args.userLink#">#args.known_as#</a>';
		var benefit     = args.record_id;
		var benefitName = args.detail.label ?: "unknown";
		var benefitUrl  = event.buildAdminLink( linkTo="websitebenefitsmanager.editbenefit", queryString="id=" & benefit );
		var benefitLink = '<a href="#benefitUrl#">#benefitName#</a>';

		return translateResource( uri="auditlog.websitebenefitsmanager:#action#.message", data=[ userLink, benefitLink ] );
	}

	private string function taskmanager( event, rc, prc ) {
		var action     = args.action    ?: "";
		var known_as   = args.known_as  ?: "";
		var userLink   = '<a href="#args.userLink#">#args.known_as#</a>';
		var task       = args.record_id;
		var taskDetail = Len( Trim( task ) ) ? taskmanagerService.getTask( task ) : {};
		var taskName   = taskDetail.name ?: "unknown";
		var taskUrl    = event.buildAdminLink( linkTo="taskmanager.history", queryString="task=" & task );
		var taskLink   = '<a href="#taskUrl#">#taskName#</a>';

		return translateResource( uri="auditlog.taskmanager:#action#.message", data=[ userLink, taskLink ] );
	}

	private string function frontendeditor( event, rc, prc, args={} ) {
		var action       = args.action        ?: "";
		var known_as     = args.known_as      ?: "";
		var userLink     = args.userLink      ?: "";
		var record_id    = args.record_id     ?: "";
		var objectName   = args.detail.object ?: "";
		var labelField   = objectName.len() ? presideObjectService.getObjectAttribute( objectName, "labelField" ) : "";
		var userLink     = '<a href="#args.userLink#">#args.known_as#</a>';
		var objectTitle  = translateResource( uri="preside-objects.#objectName#:title.singular", defaultValue=objectName );
		var recordLabel  = args.detail[ labelField ] ?: renderLabel( objectName=objectName, recordId=record_id );

		return translateResource( uri="auditlog.frontendeditor:#args.action#.message", data=[ userLink, objectTitle, recordLabel ] );
	}
}