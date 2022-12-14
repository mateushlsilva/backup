#!/bin/bash

touch /etc/systemd/system/backupHome.service

echo "[Unit]
Description="backup da pasta Home"
After=network.target
StartLimitIntervalSec=150
[Service]
Type=simple
User=root
ExecStart=/bin/bash /opt/backup/backup.sh
 
[Install]
WantedBy=multi-user.target
" >> /etc/systemd/system/backupHome.service

systemctl daemon-reload

systemctl start backupHome

systemctl enable backupHome
