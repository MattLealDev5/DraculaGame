if !active { exit; }

x += bulletSpeed*facing

var bX = x, bY = y

var enemy = instance_place(x, y, oEnemy)
if enemy != noone {
	enemy.hp -= damage
	player.returnBullet(id)
} else if x < camera.cameraX || x > camera.cameraX+camera.view_width || 
		  y < camera.cameraY || y > camera.cameraY+camera.view_height {
	player.returnBullet(id)
}