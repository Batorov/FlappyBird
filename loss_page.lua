LossPage = {}
LossPage.__index = LossPage

function LossPage:create()
	local page = {}
    setmetatable(page, LossPage)
    go_image = love.graphics.newImage("assets/sprites/gameover.png")
    return page
end

function LossPage:draw()
	game_page:draw(true)
	love.graphics.draw(go_image, 50, 200)
end

function LossPage:update()
end

function LossPage:keypressed(key)
	if key == 'space' then
        Page="game_page"
        game_page:restart()
    end
end

function LossPage:mousepressed(x, y, key, istouch)
    if key == 1 then
        Page="game_page"
        game_page:restart()
    end
end