#!/usr/bin/env bash
set -e

IMAGE_UPSTREAM="ghcr.io/anomalyco/opencode:latest"
IMAGE_SELF="shawoo/opencode"

# 1. 拉最新 upstream
docker pull $IMAGE_UPSTREAM >/dev/null

# 2. 获取 upstream 版本
upstream_version=$(docker run --rm $IMAGE_UPSTREAM --version | tr -d '\n')
echo "upstream_version=$upstream_version"

# 3. 获取远端已存在的版本（如果有）
existing_version=$(docker manifest inspect $IMAGE_SELF:$upstream_version >/dev/null 2>&1 && echo "$upstream_version" || echo "")

# 4. 判断
if [ "$existing_version" = "$upstream_version" ]; then
  echo "✅ 已是最新版本，无需构建"
  exit 0
fi

echo "🚀 发现新版本，开始构建..."

# 5. 构建 + 推送
docker build --pull --no-cache -t $IMAGE_SELF:$upstream_version -t $IMAGE_SELF:latest .
docker push $IMAGE_SELF:$upstream_version
docker push $IMAGE_SELF:latest
