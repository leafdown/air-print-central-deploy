# air-print-central-deploy

air-print 远程打印 central 服务（print-server）的**部署壳仓库**，用于免费 PaaS
（Render 免费层）从公开 Git URL 构建。仓库内容：

- `print-server`：linux/amd64 静态二进制（源码见私有库 `leafdown/music-central-server`）
- `Dockerfile`：alpine + 模块化 LibreOffice + CJK 字体运行时
- `render.yaml`：Render 配置记录

## 部署状态（2026-09-30）

- CI 构建并推送双镜像：`ghcr.io/leafdown/air-print-central:latest` + `airprintrelay/air-print-central:latest`
- Back4App Containers（免费层）已部署：`https://airprintcentral-1ssps92s.b4a.run`
  ⚠️ 免费版 URL 60 分钟过期，重新部署换新 URL；长期地址建议迁 Render 免费层
  （私有库 free-deploy 分支含 render.yaml / Dockerfile.render）。
- 端口：容器内 print-server 监听 8081（平台 Port 字段填 8081）

更新流程：在私有库 `free-deploy` 分支交叉编译
`GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o print-server ./cmd/print-server`
后替换本目录的 print-server 并提交；Actions 自动重建双镜像，
Back4App 在应用页点 Redeploy 拉新镜像。
