animCont = AnimationController(sPlayer)
mask_index = mskPlayer
tileMapID = layer_tilemap_get_id("Blocks");

hp = 30
damage = 10

takeDamage = function(dmg) {
	hp -= dmg
	if hp <= 0 {
		die()
	}
}
die = function() {
	instance_destroy()
}

walkSpeed = 0
facing = -1