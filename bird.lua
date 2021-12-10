Bird = {}
Bird.__index = Bird

function Bird:create(location, velocity, weight, image)
    local bird = {}
    setmetatable(bird, Bird)
    bird.location=location
    bird.velocity = velocity
    bird.acceleration = Vector:create(0,0)
    bird.width = 34
    bird.height = 24
    bird.weight = weight or 1
    bird.image = love.graphics.newImage(image)
    return bird
end

function Bird:applyForce(force)
    self.acceleration:add(force/self.weight)
end

function Bird:jump()
    self.velocity.y = -3.5
end

function Bird:checkBoundaries()
    if self.location.y > height or self.location.y < -self.height then 
        return true
    end
    return false
end

function Bird:draw()
    --love.graphics.rectangle("line", self.location.x, self.location.y, self.width, self.height)
    love.graphics.draw(self.image, self.location.x, self.location.y)
end


function Bird:update()
    self.velocity = self.velocity+self.acceleration
    self.location = self.location+self.velocity
    self.acceleration:mul(0)
end

