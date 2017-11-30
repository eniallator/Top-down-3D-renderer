local sort = {}

local function getDistFromCenter(texture)
  for i=1, #objList do
    local objName = objList[i].name

    local screenCenter = {
      x = screenDim.x / 2 - translation.x,
      y = screenDim.y / 2 - translation.y
    }

    local objCenter = {
      x = objList[i].pos.x + texture[objName].top:getWidth() / 2,
      y = objList[i].pos.y + texture[objName].top:getHeight() / 2
    }

    objList[i].distFromCenter = math.sqrt((screenCenter.x - objCenter.x) ^ 2 + (screenCenter.y - objCenter.y) ^ 2)
  end
end

local function getMaxLeft(index)
  local max = 0

  for i=1, index do
    max = objList[i].distFromCenter > max and objList[i].distFromCenter or max
  end

  return max
end

local function insertionSort()
  for i=1, #objList do
    while i > 1 and getMaxLeft(i) > objList[i].distFromCenter do
      objList[i], objList[i - 1] = objList[i - 1], objList[i]
      i = i - 1
    end
  end
end

local function reverseObjList()
  local reversedTbl = {}

  for i=#objList, 1, -1 do
    table.insert(reversedTbl, objList[i])
  end

  objList = reversedTbl
end

sort.table = function(texture)
  getDistFromCenter(texture)
  insertionSort()
  reverseObjList()
end

return sort
