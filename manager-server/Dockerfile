FROM ghcr.io/aliyusuf95/manager.io:latest

# Install rclone for Google Drive sync
RUN apt-get update && \
    apt-get install -y curl cron && \
    curl https://rclone.org/install.sh | bash && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY sync.sh /sync.sh
RUN chmod +x /sync.sh

# Add cron job — sync every 15 minutes
RUN echo "*/15 * * * * /sync.sh >> /var/log/rclone-sync.log 2>&1" | crontab -

RUN mkdir -p /data /root/.config/rclone

EXPOSE 8080

# Write rclone config from env var at startup, then start cron + Manager.io
CMD mkdir -p /root/.config/rclone && \
    echo "$RCLONE_CONF" > /root/.config/rclone/rclone.conf && \
    cron && \
    exec /app/ManagerServer --port 8080 --path /data
