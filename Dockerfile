FROM node:20-alpine AS builder

WORKDIR /workspace/

COPY . /workspace/

RUN npm config set registry https://registry.npmmirror.com/ && \
    npm install -g pnpm@8.15.7 && \
    pnpm install

RUN npm install -g lerna@6 && \
    lerna run build

RUN cp -rf /workspace/packages/ui/certd-client/dist/*  /workspace/packages/ui/certd-server/public/

# =========================================

FROM node:20-alpine

WORKDIR /app/

EXPOSE 443
EXPOSE 7001

COPY entrypoint.sh /app/entrypoint.sh
COPY --from=builder /workspace/ /app/

RUN chmod +x /app/packages/ui/certd-server/tools/linux/*
RUN apk add --no-cache nginx

CMD ["/bin/sh", "-c", "sh /app/entrypoint.sh && tail -f /app/packages/ui/certd-server/backend.log"]
