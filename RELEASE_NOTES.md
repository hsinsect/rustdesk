# 远程协助 v1.0.0

## 🎉 发布信息

这是基于 RustDesk 定制的远程协助软件第一版。

## ✨ 主要特性

### 🔧 自有服务器
- 使用自建的 Rendezvous 服务器：`desk.hsid.cc`
- API 服务器：`deskapi.hsid.cc`
- 完全自主控制，不依赖官方服务

### 🔐 固定密码
- 默认密码：`sc123.cc`
- 无需每次查看动态密码
- 控制端和被控端都显示固定密码

### 🚀 禁用升级
- 无自动升级提示
- 无版本更新通知
- 稳定使用不受打扰

### 🎨 品牌定制
- 软件名：**远程协助**
- 全中文界面
- 移除所有官方链接

## 📦 下载

### Windows

- **文件**: `remote-assist-windows-x64.zip`
- **大小**: ~50 MB
- **系统**: Windows 10/11 (64 位)

#### 使用方法

1. 解压下载的 ZIP 文件
2. 运行 `remote-assist.exe`
3. 被控端运行 `service.exe --service`

### Android

- **文件**: `remote-assist-android.apk`
- **大小**: ~30 MB
- **系统**: Android 8.0+

#### 使用方法

1. 下载 APK 文件
2. 允许"安装未知来源应用"
3. 点击 APK 安装

### Linux

- **文件**: `remote-assist-linux-x64.tar.gz`
- **大小**: ~16 MB
- **系统**: Linux (x86_64)

#### 使用方法

```bash
# 解压
tar -xzf remote-assist-linux-x64.tar.gz

# 运行
./remote-assist
```

## 🔧 技术规格

### 服务器配置

```
Rendezvous 服务器：desk.hsid.cc:21116
Relay 服务器：desk.hsid.cc:21117
API 服务器：deskapi.hsid.cc
默认密码：sc123.cc
```

### 编译信息

```
Rust 版本：1.95.0
Flutter 版本：3.24.0
构建时间：自动构建
Git 提交：${{ github.sha }}
```

## 📝 使用说明

### 被控端设置

1. 运行服务程序
   - Windows: `service.exe --service`
   - Linux: `./service --service`
   - Android: 打开 APP

2. 记录 ID 和密码
   - ID 会在程序界面显示
   - 固定密码：`sc123.cc`

### 控制端连接

1. 运行远程协助
2. 输入被控端 ID
3. 输入密码 `sc123.cc`
4. 点击连接

### 功能列表

✅ 远程桌面控制
✅ 文件传输
✅ 剪贴板同步
✅ TCP 中继
✅ 局域网发现
❌ 自动升级（已禁用）
❌ 官方服务器（已移除）

## 🔒 安全说明

### 密码安全

- 默认密码是固定的 `sc123.cc`
- 如需修改，请在设置中更改固定密码
- 建议在防火墙中仅开放必要端口

### 网络连接

必需的端口：
- 21116 (UDP/TCP) - Rendezvous
- 21117 (TCP) - Relay
- 21118 (TCP) - WebSocket（可选）

## 🐛 已知问题

### Windows

- 某些杀毒软件可能误报（白名单即可）
- Windows 7 需要额外安装运行库

### Android

- 部分机型需要手动授予无障碍权限
- Android 14 可能需要额外权限

### Linux

- Wayland 需要特殊配置
- 某些桌面环境可能需要额外权限

## 📋 更新日志

### v1.0.0 (First Release)

#### 核心修改
- [x] 服务器地址改为 desk.hsid.cc
- [x] 默认密码固定为 sc123.cc
- [x] 禁用自动升级检测
- [x] 软件名称改为"远程协助"
- [x] 移除所有官方链接
- [x] 中文界面完全本地化

#### 技术改进
- [x] 优化密码生成逻辑
- [x] 简化升级检测代码
- [x] 更新项目配置信息
- [x] 配置跨平台自动构建

## 🚀 版本计划

### v1.0.1 (计划中)

- [ ] 修复已知 bug
- [ ] 性能优化
- [ ] 增加自定义 Logo 支持
- [ ] 改进连接稳定性

### v1.1.0 (未来版本)

- [ ] 多语言支持
- [ ] 主题定制
- [ ] 批量管理
- [ ] 连接历史记录

## 📞 技术支持

### 文档

- 快速开始：`QUICKSTART.md`
- 详细文档：`README_远程协助.md`
- 编译指南：`跨平台编译指南.md`
- 构建设置：`GitHub_Actions 设置指南.md`

### 问题反馈

如有问题，请：
1. 查看文档中的故障排除章节
2. 检查服务器连接状态
3. 确认密码输入正确
4. 在 Issues 中提交问题

## 📄 许可证

基于 RustDesk 修改，遵循原项目许可证。

## 🙏 致谢

感谢：
- RustDesk 团队的开源项目
- 所有贡献者的工作
- GitHub Actions 提供的免费 CI/CD

---

**远程协助** - 让您随时随地获得协助！
