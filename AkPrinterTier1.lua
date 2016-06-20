AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "dymoneyprinterbase"

ENT.PrintName = "Printer" -- dont change anything here except for this name
ENT.Author = "Callum"
ENT.Contact = ""
ENT.Purpose = "" 
ENT.Instructions = ""
ENT.Category = "DyGhost Printers"
 
ENT.Spawnable = true
ENT.Time = 1
ENT.Money = 1 
ENT.PrinterColor = Color(127,127,255,255)

ENT.FunctionOnPrint = function (self) 
local button = ents.Create( "m9k_ak47" )
if ( !IsValid( button ) ) then return end 
button:SetPos( self:GetPos() + Vector( 0, 0, 25 ) )
button:Spawn()
end

ENT.Used = function (self) 
self:SetStoredMoney(self:GetStoredMoney()-1)
end

ENT.FunctionInit = function(self) 
	  local horse = ents.Create( "prop_dynamic" )
    horse:SetModel( "models/weapons/w_tct_ak47.mdl" )
    horse:SetPos( self:GetPos() + Vector(0,0,6) )
    horse:SetAngles( self:GetAngles() + Angle(12,-90,0) )
	horse:SetModelScale(0.5)
    horse:SetParent( self )
	self:SetUseType( SIMPLE_USE )
    self:DeleteOnRemove( horse )
    horse:Spawn( )
		self:SetColor(Color(159,255,159,255))
	self:SetMaterial("models/props_combine/stasisshield_sheet")
end