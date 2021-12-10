HelloPage = {}
HelloPage.__index = HelloPage

function HelloPage:create()
	local page = {}
    setmetatable(page, HelloPage)
    return page
end

function HelloPage:draw()

	mess = love.graphics.newImage("assets/sprites/message.png")
	bg = love.graphics.newImage("assets/sprites/background-day.png")
	love.graphics.draw(bg, 0, 0)
	love.graphics.draw(mess, 50, 100)
end

function HelloPage:update()
end

function HelloPage:mousepressed(x, y, key, istouch)
	if key == 1 then
        Page="game_page"
    end
end

function HelloPage:keypressed(key)
	if key == 'space' then
        Page="game_page"
    end
end