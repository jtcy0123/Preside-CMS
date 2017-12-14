component extends="tests.resources.HelperObjects.PresideBddTestCase" {

	function run() {
		describe( "getCustomizationHandlerForObject()", function(){
			it( "should return a conventions based handler path when object does not specify its own", function(){
				var service    = _getService();
				var objectName = "some_object";

				mockPresideObjectService.$( "getObjectAttribute" ).$args( objectName, "datamanagerHandler" ).$results( "" );

				expect( service.getCustomizationHandlerForObject( objectName ) ).toBe( "datamanager.some_object" );
			} );

			it( "should return the value of @datamanagerHandler if set on the object", function(){
				var service    = _getService();
				var objectName = "some_object";
				var handler    = "blah.test";

				mockPresideObjectService.$( "getObjectAttribute" ).$args( objectName, "datamanagerHandler" ).$results( handler );

				expect( service.getCustomizationHandlerForObject( objectName ) ).toBe( handler );
			} );
		} );

		describe( "getCustomizationEventForObject()", function(){
			it( "should append customization action to customization handler for the object", function(){
				var service       = _getService();
				var objectName    = "my_object";
				var customization = "buildCrumbtrail";
				var handler       = "some.handler";

				service.$( "getCustomizationHandlerForObject" ).$args( objectName ).$results( handler );

				expect( service.getCustomizationEventForObject( objectName, customization ) ).toBe( "some.handler.buildCrumbtrail" );
			} );
		} );
	}

// private helpers
	private any function _getService() {
		var service = createMock( object=new preside.system.services.admin.DataManagerCustomizationService() );

		mockPresideObjectService = CreateStub();
		service.$( "$getPresideObjectService", mockPresideObjectService );

		return service;
	}
}