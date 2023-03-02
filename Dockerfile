# 第一阶段，使用 Golang 官方镜像构建应用程序
FROM golang:latest AS builder

WORKDIR /app

COPY . .

# 使用 CGO_ENABLED=0 和 -ldflags "-s -w" 进行构建，优化二进制文件大小
RUN CGO_ENABLED=0 go build -ldflags "-s -w" -o main .

# 第二阶段，只包含 Alpine Linux 和可执行文件
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/main .

# 指定启动命令
CMD ["./main", "-run", "server"]
