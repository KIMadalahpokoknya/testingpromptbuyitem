-- KATALOG AVATAR • LocalScript
-- Letakkan di StarterPlayer > StarterPlayerScripts.
-- Hapus/nonaktifkan GUI katalog versi lama agar tidak muncul dua kali.

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("KatalogAvatarGui")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "KatalogAvatarGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local function create(class, props, parent)
    local instance = Instance.new(class)
    for key, value in pairs(props) do instance[key] = value end
    instance.Parent = parent
    return instance
end

local function corner(parent, radius)
    create("UICorner", {CornerRadius = UDim.new(0, radius)}, parent)
end

local function stroke(parent, color, transparency)
    create("UIStroke", {Color = color, Transparency = transparency, Thickness = 1}, parent)
end

local function gradient(parent, a, b)
    create("UIGradient", {Color = ColorSequence.new(a, b), Rotation = 90}, parent)
end

local white = Color3.fromRGB(244, 246, 251)
local muted = Color3.fromRGB(154, 163, 184)
local blue = Color3.fromRGB(59, 130, 246)

local open = create("TextButton", {
    Name = "BukaKatalog", Size = UDim2.fromOffset(155, 48),
    Position = UDim2.new(0, 16, 0.5, -24), BackgroundColor3 = blue,
    Text = "✦  Buka Katalog", TextColor3 = white, TextSize = 15,
    Font = Enum.Font.GothamBold, AutoButtonColor = true,
}, gui)
corner(open, 14)
gradient(open, Color3.fromRGB(79, 156, 249), Color3.fromRGB(37, 99, 235))

local overlay = create("Frame", {
    Name = "Overlay", Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(7, 10, 18), BackgroundTransparency = 0.35,
    BorderSizePixel = 0, Visible = false,
}, gui)

-- Dimensi dasar 500x460; UIScale mengecilkannya agar muat di layar kecil.
local panel = create("Frame", {
    Name = "Panel", AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(500, 460),
    BackgroundColor3 = Color3.fromRGB(25, 29, 40), BorderSizePixel = 0,
}, overlay)
corner(panel, 20)
stroke(panel, Color3.fromRGB(120, 135, 162), 0.75)
gradient(panel, Color3.fromRGB(31, 35, 48), Color3.fromRGB(20, 22, 31))
local panelScale = create("UIScale", {Scale = 1}, panel)

local logo = create("TextLabel", {
    Size = UDim2.fromOffset(46, 46), Position = UDim2.fromOffset(20, 20),
    BackgroundColor3 = Color3.fromRGB(245, 158, 11), Text = "✦", TextSize = 26,
    TextColor3 = white, Font = Enum.Font.GothamBold,
}, panel)
corner(logo, 14)
gradient(logo, Color3.fromRGB(245, 158, 11), Color3.fromRGB(239, 68, 68))

create("TextLabel", {
    Size = UDim2.fromOffset(330, 25), Position = UDim2.fromOffset(78, 19),
    BackgroundTransparency = 1, Text = "Katalog Avatar", TextColor3 = white,
    Font = Enum.Font.GothamBold, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left,
}, panel)
create("TextLabel", {
    Size = UDim2.fromOffset(330, 20), Position = UDim2.fromOffset(78, 44),
    BackgroundTransparency = 1, Text = "Temukan item favoritmu di sini", TextColor3 = muted,
    Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
}, panel)
local close = create("TextButton", {
    Size = UDim2.fromOffset(38, 38), Position = UDim2.new(1, -58, 0, 24),
    BackgroundColor3 = Color3.fromRGB(47, 52, 66), Text = "×", TextColor3 = white,
    Font = Enum.Font.Gotham, TextSize = 26,
}, panel)
corner(close, 12)

create("Frame", {Position = UDim2.fromOffset(20, 80), Size = UDim2.new(1, -40, 0, 1),
    BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(55, 61, 77)}, panel)

create("TextLabel", {
    Position = UDim2.fromOffset(20, 96), Size = UDim2.fromOffset(300, 20),
    BackgroundTransparency = 1, Text = "CARI ITEM BERDASARKAN ID", TextColor3 = muted,
    Font = Enum.Font.GothamBold, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
}, panel)

local input = create("TextBox", {
    Name = "AssetId", Position = UDim2.fromOffset(20, 123), Size = UDim2.fromOffset(347, 46),
    BackgroundColor3 = Color3.fromRGB(35, 40, 55), TextColor3 = white,
    PlaceholderColor3 = muted, PlaceholderText = "Masukkan Asset ID item...", Text = "",
    ClearTextOnFocus = false, Font = Enum.Font.Gotham, TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
}, panel)
corner(input, 10)
stroke(input, Color3.fromRGB(89, 103, 127), 0.65)
create("UIPadding", {PaddingLeft = UDim.new(0, 13), PaddingRight = UDim.new(0, 10)}, input)

local search = create("TextButton", {
    Position = UDim2.fromOffset(378, 123), Size = UDim2.fromOffset(102, 46),
    BackgroundColor3 = blue, Text = "Cari", TextColor3 = white,
    Font = Enum.Font.GothamBold, TextSize = 14,
}, panel)
corner(search, 10)
gradient(search, Color3.fromRGB(79, 156, 249), Color3.fromRGB(37, 99, 235))

local card = create("Frame", {
    Position = UDim2.fromOffset(20, 185), Size = UDim2.fromOffset(460, 170),
    BackgroundColor3 = Color3.fromRGB(35, 40, 55), BorderSizePixel = 0,
}, panel)
corner(card, 14)
stroke(card, Color3.fromRGB(95, 106, 130), 0.75)

local image = create("ImageLabel", {
    Position = UDim2.fromOffset(15, 18), Size = UDim2.fromOffset(134, 134),
    BackgroundColor3 = Color3.fromRGB(48, 55, 74), Image = "", ScaleType = Enum.ScaleType.Fit,
}, card)
corner(image, 12)
local placeholder = create("TextLabel", {
    Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "✦",
    TextColor3 = Color3.fromRGB(103, 119, 149), Font = Enum.Font.GothamBold, TextSize = 42,
}, image)

create("TextLabel", {
    Position = UDim2.fromOffset(165, 23), Size = UDim2.fromOffset(278, 18),
    BackgroundTransparency = 1, Text = "DETAIL ITEM", TextColor3 = muted,
    TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBold, TextSize = 11,
}, card)
local itemName = create("TextLabel", {
    Position = UDim2.fromOffset(165, 48), Size = UDim2.fromOffset(278, 48),
    BackgroundTransparency = 1, Text = "Belum ada item", TextColor3 = white,
    TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = true, TextTruncate = Enum.TextTruncate.AtEnd,
    Font = Enum.Font.GothamBold, TextSize = 17,
}, card)
local status = create("TextLabel", {
    Position = UDim2.fromOffset(165, 105), Size = UDim2.fromOffset(278, 48),
    BackgroundTransparency = 1, Text = "Masukkan ID, lalu tekan Cari.", TextColor3 = muted,
    TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = true, Font = Enum.Font.Gotham, TextSize = 13,
}, card)

local buy = create("TextButton", {
    Position = UDim2.fromOffset(20, 370), Size = UDim2.fromOffset(460, 48),
    BackgroundColor3 = Color3.fromRGB(34, 197, 94), Text = "Beli Item", TextColor3 = white,
    Font = Enum.Font.GothamBold, TextSize = 16,
}, panel)
corner(buy, 12)
gradient(buy, Color3.fromRGB(34, 197, 94), Color3.fromRGB(21, 128, 61))
create("TextLabel", {
    Position = UDim2.fromOffset(20, 426), Size = UDim2.fromOffset(460, 20),
    BackgroundTransparency = 1, Text = "Pembelian diproses melalui Roblox", TextColor3 = muted,
    Font = Enum.Font.Gotham, TextSize = 11,
}, panel)

local cameraConnection
local function updateScale()
    local camera = Workspace.CurrentCamera
    if not camera then return end
    local view = camera.ViewportSize
    panelScale.Scale = math.min(1, (view.X - 24) / 500, (view.Y - 24) / 460)
end
local function bindCamera()
    if cameraConnection then cameraConnection:Disconnect() end
    local camera = Workspace.CurrentCamera
    if camera then cameraConnection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale) end
    updateScale()
end
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(bindCamera)
bindCamera()

open.Activated:Connect(function() overlay.Visible = true end)
close.Activated:Connect(function() overlay.Visible = false end)

local selectedId = nil
local requestNumber = 0
input:GetPropertyChangedSignal("Text"):Connect(function()
    requestNumber += 1
    selectedId = nil
    image.Image = ""
    placeholder.Visible = true
    itemName.Text = "Belum ada item"
    status.Text = "Masukkan ID, lalu tekan Cari."
end)

local function findItem()
    requestNumber += 1
    local currentRequest = requestNumber
    selectedId = nil
    image.Image = ""
    placeholder.Visible = true
    local digits = input.Text:match("^%s*(%d+)%s*$")
    local id = digits and tonumber(digits)
    if not id or id <= 0 then
        itemName.Text = "ID tidak valid"
        status.Text = "Masukkan angka Asset ID saja."
        return
    end
    itemName.Text = "Mencari item..."
    status.Text = "Mohon tunggu sebentar."
    local ok, info = pcall(function()
        return MarketplaceService:GetProductInfo(id, Enum.InfoType.Asset)
    end)
    if requestNumber ~= currentRequest then return end
    if not ok or not info then
        itemName.Text = "Item tidak ditemukan"
        status.Text = "Periksa ID dan coba lagi."
        return
    end
    selectedId = id
    itemName.Text = info.Name or "Item avatar"
    image.Image = "rbxthumb://type=Asset&id=" .. tostring(id) .. "&w=150&h=150"
    placeholder.Visible = false
    if info.PriceInRobux ~= nil then
        status.Text = "Harga: " .. tostring(info.PriceInRobux) .. " Robux\nHarga final ada di prompt Roblox."
    else
        status.Text = "Harga tidak tersedia. Cek prompt Roblox."
    end
end
search.Activated:Connect(findItem)
input.FocusLost:Connect(function(enterPressed) if enterPressed then findItem() end end)

buy.Activated:Connect(function()
    if not selectedId then
        status.Text = "Cari item terlebih dahulu."
        return
    end
    local ok, err = pcall(function()
        MarketplaceService:PromptPurchase(player, selectedId)
    end)
    if not ok then
        status.Text = "Gagal membuka pembelian."
        warn("Prompt pembelian gagal:", err)
    end
end)
