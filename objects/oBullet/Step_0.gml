if !active { exit; }

x += bulletSpeed*facing

var bX = x, bY = y
if x < camera.cameraX || x > camera.cameraX+camera.view_width || 
y < camera.cameraY || y > camera.cameraY+camera.view_height {
	player.returnBullet(id)
}