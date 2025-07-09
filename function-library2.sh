


disable_battery() {
{
settings put global battery_saver_adaptive_constants advertise_is_enabled=false,enable_datasaver=false,enable_night_mode=true,disable_launch_boost=false,disable_vibration=true,disable_animation=true,disable_soundtrigger=true,defer_full_backup=true,defer_keyvalue_backup=true,enable_firewall=false,location_mode=2,gps_mode=2,enable_brightness_adjustment=false,adjust_brightness_factor=0.5,force_all_apps_standby=true,force_background_check=true,disable_optional_sensors=true,disable_aod=false,enable_quick_doze true
settings put global battery_saver_constants advertise_is_enabled=false,enable_datasaver=false,enable_night_mode=true,disable_launch_boost=false,disable_vibration=true,disable_animation=true,disable_soundtrigger=true,defer_full_backup=true,defer_keyvalue_backup=true,enable_firewall=false,location_mode=2,gps_mode=2,enable_brightness_adjustment=false,adjust_brightness_factor=0.5,force_all_apps_standby=true,force_background_check=true,disable_optional_sensors=true,disable_aod=false,enable_quick_doze true
settings put global battery_saver_device_specific_constants advertise_is_enabled=false,enable_datasaver=false,enable_night_mode=true,disable_launch_boost=false,disable_vibration=true,disable_animation=true,disable_soundtrigger=true,defer_full_backup=true,defer_keyvalue_backup=true,enable_firewall=false,location_mode=2,gps_mode=2,enable_brightness_adjustment=false,adjust_brightness_factor=0.5,force_all_apps_standby=true,force_background_check=true,disable_optional_sensors=true,disable_aod=false,enable_quick_doze true
settings put global activity_manager_constants "max_cached_processes=0,background_settle_time=60000,fgservice_min_shown_time=2000,fgservice_min_report_time=3000,fgservice_screen_on_before_time=1000,fgservice_screen_on_after_time=5000,content_provider_retain_time=20000,gc_timeout=5000,gc_min_interval=60000,full_pss_min_interval=1200000,full_pss_lowered_interval=300000,power_check_interval=800000,power_check_max_cpu_1=0,power_check_max_cpu_2=0,power_check_max_cpu_3=5,power_check_max_cpu_4=1,service_usage_interaction_time=1800000,usage_stats_interaction_interval=7200000,service_restart_duration=1000,service_reset_run_duration=60000,service_restart_duration_factor=0,service_min_restart_time_between=10000,service_max_inactivity=1800000,service_bg_start_timeout=15000,service_bg_activity_start_timeout=10000,process_start_async=true,memory_info_throttle_time=300000"
} > /dev/null 2>&1
}



network_booster() {
{
settings put global private_dns_specifier "1dot1dot1dot1.cloudflare-dns.com"
settings put global private_dns_mode "hostname"
settings put global download_manager_recommended_max_bytes_over_mobile "2147483647"
settings put global download_manager_max_bytes_over_mobile "2147483647"
settings put global preferred_network_mode "9,9"
settings put global network_recommendations_enabled "0"
settings put global network_scoring_ui_enabled "0"
settings put global tether_offload_disabled "0"
settings put global ble_scan_always_enabled "0"
settings put global data_roaming "0"
settings put global data_activity_timeout_mobile "0"
settings put global enable_cellular_on_boot "1"
settings put global network_scoring_ui_enabled "0"
settings put global netstats_enabled "1"
settings put global connectivity_metrics_buffer_size "20000"
settings put system nearby_scanning_permission_allowed "0"
settings put system nearby_scanning_enabled "0"
settings put global data_activity_timeout_wifi "0"
settings put global wifi_score_params "rssi2=-95:-85:-73:-60,rssi5=-85:-82:-70:-57"
settings put global wifi_coverage_extend_feature_enabled "1"
settings put global wifi_networks_available_notification_on "0"
settings put global wifi_poor_connection_warning "0"
settings put global wifi_verbose_logging_enabled "0"
settings put global wifi_suspend_optimizations_enabled "1"
settings put global wifi_wakeup_enabled "0"
settings put global network_avoid_bad_wifi "0"
settings put global wifi_country_code "GB"
settings put global wifi_framework_scan_interval_ms "0"
settings put global wifi_supplicant_scan_interval_ms "5000"
settings put global wifi_watchdog_poor_network_test_enabled "0"

# Mandatory
 sync
} > /dev/null 2>&1 
}



GarbageCleaner() {
# By Sukitooo, Thanks Sukitoo
(for a in $(find /sdcard/ -name .thumbnails;find /sdcard/ -name *.log);do rm -rf $a;done;pm trim-caches 999G)>/dev/null 2>&1&
(rm -rf /data/data/*/cache;rm -rf /sdcard/Android/data/*/cache)>/dev/null 2>&1&
for log in $(getprop | grep -E 'log|Log|LOG' | cut -f 2 -d [ | cut -f 1 -d ]); do
setprop $log ""
done > /dev/null 2>&1
}



Trash() {
# By Sukitoo, Thanks Sukitoo
pkill -f com.whatsapp>/dev/null 2>&1
rm -rf /storage/emulated/0/Android/media/com.whatsapp/WhatsApp/{.Shared,.StickerThumbs,.Thumbs,.trash,Backups,Databases,Media/{.Links,.Statuses,WallPaper,"WhatsApp Animated Gifs","WhatsApp Profile Photos","WhatsApp Audio","WhatsApp Documents/Sent","WhatsApp Images/Sent","WhatsApp Video/Sent","WhatsApp Voice Notes"}}
rm -rf /storage/emulated/0/Android/data/com.whatsapp
pkill -f com.whatsapp.w4b>/dev/null 2>&1
rm -rf /storage/emulated/0/Android/media/com.whatsapp.w4b/"WhatsApp Business"/{.Shared,.StickerThumbs,.Thumbs,.trash,Backups,Databases,Media/{.Links,.Statuses,WallPaper,"WhatsApp Business Animated Gifs","WhatsApp Profile Photos","WhatsApp Business Audio","WhatsApp Business Documents/Sent","WhatsApp Business Images/Sent","WhatsApp Business Video/Sent","WhatsApp Business Voice Notes"}}
rm -rf /storage/emulated/0/Android/data/com.whatsapp.w4b
pkill -f org.telegram.messenger>/dev/null 2>&1
rm -rf /storage/emulated/0/Android/data/org.telegram.messenger/cache
rm -rf /storage/emulated/0/Android/data/org.telegram.messenger/files/Telegram/{"Telegram Video","Telegram Images"}
rm -rf /sdcard/*/.thumbnails> /dev/null 2>&1
}



Mode_Vexz() {
   sleep 2
for app in $(cat /data/local/tmp/package | cut -f 2 -d ":"); do
    {
        cmd package compile -m everything-profile -f "$app" >/dev/null 2>&1
        cmd package compile -m quicken -f "$app" >/dev/null 2>&1
        cmd package compile -m speed --secondary-dex -f "$app" >/dev/null 2>&1
        cmd package reconcile-secondary-dex-files "$app" >/dev/null 2>&1
        cmd package compile --compile-layouts --secondary-dex -f "$app" >/dev/null 2>&1
        cmd game mode performance "$app" >/dev/null 2>&1
        cmd game mode 2 "$app" >/dev/null 2>&1
        cmd shortcut reset-all-throttling "$app" >/dev/null 2>&1
        cmd shortcut reset-throttling "$app" >/dev/null 1>&1
        cmd device_config get game_overlay "$app" >/dev/null 2>&1
        cmd game downscale 8.5 "$app"
        cmd thermalservice override-status 0 > /dev/null 2>&1
        simpleperf --log fatal --log-to-android-buffer 0 >/dev/null 2>&1
        cmd power set-mode 0 >/dev/null 2>&1
        cmd thermalservice override-status 0 >/dev/null 2>&1
        cmd power set-adaptive-power-saver-enabled false >/dev/null 2>&1
        cmd power set-fixed-performance-mode-enabled true >/dev/null 2>&1
    } > /dev/null 2>&1    
done
}



cache_cleaner() {
   sleep 2
for app in $(cat /data/local/tmp/package | cut -f 2 -d ":"); do
    {
        am memory-factor set CRITICAL > /dev/null 2>&1
        cmd display ab-logging-disable > /dev/null 2>&1
        cmd display dwb-logging-disable > /dev/null 2>&1
        cmd display dmd-logging-disable > /dev/null 2>&1
        cmd looper_stats disable > /dev/null 2>&1
        cmd package trim-caches 999G $UUID "$app" > /dev/null 2>&1
        pm trim-caches 999G $UUID "$app" > /dev/null 2>&1
        rm -rf /data/data/*/cache/* /storage/emulated/0/Android/data/*/cache/* > /dev/null 2>&1
        rm -r /cache/*.apk > /dev/null 2>&1
        rm -r /cache/*.tmp > /dev/null 2>&1
        rm -r /data/dalvik-cache/*.apk > /dev/null 2>&1
        rm -r /data/dalvik-cache/*.tmp > /dev/null 2>&1
        rm -rf /data/tombstones/*; > /dev/null 2>&1
    } > /dev/null 2>&1
done    
}



optimize() {
sleep 2
{
  cmd stats clear-puller-cache
  cmd activity clear-debug-app
  cmd activity clear-watch-heap -a
} > /dev/null 2>&1
}



render_optimizs() {
  {
    setprop debug.hwc.flattenning_enabled false
    setprop debug.hwc.hdr_nbm_enable false
    setprop debug.hwc.trace_hint_sessions false
    setprop debug.hwc.normalize_hint_session_durations false
    setprop debug.hwc.use_rate_limiter true
    setprop debug.hwc.test_plan true
    setprop debug.hwc.force_gpu 0
    setprop debug.hwc.nodirtyregion 0
    setprop debug.hwc.winupdate 1
    setprop debug.hwc.showfps 0
    setprop debug.hwc.dynThreshold 1.5
    setprop debug.hwc.bq_count 4
    setprop debug.hwc.compose_level 0
    setprop debug.hwc.otf 1
    setprop debug.hwc.fakevsync 0
    setprop debug.hwc.logvsync 0
    setprop debug.hwc.asyncdisp 1
    setprop debug.hwc.min_sdr_dimming 0
    setprop debug.hwc_dump_en 1
    setprop debug.hwc.enable_vds_dump 0
    setprop debug.hwc.simulate 0
  } > /dev/null 2>&1  
}



game_driver() {
for app in $(cat /data/local/tmp/package | cut -f 2 -d ":"); do
    {
        settings delete global updatable_driver_production_opt_in_apps
        settings delete global game_driver_opt_in_apps
        settings delete global updatable_driver_production_opt_out_apps
        settings delete global updatable_driver_prerelease_opt_in_apps
        settings put global updatable_driver_production_opt_in_apps "$app"
    } > /dev/null 2>&1
done
}



SOC() {
soc=$(getprop ro.soc.manufacturer)
Soc_optimizer() {
  setprop debug.composition.type mdp
  setprop debug.hwc.dynThreshold 4.5
  setprop debug.enable.sglscale 1
  setprop debug.hwui.disable_vsync true
  setprop debug.hwui.target_gpu_time_percent 100
  setprop debug.gpuprio 7
  setprop debug.sf.gpu_freq_index 7
  setprop debug.sf.cpu_freq_index 7
  setprop debug.sf.mem_freq_index 7
 } > /dev/null 2>&1  
  
 if [[ "$soc" == "Mediatek" ]]; then
   setprop debug.mediatek.appgamepq_compress 1
   setprop debug.mediatek.disp_decompress 1
   setprop debug.mediatek.appgamepq 2
   setprop debug.mediatek.game_pq_enable 1
   setprop debug.mediatek.high_frame_rate_sf_set_big_core_fps_threshold 119
 elif [[ "$soc" == "Qualcom" ]]; then
   setprop debug.qti.am.resource.type "super-large"
   setprop debug.qc.hardware "true"
   setprop debug.qctwa.statusbar "1"
   setprop debug.qctwa.preservebuf "1"
 fi
}



SF() {
refresh_rate=$(dumpsys display | grep -oE 'fps=[0-9]+' | awk -F '=' '{print $2}' | head -n 1)
early_offset=$((refresh_rate / 5))
late_offset=$((refresh_rate * 5 / 6))
negative_offset=$((early_offset * -1))
gl_duration=$((late_offset + frame_time / 15))
idle_timer=$((refresh_rate / 1000000 + 800))
sampling_duration=$((refresh_rate * 4 / 5))
sampling_period=$((refresh_rate * 9 / 10))
  
 {
   setprop debug.sf.hwc.min.duration "$refresh_rate"
   setprop debug.sf.early.app.duration "$early_offset"
   setprop debug.sf.late.app.duration "$late_offset"
   setprop debug.sf.early.sf.duration "$early_offset"
   setprop debug.sf.late.sf.duration "$late_offset"
   setprop debug.sf.set_idle_timer_ms "$idle_timer"
   setprop debug.sf.earlyGl.sf.duration "$gl_duration"
   setprop debug.sf.earlyGl.app.duration "$gl_duration"
   setprop debug.sf.early_phase_offset_ns "$early_offset"
   setprop debug.sf.early_gl_phase_offset_ns "$early_offset"
   setprop debug.sf.early_app_phase_offset_ns "$early_offset"
   setprop debug.sf.early_gl_app_phase_offset_ns "$early_offset"
   setprop debug.sf.high_fps_early_app_phase_offset_ns "$negative_offset"
   setprop debug.sf.high_fps_late_app_phase_offset_ns "$late_offset"
   setprop debug.sf.high_fps_early_sf_phase_offset_ns "$negative_offset"
   setprop debug.sf.high_fps_late_sf_phase_offset_ns "$late_offset"
   setprop debug.sf.high_fps_early_gl_phase_offset_ns "$early_offset"
   setprop debug.sf.high_fps_early_gl_app_phase_offset_ns "$early_offset"
 } > /dev/null 2>&1  
}



GMS() {
{
   am force-stop com.google.android.gms >/dev/null 2>&1
   cmd activity force-stop com.xiaomi.joyose >/dev/null 2>&1
   dumpsys deviceidle whitelist -com.google.android.gms >/dev/null 2>&1
   settings put global device_idle_constants "light_after_inactive_to=0,light_pre_idle_to=5000,light_idle_to=3600000,light_max_idle_to=43200000,locating_to=5000,location_accuracy=1000,inactive_to=0,sensing_to=0,motion_inactive_to=0,idle_after_inactive_to=0,idle_to=21600000,max_idle_to=172800000,quick_doze_delay_to=5000,min_time_to_alarm=300000,deep_idle_to=7200000,deep_max_idle_to=86400000,deep_idle_maintenance_max_interval=86400000,deep_idle_maintenance_min_interval=43200000,deep_still_threshold=0,deep_idle_prefetch=1,deep_idle_prefetch_delay=300000,deep_idle_delay_factor=2,deep_idle_factor=3" >/dev/null 2>&1
   settings put global app_restriction_enabled true >/dev/null 2>&1
   dumpsys deviceidle force-idle >/dev/null 2>&1
   dumpsys deviceidle step deep >/dev/null 2>&1
} > /dev/null 2>&1 
}



Launcher_game() {
   sleep 1
for game in $(cat /data/local/tmp/Scan | cut -f 2 -d ":"); do
             am start --activity-no-animation -n $(cmd package dump $game | awk '/MAIN/{getline; print $2}' | head -n 1)
done    
}
