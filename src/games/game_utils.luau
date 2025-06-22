export type Game = {
	id: string,
	name: string,
	logo: string,
	kits: { Kit },
}

local function Game(x: Game)
	table.freeze(x.kits)
	return table.freeze(x)
end

export type Kit = {
	version: vector,
	thumbnail: string,
	client_objects_config_behavior: ClientObjectConfigurationBehavior,
	client_objects: { KitClientObject },
}

export type ClientObjectConfigurationBehavior = "attributes" | "configuration_attributes" | "value_objects"

local function Kit(x: Kit)
	table.freeze(x.client_objects)
	return table.freeze(x)
end

export type KitClientObject = {
	name: string,
	model: Instance,
}

local function KitClientObject(x: KitClientObject)
	return table.freeze(x)
end

return table.freeze({
	Game = Game,
	Kit = Kit,
	KitClientObject = KitClientObject,
})
