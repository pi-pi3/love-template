
--[[ node/box2d/fixture.lua
    Copyright (c) 2017 Szymon "pi_pi3" Walter

    This software is provided 'as-is', without any express or implied
    warranty. In no event will the authors be held liable for any damages
    arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented you must not
    claim that you wrote the original software. If you use this software
    in a product, an acknowledgment in the product documentation would be
    appreciated but is not required.

    2. Altered source versions must be plainly marked as such, and must not be
    misrepresented as being the original software.

    3. This notice may not be removed or altered from any source
    distribution.
]]

local cpml = require('cpml')
local node = require('lib4/node')

local fixture = {}
local mt = {__index = fixture}

-- Create a new fixture
function fixture.new(params, children)
    local self = node.new(children)
    setmetatable(self, mt)

    self.t = "box2d/fixture"

    self.fixture = nil
    self.shape = nil
    self.params = params or {}

    return self
end

function fixture:clone()
    local new = node.clone(self)
    new.fixture = nil
    new.shape = nil
    return new
end

function fixture:set_params(params)
    if not params then params = self.params end
    for k, v in pairs(params) do
        self.params[k] = v
    end

    if not self.fixture then
        return
    end

    if params.sensor then self.fixture:setSensor(params.sensor) end
    if params.friction then self.fixture:setFriction(params.friction) end
    if params.restitution then
        self.fixture:setRestitution(params.restitution)
    end
    if params.mask then self.fixture:setMask(unpack(params.mask)) end
    if params.category then
        self.fixture:setCategory(unpack(params.category))
    end
end

function fixture:make_fixture(body, shape)
    self.fixture = love.physics.newFixture(body.body, shape.shape)
    self:set_params()
end

function fixture:destroy()
    if not self.fixture:isDestroyed() then self.fixture:destroy() end
end

setmetatable(fixture, {
    __index = node,
    __call = function(_, ...) return fixture.new(...) end ,
})

return fixture
