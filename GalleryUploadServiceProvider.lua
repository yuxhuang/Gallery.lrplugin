--[[----------------------------------------------------------------------------
	Definition of the Export Service Provider.

	Copyright (C) 2007-2008 Arnaud Mouronval <arnaud.mouronval@yahoo.com>
	Copyright (C) 2007 Moritz Post <mail@moritzpost.de>
	Released under the GNU GPL.
-----------------------------------------------------------------------------]]--

	-- Lightroom SDK
local LrView = import 'LrView'

	-- GalleryUpload plugin
require 'GalleryUploadExportDialogSections'
require 'GalleryUploadTask'

--============================================================================--

return {
	hideSections = { 'exportLocation', 'postProcessing' },

	allowFileFormats = { 'JPEG' },
	allowColorSpaces = { 'sRGB' },
	
	hidePrintResolution = true,
	
	image = 'ExportToGallery.png',
	image_alignment = 'flush_left',
	
	exportPresetFields = {
		{ key = 'serverValue', default = '' },
		{ key = 'caption', default = 'none' },
		{ key = 'showInBrowser', default = false }
	},
	
	startDialog = GalleryUploadExportDialogSections.startDialog,
	endDialog = GalleryUploadExportDialogSections.endDialog,
	sectionsForTopOfDialog = GalleryUploadExportDialogSections.sectionsForTopOfDialog,
	sectionsForBottomOfDialog = GalleryUploadExportDialogSections.sectionsForBottomOfDialog,
	processRenderedPhotos = GalleryUploadTask.processRenderedPhotos
}
