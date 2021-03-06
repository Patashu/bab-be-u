local scene = {}
game = require '../game/scene'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local scrollx = 0
local scrolly = 0

local buttonheight = height*0.05
local buttonwidth = width*0.375

local music_on = true

function scene.load()
  clear()
  playMusic("bab_be_u_them", 0.5)
  love.graphics.setBackgroundColor(0.10, 0.1, 0.11)
  local now = os.time(os.date("*t"))
  presence = {
    state = "main menu",
    details = "idling",
    largeImageKey = "titlescreen",
    largeimageText = "main menu",
    startTimestamp = now
  }
  nextPresenceUpdate = 0
  love.keyboard.setKeyRepeat(false)
end

function scene.draw(dt)
  local buttons = {"play", "editor", "exit"}
  local bgsprite = sprites["ui/menu_background"]

  -- no need to insult me, i know this is terrible code
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(bgsprite, scrollx%bgsprite:getWidth(), scrolly%bgsprite:getHeight(), 0)
  
  love.graphics.draw(bgsprite, scrollx%bgsprite:getWidth()-bgsprite:getWidth(), scrolly%bgsprite:getHeight()-bgsprite:getHeight(), 0)
  love.graphics.draw(bgsprite, scrollx%bgsprite:getWidth()-bgsprite:getWidth(), scrolly%bgsprite:getHeight(), 0)
  love.graphics.draw(bgsprite, scrollx%bgsprite:getWidth(), scrolly%bgsprite:getHeight()-bgsprite:getHeight(), 0)

  love.graphics.draw(bgsprite, scrollx%bgsprite:getWidth()+bgsprite:getWidth(), scrolly%bgsprite:getHeight()+bgsprite:getHeight(), 0)
  love.graphics.draw(bgsprite, scrollx%bgsprite:getWidth()+bgsprite:getWidth(), scrolly%bgsprite:getHeight(), 0)
  love.graphics.draw(bgsprite, scrollx%bgsprite:getWidth(), scrolly%bgsprite:getHeight()+bgsprite:getHeight(), 0)

  love.graphics.draw(bgsprite, scrollx%bgsprite:getWidth()+bgsprite:getWidth(), scrolly%bgsprite:getHeight()-bgsprite:getHeight(), 0)
  love.graphics.draw(bgsprite, scrollx%bgsprite:getWidth()-bgsprite:getWidth(), scrolly%bgsprite:getHeight()+bgsprite:getHeight(), 0)

  for i=1, #buttons do
    if mouseOverBox(width/2-buttonwidth/2, height/2-buttonheight/2+(buttonheight+10)*i, buttonwidth, buttonheight) then love.graphics.setColor(.9, .9, .9) end
    love.graphics.draw(sprites["ui/button_"..i%2+1], width/2-buttonwidth/2, height/2-buttonheight/2+(buttonheight+10)*i, 0, buttonwidth/sprites["ui/button_"..i%2+1]:getWidth(), buttonheight/sprites["ui/button_1"]:getHeight())

    love.graphics.setColor(1,1,1)
    love.graphics.printf(buttons[i], width/2-buttonwidth/2, height/2-buttonheight/2+(buttonheight+10)*i+5, buttonwidth, "center")
  end
  love.graphics.draw(sprites["ui/bab_be_u"], width/2 - sprites["ui/bab_be_u"]:getWidth() / 2, height/2 - sprites["ui/bab_be_u"]:getHeight() / 2 - 200)

  onstate = "on"
  if not settings["music_on"] then onstate = "off" end

  love.graphics.setColor(1, 1, 1)
  if mouseOverBox(10, height - sprites["ui/music-on"]:getHeight(), sprites["ui/music-on"]:getWidth(), sprites["ui/music-on"]:getHeight()) then
    love.graphics.setColor(0.8, 0.8, 0.8)
  end

  love.graphics.draw(sprites["ui/music-"..onstate], 10, height - sprites["ui/music-"..onstate]:getHeight() - 10)
  
  love.graphics.setColor(1, 1, 1)
  if mouseOverBox(20+sprites["ui/github"]:getWidth(), height-sprites["ui/github"]:getHeight() - 10, sprites["ui/github"]:getWidth(), sprites["ui/github"]:getHeight()) then
    love.graphics.setColor(0.8, 0.8, 0.8)
  end

  love.graphics.draw(sprites["ui/github"], 20+sprites["ui/github"]:getWidth(), height-sprites["ui/github"]:getHeight() - 10)
end

function scene.update()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  buttonheight = height*0.05
  buttonwidth = width*0.375

  local mousex, mousey = love.mouse.getPosition()

  scrollx = scrollx+0.1
  scrolly = scrolly+0.1

  if mouseOverBox(width/2-buttonwidth/2, height/2-buttonheight/2+(buttonheight+10)*3, buttonwidth, buttonheight) then 
    love.mouse.setPosition(mousex, mousey-(buttonheight+10)) 
  end
end

function scene.mousepressed(x, y, button)
  if mouseOverBox(10, height - sprites["ui/music-on"]:getHeight(), sprites["ui/music-on"]:getWidth(), sprites["ui/music-on"]:getHeight()) and button == 1 then
    settings["music_on"] = not settings["music_on"]
    saveAll()
  end

  if mouseOverBox(20+sprites["ui/github"]:getWidth(), height-sprites["ui/github"]:getHeight() - 10, sprites["ui/github"]:getWidth(), sprites["ui/github"]:getHeight()) and button == 1 then
    love.system.openURL("https://github.com/lilybeevee/bab-be-u")
  end
end

return scene