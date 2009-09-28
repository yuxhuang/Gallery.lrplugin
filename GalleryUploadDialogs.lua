--[[----------------------------------------------------------------------------
	Dialogs used in the application.

	Copyright (C) 2007-2009 Arnaud Mouronval <arnaud.mouronval@yahoo.com>
	Copyright (C) 2007 Moritz Post <mail@moritzpost.de>
	Released under the GNU GPL.
-----------------------------------------------------------------------------]]--

-- Lightroom SDK
local LrView = import 'LrView'
local LrFunctionContext = import 'LrFunctionContext'
local LrBinding = import 'LrBinding'
local LrDialogs = import 'LrDialogs'
local LrLogger = import 'LrLogger'

local prefs = import 'LrPrefs'.prefsForPlugin()

local bind = LrView.bind
local share = LrView.share

-- setup logger
local log = LrLogger( 'LR2Gallery' )

GalleryUploadDialogs = {}

-- Dialog to manage servers
function GalleryUploadDialogs.showManageServers( serverId )
	if serverId ~= nil then
		log:trace("Calling GalleryUploadDialogs.showManageServers ( "..serverId.." )")
	else
		log:trace("Calling GalleryUploadDialogs.showManageServers ( nil )")
	end
	
	return LrFunctionContext.callWithContext( 'GalleryUploadDialogs.showManageServers', function( context, ... )

		local f = LrView.osFactory()
		
		local properties = LrBinding.makePropertyTable( context )
		
		-- set serverId
		serverId = 0
		if (arg ~= nil and #arg > 0) then
			if type(arg[1]) == 'number' then
				log:info("got serverId "..arg[1])
				serverId = arg[1] 
			end
		end 
		
		-- fill edit fields if a server has been passed
		if serverId == 0 then
			properties.label = ""
			properties.server = ""
			properties.version = ""
			properties.username = ""
			properties.password = ""
		else
			properties.label = prefs.serverTable[serverId].label
			properties.server = prefs.serverTable[serverId].server
			properties.version = prefs.serverTable[serverId].version
			properties.username = prefs.serverTable[serverId].username
			properties.password = prefs.serverTable[serverId].password
		end 
		
		local contents = f:column {  -- create UI elements for dialog
			bind_to_object = properties,
			spacing = f:control_spacing(),
			fill = 1,
			
			f:row {
				spacing = f:label_spacing(),
				width = 400,
				
				f:static_text { -- label for label
					title = LOC "$$$/GalleryUpload/GalleryDetailsDialog/Label=Label:",
					alignment = 'right',
					width = share "label_width",
				},
				
				f:edit_field { -- text for label
					fill_horizontal = 1,
					value = bind 'label',
				},
			},	
			
			f:row {
				spacing = f:label_spacing(),
				
				f:static_text { -- label for server url
					title = LOC "$$$/GalleryUpload/GalleryDetailsDialog/ServerURL=Server URL:",
					alignment = 'right',
					width = share "label_width",
				},
				
				f:edit_field { -- text for server url
					fill_horizontal = 1,
					value = bind 'server',
				},
			},
			
			f:row {
				spacing = f:label_spacing(),
				
				f:static_text { -- label for server version
					title = LOC "$$$/GalleryUpload/GalleryDetailsDialog/ServerVersion=Version:",
					alignment = 'right',
					width = share "label_width",
				},
				
				f:popup_menu { -- popup menu for server version
					fill_horizontal = 1,
					items = {
						{ title = "Gallery 1.x & Jallery 1.x", value = '1' },
						{ title = "Gallery 2.x", value = '2' },
					},
					value = bind 'version',
				},
			},

			f:row {	
				spacing = f:label_spacing(),
				
				f:static_text { -- label for username
					title = LOC "$$$/GalleryUpload/GalleryDetailsDialog/Username=Username:",
					alignment = 'right',
					width = share "label_width",
				},
				
				f:edit_field { -- text for username
					fill_horizontal = 1,
					value = bind 'username',
				},
			},
				
			f:row {
				spacing = f:label_spacing(),
					
				f:static_text { -- label for password
					title = LOC "$$$/GalleryUpload/GalleryDetailsDialog/Password=Password:",
					alignment = 'right',
					width = share "label_width",
				},
				
				f:password_field  { -- text for password 
					fill_horizontal = 1,
					value = bind 'password',
				}
			}
		}
		
		local result = LrDialogs.presentModalDialog (
			{
			resizable = true, 
			title = LOC "$$$/GalleryUpload/GalleryDetailsDialog/Title=Gallery Details",
			actionVerb = LOC "$$$/GalleryUpload/GalleryDetailsDialog/Save=Save",
			contents = contents
			}
		)
		
		if result == 'ok' then
			log:trace("Clicked Save.")
		
			if serverId == 0 then
			
				-- creating server table in prefs
				if prefs.serverTable == nil then
					log:info("Creating server table")
					prefs.serverTable = {}
				end
				
				-- insert a new entry
				log:info("Inserting new server")
				table.insert(prefs.serverTable,
					{
						label = properties.label,
						server = properties.server,
						version = properties.version,
						username = properties.username,
						password = properties.password
					}
				)
				
			else
				-- update server
				prefs.serverTable[serverId].label = properties.label
				prefs.serverTable[serverId].server = properties.server
				prefs.serverTable[serverId].version = properties.version
				prefs.serverTable[serverId].username = properties.username
				prefs.serverTable[serverId].password = properties.password
			end
			prefs.serverTable = prefs.serverTable
		else
			return "cancelled"
		end
		
	end, serverId)
end


  -- Dialog to add an album
function GalleryUploadDialogs.showAddAlbum( context )
	log:trace("Calling GalleryUploadDialogs.showAddAlbum( context )")

	local f = LrView.osFactory()
	
	local properties = LrBinding.makePropertyTable( context )
	
	-- init fields
	properties.name = ""
	properties.title = ""
	properties.description = ""
	
	local contents = f:column {  -- create UI elements for dialog
		bind_to_object = properties,
		spacing = f:control_spacing(),
		fill = 1,
		
		f:row {
			spacing = f:label_spacing(),
			width = 400,
			
			f:static_text { -- label for name
				title = LOC "$$$/GalleryUpload/AddAlbumDialog/Name=Name:",
				alignment = 'right',
				width = share "label_width",
			},
			
			f:edit_field { -- text for name
				fill_horizontal = 1,
				value = bind 'name',
			},
		},	
		
		f:row {
			spacing = f:label_spacing(),
			
			f:static_text { -- label for title
				title = LOC "$$$/GalleryUpload/AddAlbumDialog/Title=Title:",
				alignment = 'right',
				width = share "label_width",
			},
			
			f:edit_field { -- text for title
				fill_horizontal = 1,
				value = bind 'title',
			},
		},
		
		f:row {	
			spacing = f:label_spacing(),
			
			f:static_text { -- label for description
				title = LOC "$$$/GalleryUpload/AddAlbumDialog/Description=Description:",
				alignment = 'right',
				width = share "label_width",
			},
			
			f:edit_field { -- text for description
				fill_horizontal = 1,
				value = bind 'description',
			},
		},
	}

	local result = LrDialogs.presentModalDialog (
		{
		resizable = true, 
		title = LOC "$$$/GalleryUpload/AddAlbumDialog/DialogTitle=Add a New Album",
		actionVerb = LOC "$$$/GalleryUpload/AddAlbumDialog/DialogSave=Create Album",
		contents = contents
		}
	)
	
	if result == 'ok' then
		return properties.name, properties.title, properties.description
	else
		return 'cancelled'
	end

end

