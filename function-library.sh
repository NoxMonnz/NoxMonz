system_read_function() {
GAME="$1" # This variable is still needed for cmd game downscales
CONFIG_FILE="/storage/emulated/0/NoxXBPRO/settings/settings.ini" 

# Check if the GAME (package name) argument is present
if [ -z "$GAME" ]; then
    echo "ERROR: Game package name (first argument) is empty. Cannot continue system setup."
    return 1
    exit 1
fi

# Check for the existence of the configuration file
if [ ! -f "$CONFIG_FILE" ]; then
    echo "ERROR: Configuration file NOT FOUND in $CONFIG_FILE."
    echo "Make sure 'settings.ini' is in the correct location."
    return 1
fi

ENGINE_VALUE=$(sed -n 's/Engine="\([^"]*\)"/\1/p' "$CONFIG_FILE")
BECKEND_VALUE=$(sed -n 's/Beckend="\([^"]*\)"/\1/p' "$CONFIG_FILE")
SCALE_VALUE=$(sed -n 's/Scale="\([^"]*\)"/\1/p' "$CONFIG_FILE")
FPS_VALUE=$(sed -n 's/Fps="\([^"]*\)"/\1/p' "$CONFIG_FILE")
DWNS_VALUE=$(sed -n 's/Downscale="\([^"]*\)"/\1/p' "$CONFIG_FILE")
    
# Menerapkan pengatarun SCALE
# settings put membutuhkan izin shell atau root.
{
settings put global window_animation_scale "$SCALE_VALUE"
settings put global transition_animation_scale "$SCALE_VALUE"
settings put global animator_duration_scale "$SCALE_VALUE"
} > /dev/null 2>&1
    
# Menerapkan pengaturan FPS
# settings put membutuhkan izin shell atau root.
{
settings put system peak_refresh_rate "$FPS_VALUE"
settings put system min_refresh_rate "$FPS_VALUE"
settings put system max_refresh_rate "$FPS_VALUE"
settings put system user_refresh_rate "$FPS_VALUE"
} > /dev/null 2>&1

checked=$(pm list features | grep vulkan | echo "true" || echo "false")

if [ "$checked" = "true" ]; then
# Menerapkan pengaturan Engine dan Backend
# setprop membutuhkan izin shell atau root. Pastikan Brevent memiliki ini.
  {
  setprop debug.hwui.renderer "$ENGINE_VALUE"
  setprop debug.renderengine.beckend  "$BECKEND_VALUE"
  } > /dev/null 2>&1
  echo " Engine: $ENGINE_VALUE"
  sleep 1
  echo " Beckend: $BECKEND_VALUE "
else
  echo " Your Phone Not Supported Vulkan API!"
  sleep 0.5
  echo " Auto Set To OpenGL "
  {
  setprop debug.hwui.renderer opengl
  setprop debug.renderengine.beckend opengl
  } > /dev/null 2>&1
fi 
    
sleep 1
    
# Scale Detect
# Perbaikan: Menggunakan "$SCALE_VALUE"
if [ -n "$SCALE_VALUE" ]; then
    echo " Animation Scale: $SCALE_VALUE"
else
    echo " Animation Scale: Not Detected/Applied"
fi
  
sleep 1
    
# Fps Detect
# Perbaikan: Menggunakan "$FPS_VALUE"
if [ -n "$FPS_VALUE" ]; then
    echo " Frame Per Seconds: $FPS_VALUE"
else
    echo " Frame Per Seconds: Not Detected/Applied"
fi
  
sleep 1
    
# Downscale Detect
# Perbaikan: Menggunakan "$DWNS_VALUE" dan pesan yang benar

output=$(cmd game 2>&1)

# Periksa apakah output menunjukkan dukungan Game Manager
if echo "$output" | grep -q "Game manager (game) commands:"; then 
    cmd game downscale $DWNS_VALUE $GAME > /dev/null 2>&1
    echo " Downscale: $DWNS_VALUE ( $GAME )"
elif echo "$output" | grep -q "cmd: Can't find service: game"; then
    echo "Your Phone Does Not Support Game Manager"
else
    echo "Could not determine Game Manager support. Unexpected output from 'cmd game'."
fi

 
sleep 1
    
echo " Success" 
echo ""
sleep 2 # Mengurangi sleep
    
return 0 # Mengembalikan 0 untuk menandakan sukses
}




Detected_Game() {
#Detected Game
magic_patch="package"
directory_path="/data/local/tmp"

 if [ ! -d "$directory_path" ]; then
   mkdir -p "$directory_path"
 else
   sleep 5
 fi

#Directory-Betting
games_list="/storage/emulated/0/Android/data"
magic_games="/data/local/tmp/package"
rm -f "$magic_games"

packages_list="
com.pubg.newstate
com.pwrd.hotta.laohu
com.pwrd.huanta
com.r2games.myhero.bilibili
com.rayark.implosion
com.rayark.sdorica
com.rekoo.pubgm
com.riotgames.league.teamfighttactics
com.riotgames.league.teamfighttacticsvn
com.riotgames.league.wildrift
com.roblox.client
com.rockstargames.gtasa
com.sega.ColorfulStage.en
com.sega.pjsekai
com.shangyoo.neon
com.shenlan.m.reverse1999
com.smokoko.race
com.sofunny.Sausage
com.soulgamechst.majsoul
com.sprduck.garena.vn
com.stove.epic7.google
com.supercell.brawlstars
com.supercell.clashofclans
com.supercell.clashroyale
com.sy.dldlhsdj
com.t2ksports.nba2k20and
com.tencent.KiHan
com.tencent.ig
com.tencent.jkchess
com.tencent.lolm
com.tencent.mf.uam
com.tencent.tmgp.WePop
com.tencent.tmgp.bh3
com.tencent.tmgp.cf
com.tencent.tmgp.cod
com.tencent.tmgp.dfjs
com.tencent.tmgp.ffom
com.tencent.tmgp.gnyx
com.tencent.tmgp.kr.codm
com.tencent.tmgp.pubgmhd
com.tencent.tmgp.sgame
com.tencent.tmgp.speedmobile
com.tencent.tmgp.wuxia
com.tencent.tmgp.yys.zqb
com.tencent.toaa
com.tgc.sky.android
com.the10tons.dysmantle
com.ubisoft.rainbowsixmobile.r6.fps.pvp.shooter
com.unity.mmd
com.valvesoftware.cswgsm
com.valvesoftware.source
com.vng.mlbbvn
com.vng.pubgmobile
com.vng.speedvn
com.xd.TLglobal
com.xd.rotaeno.googleplay
com.xd.rotaeno.tapcn
com.xindong.torchlight
com.yongshi.tenojo
com.zlongame.mhmnz
com.ztgame.bob
com.zy.wqmt.cn
jp.co.craftegg.band
jp.konami.pesam
net.kdt.pojavlaunch
net.wargaming.wot.blitz
org.mm.jr
org.vita3k.emulator
pro.archiemeng.waifu2x
skyline.emu
skynet.cputhrottlingtest
org.yuzu.yuzu_emu
id.rj01117883.liomeko
xyz.aethersx2.android
com.pwrd.opmwsea
com.FosFenes.Sonolus
com.devsisters.ck
ro.alyn_sampmobile.game
com.kakaogames.gdts
com.Shooter.ModernWarship
com.supercell.hayday
com.nekki.shadowfight
com.nekki.shadowfight3
com.gamedevltd.wwh
com.netease.ma100asia
com.gryphline.exastris.gp
org.sudachi.sudachi_emu.ea
me.piebridge.brevent
com.kurogame.wutheringwaves.global
com.levelinfinite.sgameGlobal.midaspay
com.drivezone.car.race.game
com.neowizgames.game.browndust2
com.bluepoch.m.en.reverse1999
com.HoYoverse.Nap
com.bycodec.project_drift
com.nebulajoy.act.dmcpoc
com.nebulajoy.act.dmcpoc.asia
com.mobilelegends.mi
com.garena.game.lmjx
com.sandboxol.blockymods
com.proximabeta.mf.liteuamo
com.pixonic.wwr
com.netmarble.sololv
com.seasun.snowbreak.google
com.F2Games.GBDE
com.eg.mimicry.horror.online
com.asia.arrival
com.riotgames.league.wildrift
com.netease.newspike
com.refuelgames.rally
com.garena.game.bc
com.xd.ssrpgen
com.GacoGames.EC2
com.fattoy.swordash.android
io.geekout.lastmemories
com.farlightgames.igame.gp
com.studiowildcard.wardrumstudios.ark
ru.nsu.ccfit.zuev.osuplus
com.ea.games.r3_row
com.moonton.mobilehero
com.levv.gametuner
com.garena.game.kgth
com.kurogame.wutheringwaves.global
com.mobilelegends.hwag
com.bandainamcoent.opbrww
com.Shooter.ModernWarfront
com.maxgames.stickwar3
com.movtery.zalithlauncher
com.mojang.minecraftpe.mbl2
ro.alyn_sampmobile.game
ro.samp_mobile.game
com.garena.game.nfsm
org.ppsspp.ppsspp
com.pixelcurves.terlauncher
com.chucklefish.stardewvalley
com.and.games505.TerrariaPaid
abc.smapi.gameloader
com.devsisters.ck
com.olzhas.carparking.multyplayer2
com.cspb.definitive
top.niunaijun.blackboxa32
com.dgames.g65002005.google
com.gaijingames.wt
com.bandainamcoent.ultimateninjastorm
com.mobilechess.gp
com.netease.dfjsjp
com.playspare.supermarket.store.simulator
com.efun.aeend3.sea
com.taiyouxi.jwshmt
com.gof.global
com.herogame.gplay.punishing.grayraven.tw
com.kurogame.gplay.punishing.grayraven.en
com.herogame.gplay.punishing.grayraven.jp
com.tgc.sky.android
com.tgc.sky.android.test.gold
org.vita3k.emulator
org.citra.emu
org.ppsspp.ppssppgold
com.github.stenzek.duckstation
com.netease.dfjsjp
com.blitzteam.battleprime
com.AlfaBravo.CombatMaster
com.rockstargames.gtasa
com.rockstargames.bully
com.proximabeta.mf.uamo
com.hhgame.mlbbvn
6age.of.civilizations2.jakowski.lukasz
com.gametaiwan.jj
com.vng.sea.metalslug
com.my.warface.online.fps.pvp.action.shooter
com.seaofconquest.global
com.cjenm.ModoMarbleKaakao
com.ea.gp.fifamobile
com.tencent.nfsonline
com.levelinfinite.sgameGlobal.xiaomi
com.tencent.tmgp.gnyx
com.lilithgame.roc.gp
com.devlaps.harekat2
com.ss.android.ugc.trill.net.kdt.pojavlaunch.firefly
com.vega.alphafgl
com.miHoYo.GI.samsung
com.netease.h75na
com.studiowildcard.wardrumstudios.ark
com.telltalegames.walkingdead300
com.mobilechess.taptap
com.epicgames.ue4.GameActivity
com.asobimo.toramonline
com.GlobalSoFunny.Sausage
com.longe.racehmt
com.winlator
com.levelinfinite.sgameGlobal.huawei
com.bushiroad.en.bangdreamgbp
com.ChillyRoom.DungeonShooter
com.chillyroom.soulknightprequel
com.Flanne.MinutesTillDawn.roguelike.shooting.gp
com.GameCoaster.ProtectDungeon
com.HoYoverse.hkrpgoversea
com.RoamingStar.BlueArchive
com.Shooter.ModernWarships
com.Sunborn.SnqxExilium
com.YoStar.AetherGazer
com.YoStarEN.Arknights
com.YoStarEN.MahjongSoul
com.YoStarJP.MajSoul
com.YostarJP.BlueArchive
com.ZeroCastleGameStudio.StrikeBusterPrototype
com.ZeroCastleGameStudioINTL.StrikeBusterPrototype
com.activision.callofduty.shooter
com.activision.callofduty.warzone
com.albiononline
com.aligames.kuang.kybc
com.autumn.skullgirls
com.axlebolt.standoff2
com.bandainamcoent.imas_millionlive_theaterdays
com.bandainamcoent.sao
com.bandainamcoent.shinycolorsprism
com.bhvr.deadbydaylight
com.bilibili.azurlane
com.bilibili.deadcells.mobile
com.bilibili.fatego
com.bilibili.star.bili
com.bilibili.warmsnow
com.bilibiligame.heglgp
com.bingkolo.kleins.cn
com.blizzard.diablo.immortal
com.bushiroad.d4dj
com.bushiroad.lovelive.schoolidolfestival2
com.carxtech.sr
com.citra.emu
com.cnvcs.xiangqi
com.criticalforceentertainment.criticalops
com.dena.a12026801
com.denachina.g13002010
com.dfjz.moba
com.dgames.g15002002
com.dolphinemu.dolphinemu
com.dragonli.projectsnow.lhm
com.dts.freefiremax
com.dts.freefireth
com.dts.freefireadv
com.ea.gp.apexlegendsmobilefps
com.ea.gp.fifamobile
com.epicgames.fortnite
com.fantablade.icey
com.firsttouchgames.dls7
com.gabama.monopostolite
com.gameloft.android.ANMP.GloftA9HM
com.gameloft.android.ANMP.GloftMVHM
com.garena.game.codm
com.garena.game.kgid
com.garena.game.kgtw
com.garena.game.kgvn
com.guyou.deadstrike
com.halo.windf.hero
com.heavenburnsred
com.hermes.j1game
com.hottapkgs.hotta
com.hypergryph.arknights
com.ignm.raspberrymash.jp
com.ilongyuan.implosion
com.jacksparrow.jpmajiang
com.je.supersus
com.kakaogames.eversoul
com.kakaogames.wdfp
com.kog.grandchaseglobal
com.komoe.kmumamusumegp
com.kurogame.haru
com.kurogame.haru.bilibili
com.leiting.wf
com.levelinfinite.hotta.gp
com.levelinfinite.sgameGlobal
com.lilithgames.hgame.cn
com.linegames.sl
com.madfingergames.legends
com.miHoYo.GenshinImpact
com.miHoYo.Yuanshen
com.miHoYo.bh3
com.miHoYo.bh3global
com.miHoYo.bh3oversea
com.miHoYo.bh3oversea_vn
com.miHoYo.enterprise.NGHSoD
com.miHoYo.hkrpg
com.miHoYo.ys
com.miraclegames.farlight84
com.mobile.legends
com.mobilelegends.hwag
com.mojang.hostilegg
com.mojang.minecraftpe
com.mojang.minecraftpe.patch
com.nanostudios.games.twenty.minutes
com.netease.AVALON
com.netease.EVE
com.netease.aceracer
com.netease.dfjs
com.netease.dwrg
com.netease.eve.en
com.netease.frxyna
com.netease.g93na
com.netease.h75na
com.netease.jddsaef
com.netease.lglr
com.netease.ma84
com.netease.moba
com.netease.mrzh
com.netease.newspike
com.netease.nshm
com.netease.onmyoji
com.netease.party
com.netease.partyglobal
com.netease.race
com.netease.racerna
com.netease.sky
com.netease.soulofhunter
com.netease.tj
com.netease.tom
com.netease.wotb
com.netease.x19
com.netease.yhtj
com.nexon.bluearchive
com.nexon.kartdrift
com.nianticlabs.monsterhunter
com.olzhass.carparking.multyplayer
com.pearlabyss.blackdesertm.gl
com.pinkcore.tkfm
com.playdigious.deadcells.mobile
com.proximabeta.mf.uamo
com.proximabeta.nikke
com.prpr.musedash
com.pubg.imobile
com.pubg.krmobile
"

echo "$packages_list" | while IFS= read -r packages; do
    if [ -d "$games_list/$packages" ]; then
      echo "$packages" >> "$magic_games"
    fi
done

sed -i '/^$/d' "$magic_games"
}



#!/system/bin/sh

moddifier() {
# Tentukan direktori target
DIR_FILE="/data/local/tmp"

# Tentukan nama file
NAME_FILE="Scan"

# Konten file akan diambil dari argumen pertama ($1)
FILE_CONTENT="$1"

# --- Validasi Argumen ---
# Pastikan ada argumen yang diberikan
if [ -z "$FILE_CONTENT" ]; then
    echo "ERROR: Tidak ada konten yang diberikan untuk file."
    echo "Penggunaan: <nama_skrip_ini> <konten_yang_diinginkan>"
    return 1 # Keluar dengan kode error
fi

# --- Pastikan Direktori Ada ---
# Buat direktori jika belum ada. Opsi -p mencegah error jika direktori sudah ada.
mkdir -p "$DIR_FILE"

# --- Buat Jalur File Lengkap ---
FULL_FILE_PATH="$DIR_FILE/$NAME_FILE"

# --- Tulis Konten ke File ---
# Menggunakan 'echo' dan 'redirect' (>) untuk menulis konten ke file.
# Jika file sudah ada, isinya akan ditimpa.
echo "$FILE_CONTENT" > "$FULL_FILE_PATH"

# --- Verifikasi Pembuatan File ---
# Periksa apakah file benar-benar ada dan isinya sesuai
if [ -f "$FULL_FILE_PATH" ] && [ "$(cat "$FULL_FILE_PATH")" = "$FILE_CONTENT" ]; then
    return 0 # Keluar dengan kode sukses
else
    echo "ERROR: Failed to create or verify file '$FULL_FILE_PATH'."
    exit 1
fi
}



Checking_file() {
magic_patch="package"
directory_path="/data/local/tmp"

#Check Package File
check_file_list() {


 if [ ! -f "$directory_path/$magic_patch" ]; then
   sleep 2
   echo "ERROR!, Game Package Not Found"
   echo ""
   sleep 5   
   exit 1
 else #Other Words
   sleep 4
 fi
}

check_file_list

sdk_version=$(getprop ro.build.version.sdk)
}
