require("vector")
require("bird")
require("pipes")
require("hello_page")
require("game_page")
require("loss_page")

function love.load()
	  width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    mainFont = love.graphics.newFont("fontick.otf", 40);
    sFont = love.graphics.newFont("fontick.otf", 20);
    love.graphics.setFont(mainFont);

    Page = "hello_page"
    hello_page = HelloPage:create()
    game_page = GamePage:create()
    loss_page = LossPage:create()
end

function love.draw()
   if Page == "hello_page" then
   		hello_page:draw()
   elseif Page == "game_page" then
   		game_page:draw(false)
   elseif Page == "loss_page" then
   		loss_page:draw()
   end	
end

function love.update()
   if Page == "hello_page" then
   		hello_page:update()
   elseif Page == "game_page" then
   		game_page:update()
   elseif Page == "loss_page" then
   		loss_page:update()
   end	
end

function love.mousepressed(x, y, key)
    if Page == "hello_page" then
    	hello_page:mousepressed(x, y, key)
    elseif Page == "game_page" then
    	game_page:mousepressed(x, y, key) 
    elseif Page == "loss_page" then
   		loss_page:mousepressed(x, y, key)
    end
end

function love.keypressed(key)
    if Page == "hello_page" then
      hello_page:keypressed(key)
    elseif Page == "game_page" then
      game_page:keypressed(key) 
    elseif Page == "loss_page" then
      loss_page:keypressed(key)
    end
end