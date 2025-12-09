#!/bin/bash

echo "🚀 开始部署到 Cloudflare Pages..."
echo ""

# 检查是否安装了 wrangler
if ! command -v wrangler &> /dev/null; then
    echo "📦 安装 Wrangler CLI..."
    npm install -g wrangler
    echo ""
fi

# 检查是否已登录
echo "🔐 检查登录状态..."
if ! wrangler whoami &> /dev/null; then
    echo "请先登录 Cloudflare..."
    wrangler login
    echo ""
fi

# 部署
echo "🚀 部署中..."
wrangler pages deploy . --project-name=daxigua-game

echo ""
echo "✅ 部署完成！"
echo ""
echo "📝 提示："
echo "   - 你的游戏已部署到 Cloudflare 全球 CDN"
echo "   - 访问网址将在上方显示"
echo "   - 要更新网站，再次运行此脚本即可"
