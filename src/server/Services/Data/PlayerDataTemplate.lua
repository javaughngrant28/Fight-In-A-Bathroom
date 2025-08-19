

export type keybindType = {
	['PC' | 'Xbox'] : string,
}

export type DataType = {
	Coins: number,
	Wins: number,

	Keybinds: {
		MosueLock: keybindType,
		Punch: keybindType,
	},
}

return {
	Wins = 0,
	Coins = 10,

	Keybinds = {
		MosueLock = {
			Xbox = 'L1',
		},

		Punch = {
			PC = 'M1',
			Xbox = 'L2',
		}
	}
}