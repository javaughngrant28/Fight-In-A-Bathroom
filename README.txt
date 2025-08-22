Fight In The Bathroom Combat System.

Inventory: {
    Weapons: {
        weaponName: {
            Equipped: boolean,
            Count: number,
        },
    },
}

--------------------------

WeaponData: {
    WeaponName: {
        Type: string,
        Stackable: boolean,
        Cost: number,
        Model: Model?,
        CustomAnimations: {
            AttackAnimations: {Animation}?
            Weave: {
                LeftWeave: Animation,
                RightWave: Animation,
            }?
            Walk: Animation,
            Equip: Animation,
            Idle: Animation,
            Block: Animation,
            Grab: Animation,
        }

    }
}

-----------------------------

[IndventoryService]

MAX_EQUIP_AMOUNT: number

InventoryState: {
    [Player]: {
        EquippedCount: number,
        
        Items: Inventory,

    }
}

- Listen For When Players To Join
- Populate InventoryState
- Remove Weapons If They Go Over The Max Amount

- Create Equipped Weapons
    - Fire To Weapon Service

-------------
[WeaponService]

- Get WeaponData
- Create Tool
- Create Weapon Class Baste On Type


------------
[WeaponConfig] < Has Cooldowns Based On Weapon Types>
---

[Weapon Class]

- 