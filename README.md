# IdeaVim 配置自动同步

这个仓库包含了自动同步 `.ideavimrc` 配置文件的脚本。

## 功能

- 每天早上 8:00 自动从 `$HOME/.ideavimrc` 同步配置文件到当前仓库
- 如果有变更，自动提交并推送到 GitHub
- 生成详细的同步日志

## 文件说明

- `sync_ideavimrc.sh` - 主要的同步脚本
- `.ideavimrc` - 同步的 IdeaVim 配置文件
- `sync.log` - 同步操作日志
- `cron.log` - cron 任务执行日志

## 自动化设置

已设置 cron 任务，每天早上 8:00 执行同步：
```bash
0 8 * * * /Users/lyman/Github/ideavim/sync_ideavimrc.sh >> /Users/lyman/Github/ideavim/cron.log 2>&1
```

## 手动执行

如需手动同步，可以直接运行脚本：
```bash
./sync_ideavimrc.sh
```

## 日志查看

查看同步日志：
```bash
cat sync.log
```

查看 cron 执行日志：
```bash
cat cron.log
```

## 脚本特性

- 智能检测文件变更，无变更时跳过提交
- 自动尝试推送到 main 或 master 分支
- 完整的错误处理和日志记录
- 提交信息包含同步时间戳
