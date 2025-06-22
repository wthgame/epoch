local exhaustive_match = require("./exhaustive_match")
local tiniest = require("@pkgs/tiniest")

return function(tiniest: tiniest.Configured): ()
	local test = tiniest.test
	local expect = tiniest.expect

	test("throws", function()
		expect(exhaustive_match).fails_with("Unknown value in exhaustive match")
	end)
end
