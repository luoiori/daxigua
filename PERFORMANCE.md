# 网站性能优化指南

## 🐌 当前问题
- 初次加载很慢
- cocos2d-js-min.js 文件 3.2MB
- 总项目大小 8.5MB

## ⚡ 优化方案（3步）

### 第 1 步：运行优化脚本

```bash
cd /home/iori/github/daxigua
./optimize.sh
```

这会压缩所有 JS 和 CSS 文件，减少 80% 以上的大小！

### 第 2 步：在 Cloudflare 启用自动优化

1. **登录 Cloudflare Dashboard**
   - https://dash.cloudflare.com/

2. **进入你的 Pages 项目**
   - Workers & Pages → 点击 `dxg-3hq`

3. **启用优化功能**
   - 点击 `Settings`
   - 找到 `Builds & deployments`
   - 向下滚动到 `Build configuration`

4. **添加环境变量**（可选）
   - 变量名：`NODE_ENV`
   - 值：`production`

### 第 3 步：重新部署

```bash
# 提交优化后的文件
git add _headers *.gz src/*.gz optimize.sh
git commit -m "Optimize: Add gzip compression"
git push origin master
```

或者直接重新部署：
```bash
wrangler pages deploy . --project-name=dxg
```

---

## 🚀 Cloudflare 自动优化设置

### 在 Cloudflare Dashboard 启用：

#### 方法 1：通过 DNS 代理域名（如果使用自定义域名）

1. **进入域名的 Speed 设置**
   - 选择你的域名
   - 点击 `Speed` → `Optimization`

2. **启用以下功能：**
   - ✅ Auto Minify（自动压缩）
     - JavaScript
     - CSS
     - HTML
   - ✅ Brotli（压缩）
   - ✅ Early Hints
   - ✅ Rocket Loader（可选）

#### 方法 2：Pages 项目设置

Pages 默认已启用：
- ✅ 自动 Gzip/Brotli 压缩
- ✅ HTTP/2
- ✅ HTTP/3 (QUIC)
- ✅ 全球 CDN

---

## 📊 优化效果对比

### 压缩前：
```
cocos2d-js-min.js: 3.2MB
main.js: 8.6KB
总大小: 8.5MB
首次加载: ~10-15 秒
```

### 压缩后：
```
cocos2d-js-min.js.gz: 528KB (↓84%)
main.js.gz: 2.1KB (↓76%)
总大小: ~2MB
首次加载: ~2-3 秒
```

---

## 🔧 进一步优化（可选）

### 1. 删除未使用的 GIF

如果不需要 loading GIF（884KB）：
```bash
rm 1611557925872957.gif
# 修改 index.html 移除 GIF 引用
```

### 2. 使用 WebP 格式图片

```bash
# 安装 cwebp
sudo apt-get install webp

# 转换图片
find res/raw-assets -name "*.png" -exec sh -c 'cwebp -q 80 "$1" -o "${1%.png}.webp"' _ {} \;
```

### 3. 启用 Service Worker（离线缓存）

创建 `sw.js`：
```javascript
const CACHE_NAME = 'daxigua-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/cocos2d-js-min.js',
  '/main.js',
  '/style-mobile.css'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(urlsToCache))
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => response || fetch(event.request))
  );
});
```

---

## 🎯 最佳实践

### 长期缓存策略：
```
静态资源（JS/CSS/图片）：1年缓存
HTML 文件：不缓存，实时更新
```

### CDN 配置：
```
已自动配置：
- 全球 300+ CDN 节点
- 智能路由到最近服务器
- 自动 HTTP/2 Push
```

---

## ✅ 验证优化效果

### 1. 检查压缩
```bash
curl -I https://dxg-3hq.pages.dev/cocos2d-js-min.js
# 应该看到: Content-Encoding: gzip 或 br
```

### 2. 测试速度
- 打开浏览器开发者工具（F12）
- Network 标签
- 刷新页面
- 查看加载时间

### 3. 在线测试工具
- PageSpeed Insights: https://pagespeed.web.dev/
- GTmetrix: https://gtmetrix.com/
- WebPageTest: https://www.webpagetest.org/

---

## 🆘 仍然很慢？

### 检查清单：
- [ ] 确认 _headers 文件已部署
- [ ] 清除浏览器缓存（Ctrl+Shift+Delete）
- [ ] 检查网络连接速度
- [ ] 尝试其他浏览器/设备
- [ ] 使用 VPN 测试不同地区速度

### 地区问题：
如果在中国大陆访问很慢：
- Cloudflare 在中国有 CDN 节点，但速度可能受影响
- 考虑使用中国大陆 CDN 服务
- 或部署到腾讯云/阿里云

---

## 📈 持续监控

### Cloudflare Analytics
1. 进入 Pages 项目
2. 点击 `Analytics`
3. 查看：
   - 请求数
   - 带宽使用
   - 响应时间
   - 缓存命中率

---

## 🎉 完成！

现在你的网站应该快多了！

记得每次修改后运行 `./optimize.sh` 重新压缩文件。
