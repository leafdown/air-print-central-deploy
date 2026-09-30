# air-print-central-deploy

air-print 远程打印 central 服务（print-server）的**部署壳仓库**，用于免费 PaaS
（Render 免费层）从公开 Git URL 构建。仓库内容：

- `print-server`：linux/amd64 静态二进制（源码见私有库 `leafdown/music-central-server`）
- `Dockerfile`：alpine + 模块化 LibreOffice + CJK 字体运行时
- `render.yaml`：Render 配置记录

更新流程：在私有库 `free-deploy` 分支交叉编译
`GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o print-server ./cmd/print-server`
后替换本文件提交，Render autoDeploy 自动重建。
