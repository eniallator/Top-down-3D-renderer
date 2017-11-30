local calculateDraw = {}

local function getValues(objName, objPos, texture)
  local img = texture[objName]

  local scaleFactor = {
    top = 2 + zOffset / 0.255,
    sides = 2 + zOffset / 60
  }

  local dim = {
    x = img.top:getWidth() * scaleFactor.top,
    y = img.top:getHeight() * scaleFactor.top
  }

  local scaledPos = {
    x = (2 + zOffset / 0.5 - 1) * objPos.x,
    y = (2 + zOffset / 0.5 - 1) * objPos.y
  }

  local offset = {
    x = (scaledPos.x + dim.x / 2 - (screenDim.x / 2 - translation.x)) * -1,
    y = (scaledPos.y + dim.y / 2 - (screenDim.y / 2 - translation.y)) * -1
  }

  local point = {
    x = offset.x / (16 / scaleFactor.sides),
    y = offset.y / (16 / scaleFactor.sides)
  }

  local shear = {
    vert = (point.x / dim.x),
    hori = (point.y / dim.y)
  }

  local imgFace = {
    vert = offset.y > 0 and "south" or "north",
    hori = offset.x > 0 and "east" or "west"
  }

  return scaledPos, scaleFactor, imgFace, point, shear, dim
end

calculateDraw.generateTextures = function(objName, objPos, texture)
  local textures = {}
  local scaledPos, scaleFactor, imgFace, point, shear, dim = getValues(objName, objPos, texture)
  local img = texture[objName]

  textures.top = {
    img = img.top,
    x = scaledPos.x,
    y = scaledPos.y,
    sx = scaleFactor.top,
    sy = scaleFactor.top
  }

  textures.vertical = {
    img = img.side,
    x = scaledPos.x,
    y = imgFace.vert == "south" and scaledPos.y + dim.y or scaledPos.y,
    sx = scaleFactor.top,
    sy = point.y / img.side:getHeight(),
    kx = shear.vert
  }

  textures.horizontal = {
    img = img.side,
    x = imgFace.hori == "east" and scaledPos.x + dim.x or scaledPos.x,
    y = scaledPos.y,
    r = math.pi / 2,
    sx = scaleFactor.top,
    sy = (-1 * point.x) / img.side:getWidth(),
    kx = shear.hori
  }

  return textures
end



return calculateDraw
