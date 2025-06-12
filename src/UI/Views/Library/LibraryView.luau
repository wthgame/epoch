-- local Assets = require(Epoch.Assets)
-- local NavTypes = require(Epoch.UI.Components.Nav.NavTypes)
-- local TextField = require(Epoch.UI.Components.Controls.TextField)
local Theme = require("@ui/Theme")
-- local TopNav = require(Epoch.UI.Components.Nav.TopNav)
local Vide = require("@pkgs/Vide")

local create, _source = Vide.create, Vide.source

export type LibraryViewProps = {}

local function LibraryView(props: LibraryViewProps)
	-- local currentPage = source("COs")
	-- local searchInput = source("")

	return create "Frame" {
		Name = "LibraryView",
		BackgroundColor3 = Theme.base,
		Size = UDim2.fromScale(1, 1),

		create "UIListLayout" {
			Padding = UDim.new(0, 8),
		},
	}
end

return LibraryView
