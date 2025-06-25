local function childExistsInPath(child: Instance, root: Instance, path: { string }): (boolean, Instance)
	for index = 1, #path do
		if root:FindFirstChild(child.Name) then
			return true, root
		end

		local nextName = path[#path]
		local next = root:FindFirstChild(nextName)
		root = next or error(`{root:GetFullName()} does not have child named {nextName}`)
	end

	return false, root
end

return childExistsInPath
