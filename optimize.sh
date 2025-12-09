#!/bin/bash

echo "🚀 开始优化网站文件..."
echo ""

# 压缩 JS 文件
echo "📦 压缩 JavaScript 文件..."
gzip -9 -f -k cocos2d-js-min.js
gzip -9 -f -k main.js
gzip -9 -f -k src/project.js
gzip -9 -f -k src/settings.js
gzip -9 -f -k src/extraSettings.js

# 压缩 CSS 文件
echo "📦 压缩 CSS 文件..."
gzip -9 -f -k style-mobile.css

echo ""
echo "✅ 优化完成！"
echo ""
echo "文件大小对比："
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ls -lh cocos2d-js-min.js cocos2d-js-min.js.gz | awk '{print $9, $5}'
echo ""
echo "现在提交并推送代码，Cloudflare 会自动使用压缩版本！"
