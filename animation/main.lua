function love.load()
  image = love.graphics.newImage("assets/explosion1.png")
  local width = image:getWidth()
  local height = image:getHeight()

  frames = {}
  
  local frame_width = 125
  local frame_height = 125
  
  for i=0,19 do
    table.insert(frames, love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, width, height))
  end

  currentFrame = 1
end

function update(dt)
  currentFrame = currentFrame + dt
  if currentFame >= 21 then
    currentFame = 1
  end

end

function love.draw()
  --love.graphics.draw(frames[math.floor(currentFrame)])
  love.graphics.draw(image, frames[math.floor(currentFrame)], 100, 100)
end