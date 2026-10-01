# air-print central 打印服务（免费托管部署壳）
# 本仓库只含已编译的 print-server 二进制（linux/amd64 静态）与运行时定义，
# 服务源码在私有仓库 leafdown/music-central-server（free-deploy 分支）。
#
# 运行时：模块化 LibreOffice（docx/xlsx/pptx→PDF 与 PDF 字体嵌入归一化）+
# 中日韩字体 + 静态 Go 二进制（内嵌 React 打印前端，pdfium 走 WASM 无 CGO）。
FROM alpine:3.20
RUN apk add --no-cache \
        ca-certificates tzdata \
        libreoffice-writer libreoffice-calc libreoffice-impress \
        font-noto-cjk
WORKDIR /app
ARG TARGETARCH
COPY print-server-linux-${TARGETARCH} /app/print-server
RUN chmod +x /app/print-server && ln -sf /app/print-server /app/print-server-linux-${TARGETARCH} && mkdir -p /tmp/uploads /tmp/office-cache
# soffice 以 root 运行需要可写 HOME（LibreOffice profile）
ENV HOME=/tmp \
    UPLOADS_DIR=/tmp/uploads \
    OFFICE_CACHE_DIR=/tmp/office-cache \
    CONVERT_TIMEOUT=60
EXPOSE 8080
USER root
CMD ["/app/print-server"]
