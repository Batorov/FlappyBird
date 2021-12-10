PipesPair = {}
PipesPair.__index = PipesPair

function PipesPair:create(velocity, image1, image2)
    local pipes = {}
    setmetatable(pipes, PipesPair)
    pipes.velocity = velocity
    pipes.acceleration = Vector:create(0,0)
    pipes.width = 52
    pipes.height = 320
    pipes.distance = 150
    pipes.location = Vector:create(width, math.random(-2*pipes.height+height-pipes.distance, 0))
    pipes.image1 = image1
    pipes.image2 = image2
    pipes.isCounted = false
    return pipes
end

function PipesPair:applyForce(force)
    self.acceleration:add(force)
end

function PipesPair:collision(bird)
    local bottom = bird.location.y + bird.height < self.location.y
    local top = bird.location.y> self.location.y + self.height
    local left = bird.location.x > self.location.x + self.width
    local right = bird.location.x + bird.width < self.location.x

    local bottom2 = bird.location.y + bird.height < self.location.y+self.height+self.distance
    local top2 = bird.location.y> self.location.y+self.height+self.distance + self.height
    return not (bottom or top or left or right) or not (bottom2 or top2 or left or right)
end

function PipesPair:draw()
    --love.graphics.rectangle("line", self.location.x, self.location.y, self.width, self.height)
    love.graphics.draw(self.image2, self.location.x, self.location.y)
    love.graphics.draw(self.image1, self.location.x, self.location.y+self.height+self.distance)
end


function PipesPair:update()
    self.velocity = self.velocity+self.acceleration
    self.location = self.location+self.velocity
    self.acceleration:mul(0)
end

Pipes = {}
Pipes.__index = Pipes

function Pipes:create(velocity, image1, image2)
    local pipes = {}
    setmetatable(pipes, Pipes)
    pipes.pipes_pairs = {}
    pipes.image1 = image1
    pipes.image2 = image2
    pipes.velocity = velocity
    pipes.period = 0
    pipes.path = 0
    return pipes
end

function Pipes:applyForce(force)
    self.velocity = self.velocity+force
end

function Pipes:draw()
    for k, v in pairs(self.pipes_pairs) do
        v:draw()
    end
end

function Pipes:collision(bird)
    for k, v in pairs(self.pipes_pairs) do
        if v:collision(bird) then return true end
    end
    return false
end

function Pipes:score(bird)
    for k, v in pairs(self.pipes_pairs) do
        if v.location.x < bird.location.x and not v.isCounted then 
            score=score+1 
            v.isCounted = true
            point_audio:play()
        end
    end
end

function Pipes:update()
    for k, v in pairs(self.pipes_pairs) do
        v:update()
        v.velocity = self.velocity
        if v.location.x < -v.width then table.remove(self.pipes_pairs, k) end
    end
    self.path=self.path+1
    if self.path>self.period then
        table.insert(self.pipes_pairs, PipesPair:create(pipes.velocity, self.image1, self.image2))
        self.path=0
    end
    self.period = math.abs((width-50)/self.velocity.x)
end