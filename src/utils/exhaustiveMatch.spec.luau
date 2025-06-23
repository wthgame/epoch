local Epoch = script:FindFirstAncestor("Epoch")

local Tiniest = require(Epoch.Packages.Tiniest)
local exhaustiveMatch = require(script.Parent.exhaustiveMatch)

return function(tiniest: Tiniest.Configured): ()
	local test = tiniest.test
	local expect = tiniest.expect

	test("throws", function()
		expect(exhaustiveMatch).fails_with("Unknown value in exhaustive match")
	end)
end
