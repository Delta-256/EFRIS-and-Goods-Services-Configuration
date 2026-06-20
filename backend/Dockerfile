FROM node:20-alpine

WORKDIR /app

COPY backend/package.json backend/package-lock.json ./
RUN npm ci --omit=dev

COPY backend/server.js ./
COPY backend/data/ ./data/
COPY frontend/ /frontend/

ARG EFRIS_PRIVATE_KEY
RUN mkdir -p /app/keys && printf '%s' "$EFRIS_PRIVATE_KEY" | sed 's/\\n/\n/g' > /app/keys/efris_private.pem

ENV NODE_ENV=production

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:3000/api/health || exit 1

CMD ["node", "server.js"]
