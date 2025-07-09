system_read_removed_function() {
   sleep 1
for GAME in $(cat /data/local/tmp/Scan | cut -f 2 -d ":"); do
      {
             setprop debug.hwui.renderer opengl
             setprop debug.renderengine.beckend opengl
             settings put system peak_refresh_rate 60
             settings put system min_refresh_rate 60
             settings put system max_refresh_rate 60
             settings put system user_refresh_rate 60
             cmd game downscale disable "$GAME"
             settings put global window_animation_scale 1
             settings put global transition_animation_scale 1
             settings put global animator_duration_scale 1
      } > /dev/null 2>&1                    
done
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



Removed_mode_vexz() {
   sleep 2
for app in $(cat /data/local/tmp/package | cut -f 2 -d ":"); do
    {        
        cmd package compile -m verify -f "$app" >/dev/null 2>&1
        cmd game mode standart "$app" >/dev/null 2>&1
        cmd game mode 1 "$app" >/dev/null 2>&1
        cmd game downscale default "$app"
        cmd thermalservice override-status 2 > /dev/null 2>&1
        cmd thermalservice reset >/dev/null 2>&1
        cmd power set-mode 1 >/dev/null 2>&1
        cmd power set-adaptive-power-saver-enabled true >/dev/null 2>&1
        cmd power set-fixed-performance-mode-enabled false >/dev/null 2>&1
    } > /dev/null 2>&1
done
}



removed_cachecleaner() {
   sleep 2
for app in $(cat /data/local/tmp/package | cut -f 2 -d ":"); do
    {
        cmd display ab-logging-enable >/dev/null 2>&1
        cmd display dwb-logging-enable >/dev/null 2>&1
        cmd display dmd-logging-enable >/dev/null 2>&1
        cmd looper_stats reset >/dev/null 2>&1
        cmd package trim-caches 999G $UUID "$app" > /dev/null 2>&1
        pm trim-caches 999G $UUID "$app" > /dev/null 2>&1
        rm -rf /data/data/*/cache/* /storage/emulated/0/Android/data/*/cache/* >/dev/null 2>&1
        rm -r /cache/*.apk >/dev/null 2>&1
        rm -r /cache/*.tmp >/dev/null 2>&1
        rm -r /data/dalvik-cache/*.apk >/dev/null 2>&1
        rm -r /data/dalvik-cache/*.tmp >/dev/null 2>&1
        rm -rf /data/tombstones/*; >/dev/null 2>&1
    } > /dev/null 2>&1
done
}



removed_optimize() {
{
  cmd stats clear-puller-cache
  cmd activity clear-debug-app
  cmd activity clear-watch-heap -a
  } > /dev/null 2>&1
}



disable_render_optimize() {
  {
    setprop debug.hwc.flattenning_enabled true
    setprop debug.hwc.hdr_nbm_enable true
    setprop debug.hwc.trace_hint_sessions true
    setprop debug.hwc.normalize_hint_session_durations true
    setprop debug.hwc.use_rate_limiter false
    setprop debug.hwc.test_plan false
    setprop debug.hwc.force_gpu 1
    setprop debug.hwc.nodirtyregion 1
    setprop debug.hwc.winupdate 0
    setprop debug.hwc.showfps 1
    setprop debug.hwc.dynThreshold 1.5
    setprop debug.hwc.bq_count 0
    setprop debug.hwc.compose_level 1
    setprop debug.hwc.otf 0
    setprop debug.hwc.fakevsync 1
    setprop debug.hwc.logvsync 1
    setprop debug.hwc.asyncdisp 0
    setprop debug.hwc.min_sdr_dimming 1
    setprop debug.hwc_dump_en 0
    setprop debug.hwc.enable_vds_dump 1
    setprop debug.hwc.simulate 1
  } > /dev/null 2>&1
}



removed_game_driver() {
   sleep 2
for app in $(cat /data/local/tmp/package | cut -f 2 -d ":"); do
    {
        settings delete global updatable_driver_production_opt_in_apps
        settings delete global game_driver_opt_in_apps
        settings delete global updatable_driver_production_opt_out_apps
        settings delete global updatable_driver_prerelease_opt_in_apps
        settings delete global updatable_driver_production_opt_in_apps
    } > /dev/null 2>&1
done
}



removed_soc_optimize() {
soc=$(getprop ro.soc.manufacturer)

{
  setprop debug.composition.type gpu
  setprop debug.hwc.dynThreshold 2.5
  setprop debug.enable.sglscale 0
  setprop debug.hwui.disable_vsync false
  setprop debug.hwui.target_gpu_time_percent 70
  setprop debug.gpuprio 5
  setprop debug.sf.gpu_freq_index 5
  setprop debug.sf.cpu_freq_index 5
  setprop debug.sf.mem_freq_index 5
 } > /dev/null 2>&1
 
 if [[ "$soc" == "Mediatek" ]]; then
   setprop debug.mediatek.appgamepq_compress 0
   setprop debug.mediatek.disp_decompress 0
   setprop debug.mediatek.appgamepq 0
   setprop debug.mediatek.game_pq_enable p
   setprop debug.mediatek.high_frame_rate_sf_set_big_core_fps_threshold 80
 elif [[ "$soc" == "Qualcom" ]]; then
   setprop debug.qti.am.resource.type ""
   setprop debug.qc.hardware "false"
   setprop debug.qctwa.statusbar "0"
   setprop debug.qctwa.preservebuf "0"
 fi
}



network_default() {
settings delete global download_manager_recommended_max_bytes_over_mobile
settings delete global download_manager_max_bytes_over_mobile
settings delete global tether_offload_disabled
settings delete global data_activity_timeout_mobile
settings delete global connectivity_metrics_buffer_size
settings delete system nearby_scanning_permission_allowed
settings delete system nearby_scanning_enabled
settings delete global data_activity_timeout_wifi
settings delete global enable_cellular_on_boot
settings delete global wifi_score_params
settings delete global wifi_coverage_extend_feature_enabled
settings delete global wifi_networks_available_notification_on
settings delete global wifi_poor_connection_warning
settings delete global wifi_verbose_logging_enabled
settings delete global wifi_suspend_optimizations_enabled
settings delete global wifi_wakeup_enabled
settings delete global network_avoid_bad_wifi
settings delete global wifi_country_code
settings delete global wifi_framework_scan_interval_ms
settings delete global wifi_supplicant_scan_interval_ms
settings delete global wifi_watchdog_poor_network_test_enabled
settings delete global wifi_scan_always_enabled
settings delete global wifi_scan_throttle_enabled   
settings put global private_dns_specifier ""
settings put global private_dns_mode "off"
}



enable_gms() {
{
  dumpsys deviceidle whitelist +com.google.android.gms >/dev/null 2>&1
  dumpsys deviceidle unforce >/dev/null 2>&1
  dumpsys deviceidle step active >/dev/null 2>&1
  settings delete global device_idle_constants >/dev/null 2>&1
  settings delete global app_restriction_enabled >/dev/null 2>&1
  dumpsys deviceidle disable >/dev/null 2>&1
} > /dev/null 2>&1
}



battery() {
{
settings put global battery_saver_adaptive_constants advertise_is_enabled=false,enable_datasaver=false,enable_night_mode=true,disable_launch_boost=false,disable_vibration=true,disable_animation=true,disable_soundtrigger=true,defer_full_backup=true,defer_keyvalue_backup=true,enable_firewall=false,location_mode=2,gps_mode=2,enable_brightness_adjustment=false,adjust_brightness_factor=0.5,force_all_apps_standby=true,force_background_check=true,disable_optional_sensors=true,disable_aod=false,enable_quick_doze true
settings put global battery_saver_constants advertise_is_enabled=false,enable_datasaver=false,enable_night_mode=true,disable_launch_boost=false,disable_vibration=true,disable_animation=true,disable_soundtrigger=true,defer_full_backup=true,defer_keyvalue_backup=true,enable_firewall=false,location_mode=2,gps_mode=2,enable_brightness_adjustment=false,adjust_brightness_factor=0.5,force_all_apps_standby=true,force_background_check=true,disable_optional_sensors=true,disable_aod=false,enable_quick_doze true
settings put global battery_saver_device_specific_constants advertise_is_enabled=false,enable_datasaver=false,enable_night_mode=true,disable_launch_boost=false,disable_vibration=true,disable_animation=true,disable_soundtrigger=true,defer_full_backup=true,defer_keyvalue_backup=true,enable_firewall=false,location_mode=2,gps_mode=2,enable_brightness_adjustment=false,adjust_brightness_factor=0.5,force_all_apps_standby=true,force_background_check=true,disable_optional_sensors=true,disable_aod=false,enable_quick_doze true
settings put global activity_manager_constants "max_cached_processes=0,background_settle_time=60000,fgservice_min_shown_time=2000,fgservice_min_report_time=3000,fgservice_screen_on_before_time=1000,fgservice_screen_on_after_time=5000,content_provider_retain_time=20000,gc_timeout=5000,gc_min_interval=60000,full_pss_min_interval=1200000,full_pss_lowered_interval=300000,power_check_interval=800000,power_check_max_cpu_1=0,power_check_max_cpu_2=0,power_check_max_cpu_3=5,power_check_max_cpu_4=1,service_usage_interaction_time=1800000,usage_stats_interaction_interval=7200000,service_restart_duration=1000,service_reset_run_duration=60000,service_restart_duration_factor=0,service_min_restart_time_between=10000,service_max_inactivity=1800000,service_bg_start_timeout=15000,service_bg_activity_start_timeout=10000,process_start_async=true,memory_info_throttle_time=300000"
} > /dev/null 2>&1
}



Reboot() {
echo " Automatic reboot will continue for 3 seconds "
sleep 3
{
reboot
} > /dev/null 2>&1
}
