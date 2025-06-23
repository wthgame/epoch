local Epoch = script:FindFirstAncestor("Epoch")

local Tiniest = require(Epoch.Packages.Tiniest)
local Vide = require(Epoch.Packages.Vide)
local dissolve = require(script.Parent.dissolve)

return function(tiniest: Tiniest.Configured)
	local test = tiniest.test
	local expect = tiniest.expect

	test("no reads", function()
		local as = "constant"
		local dissolved = dissolve(function()
			return as
		end)
		expect(dissolved).never_is_a("function")
		expect(dissolved).is(as)
	end)

	test("reads constant", function()
		local as = "constant"
		local dissolved = dissolve(function(read)
			return read(as)
		end)
		expect(dissolved).never_is_a("function")
		expect(dissolved).is(as)
	end)

	test("reads dependency", function()
		local as = Vide.source("source")
		local dissolved = dissolve(function(read)
			return read(as)
		end)
		expect(dissolved).is_a("function")
		expect(Vide.read(dissolved)).is("source")
	end)
end
