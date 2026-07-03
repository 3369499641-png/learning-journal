#!/bin/bash
# 学习总结模仿进步 — 环境初始化脚本
# 每次从 zip 解压后，先运行这个脚本再开始工作

echo "=== 学习总结模仿进步 — 环境初始化 ==="

# 1. 初始化 git
if [ ! -d ".git" ]; then
  echo "[1/3] 初始化 git 并关联远程仓库..."
  git init
  git remote add origin https://github.com/3369499641-png/learning-journal.git
  git fetch origin main
  git checkout -b main origin/main
  echo "  git 已就绪"
else
  echo "[1/3] git 已初始化，跳过"
fi

# 2. 检查 gh CLI
export PATH="$PATH:/c/Program Files/GitHub CLI"
if command -v gh &> /dev/null; then
  echo "[2/3] gh CLI 已安装"
  gh auth status &> /dev/null
  if [ $? -ne 0 ]; then
    echo "  ⚠️  未登录 GitHub，请运行: gh auth login --web"
    echo "  然后运行: gh auth setup-git"
  else
    gh auth setup-git &> /dev/null
    echo "  GitHub 已认证，git 凭证已配置"
  fi
else
  echo "[2/3] ⚠️  gh CLI 未安装，请运行: winget install GitHub.cli"
  echo "  安装后运行: gh auth login --web && gh auth setup-git"
fi

# 3. 同步 OneDrive
if [ -d "$HOME/OneDrive" ]; then
  echo "[3/3] 同步到 OneDrive..."
  mkdir -p "$HOME/OneDrive/学习总结模仿进步"
  cp -r ./* "$HOME/OneDrive/学习总结模仿进步/" 2>/dev/null
  echo "  完成"
else
  echo "[3/3] OneDrive 不可用，跳过"
fi

echo "=== 初始化完成 ==="
echo "GitHub Pages: https://3369499641-png.github.io/learning-journal/"
