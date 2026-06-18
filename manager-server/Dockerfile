FROM ghcr.io/aliyusuf95/manager.io:latest

# Install rclone for OneDrive/Google Drive sync
RUN apt-get update && \
    apt-get install -y curl cron && \
    curl https://rclone.org/install.sh | bash && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy rclone config and sync script
COPY rclone.conf /root/.config/rclone/rclone.conf
COPY sync.sh /sync.sh
RUN chmod +x /sync.sh

# Add cron job — sync every 15 minutes
RUN echo "*/15 * * * * /sync.sh >> /var/log/rclone-sync.log 2>&1" | crontab -

RUN mkdir -p /data

EXPOSE 8080

# Start cron + Manager.io
CMD cron && exec /app/ManagerServer --port 8080 --path /data
