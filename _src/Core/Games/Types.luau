export type Game = {
	id: string,
	name: string,
	logo: string,
	kits: { Kit },
}

local function Game(x: Game)
	return table.freeze(x)
end

export type Kit = {
	version: vector,
	thumbnail: string,

	insertKit: (self: Kit, parent: Instance) -> Instance | { Instance },
	insertClientObject: (self: Kit, kit: Instance, clientObject: Instance, positionTo: CFrame) -> (),

	clientObjects: { KitClientObject },
}

local function Kit(x: Kit)
	return table.freeze(x)
end

export type KitClientObject = {
	name: string,
	model: Instance,
	properties: {
		[string]: KitClientObjectProperty,
	}?,
}

local function KitClientObject(x: KitClientObject)
	return table.freeze(x)
end

export type KitClientObjectProperty = {
	desc: string,
}

local function KitClientObjectProperty(x: KitClientObjectProperty)
	return table.freeze(x)
end

return table.freeze({
	Game = Game,
	Kit = Kit,
	KitClientObject = KitClientObject,
	KitClientObjectProperty = KitClientObjectProperty,
})
