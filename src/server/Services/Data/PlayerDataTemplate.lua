
type WeaponName = string

export type keybindType = {
	['PC' | 'Xbox'] : string,
}

export type WeaponType = {
	[WeaponName]: {
		Equipped: boolean,
		Count: number,
    },
}

export type InventoryType = {
    Weapons: WeaponType
}

export type DataType = {
	Coins: number,

	Keybinds: {
		MosueLock: keybindType,
		Punch: keybindType,
	},

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
		}
	},

	Inventory = {
		Weapons = {
			Fist = {
				Equipped = true,
				Count = 1,
			}
		}
	}
}