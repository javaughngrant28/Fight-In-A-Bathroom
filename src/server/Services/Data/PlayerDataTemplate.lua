
type WeaponName = string
type IsEquipped = boolean

export type keybindType = {
	['PC' | 'Xbox'] : string,
}

export type keybindInterface = {
	MosueLock: keybindType,
	Punch: keybindType,
	Block: keybindType,
	Kick: keybindType,
	WeaveLeft: keybindType,
	WeaveRight: keybindType,
	Grab: keybindType,
}

export type WeaponType = {
	[WeaponName]: IsEquipped,
}

export type InventoryType = {
    Weapons: WeaponType
}

export type DataType = {
	Coins: number,

	Keybinds: keybindInterface,
	Inventory: InventoryType,
}

return {
	Coins = 10,

	Keybinds = {
		MosueLock = {
			Xbox = 'L1',
		},

		Punch = {
			PC = 'M1',
			Xbox = 'L2',
		},

		Kick = {
			PC = 'R',
			Xbox = 'L2',
		},

		Block = {
			PC = 'F',
			Xbox = 'L2',
		},

		WeaveRight = {
			PC = 'E',
			Xbox = 'L2',
		},

		WeaveLeft = {
			PC = 'Q',
			Xbox = 'L2',
		},

		Grab = {
			PC = 'G',
			Xbox = 'L2',
		},
	},

	Inventory = {
		Weapons = {
			Fist = true,
		}
	}
}