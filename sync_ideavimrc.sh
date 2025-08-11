#!/bin/zsh

# 自动同步 .ideavimrc 文件到 GitHub
# 每天早上8点执行

set -e  # 遇到错误时退出

# 设置变量
SOURCE_FILE="$HOME/.ideavimrc"
TARGET_DIR="/Users/lyman/Github/ideavim"
TARGET_FILE="$TARGET_DIR/.ideavimrc"
CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")

# 记录日志
LOG_FILE="$TARGET_DIR/sync.log"
echo "[$CURRENT_DATE] 开始同步 .ideavimrc 文件" >> "$LOG_FILE"

# 检查源文件是否存在
if [ ! -f "$SOURCE_FILE" ]; then
    echo "[$CURRENT_DATE] 错误: 源文件 $SOURCE_FILE 不存在" >> "$LOG_FILE"
    exit 1
fi

# 切换到目标目录
cd "$TARGET_DIR"

# 复制文件（覆盖同名文件）
cp "$SOURCE_FILE" "$TARGET_FILE"
echo "[$CURRENT_DATE] 文件复制完成: $SOURCE_FILE -> $TARGET_FILE" >> "$LOG_FILE"

# 检查是否有变更
# if git diff --quiet HEAD -- .ideavimrc 2>/dev/null; then
#     echo "[$CURRENT_DATE] 文件没有变更，跳过提交" >> "$LOG_FILE"
#     exit 0
# fi

# 添加到 git 暂存区
git add .

# 提交变更
COMMIT_MESSAGE="同步 .ideavimrc 配置文件 - $CURRENT_DATE"
git commit -m "$COMMIT_MESSAGE"

echo "[$CURRENT_DATE] Git 提交完成: $COMMIT_MESSAGE" >> "$LOG_FILE"

# 推送到 GitHub
if git push origin main 2>/dev/null || git push origin master 2>/dev/null; then
    echo "[$CURRENT_DATE] 成功推送到 GitHub" >> "$LOG_FILE"
else
    echo "[$CURRENT_DATE] 推送到 GitHub 失败" >> "$LOG_FILE"
    exit 1
fi

echo "[$CURRENT_DATE] 同步完成\n" >> "$LOG_FILE"
