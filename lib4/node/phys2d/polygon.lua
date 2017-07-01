
--[[ node/phys2d/polygon.lua
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

local node = require('lib4/node')

local polygon = {}
setmetatable(polygon, {
    __index = node,
    __call = polygon.new,
})

local mt = {__index = polygon}

-- Create a new polygon
function polygon.new(shape, children, script)
    local self = node.new(children, script)
    setmetatable(self, mt)

    self.t = "phys2d/polygon"
    self.shape = shape

    return self
end

function polygon:intersects(other)
    return phys.intersects(self, other)
end

return polygon
