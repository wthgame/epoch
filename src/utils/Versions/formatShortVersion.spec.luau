local Epoch = script:FindFirstAncestor("Epoch")

local Tiniest = require(Epoch.Packages.Tiniest)
local formatShortVersion = require(script.Parent.formatShortVersion)

return function(tiniest: Tiniest.Configured)
	local test = tiniest.test
	local expect = tiniest.expect

	test("1.2.3", function()
		expect(formatShortVersion(vector.create(1, 2, 3))).is("1.2.3")
	end)

	test("1.2", function()
		expect(formatShortVersion(vector.create(1, 2, 0))).is("1.2")
	end)

	test("1", function()
		expect(formatShortVersion(vector.create(1, 0, 0))).is("1")
	end)
end
