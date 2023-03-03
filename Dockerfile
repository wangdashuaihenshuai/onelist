# 第一阶段，使用 Golang 官方镜像构建应用程序
FROM golang:latest AS builder

WORKDIR /app

COPY . .

RUN go build -o main .

FROM alpine:3.14

RUN apk add --no-cache sqlite-libs

WORKDIR /app

COPY --from=builder /app/main .

CMD ["./main", "-run", "server"]
