-- General types

export type Pack<T> = { [number]: T, n: number }

-- Vide types

export type ReadAs<T> = T | () -> T

export type Child = ReadAs<Instance> | { Child }

export type UnpackableProps = { Child }

export type LayoutProps = {
	position: ReadAs<UDim2>?,
	anchorPoint: ReadAs<Vector2>?,
	automaticSize: ReadAs<Enum.AutomaticSize>?,
	size: ReadAs<UDim2>?,
	layoutOrder: ReadAs<number>?,
	zIndex: ReadAs<number>?,
	visible: ReadAs<boolean>?,
}

-- User project types

export type ProjectType =
	--- Eternal Towers of Hell version 6
	| "etohv6"
	--- Eternal Towers of Hell version 5
	| "etohv5"
	--- Obren's Towers of Hell version 0
	| "obrenv0"
	--- Welcome To Hell version 1
	| "wthv1"

return nil
