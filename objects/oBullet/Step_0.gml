if !active { exit; }

x += bulletSpeed*facing

var bX = x, bY = y
if x < camera.x || x > camera.x+camera.view_width || 
y < camera.y || y > camera.y+camera.view_height {
	player.returnBullet(id)
}