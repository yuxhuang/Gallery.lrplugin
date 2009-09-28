--[[----------------------------------------------------------------------------
	Intialization of the plugin.

	Copyright (C) 2008-2009 Arnaud Mouronval <arnaud.mouronval@yahoo.com>
	Released under the GNU GPL.
-----------------------------------------------------------------------------]]--

	-- Global values
_G.pluginID = "org.starway.lightroom.galleryUploader"
_G.URL = "http://www.starway.org/blogs/Photographie/lightroom-vers-gallery/"

	-- Logger initialization
local prefs = import 'LrPrefs'.prefsForPlugin()
local LrLogger = import 'LrLogger'
local log = LrLogger( 'LR2Gallery' )

if prefs.logLevel == 'none' then
	log:disable( )
elseif prefs.logLevel == 'errors' then
	log:enable( { ['error'] = 'logfile' ; ['fatal'] = 'logfile'} )
elseif prefs.logLevel == 'trace' then
	log:enable( { ['error'] = 'logfile' ; ['fatal'] = 'logfile' ; ['trace'] = 'logfile' ; ['info'] = 'logfile'} )
elseif prefs.logLevel == 'verbose' then
	log:enable( 'logfile' )
end
