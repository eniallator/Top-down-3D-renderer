local calculateDraw = require "lib/calculateDraw"
local sort = require "lib/sort"

local render = {}

local texture = {
  crate = {
    top = love.graphics.newImage("assets/crate_top.png"),
    side = love.graphics.newImage("assets/crate_side.png")
  }
}

local function renderObj(objName, objPos)
  local textures = calculateDraw.generateTextures(objName, objPos, texture)

  for name, face in pairs(textures) do
    local imgDim = {
      w = face.img:getWidth(),
      h = face.img:getHeight()
    }

    if name ~= "top" then
      for i=imgDim.w, 1, -1 do
        local quad = love.graphics.newQuad(i, 1, 1, imgDim.h, imgDim.w, imgDim.h)
        local currShear = math.abs(face.kx)

        if face.kx > 0 then
          currShear = currShear + (face.kx / 80) * (imgDim.w - i + 1)

        else
          currShear = currShear - (-face.kx / 80) * (i - 1) * -1
        end

        love.graphics.draw(
          face.img, quad,
          name == "vertical" and face.x + (i - 1) * face.sx or face.x,
          name == "horizontal" and face.y + (i - 1) * face.sx or face.y,
          face.r or 0,
          face.sx, face.sy,
          0, 0,
          face.kx < 0 and currShear * -1 or currShear
        )
      end

    else
      love.graphics.draw(face.img, face.x, face.y, 0, face.sx, face.sy)
    end
  end
end

render.grid = function()
  sort.table(texture)

  for i=1,#objList do
    if objList[i].name == "crate" then
      renderObj(objList[i].name, objList[i].pos)
    end
  end
end

return render
