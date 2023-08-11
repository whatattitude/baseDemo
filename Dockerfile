# 使用一个含有 Go 工具链的基础镜像
FROM golang:1.20-alpine

# 设置工作目录
WORKDIR /app

# 将代码复制到容器中
COPY . .

# 生成 Go 二进制程序
RUN CGO_ENABLED=0 go build -o main

# 使用一个空的基础镜像，将编译好的 Go 二进制程序复制过去
FROM alpine:3.13
COPY --from=0 /app/main /main

# 指定容器运行时的命令
ENTRYPOINT ["/main"]