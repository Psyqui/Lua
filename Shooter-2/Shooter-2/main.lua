-- Move over this program to multi-file format for.
-- Display score and lives.
-- adjust enemy spawns
-- make aditional enemy types that will hover above and shoot bullets at the player 
-- heat seeking missiles
-- Boss battle.
-- 

debug = true

math.randomseed(os.time()) -- generates the time of operation system 

player = { x = 200, y = 710, speed = 150, img = nil }
enemy = {x =0, y=0, speed = 150, img = nil}
bullet = {img = nil}


-- local playerDead = false
-- Timers
-- We declare these here so we don't have to edit them multiple places
canShoot = true
canShootTimerMax = 0.2 
canShootTimer = canShootTimerMax
enemyDead = false
-- Image Storage
bulletImg = nil


-- Entity Storage
bullets = {} -- array of current bullets being drawn and updated

-- Loading
function love.load(arg)


	player.img = love.graphics.newImage('assets/plane.png')
	bulletImg = love.graphics.newImage('assets/bullet.png')
	enemy.img = love.graphics.newImage('assets/enemy.png')
	bullet.img = love.graphics.newImage('assets/bullet.png')

	enemy.width = enemy.img:getWidth()
	enemy.height = enemy.img:getHeight()
	bullet.width = bullet.img:getWidth()
	bullet.height = bullet.img:getHeight()

	
	enemies = {}

	for i=1, 20 do
		table.insert(enemies,
			{
				x = love.math.random(0,440),
				y = love.math.random(-500, -10),
				speed = 150,
				img = love.graphics.newImage("assets/enemy.png")
			}
		)
	
	end
end

-- Updating
function love.update(dt)
	for i, enemy in ipairs(enemies) do
		enemy.y = enemy.y + (150 * dt)
		if enemy.y > 840 then
			table.remove(enemies, i)
		end
	end
	-- I always start with an easy way to exit the game
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	-- Time out how far apart our shots can be.
	canShootTimer = canShootTimer - (1 * dt)
	if canShootTimer < 0 then
		canShoot = true
	end

	-- update the positions of bullets
	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - (250 * dt)

		bullet.checkCollision(enemies)

		if bullet.y < 0 then -- remove bullets when they pass off the screen
			table.remove(bullets, i)
		end
	end

	if love.keyboard.isDown('space', 'rctrl', 'lctrl', 'ctrl') and canShoot then
		-- Create some bullets
		newBullet = { x = player.x + (player.img:getWidth()/2), y = player.y, img = bulletImg }
		table.insert(bullets, newBullet)
		canShoot = false
		canShootTimer = canShootTimerMax
		
	end

	if love.keyboard.isDown('left','a') then
		if player.x > 0 then -- binds us to the map
			player.x = player.x - (player.speed*dt)
		end
	elseif love.keyboard.isDown('right','d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed*dt)
		end
	end
end

-- Drawing
function love.draw(dt)
	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end
	for i, enemy in ipairs(enemies) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end
	love.graphics.draw(player.img, player.x, player.y)
end

function checkCollision(bullets, enemy)
	local enemy_bottom_left = enemy.x
	local enemy_bottom_right = enemy_bottom.x + enemy_bottom.width
	local enemy_bottom_top = enemy_bottom.y
	local enemy_bottom = enemy_bottom.y + enemy_bottom.height
  
	local bullet_left = bullet.x
	local bullet_right = bullet.x + bullet.width
	local bullet_top = bullet.y
	local bullet_bottom = bullet.y + bullet.height
  
	if enemy_bottom_right > obj_left and
	enemy_bottom_left < obj_right and
	enemy_bottom_bottom > obj_top and
	enemy_bottom_top < obj_bottom then
		  enemy_bottom.enemyDead = true
  
		  --Increase enemy speed
		  if enemy_bottom.enemyDead == true then
			 table.remove(enemy)
		  end 
	  end
  end 

