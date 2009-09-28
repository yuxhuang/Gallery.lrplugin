--[[----------------------------------------------------------------------------
	UI element definition for the plugin manager dialog.

	Copyright (C) 2008-2009 Arnaud Mouronval <arnaud.mouronval@yahoo.com>
	Released under the GNU GPL.
-----------------------------------------------------------------------------]]--

require "GalleryUploadManager"

return {
	startDialog = GalleryUploadManager.startDialog,
	endDialog = GalleryUploadManager.endDialog,
	sectionsForTopOfDialog = GalleryUploadManager.sectionsForTopOfDialog,
}