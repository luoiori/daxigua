# 部署到 Cloudflare Pages 指南

## 方法一：通过 Cloudflare Dashboard 部署（推荐，简单）

### 前提条件
- 已有 Cloudflare 账号（免费）
- 代码已推送到 GitHub/GitLab/Bitbucket

### 步骤

1. **登录 Cloudflare Dashboard**
   - 访问：https://dash.cloudflare.com/
   - 登录你的账号（没有账号请先注册）

2. **进入 Pages 页面**
   - 在左侧菜单中找到 `Workers & Pages`
   - 点击 `Create application`
   - 选择 `Pages` 标签
   - 点击 `Connect to Git`

3. **连接 Git 仓库**
   - 选择 `GitHub`（或你使用的其他平台）
   - 授权 Cloudflare 访问你的仓库
   - 选择 `daxigua` 仓库

4. **配置构建设置**
   ```
   项目名称: daxigua-game (或自定义名称)
   生产分支: master
   构建命令: 留空（不需要构建）
   构建输出目录: /
   根目录: /
   ```

5. **部署**
   - 点击 `Save and Deploy`
   - 等待几秒钟，部署完成
   - 你会得到一个网址：`https://daxigua-game.pages.dev`

---

## 方法二：使用 Wrangler CLI 部署（适合开发者）

### 前提条件
- 已安装 Node.js 和 npm

### 步骤

1. **安装 Wrangler**
   ```bash
   npm install -g wrangler
   ```

2. **登录 Cloudflare**
   ```bash
   wrangler login
   ```
   会自动打开浏览器进行授权

3. **部署项目**
   ```bash
   cd /home/iori/github/daxigua
   wrangler pages deploy . --project-name=daxigua-game
   ```

4. **完成**
   - 部署完成后会显示网址
   - 示例：`https://daxigua-game.pages.dev`

---

## 方法三：使用 Git 自动部署（最推荐）

### 步骤

1. **推送代码到 GitHub**
   ```bash
   cd /home/iori/github/daxigua
   git add .
   git commit -m "Deploy to Cloudflare Pages"
   git push origin master
   ```

2. **在 Cloudflare 设置自动部署**
   - 按照方法一连接 Git 仓库
   - 以后每次 push 到 master 分支，都会自动部署

---

## 自定义域名（可选）

1. 在 Cloudflare Pages 项目页面
2. 点击 `Custom domains`
3. 点击 `Set up a custom domain`
4. 输入你的域名（如：game.example.com）
5. 按照提示配置 DNS 记录

---

## 常见问题

### Q: 部署后页面空白？
A: 检查浏览器控制台错误，可能是路径问题。确保 index.html 在根目录。

### Q: 如何更新网站？
A:
- **方法一用户**: 推送代码到 Git，会自动重新部署
- **方法二用户**: 再次运行 `wrangler pages deploy .`

### Q: 部署是免费的吗？
A: Cloudflare Pages 免费版每月可以：
- 500 次构建
- 无限带宽
- 无限请求数

完全够用！

---

## 优化建议

1. **启用缓存**：_headers 文件已创建，会自动生效

2. **压缩资源**：
   ```bash
   # 安装 gzip
   sudo apt-get install gzip

   # 压缩 JS 文件
   gzip -k cocos2d-js-min.js
   ```

3. **CDN 加速**：Cloudflare 自动提供全球 CDN

---

## 完成！

你的游戏现在已经部署到 Cloudflare 的全球网络上了！🎉
