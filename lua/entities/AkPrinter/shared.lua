#NoSimplerr#
--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "AkPrinter"
ENT.Author = "DarkRP Developers and <enter name here>"
ENT.Spawnable = true
ENT.AdminSpawnable = false
StartTime = 300
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "price")
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Int", 1, "StoredMoney")
end
