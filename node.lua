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
local MP = minetest.get_modpath("doclib")

local settings = {}
doclib.create_manual("doclib", "EN", settings)
local content = dofile(MP.."/manual_EN.lua") 
doclib.add_to_manual("doclib", "EN", content)

minetest.register_node("doclib:manual", {
	description = "DocLib Manual (EN)",
	tiles = {
		-- up, down, right, left, back, front
		"doclib_book.png",
		"doclib_book.png",
		"doclib_book.png^[transformR270",
		"doclib_book.png^[transformR90",
		"doclib_book.png^[transformR180",
		"doclib_book.png"
		},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/32, -16/32, -12/32, 8/32, -12/32, 12/32},
		},
	},

	after_place_node = function(pos, placer, itemstack)
		M(pos):set_string("infotext", "DocLib Manual (EN)")
		M(pos):set_string("formspec", doclib.formspec(pos, "doclib", "EN"))
	end,

	on_receive_fields = function(pos, formname, fields, player)
		local player_name = player:get_player_name()
		if minetest.is_protected(pos, player_name) then
			return
		end
		M(pos):set_string("formspec", doclib.formspec(pos, "doclib", "EN", fields))
	end,

	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	use_texture_alpha = "clip",
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
})
