# 第一阶段，使用 Golang 官方镜像构建应用程序
FROM golang:latest AS builder

WORKDIR /app

COPY . .

RUN go build -o main .

FROM scratch

WORKDIR /app

COPY --from=builder /app/main .

CMD ["./main", "-run", "server"]
