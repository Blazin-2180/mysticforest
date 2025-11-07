class_name EquipableItemData extends ItemData

enum Type { HEAD, SHOULDERS, NECK, BACK, HANDS, CHEST, RING1, LEGS, RING2, MAINHAND, FEET, OFFHAND }

@export var type : Type = Type.MAINHAND
@export var modifiers : Array[ EqiupableItemModifier ]
@export var sprite_texture : Texture
