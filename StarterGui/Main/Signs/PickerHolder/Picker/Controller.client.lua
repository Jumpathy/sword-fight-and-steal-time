--- Services ---
local Players = game:GetService("Players")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")

--- Declarations ---
local ColorPicker = script.Parent
local Picker = ColorPicker;

local FillIn = Picker:WaitForChild("FillIn")
local Values = FillIn:WaitForChild("Values")

local RGB = Values:WaitForChild("RGB")

local Hex = FillIn:WaitForChild("Hex")

local Display = Picker:WaitForChild("Display")
local CurrentDisplay = Display:WaitForChild("Current")

local Gradient = Picker:WaitForChild("Gradient")
local Cursor = Gradient:WaitForChild("Cursor")

--- Player ---
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

--- Objects ---
local HexadecimalValues = {
	-- Decimal to Hex
	[10] = "A",
	[11] = "B",
	[12] = "C",
	[13] = "D",
	[14] = "E",
	[15] = "F",
}

--- Data ---
local Down = false

--- Definitions ---
local Abs = math.abs
local Clamp = math.clamp
local Floor = math.floor

local Tonumber = tonumber

--- Functions ---
local function UpdateCursorPosition(h, s)
	local gradientSize = Gradient.AbsoluteSize
	local sizeScale = 360 / gradientSize.X
	Cursor.Position = UDim2.new(0, gradientSize.X - (h * 360) / sizeScale, 0, gradientSize.Y - (s * 360) / sizeScale)
end

local function InBounds()
	local mousePosition = Vector2.new(Mouse.X, Mouse.Y)
	local gradientPosition = Gradient.AbsolutePosition
	local gradientSize = Gradient.AbsoluteSize

	return (mousePosition.X < (gradientPosition.X + gradientSize.X) and mousePosition.X > gradientPosition.X) and (mousePosition.Y < (gradientPosition.Y + gradientSize.Y) and mousePosition.Y > gradientPosition.Y)
end

local function HexToDecimal(hex)
	return Tonumber(hex, 16)
end

local function DecimalToHex(decimal)
	local hex = ""
	local integer, remainder
	
	while true do
		integer = math.modf(decimal / 16)
		remainder = decimal % 16
		decimal = integer
		
		hex = hex .. (HexadecimalValues[remainder] or remainder)
		
		if integer == 0 then
			break
		end
	end
	
	if #hex == 1 then
		return "0" .. hex
	end
	
	return hex:reverse()
end

local function HexToRGB(hex)
	hex = hex:sub(2):upper()
	
	if #hex == 3 then
		local f, s, t = hex:sub(1, 1), hex:sub(2, 2), hex:sub(3, 3)
		return hex, Tonumber(f .. f, 16), Tonumber(s .. s, 16), Tonumber(t .. t, 16)
	elseif #hex == 6 then
		return hex, Tonumber(hex:sub(1, 2), 16), Tonumber(hex:sub(3, 4), 16), Tonumber(hex:sub(5, 6), 16)
	elseif #hex ~= 3 and #hex < 6 then
		hex = hex .. string.rep("0", 6 - #hex)
		return hex, Tonumber(hex:sub(1, 2), 16), Tonumber(hex:sub(3, 4), 16), Tonumber(hex:sub(5, 6), 16)
	end
end

local function RGBToHex(r, g, b)
	return "#" .. DecimalToHex(r) .. DecimalToHex(g) .. DecimalToHex(b)
end

local function SanitizeNumber(value, rgbValue, isHue)
	if value then
		value = (value ~= value and 0) or (Tonumber(value) or 0)
		
		if isHue then
			return Clamp(value, 0, 360)
		else
			return Clamp(value, 0, (rgbValue and 255 or 1))
		end
	end
end

local function UpdateColorWithRGB()
	local color = Color3.fromRGB(Tonumber(RGB.R.Value.Text), Tonumber(RGB.G.Value.Text), Tonumber(RGB.B.Value.Text))
	CurrentDisplay.BackgroundColor3 = color
	
	return color
end

local last;
local function UpdateFillIns(color)
	if color then
		last = color;
		local h, s, v = Color3.toHSV(color)
		local r, g, b = Floor(color.r * 255 + 0.5), Floor(color.g * 255 + 0.5), Floor(color.b * 255 + 0.5)
		
		RGB.R.Value.Text = r
		RGB.G.Value.Text = g
		RGB.B.Value.Text = b
		
		Hex.Value.Text = RGBToHex(r, g, b)
		UpdateCursorPosition(h, s)
				
		game.ReplicatedStorage.events.setSetting:FireServer("colorPicker",{
			color = color,
			rainbow = shared.rainbow_enabled
		});
		game.ReplicatedStorage.events.overheadInteraction:FireServer("setOverheadColor",color);
	end
end

game.ReplicatedStorage:WaitForChild("events"):WaitForChild("getOptions").OnClientEvent:Connect(function(data)
	if(data.colorPicker and data.colorPicker.color) then
		UpdateFillIns(Color3.fromRGB(unpack(data.colorPicker.color)));
	end
end)

local function GetColor()
	if InBounds() then
		local gradientSize = Gradient.AbsoluteSize
		UserInputService.MouseIconEnabled = false
		
		local sizeScale = 360 / gradientSize.X
		local offset = Vector2.new(Mouse.X, Mouse.Y) - (Gradient.AbsolutePosition + gradientSize / 2)
		
		local hue = Abs((offset.X * sizeScale - 180) / 360)
		local saturation = Abs((offset.Y * sizeScale - 180) / 360)
		local color = Color3.fromHSV(hue, saturation, 1)
		
		CurrentDisplay.BackgroundColor3 = color
		Cursor.Position = UDim2.new(0, Clamp(offset.X + gradientSize.X / 2, 0, gradientSize.X), 0, Clamp(offset.Y + gradientSize.Y / 2, 0, gradientSize.Y))
		
		return color
	end
	
	UserInputService.MouseIconEnabled = true
	return nil
end

--- Execution ---
Mouse.Button1Down:Connect(function()
	UpdateFillIns(GetColor())
	Down = true
end)

Mouse.Move:Connect(function()
	if Down then
		UpdateFillIns(GetColor())
	else
		UserInputService.MouseIconEnabled = true
	end
end)

Mouse.Button1Up:Connect(function()
	Down = false
end)

do -- Fill In Events
	local R = RGB.R.Value
	local G = RGB.G.Value
	local B = RGB.B.Value
	
	local Hex = Hex.Value
	
	do -- RGB
		R:GetPropertyChangedSignal("Text"):Connect(function()
			local text = R.Text
			
			if #text ~= 0 then
				R.Text = SanitizeNumber(text, true)
				UpdateFillIns(UpdateColorWithRGB())
			end
		end)
		
		G:GetPropertyChangedSignal("Text"):Connect(function()
			local text = G.Text
			
			if #text ~= 0 then
				G.Text = SanitizeNumber(text, true)
				UpdateFillIns(UpdateColorWithRGB())
			end
		end)
		
		B:GetPropertyChangedSignal("Text"):Connect(function()
			local text = B.Text
			
			if #text ~= 0 then
				B.Text = SanitizeNumber(text, true)
				UpdateFillIns(UpdateColorWithRGB())
			end
		end)
	end

	Hex:GetPropertyChangedSignal("Text"):Connect(function()
		local text = Hex.Text
		
		if #text ~= 0 then
			local index = 0
			local s, e = text:find("#")
			
			text = text:gsub("#", function()
				index = index + 1
				
				if s == 1 then
					return index == 1 and "#" or ""
				else
					return ""
				end
			end)
			
			if text:find("#") ~= 1 then
				text = "#" .. text
			end
			
			Hex.Text = text
		end
	end)
	
	Hex.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local hex, r, g, b = HexToRGB(Hex.Text)
			local h, s, v = Color3.toHSV(Color3.fromRGB(r, g, b))
			
			Hex.Text = hex
			UpdateFillIns(Color3.fromRGB(r, g, b))
		end
	end)
end