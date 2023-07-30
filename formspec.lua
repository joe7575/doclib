--[[

	DocLib
	======

	Copyright (C) 2023 Joachim Stolberg

	AGPL v3
	See LICENSE.txt for more information

	A library to generate ingame manuals based on markdown files.

]]--

-- for lazy programmers
local S = doclib.S
local P2S = function(pos) if pos then return minetest.pos_to_string(pos) end end
local S2P = minetest.string_to_pos
local M = minetest.get_meta

local function tooltip(item)
	if type(item) == "table" then
		local img, name = item[1], item[2]
		if img == "" then  -- larger image for the plan?
			return "", name
		elseif img == "10x10" then  -- huge image for the plan?
			return "10x10", name
		elseif img == "5x4" then  -- huge image for the plan?
			return "5x4", name
		end
		local ndef = minetest.registered_nodes[name]
		if ndef and ndef.description then
			return img, minetest.formspec_escape(ndef.description)
		end
		return img
	end
	return item
end


-- formspec images
local function plan(images)
	local tbl = {}
	if images == "none" then return "label[1,3;"..S("No plan available") .."]" end
	for y=1,#images do
		for x=1,#images[1] do
			local item = images[y][x] or false
			if item ~= false then
				local img, tooltip = tooltip(item)
				local x_offs, y_offs = (x-1) * 0.9, (y-1) * 0.9 + 0.8
				if img == "top_view" then
					tbl[#tbl+1] = "label["..x_offs..","..y_offs..";"..S("Top view").."]"
				elseif img == "side_view" then
					tbl[#tbl+1] = "label["..x_offs..","..y_offs..";"..S("Side view").."]"
				elseif img == "sectional_view" then
					tbl[#tbl+1] = "label["..x_offs..","..y_offs..";"..S("Sectional view").."]"
				elseif img == "" then
					img = tooltip -- use tooltip for bigger image
					tbl[#tbl+1] = "image["..x_offs..","..y_offs..";2.2,2.2;"..img.."]"
				elseif img == "10x10" then
					img = tooltip -- use tooltip for bigger image
					tbl[#tbl+1] = "image["..x_offs..","..y_offs..";10,10;"..img.."]"
				elseif img == "5x4" then
					img = tooltip -- use tooltip for bigger image
					tbl[#tbl+1] = "image["..x_offs..","..y_offs..";5,4;"..img.."]"
				elseif string.find(img, ":") then
					tbl[#tbl+1] = "item_image["..x_offs..","..y_offs..";1,1;"..img.."]"
				else
					tbl[#tbl+1] = "image["..x_offs..","..y_offs..";1,1;"..img.."]"
				end
				if tooltip then
					tbl[#tbl+1] = "tooltip["..x_offs..","..y_offs..";1,1;"..tooltip..";#0C3D32;#FFFFFF]"
				end
			end
		end
	end
	return table.concat(tbl)
end

local function formspec_help(meta, manual)
	local idx = meta:get_int("doclib_index")
	local box = "box[9.5,0.9;1,1.1;#BBBBBB]"
	local bttn, symbol

	if manual.content.aPlans[idx] ~= "" then
		bttn = "button[9.6,1;1,1;plan;" .. S("Plan") .. "]"
	elseif manual.content.aImages[idx] ~= "" then
		local item = manual.content.aImages[idx] or ""
		if string.find(item, ":") then
			bttn = box .. "item_image[9.6,1;1,1;" .. item .. "]"
		else
			bttn = "image[9.3,1;2,2;" .. item .. "]"
		end
	else
		bttn = box
	end
	
	if string.find(manual.settings.symbol_item, ":") then
		symbol = "item_image[9.6,0;1,1;" .. manual.settings.symbol_item .. "]"
	else
		symbol = "image[9.6,0;1,1;" .. manual.settings.symbol_item .. "]"
	end
	
	return "size[11,10]" ..
		symbol ..
		"tablecolumns[tree,width=1;text,width=10,align=inline]" ..
		"tableoptions[opendepth=1]" ..
		"table[0.1,0;9,5;page;" .. table.concat(manual.content.aTitles, ",") .. ";" .. idx .. "]" ..
		bttn ..
		"box[0,5.75;10.775,4.45;#000000]" ..
		"style_type[textarea;textcolor=#FFFFFF]" ..
		"textarea[0.3,5.7;11,5.3;;;" .. (manual.content.aTexts[idx] or "") .. "]"
end

local function formspec_plan(meta, manual)
	local idx = meta:get_int("doclib_index")
	local images = manual.content.aPlans[idx] or "none"
	local titel = string.sub(manual.content.aTitles[idx], 3) or "unknown"

	return "size[11,10]" ..
		"label[0,0;"..titel..":]" ..
		"button[10,0;1,0.8;back;<<]" ..
		plan(images)
end

function doclib.formspec(pos, mod, language, fields)
	local manual = doclib.manual.mod.language
	local meta = M(pos)

	if not fields then
		meta:set_int("doclib_index", 1)
		return formspec_help(meta, manual)
	elseif fields.plan then
		return formspec_plan(meta, manual)
	elseif fields.back then
		return formspec_help(meta, manual)
	elseif fields.page then
		local evt = minetest.explode_table_event(fields.page)
		if evt.type == "CHG" then
			local idx = tonumber(evt.row)
			meta:set_int("doclib_index", idx)
		end
	end
	return formspec_help(meta, manual)
end
