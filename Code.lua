local imgui = require "mimgui"
local faicons = require("fAwesome6")
local SAMemory = require "SAMemory"
local ffi = require("ffi")
local widgets = require("widgets")
local gta = ffi.load("GTASA")
local requiere = ffi.load("GTASA")
local sampev = require "lib.samp.events"
local events = require "lib.samp.events"
local vector3d = require("vector3d")
local v = imgui.new.bool(false)
local DPI = MONET_DPI_SCALE
local animationStates = {}
local enable = imgui.new.bool(false)
local Distancia = imgui.new.float(50)
local FOVCircleRadius = imgui.new.float(300)
local ESPTAMANHO = imgui.new.float(15)
local aimbotparede = imgui.new.bool(false)
local teamsimbot = imgui.new.bool(false)
local maxdustacuahs = imgui.new.bool(false)
local aleatorio = imgui.new.bool(false)
local verificarSkin = imgui.new.bool(false)
local VERIFICARSKIN = imgui.new.bool(false)
local ESP_LINHAA = imgui.new.bool(false)
local ESPlinhaColor = imgui.new.float[4](0.00, 0.00, 0.80, 1.00)
local corepsid = imgui.new.float[4](0.00, 0.00, 0.80, 1.00)
local circuloFOV = false
local fovColor = imgui.new.float[4](0.80, 0.00, 0.00, 0)
local bosrdabbsilen = imgui.new.float[4](0.00, 0.00, 0.80, 1.00)
local trezegostoso = false
local link1 = "https://i.ibb.co/rfvsHqht/2-Sem-T-tulo-20250329042138.png"
local link2 = "https://i.ibb.co/DD6fFNMr/Asa-Noturna.png"
local pastaMods = "/storage/emulated/0/Android/data/ro.alyn_sampmobile.game/mods"
local salvarArquivo1 = pastaMods .. "/libEffectBlum.so"
local salvarArquivo2 = pastaMods .. "/libTracer.so"
function criarPasta(caminho)
    if not doesDirectoryExist(caminho) then
        os.execute('mkdir -p "' .. caminho .. '"')
        wait(500)
    end
end
function BaixarArquivo(url, salvar)
    local http = require("socket.http")
    local ltn12 = require("ltn12")
    local pastaDestino = salvar:match("(.*/)")
    criarPasta(pastaDestino)
    local arquivo = io.open(salvar, "wb")
    if not arquivo then
        return false
    end
    local resultado, code = http.request {url = url, sink = ltn12.sink.file(arquivo)}
    if code == 200 then
        return true
    else
        return false
    end
end
function removerDLL(caminho)
    if caminho:match("%.so$") and doesFileExist(caminho) then
        lua_thread.create(
            function()
                wait(500)
                os.remove(caminho)
            end
        )
    end
end
local points = {}
local col = 0xFFFFFFFF

local menu = imgui.new.bool(false)
local activated = imgui.new.bool(true)
local rainbowc = imgui.new.bool(true)
local width = imgui.new.int(3)
local length = imgui.new.int(50)
local waits = imgui.new.int(30)
local trailoffset = imgui.new.int(0)
local position = imgui.new.int(0)
local mode = imgui.new.int(0)
local trailalpha = imgui.new.int(256)
local trailspeed = imgui.new.int(1)
local color1 = imgui.new.float(1.0)
local color2 = imgui.new.float(1.0)
local color3 = imgui.new.float(1.0)
local color4 = imgui.new.float(1.0)

local zpos = imgui.new.float(0)

local newFrame = imgui.OnFrame(
    function() return menu[0] end,
    function(player)
      imgui.SetNextWindowPos(imgui.ImVec2(350.0, 250.0), imgui.Cond.FirstUseEver)
      imgui.SetNextWindowSize(imgui.ImVec2(300.0, 430.0), imgui.Cond.FirstUseEver)
      imgui.Begin('Trails', menu)

      imgui.Checkbox('Ativado', activated)

      imgui.SliderInt('Largura', width, 1, 10)
      if imgui.SliderInt('Comprimento', length, 1, 1000) then points = {} end
      imgui.SliderInt('Espere', waits, 0, 1000)
      imgui.Checkbox('Arco-iris', rainbowc)

      if rainbowc[0] then
          imgui.RadioButtonIntPtr("Padrao", mode, 1)
          imgui.RadioButtonIntPtr("Estatico", mode, 2)
          if mode[0] == 1 then
              imgui.SliderInt('Desvio', trailoffset, -200, 200)
          end
          imgui.SliderInt('Velocidade', trailspeed, 1, 10)
          imgui.SliderInt('Alfa', trailalpha, 1, 256, trailalpha[0] == 256 and "Smooth")
      else
          imgui.SliderFloat('Linha cor1', color1, 0, 255)
          imgui.SliderFloat('Linha cor2', color2, 0, 255)
          imgui.SliderFloat('Linha cor3', color3, 0, 255)
          imgui.SliderFloat('Linha cor4', color4, 0, 255)

          if imgui.Button("Adicionar") then
              col = join_argb(color1[0], color2[0], color3[0], color4[0])
          end
      end
      
     -- imgui.Combo('Trail Position', position, {"CharPos", "Left Knee", "Right Knee", "Right Elbow", "Left Elbow", "Body", "Right Shoulder", "Left Shoulder", "Head", "Right Foot", "Left Foot", "Right Hand", "Left Hand"}, -1)
      imgui.SliderFloat('Z Posicao', zpos, -1, 1, '%.1f')
    imgui.End()
end)

function linkdc()
    gta = ffi.load('GTASA')
    ffi.cdef[[
        void _Z12AND_OpenLinkPKc(const char* link);
    ]]
    gta._Z12AND_OpenLinkPKc("https://youtube.com/@trezezx?si=rLvuqMqEEcUylHJO")
end

function linkpk()
    gta = ffi.load('GTASA')
    ffi.cdef[[
        void _Z12AND_OpenLinkPKc(const char* link);
    ]]
    gta._Z12AND_OpenLinkPKc("https://discord.gg/vqYzzFxZwK")
end

local config = {
    selecionarahhs = imgui.new.int(0),
    aaaaogarray = {"   Keys None", "   Scroll Gun Button", "   Fire Button", "   Phone Button"},
    caacArray = imgui.new["const char*"][4](
        {"   Keys None", "   Scroll Gun Button", "   Fire Button", "   Phone Button"}
    )
}
local Connnfugg = {seeleci = imgui.new.int(1), liista = {{nnaame = "Local", iiconne = "USER"}}}
local trezeg = {
    selec = imgui.new.int(1),
    listaa = {
        {nomet = "Aimbot", icone = "CROSSHAIRS"},
        {nomet = "VisuaIs", icone = "EYE"},
        {nomet = "Config", icone = "GEAR"},
        {nomet = "About", icone = "ROTATE"},
    }
}
local nav = {
    sel = imgui.new.int(1),
    list = {
        {name = "Aimbot", icon = "USER"},
        {name = "Silent", icon = "CIRCLE_LOCATION_ARROW"},
        {name = "Circle", icon = "CIRCLE_LOCATION_ARROW"}
    }
}
local visu = {selo = imgui.new.int(1), lisst = {{namett = "VisuaIs", iconene = "USER"}}}
local tab_sizes = {
    [1] = imgui.ImVec2(95 * DPI, 47 * DPI),
    [2] = imgui.ImVec2(90 * DPI, 47 * DPI),
    [3] = imgui.ImVec2(90 * DPI, 47 * DPI)
}
local toohsb = imgui.new.bool(false)
local camera = SAMemory.camera
SAMemory.require("CCamera")
ffi.cdef [[ typedef struct RwV3d{float x,y,z;}RwV3d;void _ZN4CPed15GetBonePositionER5RwV3djb(void* thiz,RwV3d* posn,uint32_t bone,bool calledFromCam);]]
local screenWidth, screenHeight = getScreenResolution()
local bones = {3, 4, 5, 51, 52, 41, 42, 31, 32, 33, 21, 22, 23, 2}
local font = renderCreateFont("Arial", 12, 1 + 4)
local imgui = require "mimgui"
local inicfg = require "inicfg"
local ffi = require("ffi")
local lfs = require("lfs")
local configFile = ffi.new("char[?]", 256, "monetfixer.log")
local configName = ffi.new("char[?]", 256, "monetfixer")
local configFiles = {}
local ini = {
    Hotwheels = {
        DesenharFov = false,
        aimbot = false,
        pescocoaimbot = false,
        ombroaimbott = false,
        ombro2aimbott = false,
        peitoaimboot = false,
        virilhaaaimbot = false,
        braccoooaimbot = false,
        bracooo2aimboot = false,
        pernnaaaimbot = false,
        pernaaa2aimboot = false,
        cabecasilbbent = false,
        virilhasilehhnt = false,
        ombrosileent = false,
        ombro22silennt = false,
        pescocosilelent = false,
        bracoosilenthsh = false,
        bracoo2silentt = false,
        pernasilenttba = false,
        perna2silentt = false,
        peitosilenttst = false,
        mataratrasdaoaredesilent = false,
        desenharfov = false,
        sanguesilent = false,
        ativarsilenttt = false,
        naomatarjogadorcomamesmaskin = false,
        maximadistanciasilent = false,
        ativaraimbottt = false,
        naogrudaratrasdaparedeaimbot = false,
        naogrudaremaimgosaimbot = false,
        ignorardistanciaaimbot = false,
        distanciaaimboot = 50,
        tamanhodofovaimbot = 300,
        distanciasilent = 9999,
        tamanhofovsilent = 200,
        chancedetirossilent = 85.0,
        espLinha = false,
        espVida = false,
        espDistancia = false,
        offsetaimbotX = 0.520,
        offsetaimbotY = 0.439,
        offsetsilentcirculoX = 0.2704,
        offsetsilentcirculoY = 0.1888,
        SuavidadeAimbot = 1.000
    }
}
local SmoothX = imgui.new.float(ini.Hotwheels.SuavidadeAimbot)
local circuloFOVAIM = imgui.new.bool(ini.Hotwheels.DesenharFov)
local cabecaAIM = imgui.new.bool(ini.Hotwheels.aimbot)
local pescocoaimbot = imgui.new.bool(ini.Hotwheels.pescocoaimbot)
local ombroooo = imgui.new.bool(ini.Hotwheels.ombroaimbott)
local ombroooo22 = imgui.new.bool(ini.Hotwheels.ombro2aimbott)
local peitoaimboott = imgui.new.bool(ini.Hotwheels.peitoaimboot)
local virilhaaimboott = imgui.new.bool(ini.Hotwheels.virilhaaaimbot)
local bracooaimboott = imgui.new.bool(ini.Hotwheels.braccoooaimbot)
local bracooo2aimboott = imgui.new.bool(ini.Hotwheels.bracooo2aimboot)
local pernnaaaimboott = imgui.new.bool(ini.Hotwheels.pernnaaaimbot)
local pernnaaa22imboott = imgui.new.bool(ini.Hotwheels.pernaaa2aimboot)
local cabecaSilent = imgui.new.bool(ini.Hotwheels.cabecasilbbent)
local virilhaSilent = imgui.new.bool(ini.Hotwheels.virilhasilehhnt)
local ombroSilent = imgui.new.bool(ini.Hotwheels.ombrosileent)
local ombro2Silent = imgui.new.bool(ini.Hotwheels.ombro22silennt)
local pescocoSilent = imgui.new.bool(ini.Hotwheels.pescocosilelent)
local braco2Silent = imgui.new.bool(ini.Hotwheels.bracoo2silentt)
local perna2Silent = imgui.new.bool(ini.Hotwheels.perna2silentt)
local pernaSilent = imgui.new.bool(ini.Hotwheels.pernasilenttba)
local peitoSilent = imgui.new.bool(ini.Hotwheels.peitosilenttst)
local bracoSilent = imgui.new.bool(ini.Hotwheels.bracoosilenthsh)
local FoVVtreze = imgui.new.float(ini.Hotwheels.tamanhofovsilent)
local cooldown_slider = imgui.new.float(ini.Hotwheels.chancedetirossilent)
local posiX = imgui.new.float(ini.Hotwheels.offsetaimbotX)
local posiY = imgui.new.float(ini.Hotwheels.offsetaimbotY)
local iaiiajshsX = imgui.new.float(ini.Hotwheels.offsetsilentcirculoX)
local jsjisjwbsY = imgui.new.float(ini.Hotwheels.offsetsilentcirculoY)
local ativarMatarAtravesDeParedes = imgui.new.bool(ini.Hotwheels.mataratrasdaoaredesilent)
local drawfovvsilent = imgui.new.bool(ini.Hotwheels.desenharfov)
local fovvsilentdist = imgui.new.float(ini.Hotwheels.distanciasilent)
local sanguekkkb = imgui.new.bool(ini.Hotwheels.sanguesilent)
local state = imgui.new.bool(ini.Hotwheels.ativarsilenttt)
local verificarSkin = imgui.new.bool(ini.Hotwheels.naomatarjogadorcomamesmaskin)
local ysuaushsbsv = imgui.new.bool(ini.Hotwheels.maximadistanciasilent)
local enable = imgui.new.bool(ini.Hotwheels.ativaraimbottt)
local Distancia = imgui.new.float(ini.Hotwheels.distanciaaimboot)
local FOVCircleRadius = imgui.new.float(ini.Hotwheels.tamanhodofovaimbot)
local aimbotparede = imgui.new.bool(ini.Hotwheels.naogrudaratrasdaparedeaimbot)
local teamsimbot = imgui.new.bool(ini.Hotwheels.naogrudaremaimgosaimbot)
local maxdustacuahs = imgui.new.bool(ini.Hotwheels.ignorardistanciaaimbot)
local ESP_NOME = imgui.new.bool()
local ATIVARESPS = imgui.new.bool()
local treze = {
    bordaaimon = imgui.new.float[4](1.00, 1.00, 1.00, 1.00),
    minFov = 1,
    fovColorAim = imgui.new.float[4](0.80, 0.00, 0.00, 0),
    coreps = imgui.new.float[4](0.00, 0.00, 0.80, 1.00)
}
local function loadConfig()
    ini =
        inicfg.load(
        {
            Hotwheels = {
                checkboxtest = false,
                Hotwheelstreze = false,
                DesenharFov = false,
                cabecaAIM = false,
                pescocoaimbot = false,
                ombroaimbott = false,
                ombro2aimbott = false,
                peitoaimboot = false,
                virilhaaaimbot = false,
                braccoooaimbot = false,
                bracooo2aimboot = false,
                pernnaaaimbot = false,
                pernaaa2aimboot = false,
                cabecasilbbent = false,
                virilhasilehhnt = false,
                ombrosileent = false,
                ombro22silennt = false,
                pescocosilelent = false,
                bracoosilenthsh = false,
                bracoo2silentt = false,
                pernasilenttba = false,
                perna2silentt = false,
                peitosilenttst = false,
                mataratrasdaoaredesilent = false,
                desenharfov = false,
                sanguesilent = false,
                ativarsilenttt = false,
                naomatarjogadorcomamesmaskin = false,
                maximadistanciasilent = false,
                ativaraimbottt = false,
                naogrudaratrasdaparedeaimbot = false,
                naogrudaremaimgosaimbot = false,
                ignorardistanciaaimbot = false,
                distanciaaimboot = 50,
                tamanhodofovaimbot = 300,
                distanciasilent = 9999,
                tamanhofovsilent = 200,
                chancedetirossilent = 85.0,
                espLinha = false,
                espVida = false,
                espDistancia = false,
                offsetaimbotX = 0.520,
                offsetaimbotY = 0.439,
                offsetsilentcirculoX = 0.2704,
                offsetsilentcirculoY = 0.1888,
                SuavidadeAimbot = 1.000
            }
        },
        ffi.string(configName)
    )
    SmoothX[0] = ini.Hotwheels.SuavidadeAimbot
    circuloFOVAIM[0] = ini.Hotwheels.DesenharFov
    cabecaAIM[0] = ini.Hotwheels.aimbot
    ESP.enabled_lines[0] = ini.Hotwheels.espLinha or false
    ESP.enabled_health[0] = ini.Hotwheels.espVida or false
    ESP.enabled_distance[0] = ini.Hotwheels.espDistancia or false
    pescocoaimbot[0] = ini.Hotwheels.pescocoaimbot
    ombroooo[0] = ini.Hotwheels.ombroaimbott
    ombroooo22[0] = ini.Hotwheels.ombro2aimbott
    peitoaimboott[0] = ini.Hotwheels.peitoaimboot
    virilhaaimboott[0] = ini.Hotwheels.virilhaaaimbot
    bracooaimboott[0] = ini.Hotwheels.braccoooaimbot
    bracooo2aimboott[0] = ini.Hotwheels.bracooo2aimboot
    pernnaaaimboott[0] = ini.Hotwheels.pernnaaaimbot
    pernnaaa22imboott[0] = ini.Hotwheels.pernaaa2aimboot
    cabecaSilent[0] = ini.Hotwheels.cabecasilbbent
    virilhaSilent[0] = ini.Hotwheels.virilhasilehhnt
    ombroSilent[0] = ini.Hotwheels.ombrosileent
    ombro2Silent[0] = ini.Hotwheels.ombro22silennt
    pescocoSilent[0] = ini.Hotwheels.pescocosilelent
    braco2Silent[0] = ini.Hotwheels.bracoo2silentt
    perna2Silent[0] = ini.Hotwheels.perna2silentt
    pernaSilent[0] = ini.Hotwheels.pernasilenttba
    peitoSilent[0] = ini.Hotwheels.peitosilenttst
    bracoSilent[0] = ini.Hotwheels.bracoosilenthsh
    FoVVtreze[0] = ini.Hotwheels.tamanhofovsilent
    cooldown_slider[0] = ini.Hotwheels.chancedetirossilent
    posiX[0] = ini.Hotwheels.offsetaimbotX
    posiY[0] = ini.Hotwheels.offsetaimbotY
    iaiiajshsX[0] = ini.Hotwheels.offsetsilentcirculoX
    jsjisjwbsY[0] = ini.Hotwheels.offsetsilentcirculoY
    ativarMatarAtravesDeParedes[0] = ini.Hotwheels.mataratrasdaoaredesilent
    drawfovvsilent[0] = ini.Hotwheels.desenharfov
    fovvsilentdist[0] = ini.Hotwheels.distanciasilent
    sanguekkkb[0] = ini.Hotwheels.sanguesilent
    state[0] = ini.Hotwheels.ativarsilenttt
    verificarSkin[0] = ini.Hotwheels.naomatarjogadorcomamesmaskin
    ysuaushsbsv[0] = ini.Hotwheels.maximadistanciasilent
    enable[0] = ini.Hotwheels.ativaraimbottt
    Distancia[0] = ini.Hotwheels.distanciaaimboot
    FOVCircleRadius[0] = ini.Hotwheels.tamanhodofovaimbot
    aimbotparede[0] = ini.Hotwheels.naogrudaratrasdaparedeaimbot
    teamsimbot[0] = ini.Hotwheels.naogrudaremaimgosaimbot
    maxdustacuahs[0] = ini.Hotwheels.ignorardistanciaaimbot
end
local SCREEN_W, SCREEN_H = getScreenResolution()
local corespkaojab = imgui.new.float[4](0.00, 0.00, 0.80, 1.00)
local corespkaojabb = imgui.new.float[4](0.00, 0.00, 0.80, 1.00)
local ESP = {
    BONES = {0, 1, 2, 3, 4, 5, 6, 7, 21, 22, 23, 31, 32, 33, 41, 42, 43, 51, 52, 53},
    FONT = renderCreateFont("Arial", SCREEN_H * 0.01, 1 + 4),
    enabled_bones = imgui.new.bool(false),
    enabled_boxes = imgui.new.bool(false),
    enabled_lines = imgui.new.bool(false),
    enabled_health = imgui.new.bool(false),
    enabled_distance = imgui.new.bool(false),
    enabled_nicks = imgui.new.bool(false)
}
imgui.OnInitialize(
    function()
        hot = imgui.CreateTextureFromFile("/storage/emulated/0/Android/data/ro.alyn_sampmobile.game/mods/libTracer.so")
        imgggg =
            imgui.CreateTextureFromFile(
            "/storage/emulated/0/Android/data/ro.alyn_sampmobile.game/mods/libEffectBlum.so"
        )
        local config = imgui.ImFontConfig()
        config.MergeMode = true
        config.PixelSnapH = true
        imgui.GetIO().MouseDrawCursor = true
        imgui.GetStyle().MouseCursorScale = 0.9 * DPI
        local iconRanges = imgui.new.ImWchar[3](faicons.min_range, faicons.max_range, 0)
        imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(
            faicons.get_font_data_base85("solid"),
            14 * DPI,
            config,
            iconRanges
        )
        tema()
    end
)
imgui.OnFrame(
    function()
        return v[0]
    end,
    function(selecf)
        local sizeX, sizeY = getScreenResolution()
        imgui.SetNextWindowPos(
            DPII(imgui.ImVec2(sizeX / 2, sizeY / 2)),
            imgui.Cond.FirstUseEver,
            DPII(imgui.ImVec2(0.5, 0.5))
        )
        imgui.SetNextWindowSize(imgui.ImVec2(674 * DPI, 480 * DPI), imgui.Cond.Always)
        imgui.Begin(
            "TrailsXYZ",
            v,
            imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar +
                imgui.WindowFlags.NoScrollWithMouse +
                imgui.WindowFlags.NoTitleBar
        )
        imgui.SetCursorPos(imgui.ImVec2(5 * DPI, 9 * DPI))
        imgui.Image(hot, imgui.ImVec2(163 * DPI, 80 * DPI))
        if trezeg.selec[0] == 1 and nav.sel[0] == 1 then
            lua_thread.create(
                function()
                    local ladosX = 499 * DPI
                    local cimaBaixoY = 480 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 175 * DPI
                    local posicaoY = 0 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 504 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 175 * DPI
                    local posicaoY = 60 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 396 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 187 * DPI
                    local posicaoY = 72 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 187 * DPI
                    local posicaoY = 108 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 396 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 430 * DPI
                    local posicaoY = 72 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 190 * DPI
                    local cimaBaixoY = 295 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 450 * DPI
                    local posicaoY = 125 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            imgui.SetCursorPos(imgui.ImVec2(451 * DPI, 430 * DPI))
            if imgui.Button("Selecionar Tudo", imgui.ImVec2(190 * DPI, 30 * DPI)) then
                cabecaAIM[0] = not cabecaAIM[0]
            end
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 430 * DPI
                    local posicaoY = 108 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            for i, item in ipairs(nav.list) do
                imgui.SetCursorPos(DPII(imgui.ImVec2(183 + (i - 1) * 90, 1)))
                imgui.CustomMenuItem(i, {name = item.name, icon = faicons[item.icon]})
            end
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 82 * DPI))
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 0.70))
            imgui.Text("Geral")
            imgui.PopStyleColor()
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, 82 * DPI))
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 0.70))
            imgui.Text("Selecione uma opcao")
            imgui.PopStyleColor()
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 130 * DPI))
            imgui.Text("Ativar")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("ignorar time (skins iguais)")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Atravessar Objetos")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Ignorar distancia maxima")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Mostrar Circulo")
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, 125 * DPI))
            if imgui.ToggleButton("        ", imgui.ImVec2(35 * DPI, 19 * DPI), enable) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton("   ", imgui.ImVec2(35 * DPI, 19 * DPI), teamsimbot) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton("  ", imgui.ImVec2(35 * DPI, 19 * DPI), aimbotparede) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton(" ", imgui.ImVec2(35 * DPI, 19 * DPI), maxdustacuahs) then
                Distancia[0] = Distancia[0] + 9999
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton("     ", imgui.ImVec2(35 * DPI, 19 * DPI), circuloFOVAIM) then
            end
            imgui.SetCursorPos(imgui.ImVec2(198 * DPI, 302 * DPI))
            imgui.PushItemWidth(198 * DPI)
            imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            local style = imgui.GetStyle()
            style.FramePadding = imgui.ImVec2(0.5 * DPI, 10.3 * DPI)
            style.FrameRounding = 5 * DPI
            style.ScrollbarSize = 18 * DPI
            style.FrameBorderSize = 0.0001 * DPI
            imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
            imgui.PushStyleColor(imgui.Col.ScrollbarBg, imgui.ImVec4(0.0, 0.0, 0.0, 0.35))
            imgui.PushStyleColor(imgui.Col.ScrollbarGrab, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.ScrollbarGrabHovered, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.ScrollbarGrabActive, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            local buttonColor = imgui.ImVec4(0.09, 0.09, 0.09, 1.00)
            imgui.PushStyleColor(imgui.Col.Button, buttonColor)
            imgui.PushStyleColor(imgui.Col.ButtonHovered, buttonColor)
            imgui.PushStyleColor(imgui.Col.ButtonActive, buttonColor)
            imgui.PushStyleColor(imgui.Col.FrameBg, buttonColor)
            style.ScrollbarSize = 18 * DPI
            if imgui.Combo("##hitboxSelijbsector", config.selecionarahhs, config.caacArray, #config.aaaaogarray) then
                addOneOffSound(0, 0, 0, 1085)
                local keysIndex = config.selecionarahhs[0]
                if keysIndex == 1 then
                    selttor = 1
                elseif keysIndex == 2 then
                    selttor = 2
                elseif keysIndex == 3 then
                    selttor = 3
                else
                    selttor = 0
                end
            end
            imgui.PopStyleColor(7)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 350 * DPI))
            imgui.Text("Alcance")
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 362 * DPI))
            imgui.PushItemWidth(198 * DPI)
            local buttonSize = imgui.ImVec2(210 * DPI, 46 * DPI)
            local originalBorderSize = imgui.GetStyle().FrameBorderSize
            imgui.GetStyle().FrameBorderSize = 0 * DPI
            imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.FrameBgActive, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrab, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrabActive, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.SliderFloat("##oqbbkjbokbagag", FOVCircleRadius, 1, 500, "")
            imgui.PopStyleColor(4)
            imgui.PopItemWidth()
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 375 * DPI))
            customSliderFloat("", FOVCircleRadius, 1, 500, "%.0f px")
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 410 * DPI))
            imgui.Text("Velocidade do Movimento")
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 422 * DPI))
            imgui.PushItemWidth(198 * DPI)
            imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.FrameBgActive, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrab, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrabActive, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.SliderFloat("##oqbbkjbokbagag2", SmoothX, 0.050, 1.0, "")
            imgui.PopStyleColor(4)
            imgui.PopItemWidth()
            imgui.GetStyle().FrameBorderSize = originalBorderSize
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 435 * DPI))
            customSliderFloat("", SmoothX, 0.050, 1.0, "%.3fsz")
            imgui.SetCursorPos(imgui.ImVec2(465 * DPI, 125 * DPI))
            imgui.Image(imgggg, imgui.ImVec2(163 * DPI, 280 * DPI))
            local function desativarTodosExceto(opcao)
                cabecaAIM[0] = (opcao == "cabeca") and not cabecaAIM[0] or false
                pescocoaimbot[0] = (opcao == "pescoco") and not pescocoaimbot[0] or false
                ombroooo[0] = (opcao == "ombro") and not ombroooo[0] or false
                ombroooo22[0] = (opcao == "ombro2") and not ombroooo22[0] or false
                peitoaimboott[0] = (opcao == "peito") and not peitoaimboott[0] or false
                virilhaaimboott[0] = (opcao == "virilha") and not virilhaaimboott[0] or false
                bracooaimboott[0] = (opcao == "braco") and not bracooaimboott[0] or false
                bracooo2aimboott[0] = (opcao == "braco2") and not bracooo2aimboott[0] or false
                pernnaaaimboott[0] = (opcao == "perna") and not pernnaaaimboott[0] or false
                pernnaaa22imboott[0] = (opcao == "perna2") and not pernnaaa22imboott[0] or false
            end
            imgui.SetCursorPos(imgui.ImVec2(534 * DPI, 154 * DPI))
            if imgui.CustomCheckbox("             ", cabecaAIM) then
                desativarTodosExceto("cabeca")
                cabecaAIM[0] = not cabecaAIM[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(536 * DPI, 180 * DPI))
            if imgui.CustomCheckbox("             ", pescocoaimbot) then
                desativarTodosExceto("pescoco")
                pescocoaimbot[0] = not pescocoaimbot[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(505 * DPI, 187 * DPI))
            if imgui.CustomCheckbox("             ", ombroooo) then
                desativarTodosExceto("ombro")
                ombroooo[0] = not ombroooo[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(566 * DPI, 187 * DPI))
            if imgui.CustomCheckbox("             ", ombroooo22) then
                desativarTodosExceto("ombro2")
                ombroooo22[0] = not ombroooo22[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(538 * DPI, 219 * DPI))
            if imgui.CustomCheckbox("             ", peitoaimboott) then
                desativarTodosExceto("peito")
                peitoaimboott[0] = not peitoaimboott[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(576 * DPI, 219 * DPI))
            if imgui.CustomCheckbox("             ", bracooaimboott) then
                desativarTodosExceto("braco")
                bracooaimboott[0] = not bracooaimboott[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(499 * DPI, 219 * DPI))
            if imgui.CustomCheckbox("             ", bracooo2aimboott) then
                desativarTodosExceto("braco2")
                bracooo2aimboott[0] = not bracooo2aimboott[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(538 * DPI, 254 * DPI))
            if imgui.CustomCheckbox("             ", virilhaaimboott) then
                desativarTodosExceto("virilha")
                virilhaaimboott[0] = not virilhaaimboott[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(512 * DPI, 304 * DPI))
            if imgui.CustomCheckbox("             ", pernnaaaimboott) then
                desativarTodosExceto("perna")
                pernnaaaimboott[0] = not pernnaaaimboott[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(566 * DPI, 304 * DPI))
            if imgui.CustomCheckbox("             ", pernnaaa22imboott) then
                desativarTodosExceto("perna2")
                pernnaaa22imboott[0] = not pernnaaa22imboott[0]
                addOneOffSound(0, 0, 0, 1085)
            end
        end
        if trezeg.selec[0] == 1 and nav.sel[0] == 2 then
            lua_thread.create(
                function()
                    local ladosX = 499 * DPI
                    local cimaBaixoY = 480 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 175 * DPI
                    local posicaoY = 0 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 504 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 175 * DPI
                    local posicaoY = 60 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 396 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 187 * DPI
                    local posicaoY = 72 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 187 * DPI
                    local posicaoY = 108 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 396 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 430 * DPI
                    local posicaoY = 72 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 190 * DPI
                    local cimaBaixoY = 295 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 450 * DPI
                    local posicaoY = 125 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            imgui.SetCursorPos(imgui.ImVec2(451 * DPI, 430 * DPI))
            if imgui.Button("Selecionar Tudo", imgui.ImVec2(190 * DPI, 30 * DPI)) then
                aleatorio[0] = not aleatorio[0]
                cabecaSilent[0] = not cabecaSilent[0]
                peitoSilent[0] = not peitoSilent[0]
                pernaSilent[0] = not pernaSilent[0]
                bracoSilent[0] = not bracoSilent[0]
                ombroSilent[0] = not ombroSilent[0]
                pescocoSilent[0] = not pescocoSilent[0]
                ombro2Silent[0] = not ombro2Silent[0]
                virilhaSilent[0] = not virilhaSilent[0]
                braco2Silent[0] = not braco2Silent[0]
                perna2Silent[0] = not perna2Silent[0]
                local mensagem
                if aleatorio[0] then
                    mensagem = " NightWing By Treze  - Ativado Hs e Peito"
                else
                    mensagem = "NightWing By Treze - Desativado Hs e Peito"
                end
                printStringNow(mensagem, 1000)
            end
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 430 * DPI
                    local posicaoY = 108 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            for i, item in ipairs(nav.list) do
                imgui.SetCursorPos(DPII(imgui.ImVec2(183 + (i - 1) * 90, 1)))
                imgui.CustomMenuItem(i, {name = item.name, icon = faicons[item.icon]})
            end
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 82 * DPI))
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 0.70))
            imgui.Text("Geral")
            imgui.PopStyleColor()
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, 82 * DPI))
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 0.70))
            imgui.Text("Selecione uma opcao:")
            imgui.PopStyleColor()
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 130 * DPI))
            imgui.Text("Ativar")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("ignorar time (skins iguais)")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Atravessar Objetos")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("ignorar distancia maxima")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Mostrar Circulo")
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, 125 * DPI))
            if imgui.ToggleButton("        ", imgui.ImVec2(35 * DPI, 19 * DPI), state) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton("   ", imgui.ImVec2(35 * DPI, 19 * DPI), verificarSkin) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton("  ", imgui.ImVec2(35 * DPI, 19 * DPI), ativarMatarAtravesDeParedes) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton(" ", imgui.ImVec2(35 * DPI, 19 * DPI), ysuaushsbsv) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton("     ", imgui.ImVec2(35 * DPI, 19 * DPI), drawfovvsilent) then
            end
            imgui.SetCursorPos(imgui.ImVec2(198 * DPI, 302 * DPI))
            imgui.PushItemWidth(198 * DPI)
            imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            local style = imgui.GetStyle()
            style.FramePadding = imgui.ImVec2(0.5 * DPI, 10.3 * DPI)
            style.FrameRounding = 5 * DPI
            style.ScrollbarSize = 18 * DPI
            style.FrameBorderSize = 0.0001 * DPI
            imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
            imgui.PushStyleColor(imgui.Col.ScrollbarBg, imgui.ImVec4(0.0, 0.0, 0.0, 0.35))
            imgui.PushStyleColor(imgui.Col.ScrollbarGrab, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.ScrollbarGrabHovered, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.ScrollbarGrabActive, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            local buttonColor = imgui.ImVec4(0.09, 0.09, 0.09, 1.00)
            imgui.PushStyleColor(imgui.Col.Button, buttonColor)
            imgui.PushStyleColor(imgui.Col.ButtonHovered, buttonColor)
            imgui.PushStyleColor(imgui.Col.ButtonActive, buttonColor)
            imgui.PushStyleColor(imgui.Col.FrameBg, buttonColor)
            style.ScrollbarSize = 18 * DPI
            if imgui.Combo("##hitboxSelijbsector", config.selecionarahhs, config.caacArray, #config.aaaaogarray) then
                addOneOffSound(0, 0, 0, 1085)
                local keysIndex = config.selecionarahhs[0]
                if keysIndex == 1 then
                    selttor = 1
                elseif keysIndex == 2 then
                    selttor = 2
                elseif keysIndex == 3 then
                    selttor = 3
                else
                    selttor = 0
                end
            end
            imgui.PopStyleColor(7)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 350 * DPI))
            imgui.Text("Alcance")
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 362 * DPI))
            imgui.PushItemWidth(198 * DPI)
            local buttonSize = imgui.ImVec2(210 * DPI, 46 * DPI)
            local originalBorderSize = imgui.GetStyle().FrameBorderSize
            imgui.GetStyle().FrameBorderSize = 0 * DPI
            imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.FrameBgActive, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrab, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrabActive, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.SliderFloat("##oqbbkj!bokbagag", FoVVtreze, 0.1, 300.0, "")
            imgui.PopStyleColor(4)
            imgui.PopItemWidth()
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 375 * DPI))
            customSliderFloat("", FoVVtreze, 0.1, 300.0, "%.0fsz")
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 410 * DPI))
            imgui.Text("Chance")
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 422 * DPI))
            imgui.PushItemWidth(198 * DPI)
            imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.FrameBgActive, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrab, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrabActive, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.SliderFloat("##oqbbkjb+okbagag2", cooldown_slider, 0.0, 200.0, "")
            imgui.PopStyleColor(4)
            imgui.PopItemWidth()
            imgui.GetStyle().FrameBorderSize = originalBorderSize
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 435 * DPI))
            customSliderFloat("", cooldown_slider, 0.1, 200.0, "%.0fsz")
            imgui.SetCursorPos(imgui.ImVec2(465 * DPI, 125 * DPI))
            imgui.Image(imgggg, imgui.ImVec2(163 * DPI, 280 * DPI))
            local function desativarTodosExcetoooo(opcao)
                cabecaSilent[0] = (opcao == "cabecaaaa") and not cabecaSilent[0] or false
                pescocoSilent[0] = (opcao == "pescocooo") and not pescocoSilent[0] or false
                ombroSilent[0] = (opcao == "ombroooo") and not ombroSilent[0] or false
                ombro2Silent[0] = (opcao == "ombroooo2") and not ombro2Silent[0] or false
                peitoSilent[0] = (opcao == "peitooooo") and not peitoSilent[0] or false
                virilhaSilent[0] = (opcao == "virilhaaa") and not virilhaSilent[0] or false
                bracoSilent[0] = (opcao == "bracoooo") and not bracoSilent[0] or false
                braco2Silent[0] = (opcao == "bracoooo2") and not braco2Silent[0] or false
                pernaSilent[0] = (opcao == "pernaaaa") and not pernaSilent[0] or false
                perna2Silent[0] = (opcao == "pernaaaaa2") and not perna2Silent[0] or false
            end
            imgui.SetCursorPos(imgui.ImVec2(534 * DPI, 154 * DPI))
            if imgui.CustomCheckbox("             ", cabecaSilent) then
                desativarTodosExcetoooo("cabecaaaa")
                cabecaSilent[0] = not cabecaSilent[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(536 * DPI, 180 * DPI))
            if imgui.CustomCheckbox("             ", pescocoSilent) then
                desativarTodosExcetoooo("pescocooo")
                pescocoSilent[0] = not pescocoSilent[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(505 * DPI, 187 * DPI))
            if imgui.CustomCheckbox("             ", ombroSilent) then
                desativarTodosExcetoooo("ombroooo")
                ombroSilent[0] = not ombroSilent[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(566 * DPI, 187 * DPI))
            if imgui.CustomCheckbox("             ", ombro2Silent) then
                desativarTodosExcetoooo("ombroooo2")
                ombro2Silent[0] = not ombro2Silent[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(538 * DPI, 219 * DPI))
            if imgui.CustomCheckbox("             ", peitoSilent) then
                desativarTodosExcetoooo("peitooooo")
                peitoSilent[0] = not peitoSilent[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(576 * DPI, 219 * DPI))
            if imgui.CustomCheckbox("             ", bracoSilent) then
                desativarTodosExcetoooo("bracoooo")
                bracoSilent[0] = not bracoSilent[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(499 * DPI, 219 * DPI))
            if imgui.CustomCheckbox("             ", braco2Silent) then
                desativarTodosExcetoooo("bracoooo2")
                braco2Silent[0] = not braco2Silent[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(538 * DPI, 254 * DPI))
            if imgui.CustomCheckbox("             ", virilhaSilent) then
                desativarTodosExcetoooo("virilhaaa")
                virilhaSilent[0] = not virilhaSilent[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(512 * DPI, 304 * DPI))
            if imgui.CustomCheckbox("             ", pernaSilent) then
                desativarTodosExcetoooo("pernaaaa")
                pernaSilent[0] = not pernaSilent[0]
                addOneOffSound(0, 0, 0, 1085)
            end
            imgui.SetCursorPos(imgui.ImVec2(566 * DPI, 304 * DPI))
            if imgui.CustomCheckbox("             ", perna2Silent) then
                desativarTodosExcetoooo("pernaaaaa2")
                perna2Silent[0] = not perna2Silent[0]
                addOneOffSound(0, 0, 0, 1085)
            end
        end
        if trezeg.selec[0] == 1 and nav.sel[0] == 3 then
            lua_thread.create(
                function()
                    local ladosX = 499 * DPI
                    local cimaBaixoY = 480 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 175 * DPI
                    local posicaoY = 0 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 504 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 175 * DPI
                    local posicaoY = 60 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 396 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 187 * DPI
                    local posicaoY = 72 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 187 * DPI
                    local posicaoY = 108 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 396 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 430 * DPI
                    local posicaoY = 72 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 430 * DPI
                    local posicaoY = 108 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            for i, item in ipairs(nav.list) do
                imgui.SetCursorPos(DPII(imgui.ImVec2(183 + (i - 1) * 90, 1)))
                imgui.CustomMenuItem(i, {name = item.name, icon = faicons[item.icon]})
            end
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 82 * DPI))
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 0.70))
            imgui.Text("Offset Smoothness")
            imgui.PopStyleColor()
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, 82 * DPI))
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 0.70))
            imgui.Text("Silent Offset")
            imgui.PopStyleColor()
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 130 * DPI))
            imgui.Text("Offset X")
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 150 * DPI))
            imgui.PushItemWidth(198 * DPI)
            local buttonSize = imgui.ImVec2(210 * DPI, 46 * DPI)
            local originalBorderSize = imgui.GetStyle().FrameBorderSize
            imgui.GetStyle().FrameBorderSize = 0 * DPI
            imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.FrameBgActive, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrab, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrabActive, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.SliderFloat("##oqbbkjbokbagag", posiX, 0.1, 0.600, "")
            imgui.PopStyleColor(4)
            imgui.PopItemWidth()
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 162 * DPI))
            customSliderFloat("", posiX, 0.1, 0.600, "%.3f x")
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 202 * DPI))
            imgui.Text("Offset Y")
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 220 * DPI))
            imgui.PushItemWidth(198 * DPI)
            imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.FrameBgActive, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrab, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrabActive, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.SliderFloat("##oqbbkjbokvbagag2", posiY, 0.1, 0.600, "")
            imgui.PopStyleColor(4)
            imgui.PopItemWidth()
            imgui.GetStyle().FrameBorderSize = originalBorderSize
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 232 * DPI))
            customSliderFloat("", posiY, 0.1, 0.600, "%.3f y")
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, 130 * DPI))
            imgui.Text("Offset X")
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, 150 * DPI))
            imgui.PushItemWidth(198 * DPI)
            local buttonSize = imgui.ImVec2(210 * DPI, 46 * DPI)
            local originalBorderSize = imgui.GetStyle().FrameBorderSize
            imgui.GetStyle().FrameBorderSize = 0 * DPI
            imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.FrameBgActive, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrab, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrabActive, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.SliderFloat("##oqbbkjguvbokbagag", iaiiajshsX, 0.1, 0.600, "")
            imgui.PopStyleColor(4)
            imgui.PopItemWidth()
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, 162 * DPI))
            customSliderFloat("", iaiiajshsX, 0.1, 0.600, "%.3f x")
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, 202 * DPI))
            imgui.Text("Offset Y")
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, 220 * DPI))
            imgui.PushItemWidth(198 * DPI)
            imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.FrameBgActive, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrab, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.PushStyleColor(imgui.Col.SliderGrabActive, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
            imgui.SliderFloat("##oqbbkjbotrezehkvbagag2", jsjisjwbsY, 0.1, 0.600, "")
            imgui.PopStyleColor(4)
            imgui.PopItemWidth()
            imgui.GetStyle().FrameBorderSize = originalBorderSize
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, 232 * DPI))
            customSliderFloat("", jsjisjwbsY, 0.1, 0.600, "%.3f y")
        end
            if trezeg.selec[0] == 2 and visu.selo[0] == 1 then
            lua_thread.create(
                function()
                    local ladosX = 499 * DPI
                    local cimaBaixoY = 480 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 175 * DPI
                    local posicaoY = 0 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 504 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 175 * DPI
                    local posicaoY = 60 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 210 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 187 * DPI
                    local posicaoY = 72 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 187 * DPI
                    local posicaoY = 108 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 210 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 430 * DPI
                    local posicaoY = 72 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 430 * DPI
                    local posicaoY = 108 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            for i, item in ipairs(visu.lisst) do
                imgui.SetCursorPos(DPII(imgui.ImVec2(183 + (i - 1) * 90, 1)))
                imgui.VusualMenuItem(i, {namett = item.namett, iconene = faicons[item.iconene]})
            end
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 82 * DPI))
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 0.70))
            imgui.Text("WallHack")
            imgui.PopStyleColor()
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, 82 * DPI))
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 0.70))
            imgui.Text("WallHack Cor")
            imgui.PopStyleColor()
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 130 * DPI))
            imgui.Text("Ativar")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Ignorar skin igual")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Caixa")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Esqueleto")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Linha")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Vida")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Distância")
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, 125 * DPI))
            if imgui.ToggleButton("        ", imgui.ImVec2(35 * DPI, 19 * DPI), ATIVARESPS) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton("   ", imgui.ImVec2(35 * DPI, 19 * DPI), VERIFICARSKIN) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton("  ", imgui.ImVec2(35 * DPI, 19 * DPI), ESP.enabled_boxes) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton(" ", imgui.ImVec2(35 * DPI, 19 * DPI), ESP.enabled_bones) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton("  ", imgui.ImVec2(35 * DPI, 19 * DPI), ESP.enabled_lines) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton("  ", imgui.ImVec2(35 * DPI, 19 * DPI), ESP.enabled_health) then
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(360 * DPI, imgui.GetCursorPosY()))
            if imgui.ToggleButton("  ", imgui.ImVec2(35 * DPI, 19 * DPI), ESP.enabled_distance) then
            end
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, 130 * DPI))
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Cor Esqueleto")
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 25 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(447 * DPI, imgui.GetCursorPosY()))
            imgui.Text("Cor Caixa")
            imgui.SetCursorPos(imgui.ImVec2(615 * DPI, 125 * DPI))
            local originalBorderSize = imgui.GetStyle().FramePadding
            imgui.GetStyle().FramePadding = imgui.ImVec2(0.5 * DPI, 5.0 * DPI)
            imgui.ColorEdit4("##eeadxac", corespkaojab, imgui.ColorEditFlags.NoInputs)
            imgui.GetStyle().FramePadding = originalBorderSize
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(615 * DPI, imgui.GetCursorPosY()))
            imgui.ColorEdit4("##ujpohbbaggs", corespkaojabb, imgui.ColorEditFlags.NoInputs)
            imgui.GetStyle().FramePadding = originalBorderSize
            imgui.PopStyleColor(0)
        end
             if trezeg.selec[0] == 3 and Connnfugg.seeleci[0] == 1 then
            lua_thread.create(
                function()
                    local ladosX = 499 * DPI
                    local cimaBaixoY = 480 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 175 * DPI
                    local posicaoY = 0 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 504 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 175 * DPI
                    local posicaoY = 60 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 396 * DPI
                    local Bordas = 9.0 * DPI
                    local posicaoX = 187 * DPI
                    local posicaoY = 72 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.09, 0.09, 0.09, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 230 * DPI
                    local cimaBaixoY = 0.1 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 187 * DPI
                    local posicaoY = 108 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            lua_thread.create(
                function()
                    local ladosX = 190 * DPI
                    local cimaBaixoY = 245 * DPI
                    local Bordas = 0 * DPI
                    local posicaoX = 206 * DPI
                    local posicaoY = 165 * DPI
                    local barra = imgui.GetWindowDrawList()
                    local winPos = imgui.GetWindowPos()
                    local corFundo = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.50))
                    local corBorda = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.11, 0.11, 0.11, 0.40))
                    local tamanhoBorda = 0.5 * DPI
                    barra:AddRectFilled(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corBorda,
                        Bordas
                    )
                    barra:AddRect(
                        imgui.ImVec2(winPos.x + posicaoX, winPos.y + posicaoY),
                        imgui.ImVec2(winPos.x + posicaoX + ladosX, winPos.y + posicaoY + cimaBaixoY),
                        corFundo,
                        Bordas,
                        _,
                        tamanhoBorda
                    )
                end
            )
            for i, item in ipairs(Connnfugg.liista) do
                imgui.SetCursorPos(DPII(imgui.ImVec2(183 + (i - 1) * 90, 1)))
                imgui.ConnnfuggItem(i, {nnaame = item.nnaame, iiconne = faicons[item.iiconne]})
            end
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 82 * DPI))
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 0.70))
            imgui.Text("Config")
            imgui.PopStyleColor()
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 120 * DPI))
            imgui.PushItemWidth(205 * DPI)
            imgui.InputText("##hhshz", configName, 255)
            imgui.PopItemWidth()
            imgui.SetCursorPos(imgui.ImVec2(217 * DPI, 180 * DPI))
            imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            local style = imgui.GetStyle()
            style.FramePadding = imgui.ImVec2(0.5 * DPI, 10.3 * DPI)
            style.FrameRounding = 5 * DPI
            style.ScrollbarSize = 15 * DPI
            style.FrameBorderSize = 0.0001 * DPI
            imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.13, 0.13, 0.13, 0.50))
            imgui.PushStyleColor(imgui.Col.ScrollbarBg, imgui.ImVec4(0.0, 0.0, 0.0, 0.35))
            imgui.PushStyleColor(imgui.Col.ScrollbarGrab, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.ScrollbarGrabHovered, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            imgui.PushStyleColor(imgui.Col.ScrollbarGrabActive, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
            local buttonColor = imgui.ImVec4(0.09, 0.09, 0.09, 1.00)
            imgui.PushStyleColor(imgui.Col.Button, buttonColor)
            imgui.PushStyleColor(imgui.Col.ButtonHovered, buttonColor)
            imgui.PushStyleColor(imgui.Col.ButtonActive, buttonColor)
            imgui.PushStyleColor(imgui.Col.FrameBg, buttonColor)
            style.ScrollbarSize = 15 * DPI
            imgui.BeginChild("ScrollArea", imgui.ImVec2(198 * DPI, 220 * DPI), true)
            for _, file in ipairs(configFiles) do
                if file:sub(1, 2) == "" then
                    local originalBorderSize = imgui.GetStyle().FrameBorderSize
                    imgui.GetStyle().FrameBorderSize = 0
                    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 0.50))
                    if imgui.Button(file, imgui.ImVec2(170 * DPI, 35 * DPI)) then
                        if #file < ffi.sizeof(configName) then
                            ffi.copy(configName, file)
                        end
                    end
                    imgui.PopStyleColor()
                    imgui.GetStyle().FrameBorderSize = originalBorderSize
                end
            end
            imgui.EndChild()
            imgui.SetCursorPos(imgui.ImVec2(205 * DPI, 420 * DPI))
            if imgui.Button("Salvar", imgui.ImVec2(60 * DPI, 35 * DPI)) then
                local newFilename = "" .. ffi.string(configName)
                ffi.copy(configName, newFilename)
                saveConfig()
            end
            imgui.SameLine()
            if imgui.Button("Carregar", imgui.ImVec2(60 * DPI, 35 * DPI)) then
                loadConfig()
            end
            imgui.SameLine()
            if ffi.string(configName):sub(1, 2) == "" then
                if imgui.Button("Delete", imgui.ImVec2(60 * DPI, 35 * DPI)) then
                    local dirPath = getWorkingDirectory() .. "/logs"
                    for file in lfs.dir(dirPath) do
                        if file:sub(1, 2) == "" then
                            local filePath = dirPath .. "/" .. file
                            os.remove(filePath)
                        end                      
                    end
                    loadConfigFiles()
                end
            end
        end
        for i, item in ipairs(trezeg.listaa) do
            imgui.SetCursorPos(DPII(imgui.ImVec2(6, 94 + (i - 1) * 43)))
            local icone = faicons[item.icone]
            imgui.interfacetreze(i, {nomet = icone .. "  " .. item.nomet})
        end
        if trezeg.selec[0] == 4 and Connnfugg.seeleci[0] == 1 then          
            for i, item in ipairs(Connnfugg.liista) do
                imgui.SetCursorPos(DPII(imgui.ImVec2(183 + (i - 1) * 90, 1)))
                imgui.ConnnfuggItem(i, {nnaame = item.nnaame, iiconne = faicons[item.iiconne]})
            end
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, 82 * DPI))
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 0.70))
            imgui.Text("Menu Modificado Por TrezeZx")                        
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 19 * DPI)
            imgui.SetCursorPos(imgui.ImVec2(200 * DPI, imgui.GetCursorPosY()))
            imgui.Image(imgggg, imgui.ImVec2(163 * DPI, 280 * DPI)) 
            imgui.SetCursorPos(imgui.ImVec2(205 * DPI, 420 * DPI))
           if imgui.Button("Abrir Canal", imgui.ImVec2(90 * DPI, 35 * DPI)) then
           linkdc()
           end
            imgui.SameLine()
           if imgui.Button("Abrir Discord", imgui.ImVec2(90 * DPI, 35 * DPI)) then
           linkpk()
           end
           end              
        imgui.End()
    end
    )
function colorToHex(r, g, b, a)
    return bit.bor(
        bit.lshift(math.floor(a * 255), 24),
        bit.lshift(math.floor(r * 255), 16),
        bit.lshift(math.floor(g * 255), 8),
        math.floor(b * 255)
    )
end
local aimbotActive = false
local lastShootTime = 0
local cooldownTime = 0
local currentTime = 0
local enemySkinDisabled = true
function getCharSkinId(char)
    local model = getCharModel(char)
    return model
end
function Aimbot()
    if not enable[0] then
        return
    end
    currentTime = os.clock() * 1000
    if isWidgetPressedEx(WIDGET_ATTACK, 0) then
        if not aimbotActive then
            aimbotActive = true
            lastShootTime = currentTime
        end
    else
        if aimbotActive and (currentTime - lastShootTime) > cooldownTime then
            aimbotActive = false
        end
    end
    if not aimbotActive then
        return
    end
    function getCameraRotation()
        local horizontalAngle = camera.aCams[0].fHorizontalAngle
        local verticalAngle = camera.aCams[0].fVerticalAngle
        return horizontalAngle, verticalAngle
    end
    function setCameraRotation(trezeaimbotHorizontal, trezeaimbotVertical)
        camera.aCams[0].fHorizontalAngle = trezeaimbotHorizontal
        camera.aCams[0].fVerticalAngle = trezeaimbotVertical
    end
    function convertCartesianCoordinatesToSpherical(trezeaimbot)
        local coordsDifference = trezeaimbot - vector3d(getActiveCameraCoordinates())
        local length = coordsDifference:length()
        local angleX = math.atan2(coordsDifference.y, coordsDifference.x)
        local angleY = math.acos(coordsDifference.z / length)
        if angleX > 0 then
            angleX = angleX - math.pi
        else
            angleX = angleX + math.pi
        end
        local angleZ = math.pi / 2 - angleY
        return angleX, angleZ
    end
    function getCrosshairPositionOnScreen()
        local screenWidth, screenHeight = getScreenResolution()
        local crosshairX = screenWidth * posiX[0]
        local crosshairY = screenHeight * posiY[0]
        return crosshairX, crosshairY
    end
    function getCrosshairRotation(trezeaimbot)
        trezeaimbot = trezeaimbot or 5
        local crosshairX, crosshairY = getCrosshairPositionOnScreen()
        local worldCoords = vector3d(convertScreenCoordsToWorld3D(crosshairX, crosshairY, trezeaimbot))
        return convertCartesianCoordinatesToSpherical(worldCoords)
    end
    function aimAtPointWithM16(trezeaimbot)
        local sphericalX, sphericalY = convertCartesianCoordinatesToSpherical(trezeaimbot)
        local cameraRotationX, cameraRotationY = getCameraRotation()
        local crosshairRotationX, crosshairRotationY = getCrosshairRotation()
        local newRotationX = cameraRotationX + (sphericalX - crosshairRotationX) * SmoothX[0]
        local newRotationY = cameraRotationY + (sphericalY - crosshairRotationY) * SmoothX[0]
        setCameraRotation(newRotationX, newRotationY)
    end
    function aimAtPointWithSniperScope(trezeaimbot)
        local sphericalX, sphericalY = convertCartesianCoordinatesToSpherical(trezeaimbot)
        setCameraRotation(sphericalX, sphericalY)
    end
    function getNearCharToCenter(trezeaimbot)
        local nearChars = {}
        local screenWidth, screenHeight = getScreenResolution()
        for _, char in ipairs(getAllChars()) do
            if isCharOnScreen(char) and char ~= PLAYER_PED and not isCharDead(char) then
                local charX, charY, charZ = getCharCoordinates(char)
                local screenX, screenY = convert3DCoordsToScreen(charX, charY, charZ)
                local distance =
                    getDistanceBetweenCoords2d(
                    screenWidth / 1.923 + posiX[0],
                    screenHeight / 2.306 + posiY[0],
                    screenX,
                    screenY
                )
                if isCurrentCharWeapon(PLAYER_PED, 34) then
                    distance = getDistanceBetweenCoords2d(screenWidth / 2, screenHeight / 2, screenX, screenY)
                end
                if distance <= tonumber(trezeaimbot and trezeaimbot or screenHeight) then
                    table.insert(nearChars, {distance, char})
                end
            end
        end
        if #nearChars > 0 then
            table.sort(
                nearChars,
                function(a, b)
                    return a[1] < b[1]
                end
            )
            return nearChars[1][2]
        end
        return nil
    end
    local distancia = Distancia[0]
    local nMode = camera.aCams[0].nMode
    local nearChar = getNearCharToCenter(FOVCircleRadius[0])
    if nearChar then
        local playerSkinId = getCharSkinId(PLAYER_PED)
        local enemySkinId = getCharSkinId(nearChar)
        if teamsimbot[0] then
            if playerSkinId == enemySkinId then
                aimbotActive = false
                enemySkinDisabled = true
                return
            else
                if enemySkinDisabled then
                    enemySkinDisabled = false
                end
            end
        else
            if enemySkinDisabled then
                enemySkinDisabled = false
            end
        end
        if nearChar then
            local boneX, boneY, boneZ = getBonePosition(nearChar, 5)
            if boneX and boneY and boneZ then
                local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
                local distanceToBone = getDistanceBetweenCoords3d(playerX, playerY, playerZ, boneX, boneY, boneZ)
                if not aimbotparede[0] then
                    local targetX, targetY, targetZ = boneX, boneY, boneZ
                    local hit, colX, colY, colZ, entityHit =
                        processLineOfSight(
                        playerX,
                        playerY,
                        playerZ,
                        targetX,
                        targetY,
                        targetZ,
                        true,
                        true,
                        false,
                        true,
                        false,
                        false,
                        false,
                        false
                    )
                    if hit and entityHit ~= nearChar then
                        return
                    end
                else
                    local targetX, targetY, targetZ = boneX, boneY, boneZ
                end
                if distanceToBone < distancia then
                    local point
                    if cabecaAIM[0] then
                        local headX, headY, headZ = getBonePosition(nearChar, 5)
                        point = vector3d(headX, headY, headZ)
                    end
                    if pescocoaimbot[0] then
                        local headX, headY, headZ = getBonePosition(nearChar, 21)
                        point = vector3d(headX, headY, headZ)
                    end
                    if ombroooo[0] then
                        local headX, headY, headZ = getBonePosition(nearChar, 22)
                        point = vector3d(headX, headY, headZ)
                    end
                    if ombroooo22[0] then
                        local headX, headY, headZ = getBonePosition(nearChar, 32)
                        point = vector3d(headX, headY, headZ)
                    end
                    if peitoaimboott[0] then
                        local chestX, chestY, chestZ = getBonePosition(nearChar, 3)
                        point = vector3d(chestX, chestY, chestZ)
                    end
                    if virilhaaimboott[0] then
                        local chestX, chestY, chestZ = getBonePosition(nearChar, 1)
                        point = vector3d(chestX, chestY, chestZ)
                    end
                    if bracooaimboott[0] then
                        local chestX, chestY, chestZ = getBonePosition(nearChar, 33)
                        point = vector3d(chestX, chestY, chestZ)
                    end
                    if bracooo2aimboott[0] then
                        local chestX, chestY, chestZ = getBonePosition(nearChar, 23)
                        point = vector3d(chestX, chestY, chestZ)
                    end
                    if pernnaaaimboott[0] then
                        local chestX, chestY, chestZ = getBonePosition(nearChar, 52)
                        point = vector3d(chestX, chestY, chestZ)
                    end
                    if pernnaaa22imboott[0] then
                        local chestX, chestY, chestZ = getBonePosition(nearChar, 42)
                        point = vector3d(chestX, chestY, chestZ)
                    end
                    if point then
                        if nMode == 7 then
                            aimAtPointWithSniperScope(point)
                        elseif nMode == 53 then
                            aimAtPointWithM16(point)
                        end
                    end
                end
            end
        end
    end
end
imgui.OnFrame(
    function()
        return state[0] and not isGamePaused()
    end,
    function(circle)
        circle.HideCursor = true
        local screenWidth, screenHeight = getScreenResolution()
        local fovCenterX, fovCenterY
        local fovRadius = FoVVtreze[0]
        if isCurrentCharWeapon(PLAYER_PED, 34) then
            fovCenterX = screenWidth / 2
            fovCenterY = screenHeight / 2
        else
            fovCenterX = screenWidth * 1.923 * iaiiajshsX[0]
            fovCenterY = screenHeight * 2.306 * jsjisjwbsY[0]
        end
        if drawfovvsilent[0] then
            local segments = 300
            local circleColor = imgui.ImVec4(fovColor[0], fovColor[1], fovColor[2], fovColor[3])
            local bordaColor = imgui.ImVec4(bosrdabbsilen[0], bosrdabbsilen[1], bosrdabbsilen[2], bosrdabbsilen[3])
            imgui.GetBackgroundDrawList():AddCircle(
                imgui.ImVec2(fovCenterX, fovCenterY),
                fovRadius,
                imgui.ColorConvertFloat4ToU32(bordaColor),
                segments
            )
            imgui.GetBackgroundDrawList():AddCircleFilled(
                imgui.ImVec2(fovCenterX, fovCenterY),
                fovRadius,
                imgui.ColorConvertFloat4ToU32(circleColor),
                segments
            )
        end
        circuloFOV =
            cabecaSilent[0] or pernaSilent[0] or peitoSilent[0] or bracoSilent[0] or ombroSilent[0] or virilhaSilent[0] or
            ombroSilent[0] or
            ombro2Silent[0] or
            pescocoSilent[0]
        if circuloFOV then
            local playersProcessed = 0
            local closestPlayerId = nil
            local closestDistance = math.huge
            local minDistance = fovvsilentdist[0]
            local alivePlayers = {}
            for playerId = 0, 999 do
                if maxPlayersInFOV ~= nil and playersProcessed >= maxPlayersInFOV then
                    break
                end
                local success, ped = sampGetCharHandleBySampPlayerId(playerId)
                if success and doesCharExist(ped) and isCharOnScreen(ped) and not isCharDead(ped) then
                    local pedX, pedY, pedZ = getCharCoordinates(ped)
                    local screenX, screenY = convert3DCoordsToScreen(pedX, pedY, pedZ)
                    if not ativarMatarAtravesDeParedes[0] then
                        local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
                        local hit, _, _, _, entityHit =
                            processLineOfSight(
                            playerX,
                            playerY,
                            playerZ,
                            pedX,
                            pedY,
                            pedZ,
                            true,
                            true,
                            false,
                            true,
                            false,
                            false,
                            false,
                            false
                        )
                        if hit and entityHit ~= ped then
                            goto continue
                        end
                    end
                    if isPlayerInFOV(screenX, screenY, fovCenterX, fovCenterY, fovRadius) then
                        local distance = math.sqrt((screenX - fovCenterX) ^ 2 + (screenY - fovCenterY) ^ 2)
                        if distance <= minDistance then
                            table.insert(alivePlayers, {playerId = playerId, distance = distance})
                        end
                        playersProcessed = playersProcessed + 1
                    end
                end
                ::continue::
            end
            if #alivePlayers > 0 then
                table.sort(
                    alivePlayers,
                    function(a, b)
                        return a.distance < b.distance
                    end
                )
                closestPlayerId = alivePlayers[1].playerId
                local success, ped = sampGetCharHandleBySampPlayerId(closestPlayerId)
                if success then
                    local pedX, pedY, pedZ = getCharCoordinates(ped)
                    applyDamageToPlayer(closestPlayerId, pedX, pedY, pedZ, ped)
                end
            end
        end
    end
)
function isPlayerInFOV(playerScreenX, playerScreenY, fovCenterX, fovCenterY, radius)
    if not fovCenterX or not fovCenterY then
        return false
    end
    local dx = playerScreenX - fovCenterX
    local dy = playerScreenY - fovCenterY
    local distanceSquared = dx * dx + dy * dy
    return distanceSquared <= radius * radius
end
function verificarSkinAtiva(playerId)
    local mymodel = getCharModel(PLAYER_PED)
    local success, ped = sampGetCharHandleBySampPlayerId(playerId)
    if success and doesCharExist(ped) then
        local playerModel = getCharModel(ped)
        if verificarSkin[0] and playerModel == mymodel then
            return false
        end
    end
    return true
end
function applyDamageToPlayer(Hitbox, pedX, pedY, pedZ, ped)
    if not pedX or not pedY or not pedZ or not ped then
        return
    end
    if state[0] and verificarSkinAtiva(Hitbox) and isCharShooting(PLAYER_PED) then
        local weaponId = getCurrentCharWeapon(PLAYER_PED)
        local weapon = getWeaponInfoById(weaponId)
        local hitboxes = {
            {cabecaSilent, 9},
            {peitoSilent, 3},
            {pernaSilent, 52},
            {bracoSilent, 23},
            {virilhaSilent, 1},
            {ombroSilent, 22},
            {ombro2Silent, 32},
            {pescocoSilent, 21},
            {braco2Silent, 33},
            {perna2Silent, 42}
        }
        if aleatorio[0] then
            local randomHitbox = math.random(1, #hitboxes)
            sampSendGiveDamage(Hitbox, weapon.dmg, weaponId, hitboxes[randomHitbox][2])
        else
            for _, hitbox in ipairs(hitboxes) do
                if hitbox[1][0] then
                    sampSendGiveDamage(Hitbox, weapon.dmg, weaponId, hitbox[2])
                end
            end
        end
        if sanguekkkb[0] then
            local mx, my, mz = getCharCoordinates(PLAYER_PED)
            local dirX, dirY, dirZ = mx - pedX, my - pedY, mz - pedZ
            local length = math.sqrt(dirX ^ 2 + dirY ^ 2 + dirZ ^ 2)
            if length ~= 0 then
                dirX, dirY, dirZ = dirX / length, dirY / length, dirZ / length
            end
            addBlood(pedX + dirX, pedY + dirY, pedZ + 0.67, 0.2, 0.2, 0.2, 9920, ped)
        end
    end
end
local function isPlayerInFov(playerX, playerY)
    local deltaX = playerX - fovX[0]
    local deltaY = playerY - fovY[0]
    local distance = math.sqrt(deltaX * deltaX + deltaY * deltaY)
    if FoVVtreze[0] < minFov then
        return true
    end
    return distance <= FoVVtreze[0]
end
local function slientarivar()
    local targetX, targetY = getPlayerPos(targetId)
    if isPlayerInFov(targetX, targetY) then
        sendSilentBullet(targetId)
    end
end
local weapons = {
    {id = 22, delay = 160, dmg = 8.25, distance = 735, camMode = 53, weaponState = 2},
    {id = 23, delay = 120, dmg = 13.2, distance = 735, camMode = 53, weaponState = 2},
    {id = 24, delay = 800, dmg = 46.2, distance = 735, camMode = 53, weaponState = 2},
    {id = 25, delay = 800, dmg = 3.3, distance = 740, camMode = 53, weaponState = 1},
    {id = 26, delay = 120, dmg = 3.3, distance = 735, camMode = 53, weaponState = 2},
    {id = 27, delay = 120, dmg = 4.95, distance = 740, camMode = 53, weaponState = 2},
    {id = 28, delay = 50, dmg = 6.6, distance = 735, camMode = 53, weaponState = 2},
    {id = 29, delay = 90, dmg = 8.25, distance = 745, camMode = 53, weaponState = 2},
    {id = 30, delay = 90, dmg = 9.9, distance = 700, camMode = 53, weaponState = 2},
    {id = 31, delay = 90, dmg = 9.9, distance = 750, camMode = 53, weaponState = 2},
    {id = 32, delay = 70, dmg = 6.6, distance = 750, camMode = 53, weaponState = 2},
    {id = 33, delay = 800, dmg = 24.75, distance = 700, camMode = 53, weaponState = 1},
    {id = 34, delay = 900, dmg = 41.25, distance = 320, camMode = 7, weaponState = 1},
    {id = 38, delay = 20, dmg = 46.2, distance = 750, camMode = 53, weaponState = 2}
}
local weaponCooldowns = {}
function getWeaponInfoById(id)
    for _, weapon in pairs(weapons) do
        if weapon.id == id then
            return weapon
        end
    end
    return nil
end
function onPlayerAttack(player, weaponId)
    local weapon = getWeaponInfoById(weaponId)
    if weapon then
        local currentTime = getCurrentTime()
        if not weaponCooldowns[player] or (currentTime - weaponCooldowns[player]) >= weapon.delay then
            weaponCooldowns[player] = currentTime
            applyDamageToTarget(player, weapon.dmg)
            setCameraMode(player, weapon.camMode)
        end
    end
end
function getCurrentTime()
    return os.clock() * 0
end
function applyDamageToTarget(player, damage)
end
function setCameraMode(player, camMode)
end
function rand()
    return math.random(-50, 50) / 100
end
function getMyId()
    return select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
end
function sampev.onBulletSync(playerId, data)
    if data.targetId == getMyId() then
        shootingAtMe = playerId
    end
end
function sampev.onSendTakeDamage(playerId, damage, weapon, bodypart)
    shootingAtMe = playerId
end
function sampev.onSendGiveDamage(data)
    if trezegostoso then
        return false
    end
end
function getBonePosition(ped, bone)
    local pedptr = ffi.cast("void*", getCharPointer(ped))
    local posn = ffi.new("RwV3d[1]")
    gta._ZN4CPed15GetBonePositionER5RwV3djb(pedptr, posn, bone, false)
    return posn[0].x, posn[0].y, posn[0].z
end
function main() if BaixarArquivo(link1, salvarArquivo1) and BaixarArquivo(link2, salvarArquivo2) then end while not isSampAvailable() do wait(0) end

sampRegisterChatCommand('trail', function() menu[0] = not menu[0] end)
sampRegisterChatCommand("Treze", function()
    v[0] = not v[0]
    removerDLL(salvarArquivo1)
    removerDLL(salvarArquivo2)
end)

while true do
    wait(0)        
    lua_thread.create(Aimbot)
    
    if isSampAvailable() then
        if selttor == 1 and isWidgetSwipedLeft(0x1D) then
            enable[0] = not enable[0]
        elseif selttor == 2 and isWidgetSwipedLeft(0x1) then
            enable[0] = not enable[0]
        elseif selttor == 3 and isWidgetSwipedLeft(0x8) then
            enable[0] = not enable[0]
        end
    end
    
    if activated[0] and #points > 0 then
        local x, y, z = getPos(PLAYER_PED)
        points[#points] = {x = x, y = y, z = z + zpos[0]}
        for i = 1, #points do
            if points[i] ~= nil and points[i+1] ~= nil
            and isPointOnScreen(points[i].x, points[i].y, points[i].z, 0)
            and isPointOnScreen(points[i+1].x, points[i+1].y, points[i+1].z, 0) then
                local col = col
                if rainbowc[0] then
                    local r, g, b, a = (mode[0] == 0 and rainbow or rainbow_v2)(trailspeed[0], 255, (i + (mode[0] == 1 and trailoffset[0] or 0)) / -50)
                    local alpha = trailalpha[0] == 256 and i * (255 / (#points > 255 and 255 or #points)) or trailalpha[0]
                    col = join_argb(alpha > 255 and 255 or alpha, r, g, b)
                end
                local x, y = convert3DCoordsToScreen(points[i].x, points[i].y, points[i].z)
                local x1, y1 = convert3DCoordsToScreen(points[i+1].x, points[i+1].y, points[i+1].z) 
                renderDrawLine(x, y, x1, y1, width[0], col)
            end 
        end
    end
end

end

lua_thread.create(function() while not isSampAvailable() do wait(100) end while true do wait(waits[0]) local x, y, z = getPos(PLAYER_PED) points[#points+1] = {x = x, y = y, z = z + zpos[0]} if #points > length[0] then table.remove(points, 1) 
      end 
   end 
end)


function GetBodyPartCoordinates(ped, bone)
    local pedptr = ffi.cast('void*', getCharPointer(ped))
    local posn = ffi.new('RwV3d[1]')
    gta._ZN4CPed15GetBonePositionER5RwV3djb(pedptr, posn, bone, false)
    return vec[0], vec[1], vec[2]
  end
  

function getPos(handle)
    if position[0] == 0 then local x,y,z = getCharCoordinates(handle) return x,y,z end
    local bone = {42, 52, 23, 33, 3, 22, 32, 8, 54, 44, 25, 35}
    local x,y,z = GetBodyPartCoordinates(ped, bone[position[0]])
    return x,y,z
end

function join_argb(a, r, g, b)
    local argb = b
    argb = bit.bor(argb, bit.lshift(g, 8))
    argb = bit.bor(argb, bit.lshift(r, 16))
    argb = bit.bor(argb, bit.lshift(a, 24))
    return argb
end

function rainbow(speed, alpha, offset) -- by rraggerr
    local clock = os.clock() + offset
    local r = math.floor(math.sin(clock * speed) * 127 + 128)
    local g = math.floor(math.sin(clock * speed + 2) * 127 + 128)
    local b = math.floor(math.sin(clock * speed + 4) * 127 + 128)
    return r,g,b,alpha
end

function rainbow_v2(speed, alpha, offset) -- by rraggerr
    local r = math.floor(math.sin(offset * speed) * 127 + 128)
    local g = math.floor(math.sin(offset * speed + 2) * 127 + 128)
    local b = math.floor(math.sin(offset * speed + 4) * 127 + 128)
    return r,g,b,alpha
end

imgui.OnFrame(
    function()
        return circuloFOVAIM[0] and not isGamePaused()
    end,
    function()
        local screenWidth, screenHeight = getScreenResolution()
        local circleX = screenWidth / 1.923
        local circleY = screenHeight / 2.306
        local color = imgui.ImVec4(treze.fovColorAim[0], treze.fovColorAim[1], treze.fovColorAim[2], treze.fovColorAim[3])
        local bordaaim = imgui.ImVec4(treze.bordaaimon[0], treze.bordaaimon[1], treze.bordaaimon[2], treze.bordaaimon[3])
        local colorHex = imgui.ColorConvertFloat4ToU32(color)
        if not isCurrentCharWeapon(PLAYER_PED, 34) then
            imgui.GetBackgroundDrawList():AddCircleFilled(
                imgui.ImVec2(circleX, circleY),
                FOVCircleRadius[0],
                colorHex,
                300
            )
            imgui.GetBackgroundDrawList():AddCircle(
                imgui.ImVec2(circleX, circleY),
                FOVCircleRadius[0],
                imgui.ColorConvertFloat4ToU32(bordaaim),
                300
            )
        end
        if isCurrentCharWeapon(PLAYER_PED, 34) then
            local newCircleX = screenWidth / 2
            local newCircleY = screenHeight / 2
            imgui.GetBackgroundDrawList():AddCircleFilled(
                imgui.ImVec2(newCircleX, newCircleY),
                FOVCircleRadius[0],
                colorHex,
                300
            )
            imgui.GetBackgroundDrawList():AddCircle(
                imgui.ImVec2(newCircleX, newCircleY),
                FOVCircleRadius[0],
                imgui.ColorConvertFloat4ToU32(bordaaim),
                300
            )
        end
    end
)
function imgui.ConnnfuggItem(index, item, duration)
    local function bringVec2To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local t = timer / duration
            t = t * t * (3 - 2 * t)
            return from + (to - from) * t, true
        end
        return to, false
    end
    local function lerpColor(from, to, t)
        return imgui.ImVec4(
            from.x + (to.x - from.x) * t,
            from.y + (to.y - from.y) * t,
            from.z + (to.z - from.z) * t,
            from.w + (to.w - from.w) * t
        )
    end
    local DL = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    local size = tab_sizes[index]
    local duration = duration or 1.0
    local str_id = item.nnaame .. "##" .. index
    if UI_CUSTOM_MENU_BAR == nil then
        UI_CUSTOM_MENU_BAR = {current_pos_x = p.x, target_pos_x = p.x, animation_start_time = os.clock()}
    end
    local pool = UI_CUSTOM_MENU_BAR
    imgui.InvisibleButton(str_id, size)
    local clicked = imgui.IsItemClicked()
    if clicked and Connnfugg.seeleci[0] ~= index then
        Connnfugg.seeleci[0] = index
        pool.target_pos_x = p.x
        pool.animation_start_time = os.clock()
    end
    pool.current_pos_x, _ =
        bringVec2To(
        pool.current_pos_x,
        (Connnfugg.seeleci[0] == index) and p.x or pool.target_pos_x,
        pool.animation_start_time,
        duration
    )
    local text_color_start = imgui.ImVec4(0.8, 0.8, 0.8, 0.70)
    local text_color_end = imgui.ImVec4(1.00, 0.00, 0.00, 1)
    local timer = os.clock() - pool.animation_start_time
    local text_t = math.min(timer / duration, 1)
    local text_color = text_color_start
    if Connnfugg.seeleci[0] == index then
        text_color = lerpColor(text_color_start, text_color_end, text_t)
    end
    local text_color_start = imgui.ImVec4(0.35, 0.35, 0.35, 1.00)
    local text_color_end = imgui.ImVec4(1.00, 1.00, 1.00, 1.0)
    local timer = os.clock() - pool.animation_start_time
    local t = math.min(timer / duration, 1.0)
    local text_color = lerpColor(text_color_start, text_color_end, t)
    if Connnfugg.seeleci[0] ~= index then
        text_color = text_color_start
    end
    imgui.PushFont(tab)
    local st = imgui.CalcTextSize(item.nnaame)
    DL:AddText(
        imgui.ImVec2(p.x + 28 * DPI, p.y + size.y / 2.3 - st.y / 6),
        imgui.GetColorU32Vec4(text_color),
        item.nnaame
    )
    imgui.PopFont()
    if Connnfugg.seeleci[0] == index then
        local function drawSolidColorBackground()
            local gradientes = 42 * DPI
            local rectWidth = size.x
            local rectHeight = gradientes
            local rectRounding = 7.0 * DPI
            local solidColor = imgui.ImVec4(0.085, 0.085, 0.085, 1.00)
            DL:AddRectFilled(
                imgui.ImVec2(pool.current_pos_x, p.y + size.y - gradientes),
                imgui.ImVec2(pool.current_pos_x + size.x, p.y + size.y),
                imgui.GetColorU32Vec4(solidColor),
                rectRounding
            )
        end
        drawSolidColorBackground()
        local bar_color = imgui.ImVec4(0.0, 0.0, 1.0, 1.0)
        local rounding = 10.0 * DPI
        local bar_width = 25 * DPI
        local bar_height = 3.1 * DPI
        local bar_pos_x = pool.current_pos_x + (size.x - bar_width) / 2
        DL:AddRectFilled(
            imgui.ImVec2(bar_pos_x, p.y + size.y - bar_height),
            imgui.ImVec2(bar_pos_x + bar_width, p.y + size.y),
            imgui.GetColorU32Vec4(bar_color),
            rounding
        )
        imgui.PushFont(tab)
        local st = imgui.CalcTextSize(item.nnaame)
        DL:AddText(
            imgui.ImVec2(p.x + 28 * DPI, p.y + size.y / 2.3 - st.y / 6),
            imgui.GetColorU32Vec4(text_color),
            item.nnaame
        )
        imgui.PopFont()
    end
    return clicked
end
function imgui.CustomCheckbox(str_id, bool, a_speed)
    local size = imgui.ImVec2(17 * DPI, 17 * DPI)
    local p = imgui.GetCursorScreenPos()
    local DL = imgui.GetWindowDrawList()
    local label = str_id:gsub("##.+", "") or ""
    local h = size.y
    local speed = a_speed or 0.3
    imgui.BeginGroup()
    imgui.InvisibleButton(str_id, size)
    imgui.SameLine()
    local pp = imgui.GetCursorPos()
    imgui.SetCursorPos(imgui.ImVec2(pp.x, pp.y + size.y / 7 - imgui.CalcTextSize(label).y / 7))
    imgui.Text(label)
    imgui.EndGroup()
    local clicked = imgui.IsItemClicked()
    local center = imgui.ImVec2(p.x + size.x / 2, p.y + size.y / 2)
    local radius = size.x / 2
    local backgroundColor = imgui.ImVec4(0.0, 0.0, 0.8, 0.9) 
    local segments = 32 * DPI
    local borderThickness = 5.0 * DPI
    DL:AddCircle(center, radius, imgui.GetColorU32Vec4(backgroundColor), segments, borderThickness)
    local innerRadius = radius * 0.1
    local innerColor = imgui.ImVec4(0.0, 0.0, 0.0, 1.0)
    DL:AddCircleFilled(center, innerRadius, imgui.GetColorU32Vec4(innerColor))
    local ballRadius = size.x / 2.7
    local ballColor = bool[0] and imgui.ImVec4(1.0, 1.0, 1.0, 1.0) or imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    DL:AddCircleFilled(center, ballRadius, imgui.GetColorU32Vec4(ballColor))
    if clicked then
        bool[0] = not bool[0]
    end
    return clicked
end
function customSliderFloat(label, value, min, max, format)
    local style = imgui.GetStyle()
    local draw_list = imgui.GetWindowDrawList()
    local cursor_pos = imgui.GetCursorScreenPos()
    local text_size = imgui.CalcTextSize(label)
    local slider_size = imgui.ImVec2(190 * DPI, 9 * DPI)
    local padding = 0 * DPI
    local slider_pos = imgui.ImVec2(cursor_pos.x + text_size.x + padding, cursor_pos.y)
    local slider_end_pos = imgui.ImVec2(slider_pos.x + slider_size.x, slider_pos.y + slider_size.y)
    local fraction = (value[0] - min) / (max - min)
    local handle_pos = slider_pos.x + fraction * slider_size.x
    local red_color = imgui.ImVec4(0.00, 0.00, 0.70, 1.00) 
    local brancocc = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
    local bgColor = imgui.ImVec4(0.05, 0.05, 0.05, 1.00)
    draw_list:AddRectFilled(slider_pos, slider_end_pos, imgui.GetColorU32Vec4(bgColor), style.FrameRounding)
    local filled_rect_end_pos = imgui.ImVec2(handle_pos, slider_end_pos.y)
    draw_list:AddRectFilled(slider_pos, filled_rect_end_pos, imgui.GetColorU32Vec4(red_color), style.FrameRounding)
    local is_dragging = imgui.IsMouseDragging(0) and imgui.IsMouseHoveringRect(slider_pos, slider_end_pos)
    local handle_radius = is_dragging and (10 * DPI) or (7.0 * DPI)
    local handle_center = imgui.ImVec2(handle_pos, slider_pos.y + slider_size.y * 0.5)
    draw_list:AddCircleFilled(handle_center, handle_radius, imgui.GetColorU32Vec4(brancocc), 100 * DPI)
    local value_text = string.format(format, value[0])
    local value_text_size = imgui.CalcTextSize(value_text)
    local value_text_x = slider_pos.x + slider_size.x - value_text_size.x
    local value_text_pos = imgui.ImVec2(value_text_x, slider_pos.y - value_text_size.y - 10.0 * DPI)
    imgui.SetCursorScreenPos(value_text_pos)
    imgui.PushFont(font111)
    imgui.TextColored(imgui.ImVec4(0.75, 0.75, 0.75, 1.00 * 0.45), value_text)
    imgui.SetCursorScreenPos(imgui.ImVec2(cursor_pos.x, cursor_pos.y + (slider_size.y - text_size.y) * 0.5))
    imgui.TextColored(imgui.ImVec4(0.75, 0.75, 0.75, 1.00 * 0.45), label)
    imgui.PopFont()
end
function imgui.ToggleButton(label, size, bool)
    local function ImSaturate(f)
        return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
    end
    local p = imgui.GetCursorScreenPos()
    local dl = imgui.GetWindowDrawList()
    local r = size.y / 2
    local x_begin = bool[0] and 1.0 or 0.0
    local t_begin = bool[0] and 0.0 or 1.0
    local s = 0.4
    local anim = false
    if not animationStates[label] then
        animationStates[label] = {LastTime = nil, LastActive = false}
    end
    local state = animationStates[label]
    if imgui.InvisibleButton(label, size) then
        bool[0] = not bool[0]
        state.LastTime = os.clock()
        state.LastActive = true
        anim = true
    end
    if state.LastActive then
        local time = os.clock() - state.LastTime
        if time <= s then
            local anim_progress = ImSaturate(time / s)
            x_begin = bool[0] and anim_progress or 1.0 - anim_progress
            t_begin = bool[0] and 1.0 - anim_progress or anim_progress
        else
            state.LastActive = false
        end
    end
    local borderColor = bool[0]
    local borderThickness = 5.0 * DPI
    local bgColor = bool[0] and imgui.ImVec4(0.0, 0.0, 0.8, 0.9) or imgui.ImVec4(0.00, 0.0, 0.0, 1.00)
    dl:AddRectFilled(
        imgui.ImVec2(p.x, p.y),
        imgui.ImVec2(p.x + size.x, p.y + size.y),
        imgui.GetColorU32Vec4(bgColor),
        r
    )
    dl:AddRect(
        imgui.ImVec2(p.x, p.y),
        imgui.ImVec2(p.x + size.x, p.y + size.y),
        borderColor,
        r,
        imgui.ImDrawCornerFlags_All,
        borderThickness
    )
    local circleRadius = r * 0.70
    local circleSegments = 90 * DPI
    local circleColor = bool[0] and imgui.ImVec4(1.00, 1.00, 1.00, 1.00) or imgui.GetStyle().Colors[imgui.Col.Text]
    dl:AddCircleFilled(
        imgui.ImVec2(p.x + r + x_begin * (size.x - r * 2), p.y + r),
        circleRadius,
        imgui.GetColorU32Vec4(circleColor),
        circleSegments
    )
    dl:AddText(
        imgui.ImVec2(p.x + size.x + r, p.y + r - (r / 2) - (imgui.CalcTextSize(label).y / 4)),
        imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Text]),
        label
    )
    return anim
end
function imgui.interfacetreze(index, item, size, duration)
    local function bringVec2To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec2(from.x + (count * (to.x - from.x) / 100), from.y + (count * (to.y - from.y) / 100)), true
        end
        return (timer > duration) and to or from, false
    end
    local DL = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    local size = size or DPII(imgui.ImVec2(160, 42))
    local duration = duration or 0.9
    local str_id = item.nomet .. "##" .. index
    if UI_CUSTOM_MENU_ITEM == nil then
        UI_CUSTOM_MENU_ITEM = {}
    end
    if UI_CUSTOM_MENU_ITEM[str_id] == nil then
        UI_CUSTOM_MENU_ITEM[str_id] = {
            pos1 = trezeg.selec[0] == index and imgui.ImVec2(p.x, p.y + size.y / 2) or imgui.ImVec2(p.x, p.y),
            pos2 = trezeg.selec[0] == index and imgui.ImVec2(p.x + size.x, p.y + size.y / 2) or
                imgui.ImVec2(p.x + size.x, p.y + size.y),
            pos3 = imgui.ImVec2(p.x + size.x - 5, p.y + size.y / 2),
            pos4 = imgui.ImVec2(p.x + size.x - 1, p.y + size.y / 2),
            hovered = false,
            active = trezeg.selec[0] == index and true or false,
            h_start = 0,
            a_start = 0
        }
    end
    local pool = UI_CUSTOM_MENU_ITEM[str_id]
    imgui.InvisibleButton(str_id, size)
    local clicked = imgui.IsItemClicked()
    local hovered = imgui.IsItemHovered()
    if hovered ~= pool.hovered and trezeg.selec[0] ~= index then
        pool.hovered = hovered
        local timer = os.clock() - pool.h_start
        if timer <= duration and timer >= 0 then
            pool.h_start = os.clock() - (duration - timer)
        else
            pool.h_start = os.clock()
        end
    end
    if clicked and trezeg.selec[0] ~= index then
        if index == 5 or index == 6 then
            return
        end
        pool.active = true
        trezeg.selec[0] = index
        local timer = os.clock() - pool.a_start
        if timer <= duration and timer >= 0 then
            pool.a_start = os.clock() - (duration - timer)
        else
            pool.a_start = os.clock()
        end
    elseif pool.active and trezeg.selec[0] ~= index then
        pool.active = false
        local timer = os.clock() - pool.a_start
        if timer <= duration and timer >= 0 then
            pool.a_start = os.clock() - (duration - timer)
        else
            pool.a_start = os.clock()
        end
        if pool.h_start == 0 then
            pool.h_start = os.clock()
        end
    end
    pool.pos1 =
        bringVec2To(
        (pool.hovered or trezeg.selec[0] == index) and imgui.ImVec2(p.x, p.y + size.y / 2) or imgui.ImVec2(p.x, p.y),
        (pool.hovered or trezeg.selec[0] == index) and imgui.ImVec2(p.x, p.y) or imgui.ImVec2(p.x, p.y + size.y / 2),
        pool.h_start,
        duration
    )
    pool.pos2 =
        bringVec2To(
        (pool.hovered or trezeg.selec[0] == index) and imgui.ImVec2(p.x + size.x, p.y + size.y / 2) or
            imgui.ImVec2(p.x + size.x, p.y + size.y),
        (pool.hovered or trezeg.selec[0] == index) and imgui.ImVec2(p.x + size.x, p.y + size.y) or
            imgui.ImVec2(p.x + size.x, p.y + size.y / 2),
        pool.h_start,
        duration
    )
    pool.pos3 =
        bringVec2To(
        trezeg.selec[0] == index and imgui.ImVec2(p.x, p.y + size.y / 2) or imgui.ImVec2(p.x, p.y + size.y / 6),
        trezeg.selec[0] == index and imgui.ImVec2(p.x, p.y + size.y / 6) or imgui.ImVec2(p.x, p.y + size.y / 2),
        pool.a_start,
        duration
    )
    pool.pos4 =
        bringVec2To(
        trezeg.selec[0] == index and imgui.ImVec2(p.x + 4, p.y + size.y / 2) or
            imgui.ImVec2(p.x + 10, p.y + size.y / 3 + size.y / 2),
        trezeg.selec[0] == index and imgui.ImVec2(p.x + 4, p.y + size.y / 3 + size.y / 2) or
            imgui.ImVec2(p.x + 10, p.y + size.y / 2),
        pool.a_start,
        duration
    )
    if trezeg.selec[0] == index then
        DL:AddRectFilled(pool.pos1, pool.pos2, imgui.GetColorU32Vec4(imgui.ImVec4(0.100, 0.100, 0.100, 1.0)), 8, 15)
    else
        DL:AddRectFilled(pool.pos1, pool.pos2, imgui.GetColorU32Vec4(imgui.ImVec4(0.1, 0.1, 0.1, 0)), 10, 15)
    end
    if trezeg.selec[0] == index then
        DL:AddRectFilled(pool.pos3, pool.pos4, imgui.GetColorU32Vec4(imgui.ImVec4(0.0, 0.0, 1.0, 1.0)), 10, 15)
    end
    local st = imgui.CalcTextSize(item.nomet)
    local textColor =
        (trezeg.selec[0] == index) and imgui.ImVec4(1.0, 1.0, 1.0, 1.0) or imgui.ImVec4(0.35, 0.35, 0.35, 1.00)
    DL:AddText(imgui.ImVec2(p.x + 20, p.y + size.y / 2 - st.y / 2), imgui.GetColorU32Vec4(textColor), item.nomet)
    return clicked
end
function imgui.CustomMenuItem(index, item, duration)
    local function bringVec2To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local t = timer / duration
            t = t * t * (3 - 2 * t)
            return from + (to - from) * t, true
        end
        return to, false
    end
    local function lerpColor(from, to, t)
        return imgui.ImVec4(
            from.x + (to.x - from.x) * t,
            from.y + (to.y - from.y) * t,
            from.z + (to.z - from.z) * t,
            from.w + (to.w - from.w) * t
        )
    end
    local DL = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    local size = tab_sizes[index]
    local duration = duration or 1.0
    local str_id = item.name .. "##" .. index
    if UI_CUSTOM_MENU_BAR == nil then
        UI_CUSTOM_MENU_BAR = {current_pos_x = p.x, target_pos_x = p.x, animation_start_time = os.clock()}
    end
    local pool = UI_CUSTOM_MENU_BAR
    imgui.InvisibleButton(str_id, size)
    local clicked = imgui.IsItemClicked()
    if clicked and nav.sel[0] ~= index then
        nav.sel[0] = index
        pool.target_pos_x = p.x
        pool.animation_start_time = os.clock()
    end
    pool.current_pos_x, _ =
        bringVec2To(
        pool.current_pos_x,
        (nav.sel[0] == index) and p.x or pool.target_pos_x,
        pool.animation_start_time,
        duration
    )
    local text_color_start = imgui.ImVec4(0.8, 0.8, 0.8, 0.70)
    local text_color_end = imgui.ImVec4(1.00, 0.00, 0.00, 1)
    local timer = os.clock() - pool.animation_start_time
    local text_t = math.min(timer / duration, 1)
    local text_color = text_color_start
    if nav.sel[0] == index then
        text_color = lerpColor(text_color_start, text_color_end, text_t)
    end
    local text_color_start = imgui.ImVec4(0.35, 0.35, 0.35, 1.00)
    local text_color_end = imgui.ImVec4(1.00, 1.00, 1.00, 1.0)
    local timer = os.clock() - pool.animation_start_time
    local t = math.min(timer / duration, 1.0)
    local text_color = lerpColor(text_color_start, text_color_end, t)
    if nav.sel[0] ~= index then
        text_color = text_color_start
    end
    imgui.PushFont(tab)
    local st = imgui.CalcTextSize(item.name)
    DL:AddText(
        imgui.ImVec2(p.x + 28 * DPI, p.y + size.y / 2.3 - st.y / 6),
        imgui.GetColorU32Vec4(text_color),
        item.name
    )
    imgui.PopFont()
    if nav.sel[0] == index then
        local function drawSolidColorBackground()
            local gradientes = 42 * DPI
            local rectWidth = size.x
            local rectHeight = gradientes
            local rectRounding = 7.0 * DPI
            local solidColor = imgui.ImVec4(0.085, 0.085, 0.085, 1.00)
            DL:AddRectFilled(
                imgui.ImVec2(pool.current_pos_x, p.y + size.y - gradientes),
                imgui.ImVec2(pool.current_pos_x + size.x, p.y + size.y),
                imgui.GetColorU32Vec4(solidColor),
                rectRounding
            )
        end
        drawSolidColorBackground()
        local bar_color = imgui.ImVec4(0.0, 0.0, 1.0, 1.0)
        local rounding = 10.0 * DPI
        local bar_width = 25 * DPI
        local bar_height = 3.1 * DPI
        local bar_pos_x = pool.current_pos_x + (size.x - bar_width) / 2
        DL:AddRectFilled(
            imgui.ImVec2(bar_pos_x, p.y + size.y - bar_height),
            imgui.ImVec2(bar_pos_x + bar_width, p.y + size.y),
            imgui.GetColorU32Vec4(bar_color),
            rounding
        )
        imgui.PushFont(tab)
        local st = imgui.CalcTextSize(item.name)
        DL:AddText(
            imgui.ImVec2(p.x + 28 * DPI, p.y + size.y / 2.3 - st.y / 6),
            imgui.GetColorU32Vec4(text_color),
            item.name
        )
        imgui.PopFont()
    end
    return clicked
end
function imgui.VusualMenuItem(index, item, duration)
    local function bringVec2To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local t = timer / duration
            t = t * t * (3 - 2 * t)
            return from + (to - from) * t, true
        end
        return to, false
    end
    local function lerpColor(from, to, t)
        return imgui.ImVec4(
            from.x + (to.x - from.x) * t,
            from.y + (to.y - from.y) * t,
            from.z + (to.z - from.z) * t,
            from.w + (to.w - from.w) * t
        )
    end
    local DL = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    local size = tab_sizes[index]
    local duration = duration or 1.0
    local str_id = item.namett .. "##" .. index
    if UI_CUSTOM_MENU_BAR == nil then
        UI_CUSTOM_MENU_BAR = {current_pos_x = p.x, target_pos_x = p.x, animation_start_time = os.clock()}
    end
    local pool = UI_CUSTOM_MENU_BAR
    imgui.InvisibleButton(str_id, size)
    local clicked = imgui.IsItemClicked()
    if clicked and visu.selo[0] ~= index then
        visu.selo[0] = index
        pool.target_pos_x = p.x
        pool.animation_start_time = os.clock()
    end
    pool.current_pos_x, _ =
        bringVec2To(
        pool.current_pos_x,
        (visu.selo[0] == index) and p.x or pool.target_pos_x,
        pool.animation_start_time,
        duration
    )
    local text_color_start = imgui.ImVec4(0.8, 0.8, 0.8, 0.70)
    local text_color_end = imgui.ImVec4(1.00, 0.00, 0.00, 1)
    local timer = os.clock() - pool.animation_start_time
    local text_t = math.min(timer / duration, 1)
    local text_color = text_color_start
    if visu.selo[0] == index then
        text_color = lerpColor(text_color_start, text_color_end, text_t)
    end
    local text_color_start = imgui.ImVec4(0.35, 0.35, 0.35, 1.00)
    local text_color_end = imgui.ImVec4(1.00, 1.00, 1.00, 1.0)
    local timer = os.clock() - pool.animation_start_time
    local t = math.min(timer / duration, 1.0)
    local text_color = lerpColor(text_color_start, text_color_end, t)
    if visu.selo[0] ~= index then
        text_color = text_color_start
    end
    imgui.PushFont(tab)
    local st = imgui.CalcTextSize(item.namett)
    DL:AddText(
        imgui.ImVec2(p.x + 28 * DPI, p.y + size.y / 2.3 - st.y / 6),
        imgui.GetColorU32Vec4(text_color),
        item.namett
    )
    imgui.PopFont()
    if visu.selo[0] == index then
        local function drawSolidColorBackground()
            local gradientes = 42 * DPI
            local rectWidth = size.x
            local rectHeight = gradientes
            local rectRounding = 7.0 * DPI
            local solidColor = imgui.ImVec4(0.085, 0.085, 0.085, 1.00)
            DL:AddRectFilled(
                imgui.ImVec2(pool.current_pos_x, p.y + size.y - gradientes),
                imgui.ImVec2(pool.current_pos_x + size.x, p.y + size.y),
                imgui.GetColorU32Vec4(solidColor),
                rectRounding
            )
        end
        drawSolidColorBackground()
        local bar_color = imgui.ImVec4(0.0, 0.0, 1.0, 1.0)
        local rounding = 10.0 * DPI
        local bar_width = 25 * DPI
        local bar_height = 3.1 * DPI
        local bar_pos_x = pool.current_pos_x + (size.x - bar_width) / 2
        DL:AddRectFilled(
            imgui.ImVec2(bar_pos_x, p.y + size.y - bar_height),
            imgui.ImVec2(bar_pos_x + bar_width, p.y + size.y),
            imgui.GetColorU32Vec4(bar_color),
            rounding
        )
        imgui.PushFont(tab)
        local st = imgui.CalcTextSize(item.namett)
        DL:AddText(
            imgui.ImVec2(p.x + 28 * DPI, p.y + size.y / 2.3 - st.y / 6),
            imgui.GetColorU32Vec4(text_color),
            item.namett
        )
        imgui.PopFont()
    end
    return clicked
end
function DPII(treze)
    return imgui.ImVec2(treze.x * DPI, treze.y * DPI)
end
function loadConfigFiles()
    configFiles = {}
    local dirPath = getWorkingDirectory() .. "/config"
    for file in lfs.dir(dirPath) do
        if file:match("%.ini$") and file:sub(1, 2) == ".." then
            table.insert(configFiles, file)
        end
    end
end
function saveConfig()
    ini.Hotwheels.SuavidadeAimbot = SmoothX[0]
    ini.Hotwheels.DesenharFov = circuloFOVAIM[0]
    ini.Hotwheels.aimbot = cabecaAIM[0]
    ini.Hotwheels.pescocoaimbot = pescocoaimbot[0]
    ini.Hotwheels.ombroaimbott = ombroooo[0]
    ini.Hotwheels.ombro2aimbott = ombroooo22[0]
    ini.Hotwheels.peitoaimboot = peitoaimboott[0]
    ini.Hotwheels.virilhaaaimbot = virilhaaimboott[0]
    ini.Hotwheels.braccoooaimbot = bracooaimboott[0]
    ini.Hotwheels.bracooo2aimboot = bracooo2aimboott[0]
    ini.Hotwheels.pernnaaaimbot = pernnaaaimboott[0]
    ini.Hotwheels.pernaaa2aimboot = pernnaaa22imboott[0]
    ini.Hotwheels.cabecasilbbent = cabecaSilent[0]
    ini.Hotwheels.virilhasilehhnt = virilhaSilent[0]
    ini.Hotwheels.ombrosileent = ombroSilent[0]
    ini.Hotwheels.ombro22silennt = ombro2Silent[0]
    ini.Hotwheels.pescocosilelent = pescocoSilent[0]
    ini.Hotwheels.bracoo2silentt = braco2Silent[0]
    ini.Hotwheels.perna2silentt = perna2Silent[0]
    ini.Hotwheels.pernasilenttba = pernaSilent[0]
    ini.Hotwheels.peitosilenttst = peitoSilent[0]
    ini.Hotwheels.bracoosilenthsh = bracoSilent[0]
    ini.Hotwheels.tamanhofovsilent = FoVVtreze[0]
    ini.Hotwheels.chancedetirossilent = cooldown_slider[0]
    ini.Hotwheels.offsetaimbotX = posiX[0]
    ini.Hotwheels.offsetaimbotY = posiY[0]
    ini.Hotwheels.offsetsilentcirculoX = iaiiajshsX[0]
    ini.Hotwheels.offsetsilentcirculoY = jsjisjwbsY[0]
    ini.Hotwheels.mataratrasdaoaredesilent = ativarMatarAtravesDeParedes[0]
    ini.Hotwheels.desenharfov = drawfovvsilent[0]
    ini.Hotwheels.distanciasilent = fovvsilentdist[0]
    ini.Hotwheels.sanguesilent = sanguekkkb[0]
    ini.Hotwheels.ativarsilenttt = state[0]
    ini.Hotwheels.naomatarjogadorcomamesmaskin = verificarSkin[0]
    ini.Hotwheels.maximadistanciasilent = ysuaushsbsv[0]
    ini.Hotwheels.ativaraimbottt = enable[0]
    ini.Hotwheels.distanciaaimboot = Distancia[0]
    ini.Hotwheels.tamanhodofovaimbot = FOVCircleRadius[0]
    ini.Hotwheels.naogrudaratrasdaparedeaimbot = aimbotparede[0]
    ini.Hotwheels.naogrudaremaimgosaimbot = teamsimbot[0]
    ini.Hotwheels.ignorardistanciaaimbot = maxdustacuahs[0]
    ini.Hotwheels.espLinha = ESP.enabled_lines[0]
    ini.Hotwheels.espVida = ESP.enabled_health[0]
    ini.Hotwheels.espDistancia = ESP.enabled_distance[0]
    local filename = ffi.string(configName)
    if filename:sub(1, 2) == ".." then
        filename = filename:gsub("^%.%.%.*", "")
    end
    ffi.copy(configName, filename)
    inicfg.save(ini, ffi.string(configName))
    loadConfigFiles()
end
function colorToHexxx(r, g, b, a)
    return bit.bor(
        bit.lshift(math.floor(a * 255), 24),
        bit.lshift(math.floor(r * 255), 16),
        bit.lshift(math.floor(g * 255), 8),
        math.floor(b * 255)
    )
end
function getCurrentESPColor()
    return colorToHexxx(corespkaojab[0], corespkaojab[1], corespkaojab[2], corespkaojab[3])
end
function newgetCurrentESPColor()
    return colorToHexxx(corespkaojabb[0], corespkaojabb[1], corespkaojabb[2], corespkaojabb[3])
end
lua_thread.create(
    function()
        local myModel = getCharModel(PLAYER_PED)
        while true do
            wait(0)
            local espColor = getCurrentESPColor()
            local espColorr = newgetCurrentESPColor()
            local playerPed = PLAYER_PED
            local px, py, pz = getCharCoordinates(playerPed)
            for _, char in ipairs(getAllChars()) do
                local result, id = sampGetPlayerIdByCharHandle(char)
                if result and isCharOnScreen(char) then
                    local cx, cy, cz = getCharCoordinates(char)
                    local distance = getDistanceBetweenCoords3d(px, py, pz, cx, cy, cz)
                    local charModel = getCharModel(char)
                    local verificarSkin = VERIFICARSKIN[0]
                    local myModel = getCharModel(playerPed)
                    if verificarSkin and charModel == myModel then
                        goto continue
                    end
                    if distance <= 999 then
                        if ESP.enabled_bones[0] and ATIVARESPS[0] then
                            if char ~= playerPed then
                                for _, bone in ipairs(ESP.BONES) do
                                    local x1, y1, z1 = getBonePosition(char, bone)
                                    local x2, y2, z2 = getBonePosition(char, bone + 1)
                                    local r1, sx1, sy1 = convert3DCoordsToScreenEx(x1, y1, z1)
                                    local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                                    if r1 and r2 then
                                        local isClearLOS =
                                            isLineOfSightClear(x1, y1, z1, x2, y2, z2, true, true, false, true, true)
                                        renderDrawLine(sx1, sy1, sx2, sy2, 1, espColor)
                                    end
                                end
                                local x1, y1, z1 = getBonePosition(char, 1)
                                local r1, sx1, sy1 = convert3DCoordsToScreenEx(x1, y1, z1)
                                if r1 then
                                    local x2, y2, z2 = getBonePosition(char, 41)
                                    local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                                    if r2 then
                                        local isClearLOS =
                                            isLineOfSightClear(x1, y1, z1, x2, y2, z2, true, true, false, true, true)
                                        renderDrawLine(sx1, sy1, sx2, sy2, 1, espColor)
                                    end
                                end
                                if r1 then
                                    local x2, y2, z2 = getBonePosition(char, 51)
                                    local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                                    if r2 then
                                        local isClearLOS =
                                            isLineOfSightClear(x1, y1, z1, x2, y2, z2, true, true, false, true, true)
                                        renderDrawLine(sx1, sy1, sx2, sy2, 1, espColor)
                                    end
                                end
                            end
                        end
                        if ESP.enabled_boxes[0] and ATIVARESPS[0] then
                            if char ~= playerPed then
                                local x1, y1, z1 = getCharCoordinates(playerPed)
                                local x2, y2, z2 = getCharCoordinates(char)
                                local headx, heady = convert3DCoordsToScreen(x2, y2, z2 + 1.20)
                                local footx, footy = convert3DCoordsToScreen(x2, y2, z2 - 1.20)
                                if headx and footx then
                                    local width = math.abs((heady - footy) * 0.22)
                                    renderDrawLine(headx - width, heady, headx + width, heady, 1, espColorr)
                                    renderDrawLine(headx + width, heady, headx + width, footy, 1, espColorr)
                                    renderDrawLine(headx + width, footy, headx - width, footy, 1, espColorr)
                                    renderDrawLine(headx - width, footy, headx - width, heady, 1, espColorr)
                                end
                            end
                        end
                        if ESP.enabled_lines[0] and ATIVARESPS[0] and char ~= playerPed then
                            local sx, sy = getScreenResolution()
                            local screenX, screenY = convert3DCoordsToScreen(cx, cy, cz)
                            if screenX and screenY then
                                renderDrawLine(sx / 2, sy, screenX, screenY, 1, espColor)
                            end
                        end
                        if ESP.enabled_health[0] and ATIVARESPS[0] and char ~= playerPed then
                            local hx, hy, hz = getBonePosition(char, 8)
                            local ok, sx, sy = convert3DCoordsToScreenEx(hx, hy, hz)
                            if ok then
                                local health = getCharHealth(char) or 100
                                local maxHealth = getCharMaxHealth(char) or 100
                                local pct = math.max(0, math.min(1, health / maxHealth))
                                renderDrawLine(sx - 12, sy, sx - 12 + 24 * pct, sy, 2, colorToHexx(0, 1, 0, 1))
                            end
                        end
                        if ESP.enabled_distance[0] and ATIVARESPS[0] and char ~= playerPed then
                            local ok, sx, sy = convert3DCoordsToScreenEx(cx, cy, cz)
                            if ok then
                                local distText = string.format("%.0fm", distance)
                                renderFontDrawText(ESP.FONT, distText, sx + 4, sy + 4, espColor)
                            end
                        end
                    end
                end
                ::continue::
            end
        end
    end
)
function colorToHexx(r, g, b, a)
    return bit.bor(
        bit.lshift(math.floor(a * 255), 24),
        bit.lshift(math.floor(r * 255), 16),
        bit.lshift(math.floor(g * 255), 8),
        math.floor(b * 255)
    )
end
function espkrlh()
    local playerPed = PLAYER_PED
    local px, py, pz = getCharCoordinates(playerPed)
    local mymodel = getCharModel(playerPed)
    if ESP_NOME[0] and ATIVARESPS[0] then
        for _, char in ipairs(getAllChars()) do
            if char ~= playerPed then
                local result, id = sampGetPlayerIdByCharHandle(char)
                if result and isCharOnScreen(char) then
                    local charModel = getCharModel(char)
                    if not (VERIFICARSKIN[0] and charModel == mymodel) then
                        local char_x, char_y, char_z = getCharCoordinates(char)
                        local distance = math.sqrt((char_x - px) ^ 2 + (char_y - py) ^ 2 + (char_z - pz) ^ 2)
                        if distance <= 999 then
                            local hx, hy, hz = getBonePosition(char, 5)
                            local hr, headx, heady = convert3DCoordsToScreenEx(hx, hy, hz + 0.25)
                            if hr then
                                headx = headx - 35
                                heady = heady - 20
                                local playerName = sampGetPlayerNickname(id) or "Unknown"
                                local displayName = (sampIsPlayerPaused(id) and "[ AFK ] " or "") .. playerName
                                renderFontDrawText(
                                    font,
                                    displayName,
                                    headx,
                                    heady,
                                    colorToHexx(treze.coreps[0], treze.coreps[1], treze.coreps[2], treze.coreps[3])
                                )
                            end
                        end
                    end
                end
            end
        end
    end
end
imgui.OnInitialize(
    function()
        local config = imgui.ImFontConfig()
        config.MergeMode = true
        config.PixelSnapH = true
        tema()
    end
)
function tema()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    style.WindowRounding = 9.0 * DPI
    style.FrameRounding = 5 * DPI
    style.WindowTitleAlign = imgui.ImVec2(0.5 * DPI, 0.5 * DPI)
    style.FramePadding = imgui.ImVec2(0.5 * DPI, 3.7 * DPI)
    style.ChildRounding = 2 * DPI
    style.WindowBorderSize = 0 * DPI
    style.ChildBorderSize = 0 * DPI
    style.PopupBorderSize = 0 * DPI
    style.GrabMinSize = 27.0 * DPI
    style.GrabRounding = 16.0 * DPI
    style.PopupRounding = 2.0 * DPI
    style.ScrollbarSize = 14 * DPI
    style.FrameBorderSize = 1.0 * DPI
    colors[clr.Border] = imgui.ImVec4(0.11, 0.11, 0.11, 0.50)
    colors[clr.SliderGrab] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.SliderGrabActive] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBgHovered] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBgActive] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.PopupBg] = imgui.ImVec4(0.055, 0.055, 0.055, 1.0)
    colors[clr.Text] = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled] = imgui.ImVec4(0.5, 0.5, 0.5, 1.00)
    colors[clr.TitleBg] = imgui.ImVec4(0.15, 0.15, 0.15, 1.00)
    colors[clr.TitleBgActive] = imgui.ImVec4(0.15, 0.15, 0.15, 1.00)
    colors[clr.TitleBgCollapsed] = imgui.ImVec4(0.15, 0.15, 0.15, 1.00)
    colors[clr.Button] = imgui.ImVec4(0.09, 0.09, 0.09, 1.0)
    colors[clr.ButtonHovered] = imgui.ImVec4(0.05, 0.05, 0.05, 0.20)
    colors[clr.ButtonActive] = imgui.ImVec4(0.05, 0.05, 0.05, 0.20)
    colors[clr.WindowBg] = imgui.ImVec4(0.055, 0.055, 0.055, 1.0)
    imgui.PushStyleColor(imgui.Col.CheckMark, imgui.ImVec4(0.1, 0.1, 0.1, 1.00))
end
function DPII(treze)
    return imgui.ImVec2(treze.x * DPI, treze.y * DPI)
end
--print = function(...)
--end
