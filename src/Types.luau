local Epoch = script:FindFirstAncestor("Epoch")
local Vide = require(Epoch.Packages.Vide)

export type ReadAs<T> = T | () -> T

export type Child = ReadAs<Instance> | { Child }

export type UnpackableProps = { Child }

export type ProjectType =
	--- Eternal Towers of Hell version 6
	| "EternalTowersOfHellv6"
	--- Eternal Towers of Hell version 5
	| "EternalTowersOfHellv5"
	--- Obren's Towers of Hell version 0
	| "ObrensTowersOfHellv0"
	--- Welcome To Hell version 1
	| "WelcomeToHellv1"

export type Pack<T> = { [number]: T, n: number }

return nil
