# GitHub Actions 自动构建设置指南

## 📋 目录

1. [准备工作](#准备工作)
2. [GitHub 仓库设置](#github 仓库设置)
3. [推送代码](#推送代码)
4. [查看构建结果](#查看构建结果)
5. [手动触发构建](#手动触发构建)
6. [配置 Android 签名](#配置 android-签名)
7. [故障排除](#故障排除)

---

## 准备工作

### 1. 确认代码已提交

```bash
cd /workspace
git status
git add .
git commit -m "Initial commit: 远程协助定制版"
```

### 2. 配置 Git 远程仓库

```bash
# 如果有现有的远程仓库
git remote -v

# 如果没有，添加远程仓库（替换为你的仓库地址）
git remote add origin https://github.com/你的用户名/你的仓库.git
```

---

## GitHub 仓库设置

### 1. 创建 GitHub 仓库

1. 登录 GitHub
2. 点击右上角 **+** → **New repository**
3. 填写仓库名称（例如：remote-assist）
4. 选择 **Public** 或 **Private**
5. 点击 **Create repository**

### 2. 推送代码到 GitHub

```bash
# 推送到主分支
git push -u origin main

# 或者推送当前分支
git push -u origin master
```

### 3. 授权 GitHub Actions

1. 进入仓库页面
2. 点击 **Settings** → **Actions** → **General**
3. 在 **Permissions** 部分：
   - ✅ **Allow all actions and reusable workflows**
4. 向下滚动到 **Workflow permissions**:
   - ✅ 勾选 **Read and write permissions**
   - ✅ 勾选 **Allow GitHub Actions to create and approve pull requests**

---

## 推送代码

### 首次推送

```bash
# 确保所有文件已提交
git add .
git commit -m "配置 GitHub Actions 自动构建"

# 推送到远程仓库
git push origin main
```

### 触发构建

推送后，GitHub Actions 会自动开始构建！

---

## 查看构建结果

### 1. 查看构建进度

1. 进入仓库页面
2. 点击 **Actions** 标签
3. 会看到正在运行的工作流（绿色或黄色圆点）
4. 点击工作流名称查看详情

### 2. 等待构建完成

构建时间大约：
- **Windows**: 15-25 分钟
- **Android**: 20-30 分钟

### 3. 下载编译产物

#### 方式 A: 从 Artifacts 下载（30 天有效）

1. 点击完成的工作流
2. 在页面底部找到 **Artifacts** 部分
3. 下载：
   - `remote-assist-windows-x64` - Windows EXE
   - `remote-assist-android-apk` - Android APK

#### 方式 B: 从 Releases 下载（永久）

如果是推送 **Tag** 触发：

1. 点击仓库右侧的 **Releases**
2. 下载对应版本的安装包

---

## 手动触发构建

### 1. 进入 Actions 页面

```
仓库 → Actions → Build Windows and Android
```

### 2. 点击 **Run workflow**

### 3. 选择选项

- ✅ Build Windows EXE - 构建 Windows 版本
- ✅ Build Android APK - 构建 Android 版本

### 4. 点击绿色按钮开始

---

## 配置 Android 签名（可选）

### 需要签名吗？

- **仅测试**: 不需要，使用 Debug 签名
- **正式发布**: 需要 Release 签名

### 配置步骤

详见：`Android 签名配置指南.md`

### 快速配置（仅测试）

不需要任何配置，CI 会自动使用 Debug 签名。

---

## 创建第一个正式版本

### 1. 打标签

```bash
# 创建版本标签
git tag v1.0.0

# 推送标签
git push origin v1.0.0
```

### 2. 自动发布

推送 Tag 后，GitHub Actions 会：
1. 自动构建 Windows 和 Android 版本
2. 在 **Releases** 页面创建新版本
3. 附上安装包下载链接

### 3. 查看 Release

1. 点击仓库右侧的 **Releases**
2. 会看到 `v1.0.0` 版本
3. 下载附件中的安装包

---

## 故障排除

### ❌ 构建失败

#### 检查点 1: 构建日志

1. Actions → 点击失败的构建
2. 查看具体的错误信息
3. 根据错误调整代码

#### 检查点 2: 依赖问题

常见问题：
- vcpkg 安装失败 → 检查网络连接
- Flutter 版本不匹配 → 调整 flutter-version
- Rust 编译错误 → 查看代码错误

#### 检查点 3: 资源不足

GitHub Actions 免费额度：
- 每月 2000 分钟
- 如果用完，需要等待下月或购买

### ❌ Artifacts 无法下载

**原因**: Artifacts 只有 30 天有效期

**解决**: 
- 及时下载
- 或使用 Releases 永久保存

### ❌ Android 签名问题

详见：`Android 签名配置指南.md`

### ❌ Windows 构建时间过长

**优化**:
```yaml
# 在 .github/workflows/build.yml 中添加缓存
- uses: actions/cache@v3
  with:
    path: |
      ~/.cargo/registry
      ~/.cargo/git
      target
    key: ${{ runner.os }}-cargo-${{ hashFiles('**/Cargo.lock') }}
```

---

## 使用技巧

### 1. 仅构建 Windows

推送时添加说明：`[windows only]`

或者手动触发时只勾选 Windows 选项

### 2. 跳过构建

在 commit 信息中添加：`[skip ci]`

```bash
git commit -m "更新文档 [skip ci]"
```

### 3. 自动版本号

使用 Git Tag 作为版本号：

```bash
# 自动获取当前tag
VERSION=$(git describe --tags --always)
echo "VERSION=$VERSION" >> $GITHUB_ENV
```

### 4. 发送通知

构建完成后发送到指定渠道：

```yaml
- name: Notify on success
  if: success()
  run: |
    curl -X POST "你的 webhook 地址" \
      -H "Content-Type: application/json" \
      -d '{"text":"✅ 构建成功！"}'
```

---

## 成本估算

### GitHub Actions 免费额度

- **每月**: 2000 分钟
- **并行**: 最多 20 个任务
- **存储**: 500 MB

### 单次构建时间

- Windows: ~20 分钟
- Android: ~25 分钟
- 总计：~45 分钟/次

### 可使用次数

```
2000 分钟 ÷ 45 分钟/次 ≈ 44 次/月
```

如果超出，可以：
1. 优化构建缓存
2. 减少并行构建
3. 购买 GitHub Pro

---

## 下一步

### ✅ 已完成

- [x] 配置 GitHub Actions
- [x] 创建构建工作流
- [x] 准备签名配置文档

### 📋 待完成

- [ ] 推送代码到 GitHub
- [ ] 首次触发构建
- [ ] 测试下载的安装包
- [ ] (可选) 配置 Android 签名
- [ ] (可选) 设置自动发布

### 🚀 发布流程

1. 本地测试通过
2. 推送到 GitHub
3. 等待自动构建
4. 下载测试
5. 修复问题（如有）
6. 推送 Tag 发布正式版

---

## 需要帮助？

### 查看文档

- `跨平台编译指南.md` - 各平台编译方法
- `Android 签名配置指南.md` - Android 签名详细步骤

### GitHub 资源

- [Actions 文档](https://docs.github.com/en/actions)
- [Rust 构建示例](https://github.com/actions-rs)
- [Flutter 构建示例](https://github.com/marketplace/actions/flutter-action)

### 常见问题

遇到问题先查看：
1. GitHub Actions 日志
2. 构建错误信息
3. 本文档的故障排除章节

---

## 总结

通过这个配置，您可以：

✅ **自动构建** Windows EXE 和 Android APK
✅ **无需手动配置**复杂环境
✅ **每次推送**自动测试
✅ **标签发布**自动生成安装包
✅ **30 天有效**的 Artifacts 下载
✅ **永久保存**的 Releases 发布

现在开始推送代码吧！🚀
