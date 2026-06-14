# 1. Run the Disk Space Guardian every 15 minutes, Monday through Friday
*/15 * * * 1-5 /root/disk_guardian.sh >> /var/log/cron_guardian.log 2>&1

# 2. Run the Cloud Status Checker every single hour on Saturdays and Sundays
0 * * * 6,0 /root/status_monitor.sh >> /var/log/cron_status.log 2>&1