FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install --production

FROM node:22-alpine AS runner

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY package.json ./
COPY .next ./.next
COPY public ./public

ENV NODE_ENV=production
EXPOSE 3000

CMD ["npm", "run", "start"]
