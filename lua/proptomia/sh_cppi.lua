local _cppi = CPPI

if _cppi and _cppi.GetName() ~= "Proptomia" then
    proptomia.Warn("Detected different prop protection addon!\n\tPlease remove it to prevent conflicts")
    proptomia.Warn("\tDetected prop protection addon: " .. _cppi.GetName())
end

local MetaEntity = FindMetaTable("Entity")
local MetaPlayer = FindMetaTable("Player")

CPPI = CPPI or {}

CPPI.CPPI_DEFER = "112116"          -- basic meaning: i don't have value
CPPI.CPPI_NOTIMPLEMENTED = "8480"   -- basic meaning: too lazy to-do / don't want make this thing
                                    -- both usually used in functions

function CPPI:GetName()
    return "Proptomia"
end
function CPPI:GetVersion()
    return "1.0"
end
function CPPI:GetInterfaceVersion()
    return 1.3
end

function MetaEntity:CPPIGetOwner()
    local propInfo = proptomia.props[self:EntIndex()]
    if propInfo then
        return IsValid(propInfo.Owner) and propInfo.Owner or nil, CPPI.CPPI_NOTIMPLEMENTED
    end
end
function MetaEntity:CPPISetOwner(ply)
    return proptomia.SetOwner(self, ply)
end
function MetaEntity:CPPICanPhysgun(ply)
    if not proptomia.convars.protection:GetBool() then
        return true
    end
    return proptomia.CanPhysgunPickup(ply, self)
end
function MetaEntity:CPPICanTool(ply, mode)
    if not proptomia.convars.protection:GetBool() then return true end

    if proptomia.CanTool(ply, {Entity = self}, mode) == false then
        return false
    end

    return true
end