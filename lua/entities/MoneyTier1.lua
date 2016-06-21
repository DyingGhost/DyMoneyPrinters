AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "dyMoneyPrinterBase"
 
ENT.PrintName = "Printer (Tier 1)" -- dont change anything here except for this name
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
local MoneyPos = self:GetPos()
DarkRP.createMoneyBag(Vector(MoneyPos.x + 15, MoneyPos.y, MoneyPos.z + 15), self:GetStoredMoney())
end

ENT.FunctionInit = function(self) 

end