debug = true

math.randomseed(os.time()) -- generates the time of operation system 

player = { x = 200, y = 710, speed = 150, img = nil }
enemy = {x =0, y=0, speed = 150, img = nil}


-- Timers
-- We declare these here so we don't have to edit them multiple places
canShoot = true
canShootTimerMax = 0.2 
canShootTimer = canShootTimerMax

-- Image Storage
bulletImg = nil


-- Entity Storage
bullets = {} -- array of current bullets being drawn and updated

-- Loading
function love.load(arg)
	player.img = love.graphics.newImage('assets/plane.png')
	bulletImg = love.graphics.newImage('assets/bullet.png')
	enemy.img = love.graphics.newImage('assets/enemy.png')
	
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

		if bullet.y < 0 then -- remove bullets when they pass off the screen
			table.remove(bullets, i)
		end
	end

	if love.keyboard.isDown(' ', 'rctrl', 'lctrl', 'ctrl') and canShoot then
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


