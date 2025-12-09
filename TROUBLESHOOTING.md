# Cloudflare Pages 故障排查

## 问题：网址无法访问

### 症状
```
网址：https://dxg.iori-law-cn.workers.dev/
错误：无法访问
```

### 原因分析

#### ❌ 错误类型 1：部署到了 Workers 而不是 Pages
- Workers 用于运行服务端代码
- Pages 用于托管静态网站
- 大西瓜游戏是静态网站，应该用 Pages

#### ❌ 错误类型 2：使用了 Workers 域名
- Workers 域名：`*.workers.dev`
- Pages 域名：`*.pages.dev`

---

## ✅ 解决方案

### 方案一：删除 Worker，重新创建 Pages

1. **删除错误的 Worker**
   - 进入 https://dash.cloudflare.com/
   - Workers & Pages → Workers 标签
   - 找到 `dxg` 项目
   - 点击项目 → Settings → Delete

2. **创建正确的 Pages 项目**
   - Workers & Pages → Create application
   - **选择 Pages 标签**（重要！）
   - Connect to Git
   - 选择仓库
   - 配置：
     ```
     Project name: dxg
     Build command: exit 0
     Build output directory: /
     ```
   - Save and Deploy

3. **获得正确的网址**
   ```
   ✅ https://dxg.pages.dev
   ```

---

### 方案二：检查是否是自定义域名问题

如果 `iori-law-cn` 是你的域名：

1. **进入 Pages 项目**
2. **Custom domains**
3. **检查 DNS 记录**
   ```
   类型: CNAME
   名称: dxg
   内容: dxg.pages.dev
   ```

---

## 📊 区分 Workers 和 Pages

### Workers（服务端代码）
```
用途: 运行 JavaScript 代码
域名: *.workers.dev
适合: API、后端服务、边缘函数
```

### Pages（静态网站）
```
用途: 托管 HTML/CSS/JS 文件
域名: *.pages.dev
适合: 前端网站、静态博客、游戏
```

**大西瓜游戏应该用 Pages！**

---

## 🔍 如何检查你当前的部署

### 步骤 1：登录 Dashboard
https://dash.cloudflare.com/

### 步骤 2：查看项目列表
Workers & Pages → 查看所有项目

### 步骤 3：识别项目类型

#### Workers 项目显示：
```
⚙️ Worker
dxg
Route: dxg.iori-law-cn.workers.dev/*
```

#### Pages 项目显示：
```
📄 Pages
dxg
Production: https://dxg.pages.dev
```

---

## 🚀 使用 CLI 部署到 Pages

如果你想用命令行：

```bash
# 确保在项目目录
cd /home/iori/github/daxigua

# 部署到 Pages（不是 Workers）
wrangler pages deploy . --project-name=dxg

# 查看部署的项目
wrangler pages project list
```

---

## ✅ 验证部署成功

部署成功后：

1. **网址格式**
   ```
   ✅ https://dxg.pages.dev
   ❌ https://xxx.workers.dev
   ```

2. **访问测试**
   - 打开网址
   - 应该看到游戏界面
   - 标题显示阿拉伯语

3. **检查响应头**
   ```bash
   curl -I https://dxg.pages.dev
   ```
   应该返回：
   ```
   HTTP/2 200
   server: cloudflare
   ```

---

## 🆘 仍然无法访问？

### 检查清单：

- [ ] 确认部署到 Pages 而不是 Workers
- [ ] 检查 Deployment 状态是 Success
- [ ] 确认网址是 `.pages.dev` 结尾
- [ ] 检查 index.html 在仓库根目录
- [ ] 清除浏览器缓存重试
- [ ] 尝试无痕模式访问

### 查看部署日志：

1. 进入项目
2. Deployments → 点击最新部署
3. View build log
4. 查看是否有错误

---

## 📞 需要帮助

如果以上方案都不行：

1. 截图 Cloudflare Dashboard 的项目列表
2. 截图部署日志
3. 告诉我具体的错误信息

我会帮你进一步排查！
