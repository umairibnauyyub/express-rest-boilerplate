FROM node:20.15 AS base-dev
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

FROM node:20.15 AS base-prod
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .

FROM base-dev AS development
CMD ["node", "--env-file=.env", "--require=./src/lib/tracing.cjs", "--watch", "bin/www.js"]

FROM gcr.io/distroless/nodejs20-debian12:20.15 AS production
WORKDIR /app
COPY --from=base-prod /app /app
CMD ["bin/www.js"]
