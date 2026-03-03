FROM node:20-alpine

WORKDIR /app

# Copy manifest(s), Tailwind config, and app sources
COPY package*.json tailwind.config.cjs ./
COPY src ./src
COPY public ./public

# Install dependencies (prefer npm ci when lockfile is present) and build CSS
RUN if [ -f package-lock.json ]; then npm ci; else npm install; fi \
  && npm run build:css

ENV NODE_ENV=production
ENV CONTENT_ROOT=/content

# Create and use a non-root user for runtime
RUN addgroup -S app && adduser -S app -G app \
  && chown -R app:app /app
USER app

EXPOSE 3000

CMD ["npm", "start"]

