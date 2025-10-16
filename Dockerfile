FROM node:20-alpine AS dependencies

WORKDIR /app
ENV NODE_ENV=production

COPY package.json ./
RUN npm install --only=production


FROM node:20-alpine AS runtime

WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY --chown=node:node . .
USER node

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) })"

CMD ["node", "app.js"]
