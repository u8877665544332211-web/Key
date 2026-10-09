-- ==========================================================
-- [!] 아래의 따옴표("") 사이에 사용할 키를 입력하세요.
local script_key = "여기에_키를_입력하세요"
-- ==========================================================


-- [ 여기서부터는 시스템 로직이므로 수정하지 마세요 ]
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- 1. 하드웨어 고유 ID(HWID) 추출 함수
local function getHWID()
    local hwid = ""
    if syn and syn.get_hwid then
        hwid = syn.get_hwid()
    elseif gethwid then
        hwid = gethwid()
    elseif RBX_HWID then
        hwid = RBX_HWID()
    else
        hwid = tostring(localPlayer.UserId) .. "_" .. localPlayer.Name
    end
    return hwid
end

-- 2. 등록된 키 목록 (여기다 계속 아래로 써내려가세요!)
-- 형식: ["키"] = "귀속된HWID (처음엔 빈 칸)"
local validKeys = {
    ["KEY_AAA_1111"] = "",
    ["KEY_BBB_2222"] = "",
    ["KEY_CCC_3333"] = "",
    -- 💡 새로운 키를 만들고 싶다면 이 아래로 계속 써내려가세요!
    ["freekey"] = "",
}

-- 3. 실행할 진짜 메인 스크립트의 문서 링크
local mainScriptUrl = "https://raw.githubusercontent.com/u8877665544332211-web/Gg/refs/heads/main/Gg.lua"

local currentHWID = getHWID()

-- 4. 키 검증 및 HWID 귀속 로직
if validKeys[script_key] == nil then
    -- 키가 틀렸거나 목록에 없을 때 (267 에러)
    localPlayer:Kick("\n[Error Code: 267]\n키가 알맞지않습니다. 다른키를 입력하세요.")
else
    local registeredHWID = validKeys[script_key]
    
    if registeredHWID == "" then
        -- 처음 사용하는 키인 경우 -> 현재 하드웨어(HWID)로 귀속
        validKeys[script_key] = currentHWID
        
        -- 인증 성공 후 메인 스크립트 실행
        loadstring(game:HttpGet(mainScriptUrl))()
        
    elseif registeredHWID == currentHWID then
        -- 이미 내 하드웨어에 귀속된 키인 경우 -> 통과
        loadstring(game:HttpGet(mainScriptUrl))()
        
    else
        -- 이미 다른 사람의 하드웨어에 귀속된 키인 경우 (267 에러)
        localPlayer:Kick("\n[Error Code: 267]\n이미 누군가의 하드웨어에 귀속된 키입니다. 하드웨어 리셋을 하거나 키를 새로 만드세요.")
    end
end
