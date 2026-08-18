spawnTimer--
if spawnTimer <= 0 {
	spawnTimer = spawnTimerSet
	
	var xPos = camera.cameraX + camera.view_width + 32
	var yPos = camera.cameraY + player.y
	instance_create_layer(xPos, yPos, "Instances", sinWaveIndex)
}