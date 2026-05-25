# Remote Assist - 快速开始

## 项目概述

这是基于 RustDesk 定制的远程协助软件，品牌名称为"远程协助"。

## 核心配置

```
服务器：desk.hsid.cc:21116
API: deskapi.hsid.cc
默认密码：sc123.cc
```

## 快速编译

### Linux

```bash
# 一键编译
./build.sh

# 或手动编译
cargo build --release --features flutter
```

### Windows

```powershell
# 双击运行
build.bat

# 或命令行
cargo build --release --features flutter
```

### macOS

```bash
cargo build --release --features flutter
```

## 编译产物

- `remote-assist` (主程序)
- `service` (后台服务)
- `naming` (命名工具)

## 使用方式

### 方式 1: 直接运行

```bash
# Linux
./remote-assist

# Windows
remote-assist.exe
```

### 方式 2: 文件名携带配置（Windows）

```
远程协助-host=desk.hsid.cc,api=deskapi.hsid.cc.exe
```

## 连接测试

1. 确保服务器 `desk.hsid.cc` 正常运行
2. 端口 21116 (UDP/TCP) 已开放
3. 启动被控端和控制端
4. 使用固定密码 `sc123.cc` 连接

## 主要特性

✅ 自有服务器，无第三方中转
✅ 固定密码，无需每次查看
✅ 无升级提示，稳定使用
✅ 完全自有品牌"远程协助"
✅ 移除所有官方链接

## 文件清单

```
/workspace/
├── Cargo.toml                    # 项目配置（已修改品牌）
├── build.sh                      # Linux 编译脚本
├── build.bat                     # Windows 编译脚本
├── README_远程协助.md             # 详细文档
├── 修改说明.md                    # 修改说明
├── src/                          # Rust 源码
│   ├── lang/cn.rs               # 中文语言文件（已汉化）
│   ├── updater.rs               # 升级检测（已禁用）
│   └── common.rs                # 通用配置（已改服务器）
├── libs/hbb_common/src/
│   ├── config.rs                # 核心配置（服务器/APP 名）
│   └── password_security.rs     # 密码逻辑（固定密码）
└── flutter/lib/
    ├── common.dart              # Flutter 通用（禁用升级）
    └── models/server_model.dart # 密码显示（固定显示）
```

## 服务器要求

确保你的服务器部署了 rustdesk-server 并运行：

```bash
# 必需服务
- hbbs (Rendezvous 服务器) - 端口 21116
- hbbr (Relay 服务器) - 端口 21117

# 可选服务
- API 服务器 - deskapi.hsid.cc
```

## 常见问题

**Q: 连接失败怎么办？**
A: 检查防火墙是否开放 21116 端口，确认 DNS 解析正确。

**Q: 密码错误？**
A: 确认服务器配置的密码与客户端一致为 `sc123.cc`。

**Q: 如何修改密码？**
A: 修改 `libs/hbb_common/src/password_security.rs` 中的 `get_auto_password()` 函数。

**Q: 如何更换服务器？**
A: 修改 `libs/hbb_common/src/config.rs` 中的 `RENDEZVOUS_SERVERS`。

## 许可证

基于 RustDesk 修改，遵循原项目许可证。

## 支持

详细文档请参考 `README_远程协助.md`
