--[[----------------------------------------------------------------------------
	Integration within the plugin mananger.

	Copyright (C) 2007-2009 Arnaud Mouronval <arnaud.mouronval@yahoo.com>
	Released under the GNU GPL.
-----------------------------------------------------------------------------]]--

local LrView = import 'LrView'
local LrColor = import 'LrColor'
local LrHttp = import 'LrHttp'
local bind = import 'LrBinding'
local app = import 'LrApplication'
local prefs = import 'LrPrefs'.prefsForPlugin()
local LrLogger = import 'LrLogger'
local log = LrLogger( 'LR2Gallery' )

GalleryUploadManager = {}

-------------------------------------------------------------------------------

updateLogLevelStatus = function( properties )
	log:trace ("Calling updateLogLevelStatus( properties )")
	if properties.logLevel == 'none' then
		log:disable( )
		properties.logSynopsis = LOC "$$$/GalleryUpload/PluginManagerDialog/NoLogging=No Log File"
	elseif properties.logLevel == 'errors' then
		log:enable( { ['error'] = 'logfile' ; ['fatal'] = 'logfile'} )
		properties.logSynopsis = LOC "$$$/GalleryUpload/PluginManagerDialog/ErrorLogging=Log File - Errors Only"
	elseif properties.logLevel == 'trace' then
		log:enable( { ['error'] = 'logfile' ; ['fatal'] = 'logfile' ; ['trace'] = 'logfile' ; ['info'] = 'logfile'} )
		properties.logSynopsis = LOC "$$$/GalleryUpload/PluginManagerDialog/TraceLogging=Log File - Trace"
		elseif properties.logLevel == 'verbose' then
		log:enable( 'logfile' )
		properties.logSynopsis = LOC "$$$/GalleryUpload/PluginManagerDialog/VerboseLogging=Log File - Verbose"
	end
end

-------------------------------------------------------------------------------

function GalleryUploadManager.startDialog( properties )
	log:trace("Calling GalleryUploadManager.startDialog( properties )")
	
	-- initialize the log level
	if properties.logLevel == nil then
		if prefs.logLevel ~= nil and prefs.logLevel ~= '' then
			properties.logLevel = prefs.logLevel
		else
			properties.logLevel = 'none'
		end
	end

	-- add observer
	properties:addObserver( 'logLevel', updateLogLevelStatus )

	-- initialize dialog elements
	updateLogLevelStatus( properties )
end

-------------------------------------------------------------------------------

function GalleryUploadManager.endDialog( properties )
	log:trace("Calling GalleryUploadManager.endDialog( properties )")
	
	-- save the log level into the preferences
	prefs.logLevel = properties.logLevel
end

-------------------------------------------------------------------------------

function GalleryUploadManager.sectionsForTopOfDialog( f, properties )
	log:trace("Calling GalleryUploadManager.sectionsForBottomOfDialog( f, properties )")

	local f = LrView.osFactory()
	local bind = LrView.bind
	local share = LrView.share

	-- Initializations
	if properties.logLevel == nil then
		properties.logLevel = 'none'
	end
	if properties.logSynopsis == nil then
		properties.logSynopsis = ''
	end
	
	local result = {
		{
			title = LOC "$$$/GalleryUpload/PluginManagerDialog/InfoSectionTitle=Module Properties",
			
			synopsis = bind { key = 'logSynopsis', object = properties },
			
			f:row {
				f:spacer {
					width = share 'labelWidth'
				},
				
				f:picture {
					value = _PLUGIN:resourceId( "Gallery.png" ),
					frame_width = 2,
					frame_color = LrColor( "black" )
				}			
			},
			
			f:row {
				f:static_text {
					title = LOC "$$$/GalleryUpload/PluginManagerDialog/Author=Author:",
					alignment = 'right',
					width = share 'labelWidth'
				},
				
				f:static_text {
					title = "Arnaud Mouronval",
					alignment = 'left'
				}
			},
			
			f:row {
				f:static_text {
					title = LOC "$$$/GalleryUpload/PluginManagerDialog/Support=Support:",
					alignment = 'right',
					width = share 'labelWidth'
				},
				
				f:static_text {
					title = LOC "$$$/GalleryUpload/PluginManagerDialog/SupportText=",
					alignment = 'left'
				}
			},
			
			f:row {
				f:static_text {
					title = LOC "$$$/GalleryUpload/PluginManagerDialog/Credits=Credits:",
					alignment = 'right',
					width = share 'labelWidth'
				},
				
				f:static_text {
					title = LOC "$$$/GalleryUpload/PluginManagerDialog/CreditsText=",
					alignment = 'left'
				}
			},
			
			f:row {
				f:static_text {
					title = LOC "$$$/GalleryUpload/PluginManagerDialog/Logging=Logging Level:",
					alignment = 'right',
					width = share 'labelWidth'
				},
				
				f:popup_menu {
					fill_horizontal = 1,
					items = {
						{ title = LOC "$$$/GalleryUpload/PluginManagerDialog/NoLogging=No Log File", value = 'none' },
						{ title = LOC "$$$/GalleryUpload/PluginManagerDialog/ErrorLogging=Log File - Errors Only", value = 'errors' },
						{ title = LOC "$$$/GalleryUpload/PluginManagerDialog/TraceLogging=Log File - Trace", value = 'trace' },
						{ title = LOC "$$$/GalleryUpload/PluginManagerDialog/VerboseLogging=Log File - Verbose", value = 'verbose' },
					},
					value = bind { key = 'logLevel', object = properties }
				}
			}			
		}
	}
	
	return result

end