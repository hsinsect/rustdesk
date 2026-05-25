# 远程协助 Android 签名配置

本指南帮助您配置 Android APK 的签名。

## 一、生成签名密钥

### 在本地电脑生成

```bash
# 1. 生成 keystore
keytool -genkey -v -keystore remote-assist.keystore -alias remote-assist -keyalg RSA -keysize 2048 -validity 10000

# 按照提示输入:
# - 密码 (记住这个密码!)
# - 姓名
# - 组织
# - 城市等

# 2. 将生成的 remote-assist.keystore 文件保存到安全位置
```

## 二、配置 GitHub Secrets

### 1. 上传 Keystore

将生成的 keystore 文件进行 Base64 编码：

```bash
# Linux/Mac
base64 -w 0 remote-assist.keystore > keystore_base64.txt

# Windows PowerShell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("remote-assist.keystore")) > keystore_base64.txt
```

### 2. 添加 Secrets

在 GitHub 仓库设置中，添加以下 Secrets：

**Settings → Secrets and variables → Actions → New repository secret**

需要添加的 Secrets：

| Secret 名称 | 值 |
|------------|-----|
| `KEYSTORE_BASE64` | 上面生成的 base64 字符串 |
| `KEYSTORE_PASSWORD` | keystore 密码 |
| `KEY_ALIAS` | 密钥别名 (例如：remote-assist) |
| `KEY_PASSWORD` | 密钥密码 (通常与 keystore 密码相同) |

## 三、更新工作流文件

将以下内容添加到 `.github/workflows/build.yml` 的 `build-android` job 中：

```yaml
- name: Setup keystore
  if: startsWith(github.ref, 'refs/tags/')
  run: |
    # 创建 key.properties
    cat > flutter/android/key.properties << EOF
    storePassword=${{ secrets.KEYSTORE_PASSWORD }}
    keyPassword=${{ secrets.KEY_PASSWORD }}
    keyAlias=${{ secrets.KEY_ALIAS }}
    storeFile=../key.jks
    EOF
    
    # 解码 keystore
    echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > flutter/android/key.jks
```

## 四、使用 Debug 签名（测试用）

如果只是测试，不需要配置 release 签名，CI 会自动使用 debug 签名。

注意：
- Debug 签名的 APK 不能上架 Google Play
- Debug 签名每次构建都不同，无法覆盖安装
- 正式发布必须使用 release 签名

## 五、本地测试构建

```bash
# Debug APK (用于测试)
flutter build apk --debug

# Release APK (签名后)
flutter build apk --release

# 输出位置
# flutter/build/app/outputs/flutter-apk/app-release.apk
```

## 六、验证签名

```bash
# 查看 APK 签名信息
jarsigner -verify -verbose -certs remote-assist-android.apk

# 查看详情
apksigner verify --print-certs remote-assist-android.apk
```

## 七、安全提醒

⚠️ **重要**：

1. **永远不要**将 keystore 文件提交到 Git
2. **永远不要**将密码明文写入代码
3. 使用 GitHub Secrets 存储敏感信息
4. 备份 keystore 文件（丢失后无法更新应用）

## 八、添加 .gitignore

确保以下文件不会被提交：

```gitignore
# Android
flutter/android/key.properties
flutter/android/key.jks
flutter/android/*.jks
flutter/android/*.keystore
flutter/android/*.pfx

# Build outputs
flutter/build/
flutter/.android/
```

## 九、Google Play 发布

如果要发布到 Google Play：

1. 使用 AAB 格式（不是 APK）
   ```bash
   flutter build appbundle --release
   ```

2. 在 Google Play Console 创建应用

3. 上传 AAB 文件

4. 填写应用信息

## 十、故障排除

### 问题 1: 签名失败

```
Error: Keystore was tampered with, or password was incorrect
```

**解决**: 检查密码是否正确，keystore 文件是否损坏

### 问题 2: 无法覆盖安装

```
INSTALL_FAILED_UPDATE_INCOMPATIBLE
```

**解决**: 使用相同的签名密钥重新签名

### 问题 3: CI 构建失败

检查 GitHub Secrets 是否正确设置，keystore Base64 是否完整

## 联系

如果遇到问题，请查看：
- GitHub Actions 日志
- Flutter 构建日志
- Gradle 错误信息
