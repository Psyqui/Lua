--! file: main.lua
-- include the other file by passing filename as require() argument
function love.load()
  -- load player file
  Object = require "classic"
  require "player"
  require "enemy"
  require "bullet"

  player = Player()
  enemy = Enemy()
  bullets = {}

end

function love.update(dt)
  player:update(dt)
  enemy:update(dt)

  for i, v in ipairs(bullets) do
    v:update(dt)
    -- checks for bullet collision with enemy
    v:checkCollision(enemy)
    -- if bullet has dead it removes from list
    if v.dead then
      table.remove(bullets, i)
    end 
   
    
  end
end

function love.draw()
  player:draw()
  enemy:draw()

  for i, v in ipairs(bullets) do 
    v:draw()
  end 

end

function love.keypressed(key)
  player:keyPressed(key)
end
