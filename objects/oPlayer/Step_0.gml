if !alive { exit; }


state()

if hurtInvincibility <= 0 {
	var enemy = instance_place(x, y, oEnemy)
	if enemy != noone {
		takeDamage(enemy.damage)
	}
} else { hurtInvincibility-- }