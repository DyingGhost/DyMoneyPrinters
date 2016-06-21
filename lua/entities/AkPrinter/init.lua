#NoSimplerr#
--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.SeizeReward = 950

function ENT:PrintMore()
		self:SetStoredMoney(self:GetStoredMoney() + 3)
		timer.Simple(StartTime, function() self:PrintMore() end)
end

function ENT:Initialize()
	self:SetUseType( SIMPLE_USE )
	self:SetModel("models/props_c17/consolebox01a.mdl")
	self:SetColor(Color(159,255,159,255))
	self:SetMaterial("models/props_combine/stasisshield_sheet")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self.sparking = false
	self.damage = 100 
	self.IsMoneyPrinter = true
	timer.Simple(StartTime, function() self:PrintMore() end)

	self.sound = CreateSound(self, Sound("ambient/levels/labs/equipment_printer_loop1.wav"))
	self.sound:SetSoundLevel(52)
	self.sound:PlayEx(1, 100)
	
	  local horse = ents.Create( "prop_dynamic" )
    horse:SetModel( "models/weapons/w_tct_ak47.mdl" )
    horse:SetPos( self:GetPos() + Vector(0,0,6) )
    horse:SetAngles( self:GetAngles() + Angle(12,-90,0) )
	horse:SetModelScale(0.5)
    horse:SetParent( self )
	
    self:DeleteOnRemove( horse )
    horse:Spawn( )
	
end

function ENT:OnTakeDamage(dmg)
	if self.burningup then return end

	self.damage = (self.damage or 100) - dmg:GetDamage()
	if self.damage <= 0 then
		local rnd = math.random(1, 10)
		if rnd < 3 then
			self:BurstIntoFlames()
		else
			self:Destruct()
			self:Remove()
		end
	end
end

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
	DarkRP.notify(self:Getowning_ent(), 1, 4, DarkRP.getPhrase("money_printer_exploded"))
end

function ENT:BurstIntoFlames()
	DarkRP.notify(self:Getowning_ent(), 0, 4, DarkRP.getPhrase("money_printer_overheating"))
	self.burningup = true
	local burntime = math.random(8, 18)
	self:Ignite(burntime, 0)
	timer.Simple(burntime, function() self:Fireball() end)
end

function ENT:Fireball()
	if not self:IsOnFire() then self.burningup = false return end
	local dist = math.random(20, 280) -- Explosion radius
	self:Destruct()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), dist)) do
		if not v:IsPlayer() and not v:IsWeapon() and v:GetClass() ~= "predicted_viewmodel" and not v.IsMoneyPrinter then
			v:Ignite(math.random(5, 22), 0)
		elseif v:IsPlayer() then
			local distance = v:GetPos():Distance(self:GetPos())
			v:TakeDamage(distance / dist * 100, self, self)
		end
	end
	self:Remove()
end
--[[
	if GAMEMODE.Config.printeroverheat then
		local overheatchance
		if GAMEMODE.Config.printeroverheatchance <= 3 then
			overheatchance = 22
		else
			overheatchance = GAMEMODE.Config.printeroverheatchance or 22
		end
		if math.random(1, overheatchance) == 3 then self:BurstIntoFlames() end
	end]]

	


function ENT:Use()
--	if not IsValid(self) or self:IsOnFire() then return end

	local MoneyPos = self:GetPos()




if self:GetStoredMoney() == 0 then return end
	local button = ents.Create( "m9k_ak47" )
if ( !IsValid( button ) ) then return end 
button:SetPos( self:GetPos() + Vector( 0, 0, 25 ) )
button:Spawn()
self:SetStoredMoney(self:GetStoredMoney()-1)
	
end

function ENT:Think()

	if self:WaterLevel() > 0 then
		self:Destruct()
		self:Remove()
		return
	end

	if not self.sparking then return end

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetMagnitude(1)
	effectdata:SetScale(1)
	effectdata:SetRadius(2)
	util.Effect("Sparks", effectdata)
end

function ENT:OnRemove()
	if self.sound then
		self.sound:Stop()
	end
end
