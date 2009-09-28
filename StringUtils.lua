--[[----------------------------------------------------------------------------
	Utility functions for string processing.

	Copyright (C) 2007 Moritz Post <mail@moritzpost.de>
	Released under the GNU GPL.
-----------------------------------------------------------------------------]]--

function string.split( _str, _sep ) 
	local t = {}
	local sep = _sep
	if _sep == nil then 
		sep = "%S+"
	end 
	for a in string.gmatch( _str, sep ) do
		table.insert( t, a ) end
	return t
end