#!/bin/bash

touch /etc/systemd/system/backupHome.service

echo "[Unit]
Description="backup da pasta Home"
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=/bin/bash /opt/backup/backup.sh
 
[Install]
WantedBy=multi-user.target
" >> /etc/systemd/system/backupHome.service

systemctl daemon-reload

systemctl start backupHome

systemctl enable backupHome
