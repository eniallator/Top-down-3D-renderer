function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  translation = {x = 0, y = 0}
  zOffset = 0
  screenDim = {}
  screenDim.x, screenDim.y = love.graphics.getDimensions()

  render = require "lib/render"

  objList = {
    {
      name = "crate",
      pos = {x = 10, y = 10}
    },
    {
      name = "crate",
      pos = {x = 500, y = 10}
    },
    {
      name = "crate",
      pos = {x = 100, y = 400}
    },
    {
      name = "crate",
      pos = {x = 600, y = 400}
    }
  }
end

function love.update()
  if love.keyboard.isDown("left") then
    translation.x = translation.x + 5
  end

  if love.keyboard.isDown("right") then
    translation.x = translation.x - 5
  end

  if love.keyboard.isDown("up") then
    translation.y = translation.y + 5
  end

  if love.keyboard.isDown("down") then
    translation.y = translation.y - 5
  end

  if love.keyboard.isDown("i") then
    zOffset = zOffset + 0.02
  end

  if love.keyboard.isDown("o") then
    zOffset = zOffset - 0.02
  end

  local isDown = love.mouse.isDown(1)

  clicked = not held and isDown
  held = isDown
  mouseCoords = {love.mouse.getPosition()}

  if clicked then
    table.insert(objList, {
      name = "crate",
      pos = {
        x = mouseCoords[1] - translation.x,
        y = mouseCoords[2] - translation.y
      }
    })
  end
end

function love.draw()
  love.graphics.translate(translation.x, translation.y)
  render.grid()
end
