#NoSimplerr#
--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
include("shared.lua")
 
function ENT:Initialize()
end
surface.CreateFont( "blurview_font48",
{
	font = "Lato Light", 
	size = 24,
	weight = 250,
	antialias = true,
	strikeout = true,
	additive = true,
} )
surface.CreateFont( "blurview_big",
{
	font = "Lato Light", 
	size = 48,
	weight = 24,
	antialias = true,
	strikeout = true,
	additive = true,
} )

local function formatCurrency( number ) 
	local output = number
	if number < 1000000 then
		output = string.gsub( number, "^(-?%d+)(%d%d%d)", "%1,%2" ) 
	else
		output = string.gsub( number, "^(-?%d+)(%d%d%d)(%d%d%d)", "%1,%2,%3" )
	end
	output = "$" .. output

	return output
end

function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is need for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local Pos2 = self:GetPos()
	local Ang2 = self:GetAngles()
	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")

	surface.SetFont("blurview_font18")
	local text = DarkRP.getPhrase("money_printer")
	local TextWidth = surface.GetTextSize(text)
	local TextWidth2 = surface.GetTextSize(owner) 

	Ang:RotateAroundAxis(Ang:Up(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 11.5, Ang, 0.11)
	draw.RoundedBox(5,-125,-125,250,250,Color(0,0,0,100))
	surface.SetDrawColor( 0, 0, 0, 125 )
	draw.NoTexture()
	draw.Circle(0,0,100,36)
	draw.WordBox(2, -125/2, -125, text, "blurview_font48", Color(140, 0, 0, 0), Color(255,255,255,255))
draw.DrawText("Ak47's  "..self:GetStoredMoney(), "blurview_big",-0,-100/2 + 125/5, Color(255,255,255,255),TEXT_ALIGN_CENTER)
	cam.End3D2D()

	Ang2:RotateAroundAxis(Ang2:Right(), 270)
		Ang2:RotateAroundAxis(Ang2:Up(), 90)
	cam.Start3D2D(Pos2 + Ang2:Up() * 16.5, Ang2, 0.11)
		draw.RoundedBox(5,-135,-100,202,100,Color(0,0,0,100))
	draw.DrawText("Owned by "..owner, "blurview_font48",-125,-50, Color(255,255,255,255),TEXT_ALIGN_LEFT)
	cam.End3D2D()

	cam.Start3D2D(Pos2 + Ang2:Up() * 16.9, Ang2, 0.11)
		draw.RoundedBox(0,72,-80,65,60,Color(0,0,0,100))



	
	
	
	cam.End3D2D() 
	
	
end

function ENT:Think()
end
