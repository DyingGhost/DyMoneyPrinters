AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "dymoneyprinterbase"

ENT.PrintName = "Health Printer" -- dont change anything here except for this name
ENT.Author = "Callum"
ENT.Contact = ""
ENT.Purpose = "" 
ENT.Instructions = ""
ENT.Category = "DyGhost Printers"
 
ENT.Spawnable = true
ENT.Time = 45
ENT.Money = 1 
ENT.PrinterColor = Color(127,127,255,255)
ENT.Icon = ""
ENT.Name = "Health Printer"
ENT.FunctionOnPrint = function (self) 
local button = ents.Create( "item_healthkit" )
if ( !IsValid( button ) ) then return end 
button:SetPos( self:GetPos() + Vector( 0, 0, 25 ) )
button:Spawn()
end
 
ENT.Used = function (self) 
self:SetStoredMoney(self:GetStoredMoney()-1)
end

ENT.FunctionInit = function(self) 
	  local horse = ents.Create( "prop_dynamic" )
    horse:SetModel( "models/items/healthkit.mdl" )
    horse:SetPos( self:GetPos() + Vector(0,0,0) )
    horse:SetAngles( self:GetAngles() + Angle(0,-0,0) )
	horse:SetModelScale(1)
    horse:SetParent( self )
	self:SetUseType( SIMPLE_USE )
    self:DeleteOnRemove( horse )
    horse:Spawn( )
		self:SetColor(Color(159,255,159,255))
	self:SetMaterial("phoenix_storms/metalfence004a ")
end
