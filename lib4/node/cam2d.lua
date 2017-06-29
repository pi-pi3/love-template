
--[[ node/cam2d.lua
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
local node = require('node')

local cam2d = {}
setmetatable(cam2d, {
    __index = node,
    __call = cam2d.new,
})

local mt = {__index = cam2d}

-- Create a new cam2d
function cam2d.new(children, script)
    local self = node.new(children, script)
    setmetatable(self, mt)

    self.t = "cam2d"

    self.origin = cpml.vec2()
    self.position = cpml.vec2()
    self.rotation = 0

    return self
end

function cam2d:signal(s, ...)
    if s == 'draw' then
        love.graphics.push()

        local pos = -self.position 
        local rot = -self.rotation
        local origin = pos - self.origin

        love.graphics.translate(origin.x, origin.y)
        love.graphics.rotate(rot)
        love.graphics.translate(-origin.x, -origin.y)
        love.graphics.translate(pos.x, pos.y)

        node.signal(self, s, ...)

        love.graphics.pop()
    else
        node.signal(self, s, ...)
    end
end

return cam2d
