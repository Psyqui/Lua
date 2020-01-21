-- 1-18-2020 - Designing a Main Menu system
-- This code is supposed to display buttons for the user to click on
-- It does not work correctly. The buttons will display but only briefly
-- Done using the love engine version 0.10.2 

BUTTON_HEIGHT = 64


local 
function newButton(text, fn)
    return {text = text;fn = fn}
    
end

local buttons = {}
local font = nil

function love.load()
  -- load font
  font = love.graphics.newFont(32)
  --love.graphics.newFont(20)
  
  table.insert(buttons, newButton(
    "Start Game",
    function()
      print("Starting Game")
    end))

  table.insert(buttons, newButton(
    "Load Game",
    function()
      print("Loading Game")
    end))

  table.insert(buttons, newButton(
    "Settings",
    function()
      print("Going to Settings Menu")
    end))

  table.insert(buttons, newButton(
    "Exit",
    function()
      love.event.quit(0)
    end))
    
end

function love.update(dt)
end

function love.draw()
  love.graphics.clear()
  love.graphics.setFont(font)
  
  -- draw menu in middle of screen
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local button_width = ww * (1/3)
  local margin = 16

  local total_height = (BUTTON_HEIGHT + margin) * #buttons
  local cursor_y = 0

  for i , button in ipairs(buttons) do 
    local bx = (ww * 0.5) - (button_width * 0.5)
    local by = (wh * 0.5) - (total_height * 0.5) + cursor_y
    love.graphics.rectangle(
      "fill",
      bx,
      by,
      button_width,
      BUTTON_HEIGHT
    )

      -- text color black
    love.graphics.setColor(0,0,0)

    local textW = font:getWidth(button.text)
    local textH = font:getHeight(button.text)

    
    love.graphics.print(
      button.text,
      (ww * 0.5) - textW * 0.5,
      by + textH * 0.5
    )
    
    cursor_y = cursor_y + (BUTTON_HEIGHT + margin)
  end
end
