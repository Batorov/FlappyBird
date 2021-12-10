GamePage = {}
GamePage.__index = GamePage

function GamePage:create()
    local page = {}
    setmetatable(page, GamePage)
    score = 0
	bird = Bird:create(Vector:create(10, height/2-10), Vector:create(0,0), 1, "assets/sprites/bluebird-midflap.png")
    gravity=Vector:create(0, 0.1)
    pipes_acceleration = Vector:create(-0.0005, 0)
    pipe_image1 = love.graphics.newImage("assets/sprites/pipe-green.png")
    pipe_image2 = love.graphics.newImage("assets/sprites/pipe-green2.png")
    base_image = love.graphics.newImage("assets/sprites/base.png")
    wing_audio = love.audio.newSource("assets/audio/wing.ogg", "static")
    die_audio = love.audio.newSource("assets/audio/die.ogg", "static")
    point_audio = love.audio.newSource("assets/audio/point.ogg", "static")
    pipes = Pipes:create(Vector:create(-1, 0), pipe_image1, pipe_image2)
    return page
end

function GamePage:restart()
	bird = Bird:create(Vector:create(10, height/2-10), Vector:create(0,0), 1, "assets/sprites/bluebird-midflap.png")
    pipes = Pipes:create(Vector:create(-1, 0), pipe_image1, pipe_image2)
    score = 0
end

function GamePage:draw(gover)
    love.graphics.draw(bg, 0, 0)
    love.graphics.draw(base_image, 0, height-80)
    pipes:draw()
	bird:draw()
    if not gover then 
        love.graphics.setFont(sFont)
        love.graphics.print(score, 10, 10)
    else
        love.graphics.setFont(mainFont)
        love.graphics.print(score, 130, 270)
    end
end

function GamePage:update()
	bird:applyForce(gravity)
    bird:update()
    pipes:applyForce(pipes_acceleration)
    pipes:update()
    pipes:score(bird)
    if pipes:collision(bird) or bird:checkBoundaries() then 
        Page="loss_page"
        die_audio:play() 
    end
end

function GamePage:keypressed(key)
	if key == 'space' then
        bird:jump()
        wing_audio:play()
    end
end

function GamePage:mousepressed(x, y, key, istouch)
    if key == 1 then
        bird:jump()
        wing_audio:play()
    end
end