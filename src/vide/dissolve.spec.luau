local dissolve = require("./dissolve")
local tiniest = require("@pkgs/tiniest")
local vide = require(".")

return function(tiniest: tiniest.Configured)
	local test = tiniest.test
	local expect = tiniest.expect

	test("no reads", function()
		local as = "constant"
		local dissolved = dissolve(function()
			return as
		end)
		expect(dissolved).never_is_a("function")
		expect(vide.read(dissolved)).is(as)
	end)

	test("reads constant", function()
		local as = "constant"
		local dissolved = dissolve(function(read)
			return read(as)
		end)
		expect(dissolved).never_is_a("function")
		expect(vide.read(dissolved)).is(as)
	end)

	test("reads dependency", function()
		local as = vide.source("source")
		local dissolved = dissolve(function(read)
			return read(as)
		end)
		expect(dissolved).is_a("function")
		expect(vide.read(dissolved)).is("source")
	end)
end
