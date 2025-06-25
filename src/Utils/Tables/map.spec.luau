local Epoch = script:FindFirstAncestor("Epoch")

local Tiniest = require(Epoch.Packages.Tiniest)
local map = require(script.Parent.map)

return function(tiniest: Tiniest.Configured)
	local test = tiniest.test
	local expect = tiniest.expect

	test("values", function()
		local input = { 1, 2, 3 }
		local result = map(input, function(index, value)
			return index, tostring(value)
		end)
		expect(result).never_is(input)
		expect(result).is_a("table")
		expect(result[1]).is("1")
		expect(result[2]).is("2")
		expect(result[3]).is("3")
	end)

	test("keys", function()
		local input = { foo = true, bar = true, qux = true }
		local result = map(input, function(key: string, value)
			return key .. "Modified", value
		end)
		expect(result).never_is(input)
		expect(result).is_a("table")
		expect(result).never_has_key("foo")
		expect(result).never_has_key("bar")
		expect(result).never_has_key("qux")
		expect(result.fooModified).is(true)
		expect(result.barModified).is(true)
		expect(result.quxModified).is(true)
	end)

	test("pairs", function()
		local input = { foo = true, bar = true, qux = true }
		local result = map(input, function(key: string, value)
			return key .. "Modified", not value
		end)
		expect(result).never_is(input)
		expect(result).is_a("table")
		expect(result).never_has_key("foo")
		expect(result).never_has_key("bar")
		expect(result).never_has_key("qux")
		expect(result.fooModified).is(false)
		expect(result.barModified).is(false)
		expect(result.quxModified).is(false)
	end)
end
