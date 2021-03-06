
--[[ node/gui/textfield.lua
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

local element = require('lib4/node/gui/element')
local textfield = {}
local mt = {__index = textfield}

function textfield.new(opts, children)
    local self = element.new(opts, children)
    setmetatable(self, mt)

    self.t = 'gui/textfield'

    opts = opts or {}
    self.text = opts.text or ''

    return self
end

function textfield:draw()
    element.draw(self)

    if self.focus then
        love.graphics.printf(self.text .. '|', 0, 0, self.width, self.align)
    else
        love.graphics.printf(self.text, 0, 0, self.width, self.align)
    end
end

function textfield:textinput(text)
    if self.focus then
        self.text = self.text .. text
    end
end

function textfield:keypressed(key, scancode, isrepeat)
    if key == 'backspace' then
        e.text = string.sub(e.text, 1, #e.text-1)
    elseif key == 'return' then
        e.text = e.text .. '\n'
    elseif key == 'escape' or scancode == 'acback' then
        love.keyboard.setTextInput(false)
    end
end

setmetatable(textfield, {
    __index = element,
    __call = function(_, ...) return textfield.new(...) end 
})

return textfield
