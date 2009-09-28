--[[----------------------------------------------------------------------------
	Definition of the Gallery export plugin.

	Copyright (C) 2007-2009 Arnaud Mouronval <arnaud.mouronval@yahoo.com>
	Copyright (C) 2007 Moritz Post <mail@moritzpost.de>
	Released under the GNU GPL
-----------------------------------------------------------------------------]]--

return {
	-- Lightroom SDK version
	LrSdkVersion = 2.0,
	LrSdkMinimumVersion = 2.0,
	
	-- Plugin attibutes
	LrPluginName = "Gallery",
	LrToolkitIdentifier  = "org.starway.lightroom.galleryUploader",
	LrPluginInfoUrl = "http://www.starway.org/blogs/Photographie/lightroom-vers-gallery/",
	
	LrInitPlugin = "GalleryUploadInit.lua",
	LrPluginInfoProvider = "GalleryUploadInfoProvider.lua",

	LrExportServiceProvider = {
		title = LOC "$$$/GalleryUpload/Info/Title=Gallery",
		file = "GalleryUploadServiceProvider.lua",
		builtInPresetsDir = "presets"
	},

	VERSION = { display='2.0.0', major=2, minor=0, revision=0, build=16, }
}