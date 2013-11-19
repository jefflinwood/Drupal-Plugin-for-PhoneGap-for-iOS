Notes on using the Drupal PhoneGap Plugin for iOS

Installation Notes
==================

* Tested with PhoneGap 1.1.0 and XCode 4.2
* Create a new PhoneGap Application from XCode 4.2 to get started
* Add my fork of the ASIHTTPRequest (git://github.com/jefflinwood/asi-http-request.git) to your XCode Project (but only the Classes folder). You can add it as a submodule - git submodule add git://github.com/jefflinwood/asi-http-request.git DrupalPhoneGapApp/Classes/asi-http-request
* Add my fork of the Drupal IOS SDK (git://github.com/jefflinwood/drupal-ios-sdk.git) to your XCode Project. You can add it as a submodule - git submodule add git://github.com/jefflinwood/drupal-ios-sdk.git DrupalPhoneGapApp/Classes/drupal-ios-sdk
* Add libz.1.2.5 as a dynamic library for your app
* Add CFNetwork as a Framework for your app
* Add DrupalPlugin.m and DrupalPlugin.h from this project to your XCode PhoneGap project's plugins directory
* Add the javascript file to your XCode project's www directory
* Reference the javascript file in your index.html
<script type="text/javascript" charset="utf-8" src="drupal-phonegap.js"></script>
* Add DrupalPlugin to your PhoneGap.plist configuration file's list of plugins. Select the last plugin in the list (there are 14 out of the box) and then click the Plus sign. 
* Type "DrupalPlugin" into both boxes of the new plugin and save the file.
* You will need to edit DIOSConfig.h to reference your Drupal server's services URL, main URL, and domain
* For PhoneGap 1.1.0, you will need to also add that Drupal Server to the list of allowed external hosts by editing the ExternalHosts property in the PhoneGap.plist file under Supporting Files

* Start using the plugin

Sample Code
==================
```js
//authenticated user
function onDeviceReady()
{
	window.plugins.drupal.login("drupaluser", "password", successCallback,failureCallback);
	var node = {
				 title: "Sample Article",
				 body: { 
				 und: [{
					   value: "Sample Body"
					   }]
				 },
				 type: 'article',
				 language: 'und'
	};
	window.plugins.drupal.nodeSave(node,articleSaveSuccess,failureCallback);
    window.plugins.drupal.logout(successCallback,failureCallback);	
}

//anonymous user
function onDeviceReady()
{
        window.plugins.drupal.openAnonymousSession(successCallback,failureCallback);
        window.plugins.drupal.viewGet("frontpage",frontPageSuccess,failureCallback);
}
```

Version 0.3

===========
* Currently the plugin only supports a connection to one Drupal site per app
* Currently supported methods from Drupal Services:
	* `user.login`
	* `user.logout`
	* `system.connect`
	* `node.get` (individual node and node index)
	* `node.save`
	* `node.delete`
	* `views.get`
	* `file.save`

* Adding more methods should be pretty easy.



