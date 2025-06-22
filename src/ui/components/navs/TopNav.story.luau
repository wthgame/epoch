--
-- local NavTypes = require("./NavTypes")
-- local Theme = require("@src/Theme")
-- local TopNav = require("./TopNav")
-- local UILabs = require("@pkgs/UILabs")
-- local Vide = require("@pkgs/Vide")

-- return UILabs.CreateVideStory(
-- 	{
-- 		vide = require(Epoch.Packages.Vide),
-- 	},
-- 	function(props: UILabs.VideProps)
-- 		return Theme.ThemePreview {
-- 			fillDirection = "vertical",
-- 			render = function()
-- 				local current = Vide.source("Complexity")

-- 				local function createCurrentIsCheck(is: string)
-- 					local function check()
-- 						return current() == is
-- 					end
-- 					return check
-- 				end

-- 				return TopNav {
-- 					colors = {
-- 						background = Theme.library.navBackground,
-- 						hoverBackground = Theme.library.navHoverBackground,
-- 						activeBackground = Theme.library.navActiveBackground,
-- 						text = Theme.library.navText,
-- 						activeText = Theme.library.navActiveText,
-- 					},

-- 					layout = {
-- 						position = UDim2.fromScale(0.5, 0.5),
-- 						anchorPoint = Vector2.new(0.5, 0.5),
-- 					},

-- 					NavTypes.NavOption {
-- 						label = "Complexity",
-- 						active = createCurrentIsCheck("Complexity"),
-- 						on_activated = function()
-- 							current("Complexity")
-- 						end,
-- 					},

-- 					NavTypes.NavOption {
-- 						label = "Volatility",
-- 						active = createCurrentIsCheck("Volatility"),
-- 						on_activated = function()
-- 							current("Volatility")
-- 						end,
-- 					},
-- 				}
-- 			end,
-- 		}
-- 	end :: any
-- )
