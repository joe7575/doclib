--[[

	DocLib
	======

	Copyright (C) 2023 Joachim Stolberg

	AGPL v3
	See LICENSE.txt for more information

	A library to generate ingame manuals based on markdown files.

]]--

function doclib.create_manual(mod, language, settings)
	doclib.manual = doclib.manual or {}
	doclib.manual.mod = doclib.manual.mod or {}
	doclib.manual.mod.language = doclib.manual.mod.language or {settings = settings, 
		content = {
			aTitles = {},
			aTexts = {},
			aImages = {},
			aPlans = {}
		}
	}
end

function doclib.add_to_manual(mod, language, content)
	local manual = doclib.manual.mod.language

	for _, item in ipairs(content.titles) do
		table.insert(manual.content.aTitles, item)
	end
	for _, item in ipairs(content.texts) do
		table.insert(manual.content.aTexts, item)
	end
	for _, item in ipairs(content.images) do
		table.insert(manual.content.aImages, item)
	end
	for _, item in ipairs(content.plans) do
		table.insert(manual.content.aPlans, item)
	end
end

-- Replace images tags from the markdown file with real PNG file names or node names
function doclib.add_manual_images(mod, language, table_with_images)
	local manual = doclib.manual.mod.language
	
	for k, v in pairs(table_with_images) do
		manual.kvImages[k] = v
	end
end

-- Replace plan tags from the markdown file with real Lua plan tables
function doclib.add_manual_plans(mod, language, table_with_plans)
	local manual = doclib.manual.mod.language
	
	for k, v in pairs(table_with_plans) do
		manual.kvPlans[k] = v
	end
end
