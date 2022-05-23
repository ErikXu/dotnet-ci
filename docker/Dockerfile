# 使用 alpine 作为基础镜像
FROM alpine:3.14

# 操作系统使用阿里云的源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装运行 .Net 程序相关依赖
RUN apk update
RUN apk add --no-cache \
        ca-certificates \
        krb5-libs \
        libgcc \
        libintl \
        libssl1.1 \
        libstdc++ \
        zlib

# 拷贝可执行文件到 /app
COPY . /app

# 设置 /app 为工作目录
WORKDIR /app

# 暴露 5000 端口
EXPOSE 5000

# 启动指令
ENTRYPOINT ["/app/WebApi", "--urls=http://*:5000"]
