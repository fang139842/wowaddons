CLASS_DISABLED = "你必须选择不同的种族来选择这个职业";
CUSTOMIZE = "下一步1";
NEXT = "下一步2";
FINISH = "完  成";


CHARACTER_FACING_INCREMENT = 2;
MAX_RACES = 11;
MAX_CLASSES_PER_RACE = 11;
NUM_CHAR_CUSTOMIZATIONS = 5;
MIN_CHAR_NAME_LENGTH = 2;
CHARACTER_CREATE_ROTATION_START_X = nil;
CHARACTER_CREATE_INITIAL_FACING = nil;
NUM_PREVIEW_FRAMES = 14;
WORGEN_RACE_ID = 6;
TUSKARR_RACE_ID = 6;
IS_ZOOMED = false
local featureIndex = 1
local FeatureType = 1
COA_REALM = false

PAID_CHARACTER_CUSTOMIZATION = 1;
PAID_RACE_CHANGE = 3;
PAID_FACTION_CHANGE = 2;
PAID_SERVICE_CHARACTER_ID = nil;
PAID_SERVICE_TYPE = nil;

PREVIEW_FRAME_HEIGHT = 130;
PREVIEW_FRAME_X_OFFSET = 19;
PREVIEW_FRAME_Y_OFFSET = -7;

FACTION_BACKDROP_COLOR_TABLE = {
	["Alliance"] = {0.5, 0.5, 0.5, 0.09, 0.09, 0.19, 0, 0, 0.2, 0.29, 0.33, 0.91},
	["Horde"] = {0.5, 0.2, 0.2, 0.19, 0.05, 0.05, 0.2, 0, 0, 0.90, 0.05, 0.07},
	["Player"] = {0.2, 0.5, 0.2, 0.05, 0.2, 0.05, 0.05, 0.2, 0.05, 1, 1, 1},
};
FRAMES_TO_BACKDROP_COLOR = {
	"CharacterCreateCharacterRace",
	"CharacterCreateCharacterClass",
--	"CharacterCreateCharacterFaction",
	"CharacterCreateNameEdit",
};
RACE_ICON_TCOORDS = {
	["HUMAN_MALE"]		= {0, 0.125, 0, 0.25},
	["DWARF_MALE"]		= {0.125, 0.25, 0, 0.25},
	["GNOME_MALE"]		= {0.25, 0.375, 0, 0.25},
	["NIGHTELF_MALE"]	= {0.375, 0.5, 0, 0.25},

	["TAUREN_MALE"]		= {0, 0.125, 0.25, 0.5},
	["SCOURGE_MALE"]	= {0.125, 0.25, 0.25, 0.5},
	["TROLL_MALE"]		= {0.25, 0.375, 0.25, 0.5},
	["ORC_MALE"]		= {0.375, 0.5, 0.25, 0.5},

	["HUMAN_FEMALE"]	= {0, 0.125, 0.5, 0.75},
	["DWARF_FEMALE"]	= {0.125, 0.25, 0.5, 0.75},
	["GNOME_FEMALE"]	= {0.25, 0.375, 0.5, 0.75},
	["NIGHTELF_FEMALE"]	= {0.375, 0.5, 0.5, 0.75},

	["TAUREN_FEMALE"]	= {0, 0.125, 0.75, 1.0},
	["SCOURGE_FEMALE"]	= {0.125, 0.25, 0.75, 1.0},
	["TROLL_FEMALE"]	= {0.25, 0.375, 0.75, 1.0},
	["ORC_FEMALE"]		= {0.375, 0.5, 0.75, 1.0},

	["BLOODELF_MALE"]	= {0.5, 0.625, 0.25, 0.5},
	["BLOODELF_FEMALE"]	= {0.5, 0.625, 0.75, 1.0},

	["DRAENEI_MALE"]	= {0.5, 0.625, 0, 0.25},
	["DRAENEI_FEMALE"]	= {0.5, 0.625, 0.5, 0.75},

	-- ["WORGEN_MALE"]		= {0.625, 0.75, 0, 0.25},
	-- ["WORGEN_FEMALE"]	= {0.625, 0.75, 0.5, 0.75},
	--
	-- ["GOBLIN_MALE"]		= {0.625, 0.75, 0.125, 0.25},
	-- ["GOBLIN_FEMALE"]	= {0.625, 0.75, 0.375, 0.5},
};
CLASS_ICON_TCOORDS = {
	["WARRIOR"]	= {0, 0.25, 0, 0.25},
	["MAGE"]	= {0.25, 0.49609375, 0, 0.25},
	["ROGUE"]	= {0.49609375, 0.7421875, 0, 0.25},
	["DRUID"]	= {0.7421875, 0.98828125, 0, 0.25},
	["HUNTER"]	= {0, 0.25, 0.25, 0.5},
	["SHAMAN"]	= {0.25, 0.49609375, 0.25, 0.5},
	["PRIEST"]	= {0.49609375, 0.7421875, 0.25, 0.5},
	["WARLOCK"]	= {0.7421875, 0.98828125, 0.25, 0.5},
	["PALADIN"]	= {0, 0.25, 0.5, 0.75},
	["DEATHKNIGHT"]	= {0.25, 0.49609375, 0.5, 0.75},
	["ENGINEER"] = {0.25, 0.49609375, 0.5, 0.75},
	["HERO"] = {0, 0.25, 0.5, 0.75},
};

BANNER_DEFAULT_TEXTURE_COORDS = {0.109375, 0.890625, 0.201171875, 0.80078125};
BANNER_DEFAULT_SIZE = {200, 308};

CHAR_CUSTOMIZE_HAIR_COLOR = 4;
local selectedRaceInfo = {}

--新增函数
function CustomSliderOnUpdate(self)
	if not(self.centerX) then
		self.centerX = self:GetCenter()
		self.centerX = math.floor(self.centerX)
	end

	local sx = self:GetCenter()
	local _, _, _, x = self:GetPoint()

	if (self.IsMoving) then
		self.startMoveTime = self.startMoveTime + 1
		local px, py = GetCursorPosition()
		--px = px + 76

		local toMove = (math.floor((px-sx)/10))

		if (math.abs(self.centerX-(sx+toMove)) < self.sliderLength) then
			self:SetPoint("CENTER", x+toMove, 0)
		end

		if (self.startMoveTime) >= self.speed then
			if (math.floor(sx) > self.centerX) then
				CharacterCustomization_Right(self:GetParent():GetID());
			else
				CharacterCustomization_Left(self:GetParent():GetID());
			end

			self.startMoveTime = 0
		end
 
	elseif (math.floor(sx) ~= self.centerX) then
		local toMove = ((self.centerX-sx)/10)
		self:SetPoint("CENTER", x+toMove, 0)
	end
end

local function HandleFactionBackground()
	local name, faction = GetFactionForRace(CharacterCreate.selectedRace);

	-- if CLASSLESS_REALM then
		-- faction = faction.."REGULAR"
	-- end

	SetBackgroundModel(CharacterCreate, string.upper(faction));
	IS_ZOOMED = false
	--SetBackgroundModel(CharacterCreate, string.upper(faction));
end

local function SetFaceCustomizeCamera(flag)
	local race, fileString = GetNameForRace();

	if (flag) and not(IS_ZOOMED) then
		SetBackgroundModel(CharacterCreate, string.upper(fileString).."_ZOOM");
		IS_ZOOMED = true
	elseif not(flag) and (IS_ZOOMED) then
		SetBackgroundModel(CharacterCreate, string.upper(fileString));
		IS_ZOOMED = false
	end
end


--角色创建界面加载时执行的函数。
function CharacterCreate_OnLoad(self)	
	self:RegisterEvent("RANDOM_CHARACTER_NAME_RESULT");	-- 随机生成角色名事件
	self:RegisterEvent("GLUE_UPDATE_EXPANSION_LEVEL");	-- 游戏扩展等级更新事件

	self:SetSequence(14);	-- 设置默认动作序列
	self:SetCamera(2);		-- 设置默认相机视角

	-- 初始化种族、职业、性别信息
	CharacterCreate.numRaces = 0;
	CharacterCreate.selectedRace = 0;
	CharacterCreate.numClasses = 0;
	CharacterCreate.selectedClass = 0;
	CharacterCreate.selectedGender = 0;

	-- 设置人物自定义框架类型
	SetCharCustomizeFrame("CharacterCreate");

	-- 设置自定义选项按钮文本
	for i=1, NUM_CHAR_CUSTOMIZATIONS, 1 do
		_G["CharCreateCustomizationButton"..i].text:SetText(_G["CHAR_CUSTOMIZATION"..i.."_DESC"]);
	end

	-- 设置姓名编辑框的背景颜色
	local backdropColor = FACTION_BACKDROP_COLOR_TABLE["Alliance"];
	CharacterCreateNameEdit:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	CharacterCreateNameEdit:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	--[[CharacterCreateNameEdit:SetParent(CharacterCreateFrame)
	CharacterCreateNameEdit:SetPoint("TOPLEFT", CharacterCreateFrame, 635, -30)]]--

	-- 设置自定义设置窗口的位置
	CharCreateCustomizationFrame:SetPoint("RIGHT", CharacterCreateFrame, -50, -10)

	-- 设置角色创建框架的状态为"CLASSRACE"
	CharacterCreateFrame.state = "CLASSRACE";

	-- 初始化预览框架列表
	CharCreatePreviewFrame.previews = { };

	-- 设置自定义背景（隐藏）
	CustomizationBG = CharacterCreateFrame:CreateTexture("CustomizationBG", "BACKGROUND")
	CustomizationBG:SetSize(-5, GlueParent:GetHeight())
    CustomizationBG:SetTexture("Interface\\Glues\\CharacterCreate\\Shadowv")
    CustomizationBG:SetPoint("RIGHT")
    CustomizationBG:Hide()

	-- 设置自定义背景2
	CustomizationBG2 = CharacterCreateFrame:CreateTexture("CustomizationBG2", "BACKGROUND")
	CustomizationBG2:SetSize(-5, GlueParent:GetHeight())
    CustomizationBG2:SetTexture("Interface\\Glues\\CharacterCreate\\MainShadow")
    CustomizationBG2:SetPoint("CENTER")
    CustomizationBG2:SetAlpha(1)

	--筑梦星辰LOGO
	-- CharacterCreateCustomZhuMengXingChenLOGO = CharacterCreateFrame:CreateTexture("CharacterCreateCustomZhuMengXingChenLOGO", "ARTWORK")
	-- CharacterCreateCustomZhuMengXingChenLOGO:SetSize(250, 125)
    -- CharacterCreateCustomZhuMengXingChenLOGO:SetTexture("Interface\\changjing01\\CJ05\\ZMXC_LOGO")
    -- CharacterCreateCustomZhuMengXingChenLOGO:SetPoint("TOPLEFT", 20, 20)

	-- CustomizationLogoAlliance = CharacterCreateFrame:CreateTexture("CustomizationLogoAlliance", "ARTWORK")	--联盟图标
	-- CustomizationLogoAlliance:SetSize(100, 100)
    -- CustomizationLogoAlliance:SetTexture("Interface\\Glues\\CharacterCreate\\AllianceLogo")
    -- CustomizationLogoAlliance:SetPoint("TOPLEFT", -16, 16)

	-- CustomizationTextAlliance = CharacterCreateFrame:CreateFontString("CustomizationTextAlliance", "OVERLAY") --联盟文字
    -- CustomizationTextAlliance:SetFontObject(GlueFontNormal)
    -- CustomizationTextAlliance:SetFont("Interface\\Fonts\\FRIZQT__.TTF", 16)
    -- CustomizationTextAlliance:SetText(string.upper(ALLIANCE))
    -- CustomizationTextAlliance:SetPoint("LEFT", CustomizationLogoAlliance, "RIGHT", -54, 0)

	-- CustomizationLogoHorde = CharacterCreateFrame:CreateTexture("CustomizationLogoHorde", "ARTWORK")--部落图标
	-- CustomizationLogoHorde:SetSize(100, 100)
    -- CustomizationLogoHorde:SetTexture("Interface\\Glues\\CharacterCreate\\HordeLogo")
    -- CustomizationLogoHorde:SetPoint("TOPRIGHT", 16, 16)

	-- CustomizationTextHorde = CharacterCreateFrame:CreateFontString("CustomizationTextHorde", "OVERLAY")--部落文字
    -- CustomizationTextHorde:SetFontObject(GlueFontNormal)
    -- CustomizationTextHorde:SetFont("Interface\\Fonts\\FRIZQT__.TTF", 16)
    -- CustomizationTextHorde:SetText(string.upper(HORDE))
    -- CustomizationTextHorde:SetPoint("RIGHT", CustomizationLogoHorde, "LEFT", 24, 0)


end

--自定义角色外观按钮点击时执行的函数
function CharCustomizeButtonClick(id, button)
	if (button == 'LeftButton') then
		for i = 1, math.random(1, 5) do
			CharacterCustomization_Left(id)
		end
	elseif (button == 'RightButton') then
		for i = 1, math.random(1, 5) do
			CharacterCustomization_Right(id)
		end
	end
	
	if (id > 1) then
		SetFaceCustomizeCamera(true)
		_G["CharaCustomTexFrameText1"]:SetText(button);
	else
		SetFaceCustomizeCamera(false)
	end
	-- CycleCharCustomization(id, 1);
	--[[FeatureType = id
	for i=1,5 do
		_G["CharCreateCustomizationButton"..i]:SetChecked(0);
	end
	_G["CharCreateCustomizationButton"..id]:SetChecked(1);]]

end

--角色创建界面显示时执行的函数。
function CharacterCreate_OnShow()
	-- 隐藏并启用所有职业按钮和种族按钮。
	for i=1, MAX_CLASSES_PER_RACE, 1 do
		local button = _G["CharCreateClassButton"..i];
		--button:Enable();
		button:Hide();
		--button:SetScale(0.8)
		SetButtonDesaturated(button, false)
		--CharacterCreateEnumerateRaces()
	end

	for i=1, MAX_RACES, 1 do
		local button = _G["CharCreateRaceButton"..i];
		button:Enable();
		--button:SetScale(0.8)
		SetButtonDesaturated(button, false)	-- 取消按钮变灰效果
	end

	-- 如果进行付费服务，则使用自定义现有角色功能。
	if ( PAID_SERVICE_TYPE ) then
		CustomizeExistingCharacter( PAID_SERVICE_CHARACTER_ID );
		CharacterCreateNameEdit:SetText( PaidChange_GetName() );
	else
		--randomly selects a combination
		-- 如果不是付费服务，则随机选择一个外观组合，并在名称编辑框中清除任何输入。
		ResetCharCustomize();
		CharacterCreateNameEdit:SetText("");
		CharCreateRandomizeButton:Show();
	end

	-- 枚举可用的种族，并设置所选种族。
	CharacterCreateEnumerateRaces(GetAvailableRaces());
	SetCharacterRace(GetSelectedRace());

	--CharacterCreateEnumerateClasses(GetAvailableClasses());
	-- 获取当前选择的职业，并设置所选职业。 
	local_,_,index = GetSelectedClass();
	SetCharacterClass(index);

	--[[if ( GetSelectedRace() == TUSKARR_RACE_ID ) then
		SetCharacterGender(SEX_MALE);
		CharCreateMaleButton:SetChecked(1);
		CharCreateFemaleButton:SetChecked(0);
	else]]
		 -- 设置性别为所选性别。
	SetCharacterGender(GetSelectedSex());
	--end

	 -- 更新发型的定制选项。
	CharacterCreate_UpdateHairCustomization();

	-- 将角色面对方向设置为 -15度。
	SetCharacterCreateFacing(-15);
	if (previewFrame and previewFrame.ModelScene) then
		previewFrame.ModelScene:SetCameraZoom(1.5);
	end

	-- 设置角色创建时的其他自定义选项。
	CharacterChangeFixup();
 	-- 最后设置摄像头。
	--SetFaceCustomizeCamera(false);

	
end

--角色创建界面隐藏时执行的函数。
function CharacterCreate_OnHide()
	-- 重置全局变量PAID_SERVICE_CHARACTER_ID和PAID_SERVICE_TYPE为nil
	PAID_SERVICE_CHARACTER_ID = nil;
	PAID_SERVICE_TYPE = nil;

	-- 如果当前角色创建状态为CUSTOMIZATION，则返回到上一个状态
	if ( CharacterCreateFrame.state == "CUSTOMIZATION" ) then
		CharacterCreate_Back();
	end

	-- 需要重新构建角色预览界面，其中一个原因是当用户返回到登录界面时，用于跟踪框架的所有内存都会被释放。
	CharCreatePreviewFrame.rebuildPreviews = true;
end

--角色创建界面监听事件的函数。
function CharacterCreate_OnEvent(event, arg1, arg2, arg3)
	if ( event == "RANDOM_CHARACTER_NAME_RESULT" ) then
		if ( arg1 == 0 ) then
			-- Failed.  Generate a random name locally. 失败。在本地生成一个随机名称。
			CharacterCreateNameEdit:SetText(GenerateRandomName());
		else
			-- Succeeded.  Use what the server sent. 成功使用服务器发送的内容。
			CharacterCreateNameEdit:SetText(arg2);
		end
		CharacterCreateRandomName:Enable();
		CharCreateOkayButton:Enable();
		PlaySound("gsCharacterCreationLook");
	elseif ( event == "GLUE_UPDATE_EXPANSION_LEVEL" ) then
		-- Expansion level changed while online, so enable buttons as needed
		--在线时扩展级别已更改，因此根据需要启用按钮
		if ( CharacterCreateFrame:IsShown() ) then
			CharacterCreateEnumerateRaces(GetAvailableRaces());
			--CharacterCreateEnumerateClasses(GetAvailableClasses());
		end
	end
end

--角色创建界面鼠标按下时执行的函数。
function CharacterCreateFrame_OnMouseDown(button)
	if ( button == "LeftButton" ) then
		CHARACTER_CREATE_ROTATION_START_X = GetCursorPosition();
		CHARACTER_CREATE_INITIAL_FACING = GetCharacterCreateFacing();
	end
end

--角色创建界面鼠标抬起时执行的函数。
function CharacterCreateFrame_OnMouseUp(button)
	if ( button == "LeftButton" ) then
		CHARACTER_CREATE_ROTATION_START_X = nil
	end
end

--角色创建界面更新时执行的函数。
function CharacterCreateFrame_OnUpdate(self, elapsed)
	if ( CHARACTER_CREATE_ROTATION_START_X ) then
		local x = GetCursorPosition();
		local diff = (x - CHARACTER_CREATE_ROTATION_START_X) * CHARACTER_ROTATION_CONSTANT;
		CHARACTER_CREATE_ROTATION_START_X = GetCursorPosition();
		SetCharacterCreateFacing(GetCharacterCreateFacing() + diff);
		CharCreate_RotatePreviews();
	end
	CharacterCreateWhileMouseDown_Update(elapsed);
end

-- 枚举所有可选种族的函数
function CharacterCreateEnumerateRaces(...)	
   CharacterCreate.numRaces = select("#", ...)/3;
	if ( CharacterCreate.numRaces > MAX_RACES ) then
		message("Too many races!  Update MAX_RACES");
		return;
	end
	local index = 1;
	local button;
	local gender;
	local selectedSex = GetSelectedSex();
	if ( selectedSex == SEX_MALE ) then
		gender = "MALE";
	else
		gender = "FEMALE";
	end
	for i=1, select("#", ...), 3 do
		local name = select(i, ...);
		local unlocalizedname = strupper(select(i+1, ...))

		 -- 设置按钮样式和信息
        button = _G["CharCreateRaceButton" .. index]
        button:SetNormalTexture("Interface\\Glues\\CHARACTERCREATE\\custom\\" .. gender .. "-" .. index)
        button:SetPushedTexture("Interface\\Glues\\CHARACTERCREATE\\custom\\" .. gender .. "-" .. index)
        button.nameFrame.text:SetText(name)
        button.name = name
		if ( not button  ) then
			return;
		end

		button.nameFrame.text:SetText(name);
		if ( select(i+2, ...) == 1 ) then
			button:Enable();
			SetButtonDesaturated(button);
			button.name = name;
			button.tooltip = name;
			
		else
			button:Disable();
			SetButtonDesaturated(button, 1);
			button.name = name;
			local disabledReason = _G[strupper(select(i+1, ...).."_".."DISABLED")];
			if (disabledReason) then
				button.tooltip = name .. "|n" .. disabledReason;
				_G["CharaRaceDescriptionFrameText1"]:SetText(button.tooltip);
			else
				button.tooltip = nil;
			end
		end

		local abilityIndex = 1;
		local tempText = _G["ABILITY_INFO_"..unlocalizedname..abilityIndex];
		local AbilityText = "";
		while ( tempText ) do
			AbilityText = AbilityText..tempText.."\n\n";
			abilityIndex = abilityIndex + 1;
			tempText = _G["ABILITY_INFO_"..unlocalizedname..abilityIndex];
		end

		local Text = GetFlavorText("RACE_INFO_"..unlocalizedname, gender)
		button.tooltip = "|r"..Text
		button.tooltip = button.tooltip.."\n\n|cffFFFFFF"..AbilityText
		CharaRaceDescriptionFrameText1:SetText(button.tooltip)

		-- 设置按钮高亮材质
        local highlightTexture = "Interface\\Glues\\CHARACTERCREATE\\custom\\Highlight" .. (enabled and gender or (gender == "MALE" and "FEMALE" or "MALE"))
        local border = _G["CharCreateRaceButton" .. index .. "Border"]

        if not border then
            border = CreateFrame("Frame", "CharCreateRaceButton" .. index .. "Border", button)
            border:SetPoint("TOPLEFT", button, "TOPLEFT")
            border:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT")
        end

        border:SetBackdrop({
            bgFile = highlightTexture,
            edgeFile = "",
            tile = false,
            tileSize = 0,
            edgeSize = 0,
            insets = {
                left = 0,
                right = 0,
                top = 0,
                bottom = 0,
            },
        })

		index = index + 1;
	end
	for i=CharacterCreate.numRaces + 1, MAX_RACES, 1 do
		_G["CharCreateRaceButton"..i]:Hide();
	end
end

-- 获取种族能力文本
function GetAbilityTexts(race)
    local abilityTexts = {}
    local abilityIndex = 1
    local tempText = _G["ABILITY_INFO_" .. race .. abilityIndex]

    while tempText do
        table.insert(abilityTexts, tempText)
        abilityIndex = abilityIndex + 1
        tempText = _G["ABILITY_INFO_" .. race .. abilityIndex]
    end

    return abilityTexts
end


--枚举所有可选职业的函数。
function CharacterCreateEnumerateClasses(...)
	CharacterCreate.numClasses = select("#", ...) / 3;
	if (CharacterCreate.numClasses > MAX_CLASSES_PER_RACE) then
		message("Too many classes!  Update MAX_CLASSES_PER_RACE");
		return;
	end
	local coords;
	local index = 1;
	local button;
	for i = 1, select("#", ...), 3 do
		local unlocalizedname = strupper(select(i + 1, ...))

		coords = CLASS_ICON_TCOORDS[strupper(select(i + 1, ...))];
		_G["CharCreateClassButton" .. index .. "NormalTexture"]:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
		_G["CharCreateClassButton" .. index .. "PushedTexture"]:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
		button = _G["CharCreateClassButton" .. index];
		button:Show();
		button.nameFrame.text:SetText(select(i, ...));
		button.tooltip = ""
		button.tooltip = button.nameFrame.text:GetText()

		local abilityIndex = 0;
		local tempText = _G["CLASS_INFO_" .. unlocalizedname .. abilityIndex];
		abilityText = "";
		while (tempText) do
			abilityText = abilityText .. tempText .. "\n\n";
			abilityIndex = abilityIndex + 1;
			tempText = _G["CLASS_INFO_" .. unlocalizedname .. abilityIndex];
		end

		if (select(i + 2, ...) == 1) then
			if (IsRaceClassValid(CharacterCreate.selectedRace, index)) then
				button:Enable();
				SetButtonDesaturated(button);
				text = GetFlavorText("CLASS_" .. strupper(unlocalizedname), "MALE") .. "|n|n"
				button.tooltip = "|r" .. text
				button.tooltip = button.tooltip .. "\n\n|cffFFFFFF" .. abilityText
				--button.tooltip = nil;
				-- _G["CharCreateClassButton"..index.."DisableTexture"]:Hide();
			else
				button:Disable();
				SetButtonDesaturated(button, 1);
				button.tooltip = CLASS_DISABLED;
				text = GetFlavorText("CLASS_" .. strupper(unlocalizedname), "MALE") .. "|n|n"
				button.tooltip = "|cffFFFFFF" .. button.tooltip .. "|r\n\n"
				_G["CharCreateClassButton" .. index .. "DisableTexture"]:Show();
			end
		else
			button:Disable();
			SetButtonDesaturated(button, 1);
			_G["CharCreateClassButton" .. index .. "DisableTexture"]:Show();
		end

		index = index + 1;
	end
	for i = CharacterCreate.numClasses + 1, MAX_CLASSES_PER_RACE, 1 do
		_G["CharCreateClassButton" .. i]:Hide();
	end
end

--设置角色种族的函数。
function SetCharacterRace(id)

	CharacterCreate.selectedRace = id;
	for i=1, CharacterCreate.numRaces, 1 do
		local button = _G["CharCreateRaceButton"..i];
		if ( i == id ) then
			button:SetChecked(1);
		else
			button:SetChecked(0);
		end
	end

	local name, faction = GetFactionForRace(CharacterCreate.selectedRace);

	if faction == nil then
		faction = "Alliance";
	end

	-- during a paid service we have to set alliance/horde for neutral races
	-- hard-coded for Pandaren because of alliance/horde pseudo buttons
	local canProceed = true;
	-- if ( id == TUSKARR_RACE_ID and PAID_SERVICE_TYPE ) then
	-- 	--[[
	-- 	--local currentFaction = PaidChange_GetCurrentFaction();
	-- 	if ( PaidChange_GetCurrentRaceIndex() == TUSKARR_RACE_ID and PAID_SERVICE_TYPE == PAID_FACTION_CHANGE ) then
	-- 		-- this is an original pandaren staying or becoming selected
	-- 		-- check the pseudo-buttons
	-- 		faction = PandarenFactionButtons_GetSelectedFaction();
	-- 		--if ( faction == currentFaction ) then
	-- 			canProceed = false;
	-- 		--end
	-- 	else
	-- 		-- for faction change use the opposite faction of current character
	-- 		if ( PAID_SERVICE_TYPE == PAID_FACTION_CHANGE ) then
	-- 			--if ( currentFaction == "Horde" ) then
	-- 				faction = "Alliance";
	-- 			--elseif ( currentFaction == "Alliance" ) then
	-- 			--	faction = "Horde";
	-- 			--end
	-- 		-- for race change and customization use the same faction as current character
	-- 		else
	-- 			faction = "Alliance";
	-- 		end
	-- 	end
	-- 	]]
	-- else
	-- 	PandarenFactionButtons_ClearSelection();
	-- end
	CharCreate_EnableNextButton(canProceed);

	-- Set background
	local backgroundFilename = GetCreateBackgroundModel(faction);
	--[[if CharacterCreate.selectedClass == 11 then
		backgroundFilename = "DEMONHUNTER"
	end]]

	if (faction == "Alliance") then
		SetBackgroundModel(CharacterCreate, "HUMAN");
	else
		SetBackgroundModel(CharacterCreate, "ORC");
	end

	local _, factionSelected = GetFactionForRace(CharacterCreate.selectedRace);

	local name, faction = GetFactionForRace(id);

	if (factionSelected ~= faction) then
		if not (COA_REALM) then
			faction = faction .. "REGULAR"
		end
		GlueFrameFadeIn(CharacterCreateFrameFade, 0.3, function()
			SetBackgroundModel(CharacterCreate, string.upper(faction));
		end)
	end

	-- Set backdrop colors based on faction
	--根据派系设置背景颜色
	local backdropColor = FACTION_BACKDROP_COLOR_TABLE[faction];
	--CharCreateRaceFrame.factionBg:SetGradient("VERTICAL", 0, 0, 0, backdropColor[7], backdropColor[8], backdropColor[9]);
	--CharCreateClassFrame.factionBg:SetGradient("VERTICAL", 0, 0, 0, backdropColor[7], backdropColor[8], backdropColor[9]);
	--CharCreateCustomizationFrame.factionBg:SetGradient("VERTICAL", 0, 0, 0, backdropColor[7], backdropColor[8], backdropColor[9]);
	--harCreatePreviewFrame.factionBg:SetGradient("VERTICAL", 0, 0, 0, backdropColor[7], backdropColor[8], backdropColor[9]);
	CharCreateCustomizationFrameBanner:SetVertexColor(backdropColor[10], backdropColor[11], backdropColor[12]);
	CharacterCreateNameEdit:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	--CharCreateRaceInfoFrame.factionBg:SetGradient("VERTICAL", 0, 0, 0, backdropColor[7], backdropColor[8], backdropColor[9]);
	--CharCreateClassInfoFrame.factionBg:SetGradient("VERTICAL", 0, 0, 0, backdropColor[7], backdropColor[8], backdropColor[9]);

	-- race info
	local frame = CharCreateRaceInfoFrame;
	local race, fileString = GetNameForRace();
	frame.title:SetText(race);
	fileString = strupper(fileString);
	local gender;
	if ( GetSelectedSex() == SEX_MALE ) then
		gender = "MALE";
	else
		gender = "FEMALE";
	end
	local raceText = _G["RACE_INFO_"..fileString];
	local abilityIndex = 1;
	local tempText = _G["ABILITY_INFO_"..fileString..abilityIndex];
	abilityText = "";
	while ( tempText ) do
		abilityText = abilityText..tempText.."\n\n";
		abilityIndex = abilityIndex + 1;
		tempText = _G["ABILITY_INFO_"..fileString..abilityIndex];
	end
	CharCreateRaceInfoFrameScrollFrameScrollBar:SetValue(0);
	local text
	text = GetFlavorText("RACE_INFO_"..strupper(fileString), GetSelectedSex())
	if not text then
		text = "Not in GlueXML."
	end
	CharCreateRaceInfoFrame.scrollFrame.scrollChild.infoText:SetText(text.."|n|n");
	if ( abilityText and abilityText ~= "" ) then
		CharCreateRaceInfoFrame.scrollFrame.scrollChild.bulletText:SetText(abilityText);
	else
		CharCreateRaceInfoFrame.scrollFrame.scrollChild.bulletText:SetText("");
	end

	-- Altered form
	--[[if (HasAlteredForm()) then
		SetPortraitTexture(CharacterCreateAlternateFormTopPortrait, 22, GetSelectedSex());
		SetPortraitTexture(CharacterCreateAlternateFormBottomPortrait, 23, GetSelectedSex());
		CharacterCreateAlternateFormTop:Show();
		CharacterCreateAlternateFormBottom:Show();
		if( IsViewingAlteredForm() ) then
			CharacterCreateAlternateFormTop:SetChecked(false);
			CharacterCreateAlternateFormBottom:SetChecked(true);
		else
			CharacterCreateAlternateFormTop:SetChecked(true);
			CharacterCreateAlternateFormBottom:SetChecked(false);
		end
	else
		CharacterCreateAlternateFormTop:Hide();
		CharacterCreateAlternateFormBottom:Hide();
	end]]
end

--设置角色职业的函数。
function SetCharacterClass(id)
	if id == 11 then
		return
	end
	CharacterCreate.selectedClass = 1;--id;
	for i=1, CharacterCreate.numClasses, 1 do
		local button = _G["CharCreateClassButton"..i];
		if ( i == id ) then
			button:SetChecked(1);
		else
			button:SetChecked(0);
			button.selection:Hide();
		end
	end

	-- class info
	local frame = CharCreateClassInfoFrame;
	local className, classFileName, _, tank, healer, damage = GetSelectedClass();
	local abilityIndex = 0;
	if not classFileName then
		classFileName = "WARRIOR"
	end
	local tempText = _G["CLASS_INFO_"..classFileName..abilityIndex];
	abilityText = "";
	while ( tempText ) do
		abilityText = abilityText..tempText.."\n\n";
		abilityIndex = abilityIndex + 1;
		tempText = _G["CLASS_INFO_"..classFileName..abilityIndex];
	end
	CharCreateClassInfoFrame.title:SetText(className);
	CharCreateClassInfoFrame.scrollFrame.scrollChild.bulletText:SetText(abilityText);
	CharCreateClassInfoFrame.scrollFrame.scrollChild.infoText:SetText(GetFlavorText("CLASS_"..strupper(classFileName), GetSelectedSex()).."|n|n");
	CharCreateClassInfoFrameScrollFrameScrollBar:SetValue(0);
end

--角色创建界面输入字符时执行的函数。
function CharacterCreate_OnChar()
end

--角色创建界面按下键盘按键时执行的函数。
function CharacterCreate_OnKeyDown(key)
	if ( key == "ESCAPE" ) then
		CharacterCreate_Back();
	elseif ( key == "ENTER" ) then
		CharacterCreate_Forward();
	elseif ( key == "PRINTSCREEN" ) then
		Screenshot();
	end
end

-- 更新角色模型的函数。
function CharacterCreate_UpdateModel(self)
	UpdateCustomizationScene(); 		-- 更新自定义场景	
	self:AdvanceTime();      			-- 推进时间（应该是让动画动起来）
end

--角色创建完成时执行的函数。
function CharacterCreate_Finish()
	PlaySound("gsCharacterCreationCreateChar");

	--如果有哪里禁用了此按钮，请忽略此消息。
	--例如，如果在禁用时按enter键，就会发生这种情况。
	if ( not CharCreateOkayButton:IsEnabled() ) then
		return;
	end

	if ( PAID_SERVICE_TYPE ) then
		GlueDialog_Show("CONFIRM_PAID_SERVICE");
	else
		--如果使用模板，熊猫侠必须选择一个派系
		local _, faction = GetFactionForRace(CharacterCreate.selectedRace);
		--if ( IsUsingCharacterTemplate() and ( faction ~= "Alliance" and faction ~= "Horde" ) ) then
		--	CharacterTemplateConfirmDialog:Show();
		--else
			CreateCharacter(CharacterCreateNameEdit:GetText());
		--end
	end
end

--角色创建返回上一个步骤时执行的函数。
function CharacterCreate_Back()
	if ( CharacterCreateFrame.state == "CUSTOMIZATION" ) then
		PlaySound("gsCharacterCreationCancel");
		CharacterCreateFrame.state = "CLASSRACE"
		CharCreateClassFrame:Show();
		CharCreateRaceFrame:Show();
		CharCreateMaleButton:Show()
		CharCreateFemaleButton:Show()
		-- CharCreateMoreInfoButton:Show();
		CharCreateCustomizationFrame:Hide();
		CharCreatePreviewFrame:Hide();
		CharCreateOkayButton:SetText(NEXT);
		CharacterCreateNameEdit:Hide();
		CharacterCreateRandomName:Hide();
		CustomizationBG:Hide()
		CharCreateRandomizeButton:Hide()
		--CustomizationLogoAlliance:Show()	--联盟图标显示
		--CustomizationTextAlliance:Show()	--部落文字显示
		--CustomizationLogoHorde:Show()		--部落图标显示
		--CustomizationTextHorde:Show()		--部落文字显示

		--很棒的装备
		--SetSelectedPreviewGearType(1);

		-- 正常的相机
		--SetFaceCustomizeCamera(false);

		return;
	end

	PlaySound("gsCharacterCreationCancel");
	CHARACTER_SELECT_BACK_FROM_CREATE = true;
	SetGlueScreen("charselect");
end

--更新角色面部毛发自定义的函数。
function CharacterCreate_UpdateFacialHairCustomization()
	if ( GetFacialHairCustomization() == "NONE" ) then
		CharacterCustomizationButtonFrame5:Hide();
		--CharCreateRandomizeButton:SetPoint("TOP", "CharacterCustomizationButtonFrame5", "BOTTOM", 0, -5);
	else
		CharacterCustomizationButtonFrame5Text:SetText(_G["FACIAL_HAIR_"..GetFacialHairCustomization()]);
		CharacterCustomizationButtonFrame5:Show();
		--CharCreateRandomizeButton:SetPoint("TOP", "CharacterCustomizationButtonFrame5", "BOTTOM", 0, -5);
	end
end

--更新角色头发自定义的函数。
function CharacterCreate_UpdateHairCustomization()
	if not _G["HAIR_"..GetHairCustomization().."_STYLE"] or _G["HAIR_"..GetHairCustomization().."_STYLE"] == "" then
		CharCreateCustomizationButton3:Hide()
		CharCreateCustomizationButton4:SetPoint("TOP", CharCreateCustomizationButton2, "BOTTOM", 0, -20)
	else
		CharCreateCustomizationButton3:Show()
		CharCreateCustomizationButton3.text:SetText(_G["HAIR_"..GetHairCustomization().."_STYLE"])
		--CharCreateCustomizationButton4:SetPoint("TOP", CharCreateCustomizationButton3, "BOTTOM", 0, -20)
	end

	if not _G["HAIR_"..GetHairCustomization().."_COLOR"] or _G["HAIR_"..GetHairCustomization().."_COLOR"] == "" then
		CharCreateCustomizationButton4:Hide()
		if CharCreateCustomizationButton3:IsShown() then
			CharCreateCustomizationButton5:SetPoint("TOP", CharCreateCustomizationButton4, "BOTTOM", 0, 0)
		else
			CharCreateCustomizationButton5:SetPoint("TOP", CharCreateCustomizationButton3, "BOTTOM", 0, 0)
		end
	else
		CharCreateCustomizationButton4:Show()
		CharCreateCustomizationButton4.text:SetText(_G["HAIR_"..GetHairCustomization().."_COLOR"])
		CharCreateCustomizationButton5:SetPoint("TOP", CharCreateCustomizationButton4, "BOTTOM", 0, 0)
	end

	if not _G["FACIAL_HAIR_"..GetFacialHairCustomization()] or _G["FACIAL_HAIR_"..GetFacialHairCustomization()] == "" then
		CharCreateCustomizationButton5:Hide()
	else
		CharCreateCustomizationButton5:Show()
		CharCreateCustomizationButton5.text:SetText(_G["FACIAL_HAIR_"..GetFacialHairCustomization()])
	end

end

--角色创建进入下一个步骤时执行的函数。
function CharacterCreate_Forward()
	_G["CharaCustomTexFrameText1"]:SetText("刚刚进入了改变外观界面");
	if ( CharacterCreateFrame.state == "CLASSRACE" ) then
		CharacterCreateFrame.state = "CUSTOMIZATION"		-- 更改状态为自定义
		PlaySound("gsCharacterSelectionCreateNew");			-- 	播放声音
		CharCreateClassFrame:Hide();						-- 	隐藏职业和种族框架
		CharCreateRaceFrame:Hide();
		-- CharCreateMoreInfoButton:Hide();
		CharCreateCustomizationFrame:Show();				-- 	显示自定义框架
		CharacterCreate_UpdateHairCustomization()			-- 	更新发型自定义
		--CharCreatePreviewFrame:Show();
		CharacterTemplateConfirmDialog:Hide();				-- 	隐藏角色模板确认对话框

		CharCreate_PrepPreviewModels();						-- 	准备预览模型
		if ( CharacterCreateFrame.customizationType ) then	-- 	如果有自定义类型，则重置特征显示
			CharCreate_ResetFeaturesDisplay();
		else
			CharCreateSelectCustomizationType(1);			-- 	否则选择第一个自定义类型
		end

		CharCreateOkayButton:SetText(FINISH);				-- 	更改确认按钮的文字为“完成”
		CharacterCreateNameEdit:Show();						-- 	显示角色名输入框
		if ( ALLOW_RANDOM_NAME_BUTTON ) then				-- 	如果允许随机名字，则显示随机名字按钮
			CharacterCreateRandomName:Show();
		end

		CharCreateMaleButton:Hide()							-- 	隐藏性别选择按钮
		CharCreateFemaleButton:Hide()
		CustomizationBG:Show()								-- 	显示自定义背景
		CharCreateRandomizeButton:Show()					-- 	显示随机化按钮
		--CustomizationLogoAlliance:Hide()					--	联盟图标隐藏
		--CustomizationTextAlliance:Hide()					--	联盟文字隐藏
		--CustomizationLogoHorde:Hide()						--	部落图标隐藏
		--CustomizationTextHorde:Hide()						--	部落文字隐藏

		-- Custom Part.

		-- set cam
		-- set cam
		--CameraZoomIn(3.0)
	else
		CharacterCreate_Finish();							-- 完成角色创建
	end
end

--显示角色自定义界面时执行的函数。
function CharCreateCustomizationFrame_OnShow ()
	-- reset size/tex coord to default to facilitate switching between genders for Pandaren
	CharCreateCustomizationFrameBanner:SetSize(BANNER_DEFAULT_SIZE[1], BANNER_DEFAULT_SIZE[2]);
	CharCreateCustomizationFrameBanner:SetTexCoord(BANNER_DEFAULT_TEXTURE_COORDS[1], BANNER_DEFAULT_TEXTURE_COORDS[2], BANNER_DEFAULT_TEXTURE_COORDS[3], BANNER_DEFAULT_TEXTURE_COORDS[4]);

	-- check each button and hide it if there are no values select
	local resize = 0;
	local lastGood = 0;
	local isSkinVariantHair = false --GetSkinVariationIsHairColor(CharacterCreate.selectedRace);
	local isDefaultSet = 0;
	local checkedButton = 1;

	-- check if this was set, if not, default to 1
	if ( CharacterCreateFrame.customizationType == 0 or CharacterCreateFrame.customizationType == nil ) then
		CharacterCreateFrame.customizationType = 1;
	end
	for i=1, NUM_CHAR_CUSTOMIZATIONS, 1 do
		if ( ( --[[GetNumFeatureVariationsForType(i)]]5 <= 1 ) or ( isSkinVariantHair and i == CHAR_CUSTOMIZE_HAIR_COLOR ) ) then
			resize = resize + 1;
			_G["CharCreateCustomizationButton"..i]:Hide();
		else
			_G["CharCreateCustomizationButton"..i]:Show();
			--_G["CharCreateCustomizationButton"..i]:SetChecked(0); -- we will handle default selection
			-- this must be done since a selected button can 'disappear' when swapping genders
			if ( isDefaultSet == 0 and CharacterCreateFrame.customizationType == i) then
				isDefaultSet = 1;
				checkedButton = i;
			end
			-- set your anchor to be the last good, this currently means button 1 HAS to be shown
			if (i > 1) then
				_G["CharCreateCustomizationButton"..i]:SetPoint( "TOP",_G["CharCreateCustomizationButton"..lastGood]:GetName() , "BOTTOM");
			end
			lastGood = i;
		end
	end

	if (isDefaultSet == 0) then
		CharacterCreateFrame.customizationType = lastGood;
		checkedButton = lastGood;
	end
	--_G["CharCreateCustomizationButton"..checkedButton]:SetChecked(1);

	if (resize > 0) then
	-- we need to resize and remap the banner texture
		local buttonx, buttony = CharCreateCustomizationButton1:GetSize()
		local screenamount = resize*buttony;
		print(screenamount);
		local frameX, frameY = CharCreateCustomizationFrameBanner:GetSize();
		local pctShrink = .2*resize;
		local uvXDefaultSize = BANNER_DEFAULT_TEXTURE_COORDS[2] - BANNER_DEFAULT_TEXTURE_COORDS[1];
		local uvYDefaultSize = BANNER_DEFAULT_TEXTURE_COORDS[4] - BANNER_DEFAULT_TEXTURE_COORDS[3];
		local newYUV = pctShrink*uvYDefaultSize + BANNER_DEFAULT_TEXTURE_COORDS[3];
		-- end coord stay the same
		CharCreateCustomizationFrameBanner:SetTexCoord(BANNER_DEFAULT_TEXTURE_COORDS[1], BANNER_DEFAULT_TEXTURE_COORDS[2], newYUV, BANNER_DEFAULT_TEXTURE_COORDS[4]);
		print(pctShrink);
		CharCreateCustomizationFrameBanner:SetSize(frameX, frameY - screenamount);
		print(CharCreateCustomizationFrameBanner:GetTexCoord());
	end

	--CharCreateRandomizeButton:SetPoint("TOP", _G["CharCreateCustomizationButton"..lastGood]:GetName(), "BOTTOM", 0, 0);
end

--角色职业选择时执行的函数。
function CharacterClass_OnClick(self, id)
	if( self:IsEnabled() ) then
		PlaySound("gsCharacterCreationClass");
		local _,_,currClass = GetSelectedClass();
		if ( currClass ~= id ) then
			SetSelectedClass(id);
			SetCharacterClass(id);
			SetCharacterRace(GetSelectedRace());
			CharacterChangeFixup();
		else
			self:SetChecked(1);
		end
	else
		self:SetChecked(0);
	end
end

--角色种族选择时执行的函数。
function CharacterRace_OnClick(self, id, forceSelect)
	_G["CharaRaceDescriptionFrameText1"]:SetText("self.tooltip")
	if( self:IsEnabled() ) then
		PlaySound("gsCharacterCreationClass");
		if ( GetSelectedRace() ~= id or forceSelect ) then
			SetSelectedRace(id);
			SetCharacterRace(id);
			--[[if ( id == TUSKARR_RACE_ID ) then
				SetCharacterGender(SEX_MALE);
			else]]
				SetCharacterGender(GetSelectedSex());
			--end
			SetCharacterCreateFacing(-15);
			--CharacterCreateEnumerateClasses(GetAvailableClasses());
			local _,_,classIndex = GetSelectedClass();
			if ( PAID_SERVICE_TYPE ) then
				classIndex = PaidChange_GetCurrentClassIndex();
				SetSelectedClass(classIndex);	-- selecting a race would have changed class to default
			end
			SetCharacterClass(classIndex);

			-- Hair customization stuff
			CharacterCreate_UpdateHairCustomization();

			CharacterChangeFixup();
		else
			self:SetChecked(1);
		end
	else
		self:SetChecked(0);
	end
end

--设置角色性别的函数。
function SetCharacterGender(sex)
	local gender;

	if ( sex == SEX_MALE ) then
		CharCreateMaleButton:SetChecked(1);
		CharCreateFemaleButton:SetChecked(0);
	else
		CharCreateMaleButton:SetChecked(0);
		CharCreateFemaleButton:SetChecked(1);
	end
	SetSelectedSex(sex);

	-- Update race images to reflect gender
	CharacterCreateEnumerateRaces(GetAvailableRaces());
	--CharacterCreateEnumerateClasses(GetAvailableClasses());
 	SetCharacterRace(GetSelectedRace());

	local _,_,classIndex = GetSelectedClass();
	if ( PAID_SERVICE_TYPE ) then
		classIndex = PaidChange_GetCurrentClassIndex();
		-- PandarenFactionButtons_SetTextures();
	end
	SetCharacterClass(classIndex);

	CharacterCreate_UpdateHairCustomization();
	CharacterChangeFixup();

	-- 如果处于自定义步骤，则更新预览模型
	if ( CharCreatePreviewFrame:IsShown() ) then
		CharCreateCustomizationFrame_OnShow(); -- 脏熊猫可能需要重置按钮
		CharCreate_PrepPreviewModels();
		CharCreate_ResetFeaturesDisplay();
	end
end

--角色自定义左旋转时执行的函数。
function CharacterCustomization_Left(id)
	if id == 1 then
		_G["CharaCustomTexFrameText1"]:SetText("左按钮["..id.."]选择了肤色按钮");
		SetFaceCustomizeCamera(false)
	else
		_G["CharaCustomTexFrameText1"]:SetText("左按钮["..id.."]选择了其他面部特征");
		SetFaceCustomizeCamera(true)
	end
	PlaySound("gsCharacterCreationLook");
	CycleCharCustomization(id, -1);
end

--角色自定义右旋转时执行的函数。
function CharacterCustomization_Right(id)
	if id == 1 then
		_G["CharaCustomTexFrameText1"]:SetText("右按钮["..id.."]选择了肤色按钮");
		SetFaceCustomizeCamera(false)
	else
		_G["CharaCustomTexFrameText1"]:SetText("右按钮["..id.."]选择了其他面部特征");
		SetFaceCustomizeCamera(true)
	end
	PlaySound("gsCharacterCreationLook");
	CycleCharCustomization(id, 1);
end

--随机生成角色名称的函数。
function CharacterCreate_GenerateRandomName(button)
	CharacterCreateNameEdit:SetText(GetRandomName());
end

--角色创建随机化的函数。
function CharacterCreate_Randomize()
	PlaySound("gsCharacterCreationLook");
	RandomizeCharCustomization();
	CharCreate_ResetFeaturesDisplay();
end

--角色模型向右旋转时执行的函数。
function CharacterCreateRotateRight_OnUpdate(self)
	if ( self:GetButtonState() == "PUSHED" ) then
		SetCharacterCreateFacing(GetCharacterCreateFacing() + CHARACTER_FACING_INCREMENT);
		CharCreate_RotatePreviews();
	end
end

--角色模型向左旋转时执行的函数。
function CharacterCreateRotateLeft_OnUpdate(self)
	if ( self:GetButtonState() == "PUSHED" ) then
		SetCharacterCreateFacing(GetCharacterCreateFacing() - CHARACTER_FACING_INCREMENT);
		CharCreate_RotatePreviews();
	end
end

--设置按钮是否灰化的函数。
function SetButtonDesaturated(button, desaturated)
	if ( not button ) then
		return;
	end
	local icon = button:GetNormalTexture();
	if ( not icon ) then
		return;
	end

	icon:SetDesaturated(desaturated);
end

--获取配文本的函数。
function GetFlavorText(tagname, sex)
	local primary, secondary;
	if ( sex == SEX_MALE ) then
		primary = "";
		secondary = "_FEMALE";
	else
		primary = "_FEMALE";
		secondary = "";
	end
	local text = _G[tagname..primary];
	if ( (text == nil) or (text == "") ) then
		text = _G[tagname..secondary];
	end
	return text;
end

--角色变更时执行的函数。
function CharacterChangeFixup()
	if ( PAID_SERVICE_TYPE ) then
		-- no class changing as a paid service
		CharCreateClassFrame:SetAlpha(0.5);
		for i=1, MAX_CLASSES_PER_RACE, 1 do
			if (CharacterCreate.selectedClass ~= i) then
				local button = _G["CharCreateClassButton"..i];
				button:Disable();
				SetButtonDesaturated(button, true);
			end
		end

		local numAllowedRaces = 0;
		for i=1, MAX_RACES, 1 do
			local allow = false;
			if ( PAID_SERVICE_TYPE == PAID_FACTION_CHANGE ) then
				--[[local faction = PaidChange_GetCurrentFaction();
				if ( (i == PaidChange_GetCurrentRaceIndex()) or ((GetFactionForRace(i) ~= faction) and (IsRaceClassValid(i,CharacterCreate.selectedClass))) ) then
					allow = true;
				end]]
				for i=1,MAX_RACES do
					allow = true
				end
			elseif ( PAID_SERVICE_TYPE == PAID_RACE_CHANGE ) then
				--[[local faction = PaidChange_GetCurrentFaction();
				if ( (i == PaidChange_GetCurrentRaceIndex()) or ((GetFactionForRace(i) == faction or IsNeutralRace(i)) and (IsRaceClassValid(i,CharacterCreate.selectedClass))) ) then
					allow = true
				end]]
				local fact = CharacterCreate.selectedRace
				--local str = tostring(fact)..": "
				for i=1,MAX_RACES do
					if (fact < MAX_RACES and i < MAX_RACES) or (fact > (MAX_RACES-1) and i > (MAX_RACES-1)) then
						allow = true
						local button = _G["CharCreateRaceButton"..i];
						button:Enable();
						SetButtonDesaturated(button, false);
					else
						allow = false
						--str = str..tostring(i)..", "
						local button = _G["CharCreateRaceButton"..i];
						button:Disable();
						SetButtonDesaturated(button, true);
					end
				end
				--message(str)
			elseif ( PAID_SERVICE_TYPE == PAID_CHARACTER_CUSTOMIZATION ) then
				if ( i == CharacterCreate.selectedRace ) then
					allow = true
				end
			end
			if (not allow) then
				--local button = _G["CharCreateRaceButton"..i];
				--button:Disable();
				--SetButtonDesaturated(button, true);
			else
				numAllowedRaces = numAllowedRaces + 1;
			end
		end
		if ( numAllowedRaces > 1 ) then
			CharCreateRaceButtonsFrame:SetAlpha(1);
		else
			CharCreateRaceButtonsFrame:SetAlpha(0.5);
		end
	else
		CharCreateRaceButtonsFrame:SetAlpha(1);
		CharCreateClassFrame:SetAlpha(1);
	end
end

--选择角色自定义类型时执行的函数。
function CharCreateSelectCustomizationType(newType)
	-- deselect previous type selection
	if ( CharacterCreateFrame.customizationType and CharacterCreateFrame.customizationType ~= newType ) then
		--_G["CharCreateCustomizationButton"..CharacterCreateFrame.customizationType]:SetChecked(0);
	end
	--_G["CharCreateCustomizationButton"..newType]:SetChecked(1);
	CharacterCreateFrame.customizationType = newType;
	CharCreate_ResetFeaturesDisplay();

	--[[if (newType > 1) then
		SetFaceCustomizeCamera(true);
	else
		SetFaceCustomizeCamera(false);
	end]]
end

--重置角色自定义特征显示的函数。
function CharCreate_ResetFeaturesDisplay()
	--SetPreviewFramesFeature(CharacterCreateFrame.customizationType);
	-- set the previews scrollframe container height
	-- since the first and the last previews need to be in the center position when scrolled all the way
	-- to the top or to the bottom, there will be gaps of height equal to 2 previews on each side
	--设置预览框架功能（CharacterCreateFrame.customizationType）；
	--设置预览滚动框容器高度
	--因为第一个和最后一个预览需要在滚动时处于中心位置
	--到顶部或底部，每侧将有高度等于2个预览的间隙
	local numTotalButtons = 4--GetNumFeatureVariations() + 4;
	CharCreatePreviewFrame.scrollFrame.container:SetHeight(numTotalButtons * PREVIEW_FRAME_HEIGHT - PREVIEW_FRAME_Y_OFFSET);

	for _, previewFrame in pairs(CharCreatePreviewFrame.previews) do
		previewFrame.featureType = 0;
	end

	CharCreate_DisplayPreviewModels();
end

--准备预览角色模型的函数。
function CharCreate_PrepPreviewModels(reloadModels)
	local displayFrame = CharCreatePreviewFrame;

	--如果rebuildPreviews被标记，则清除模型
	local rebuildPreviews = displayFrame.rebuildPreviews;
	displayFrame.rebuildPreviews = nil;

	--需要重新加载模型类已交换到DK或从DK交换
	local classSwap = false;
	local _, class = GetSelectedClass();
	--检查是否有类别交换的情况，并设置标志
	--[[if ( class == "DEATHKNIGHT" or displayFrame.lastClass == "DEATHKNIGHT" ) and ( class ~= displayFrame.lastClass ) then
		classSwap = true;
	end]]

	--始终清除featureType
	for index, previewFrame in pairs(displayFrame.previews) do
		previewFrame.featureType = 0;
		--如果类别更改，则强制模型重新加载
		if ( classSwap ) then
			previewFrame.race = nil;
			previewFrame.gender = nil;
		end
		--如果标记了rebuildPreviews，则重新设置预览框架
		if ( rebuildPreviews ) then
			--SetPreviewFrame(previewFrame.model:GetName(), index);
		end
	end
	if (previewFrame and previewFrame.ModelScene) then
		previewFrame.ModelScene:SetCameraTargetOffset(Vector(0, 0, 0.5));
		previewFrame.ModelScene:SetCameraZoom(1.5);
	end
end

--显示预览角色模型的函数。
function CharCreate_DisplayPreviewModels(selectionIndex)
	if ( not selectionIndex ) then
		selectionIndex = featureIndex--GetSelectedFeatureVariation();
	end

	local displayFrame = CharCreatePreviewFrame;
	local previews = displayFrame.previews;
	local numVariations = 8--GetNumFeatureVariations();
	local currentFeatureType = CharacterCreateFrame.customizationType;

	local race = GetSelectedRace();
	local gender = GetSelectedSex();

	-- selection index is the center preview
	-- there are 2 previews above and 2 below, and will pad it out to 1 more on each side, for a total of 7 previews to set up
	--选择索引是中心预览
	--上面有2个预览，下面有2个，每侧都会增加1个，总共需要设置7个预览
	for index = selectionIndex - 3, selectionIndex + 3 do
		-- there is empty space both at the beginning and at end of the list, each gap the height of 2 previews
		--列表的开头和结尾都有空白，每个空白的高度为2个预览
		if ( index > 0 and index <= numVariations ) then
			local previewFrame = previews[index];
			-- create button if we don't have it yet
			--如果我们还没有创建按钮
			if ( not previewFrame ) then
				previewFrame = CreateFrame("BUTTON", "PreviewFrame"..index, displayFrame.scrollFrame.container, "CharCreatePreviewFrameTemplate");
				-- index + 1 because of 2 gaps at the top and -1 for the current preview
				--索引+1，因为顶部有2个间隙，当前预览为-1
				previewFrame:SetPoint("TOPLEFT", PREVIEW_FRAME_X_OFFSET, (index + 1) * -PREVIEW_FRAME_HEIGHT + PREVIEW_FRAME_Y_OFFSET);
				previewFrame.button.index = index;
				previews[index] = previewFrame;
				--SetPreviewFrame(previewFrame.model:GetName(), index);

				-- no texture as of yet
				--到目前为止还没有纹理

				--previewFrame:SetNormalTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
			end
			-- load model if needed, may have been cleared by different race/gender selection
			--负荷模型（如果需要）可能已被不同种族/性别的选择清除
			if ( previewFrame.race ~= race or previewFrame.gender ~= gender ) then
				--SetPreviewFrameModel(index);
				previewFrame.race = race;
				previewFrame.gender = gender;
				-- apply settings
				--应用设置
				local model = previewFrame.model;
				--model:SetCustomCamera(cameraID);
				local scale = 1--model:GetWorldScale();
				--model:SetCameraTarget(config.tx * scale, config.ty * scale, config.tz * scale);
				--model:SetCameraDistance(config.distance * scale);
				local cx, cy, cz = model:GetPosition();
				-- model:SetPosition(cx-15, cy, cz)
				--model:SetCameraPosition(cx, cy, config.cz * scale);
				previewFrame.model:SetLight(1, 0, 0, 0, 0, 1, 1.0, 1.0, 1.0);
			end

			-- need to reset the model if it was last used to preview a different feature
			--如果上次用于预览不同的功能，则需要重置模型

			if ( previewFrame.featureType ~= currentFeatureType ) then
				--ResetPreviewFrameModel(index);
				--ShowPreviewFrameVariation(index);
				previewFrame.featureType = currentFeatureType;
			end
			previewFrame:Show();
		else
			
			-- need to hide tail previews when going to features with fewer styles
			--转到样式较少的功能时需要隐藏尾部预览

			if ( previews[index] ) then
				previews[index]:Hide();
			end
		end
	end
	displayFrame.border.number:SetText("Option "..selectionIndex.."                     ");
	displayFrame.selectionIndex = selectionIndex;
	CharCreate_RotatePreviews();
	CharCreatePreviewFrame_UpdateStyleButtons();
	
	-- scroll to center the selection
	--滚动以居中选择

	if ( not displayFrame.animating ) then
		displayFrame.scrollFrame:SetVerticalScroll((selectionIndex - 1) * PREVIEW_FRAME_HEIGHT);
	end
end

--预览角色模型旋转时执行的函数。
function CharCreate_RotatePreviews()
	if ( CharCreatePreviewFrame:IsShown() ) then
		local facing = ((GetCharacterCreateFacing())/ -180) * math.pi;
		local previews = CharCreatePreviewFrame.previews;
		--CharCreatePreviewFrame.selectionIndex = 0;
		for index = CharCreatePreviewFrame.selectionIndex - 3, CharCreatePreviewFrame.selectionIndex + 3 do
			local previewFrame = previews[index];
			if ( previewFrame ) then -- and previewFrame.model:HasCustomCamera()
				--previewFrame.model:SetCameraFacing(facing);
			end
		end
	end
end

--更改角色自定义特征变量的函数。
function CharCreate_ChangeFeatureVariation(delta)
	local numVariations = 8--GetNumFeatureVariations();
	local startIndex = featureIndex--GetSelectedFeatureVariation();
	local endIndex = startIndex + delta;
	if ( endIndex < 1 or endIndex > numVariations ) then
		return;
	end
	PlaySound("gsCharacterCreationClass");
	featureIndex = endIndex
	CharCreatePreviewFrame_SelectFeatureVariation(endIndex);

	--_G["CharaCustomTexFrameText1"]:SetText("delta");
end

--预览角色模型按钮点击时执行的函数。
function CharCreatePreviewFrameButton_OnClick(self)
	PlaySound("gsCharacterCreationClass");
	CharCreatePreviewFrame_SelectFeatureVariation(self.index);
end

--选择角色自定义特征变量时执行的函数。
function CharCreatePreviewFrame_SelectFeatureVariation(endIndex)
	local self = CharCreatePreviewFrame;
	if ( self.animating ) then
		if ( not self.queuedIndex ) then
			self.queuedIndex = endIndex;
		end
	else
		local startIndex = featureIndex--GetSelectedFeatureVariation();
		--SelectFeatureVariation(endIndex);
		for i=1,endIndex do
			CycleCharCustomization(FeatureType, 1);
		end
		CharCreatePreviewFrame_UpdateStyleButtons();
		featureIndex = endIndex
		CharCreatePreviewFrame_StartAnimating(startIndex, endIndex);
	end
end

--开始预览角色模型动画时执行的函数
function CharCreatePreviewFrame_StartAnimating(startIndex, endIndex)
	local self = CharCreatePreviewFrame;
	if ( self.animating ) then
		return;
	else
		self.startIndex = startIndex;
		self.currentIndex = startIndex;
		self.endIndex = endIndex;
		self.queuedIndex = nil;
		self.direction = 1;
		if ( self.startIndex > self.endIndex ) then
			self.direction = -1;
		end
		self.movedTotal = 0;
		self.moveUntilUpdate = PREVIEW_FRAME_HEIGHT;
		self.animating = true;
	end
end

--停止预览角色模型动画时执行的函数。
function CharCreatePreviewFrame_StopAnimating()
	local self = CharCreatePreviewFrame;
	if ( self.animating ) then
		self.animating = false;
	end
end

local ANIMATION_SPEED = 5;

--预览角色模型更新时执行的函数。
function CharCreatePreviewFrame_OnUpdate(self, elapsed)
	if ( self.animating ) then
		local moveIncrement = PREVIEW_FRAME_HEIGHT * elapsed * ANIMATION_SPEED;
		self.movedTotal = self.movedTotal + moveIncrement;
		self.scrollFrame:SetVerticalScroll((self.startIndex - 1) * PREVIEW_FRAME_HEIGHT + self.movedTotal * self.direction);
		self.moveUntilUpdate = self.moveUntilUpdate - moveIncrement;
		if ( self.moveUntilUpdate <= 0 ) then
			self.currentIndex = self.currentIndex + self.direction;
			self.moveUntilUpdate = PREVIEW_FRAME_HEIGHT;
			-- reset movedTotal to account for rounding errors
			-- 重置movedTotal以考虑舍入误差
			self.movedTotal = abs(self.startIndex - self.currentIndex) * PREVIEW_FRAME_HEIGHT;
			CharCreate_DisplayPreviewModels(self.currentIndex);
		end
		if ( self.currentIndex == self.endIndex ) then
			self.animating = false;
			CharCreate_DisplayPreviewModels();
			if ( self.queuedIndex ) then
				local newIndex = self.queuedIndex;
				self.queuedIndex = nil;
				--SelectFeatureVariation(newIndex);
				--选择特征变化（新索引）；
				featureIndex = newIndex
				CycleCharCustomization(FeatureType, featureIndex);
				CharCreatePreviewFrame_UpdateStyleButtons();
				CharCreatePreviewFrame_StartAnimating(self.endIndex, newIndex);
			end
		end
	end
end

--更新角色自定义样式按钮的函数。
function CharCreatePreviewFrame_UpdateStyleButtons()
	local selectionIndex = math.random(1,5)--GetSelectedFeatureVariation();
	local numVariations = 8--GetNumFeatureVariations();
	if ( selectionIndex == 1 ) then
		CharCreateStyleUpButton:Enable();
		CharCreateStyleUpButton.arrow:SetDesaturated(true);
	else
		CharCreateStyleUpButton:Enable();
		CharCreateStyleUpButton.arrow:SetDesaturated(false);
	end
	if ( selectionIndex == numVariations ) then
		CharCreateStyleDownButton:Disable();
		CharCreateStyleDownButton.arrow:SetDesaturated(true);
	else
		CharCreateStyleDownButton:Disable(true);
		CharCreateStyleDownButton.arrow:SetDesaturated(false);
	end
end

local TotalTime = 0;
local KeepScrolling = nil;
local TIME_TO_SCROLL = 0.5;

--鼠标按下并旋转角色模型时执行的函数。
function CharacterCreateWhileMouseDown_OnMouseDown(direction)
	TIME_TO_SCROLL = 0.5;
	TotalTime = 0;
	KeepScrolling = direction;
	_G["CharaCustomTexFrameText1"]:SetText("delta2");
end

--鼠标抬起时停止旋转角色模型时执行的函数。
function CharacterCreateWhileMouseDown_OnMouseUp()
	KeepScrolling = nil;
end

--鼠标按下并旋转角色模型时更新角色模型的函数。
function CharacterCreateWhileMouseDown_Update(elapsed)
	if ( KeepScrolling ) then
		TotalTime = TotalTime + elapsed;
		if ( TotalTime >= TIME_TO_SCROLL ) then
			CharCreate_ChangeFeatureVariation(KeepScrolling);
			TIME_TO_SCROLL = 0.25;
			TotalTime = 0;
		end
	end
end

-- pandaren stuff related to faction change
--设置是否启用“下一步”按钮的函数。
function CharCreate_EnableNextButton(enabled)
	local button = CharCreateOkayButton;
	if enabled then
		button:Enable();
	else
		button:Disable();
	end
	button.Arrow:SetDesaturated(not enabled);
	if enabled then
		button.TopGlow:Hide();
		button.BottomGlow:Hide();
	else
		button.TopGlow:Show();
		button.BottomGlow:Show();
	end
end


-- function CharCreateMaleButtonOnLoad(self)
-- 	_G["CharCreateMaleButton".."NormalTexture"]:SetNormalTexture("Interface\\Glues\\CHARACTERCREATE\\custom\\maleButton")
-- 	_G["CharCreateMaleButton".."PushedTexture"]:SetPushedTexture("Interface\\Glues\\CHARACTERCREATE\\custom\\maleButton")
-- end
-- -- function PandarenFactionButtons_OnLoad(self)
-- -- 	self.PandarenButton = CharCreateRaceButton6;
-- -- end
-- --
-- -- function PandarenFactionButtons_OnLoad(self)
-- -- 	self.PandarenButton = CharCreateRaceButton6;
-- -- end
--
-- function PandarenFactionButtons_Show()
-- 	local frame = CharCreatePandarenFactionFrame;
-- 	-- set the name
-- 	local raceName = GetNameForRace();
-- 	frame.AllianceButton.nameFrame.text:SetText(raceName);
-- 	frame.AllianceButton.tooltip = raceName;
-- 	frame.HordeButton.nameFrame.text:SetText(raceName);
-- 	frame.HordeButton.tooltip = raceName;
-- 	-- set the texture
-- 	PandarenFactionButtons_SetTextures();
-- 	-- set selected button
-- 	local faction = PaidChange_GetCurrentFaction();
-- 	-- deselect first in case of multiple pandaren faction changes
-- 	PandarenFactionButtons_ClearSelection();
-- 	frame[faction.."Button"]:SetChecked(1);
-- 	-- show the frame on top of the normal pandaren button
-- 	frame:Show();
-- 	frame:SetFrameLevel(frame.PandarenButton:GetFrameLevel() + 2);
-- 	CharCreate_EnableNextButton(false);
-- end
--
-- function PandarenFactionButtons_Hide()
-- 	CharCreatePandarenFactionFrame:Hide();
-- 	CharCreate_EnableNextButton(true);
-- end
--
-- function PandarenFactionButtons_SetTextures()
-- 	--[[local gender = "MALE";
-- 	local coords = RACE_ICON_TCOORDS["TUSKARR_"..gender];
-- 	CharCreatePandarenFactionFrameAllianceButtonNormalTexture:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
-- 	CharCreatePandarenFactionFrameAllianceButtonPushedTexture:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
-- 	CharCreatePandarenFactionFrameHordeButtonNormalTexture:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
-- 	CharCreatePandarenFactionFrameHordeButtonPushedTexture:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);	]]
-- end
--
-- function PandarenFactionButtons_ClearSelection()
-- 	CharCreatePandarenFactionFrame.AllianceButton:SetChecked(0);
-- 	CharCreatePandarenFactionFrame.HordeButton:SetChecked(0);
-- end
--
-- function PandarenFactionButtons_GetSelectedFaction()
-- 	if ( CharCreatePandarenFactionFrame.AllianceButton:GetChecked() ) then
-- 		return "Alliance";
-- 	elseif ( CharCreatePandarenFactionFrame.HordeButton:GetChecked() ) then
-- 		return "Horde";
-- 	end
-- end
--
-- function PandarenFactionButton_OnClick(self)
-- 	PandarenFactionButtons_ClearSelection();
-- 	self:SetChecked(1);
-- 	CharacterRace_OnClick(CharCreatePandarenFactionFrame.PandarenButton, CharCreatePandarenFactionFrame.PandarenButton:GetID(), true);
-- end

