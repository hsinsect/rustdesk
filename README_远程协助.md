# 远程协助 - RustDesk 自定义版本

## 配置信息

### 服务器配置
- **Rendezvous 服务器**: `desk.hsid.cc` (端口 21116)
- **API 服务器**: `deskapi.hsid.cc`
- **中继服务器**: 只使用自有服务器（已移除官方中继）

### 默认密码
- **固定密码**: `sc123.cc`
- **动态密码**: 已禁用（不再刷新）
- **密码显示**: 始终显示固定密码

### 软件名称
- **应用名称**: 远程协助
- **包名**: remote-assist
- **Windows 产品名**: 远程协助
- **Bundle ID**: com.hsid.remote-assist

### 升级检测
- **自动升级**: 已禁用
- **升级提示**: 已移除
- **检测代码**: 已注释

## 主要修改内容

### Rust 核心代码修改

#### 1. 配置修改
**文件**: `libs/hbb_common/src/config.rs`
- 修改 `RENDEZVOUS_SERVERS` 为 `desk.hsid.cc`
- 清空 `RS_PUB_KEY`（需使用自己的密钥）
- 修改 `APP_NAME` 为 `远程协助 `
- 清空所有官方帮助链接

#### 2. 密码安全修改
**文件**: `libs/hbb_common/src/password_security.rs`
- 固定密码为 `sc123.cc`
- 禁用密码刷新功能

#### 3. 升级模块修改
**文件**: `src/updater.rs`
- 禁用自动升级检测线程
- 简化 `check_update` 函数直接返回成功

#### 4. 主程序修改
**文件**: `src/main.rs`
- 命令行工具名称改为 `远程协助`
- 作者信息更新

#### 5. 语言文件修改
**文件**: `src/lang/cn.rs`
- 所有 `RustDesk` 替换为 `远程协助`

#### 6. API 服务器修改
**文件**: `src/common.rs`
- 默认 API 服务器改为 `deskapi.hsid.cc`

### Flutter UI 修改

#### 1. 升级检测
**文件**: `flutter/lib/common.dart`
- 禁用 `checkUpdate()` 函数

#### 2. 密码显示
**文件**: `flutter/lib/models/server_model.dart`
- 固定显示密码 `sc123.cc`
- 不显示 "-" 占位符

#### 3. 官方链接
**文件**: 多个 Flutter 页面
- 所有 `rustdesk.com` 链接替换为 `#`
- 品牌文本改为 `远程协助`

### 项目配置修改

**文件**: `Cargo.toml`
- 包名、作者、描述全部更新
- Windows 和 macOS 产品信息更新

## 编译说明

### Linux 编译

```bash
# 安装依赖
sudo apt update
sudo apt install -y cmake clang libgtk-3-dev libwayland-dev \
    libxfixes-dev libxdo3-dev libpulse-dev libasound2-dev \
    libxcb1 libxcb-xfixes0-dev

# 编译
cargo build --release --features flutter

# 编译产物位置
./target/release/remote-assist
./target/release/service
./target/release/naming
```

### Windows 编译

```powershell
# 安装 vcpkg 依赖
vcpkg install

# 编译
cargo build --release --features flutter

# 编译产物位置
.\target\release\remote-assist.exe
.\target\release\service.exe
.\target\release\naming.exe
```

### macOS 编译

```bash
# 编译
cargo build --release --features flutter

# 编译产物位置
./target/release/remote-assist
```

## 部署方式

### Windows 部署

1. **打包**: 将 `target/release/` 目录下的可执行文件打包
2. **可选**: 重命名可执行文件携带配置
   ```
   远程协助-host=desk.hsid.cc,api=deskapi.hsid.cc.exe
   ```

### Linux 部署

1. **打包**: 将编译产物打包为 tar.gz
   ```bash
   cd target/release
   tar -czf remote-assist-linux-x64.tar.gz remote-assist service naming
   ```

2. **安装**: 解压到目标机器运行

### 配置文件（可选）

可以在程序目录创建配置文件进一步自定义：

**Windows**: `C:\Program Files\远程协助\config.toml`
**Linux**: `/opt/remote-assist/config.toml`

## 注意事项

### 1. 密钥生成
你需要使用 rustdesk-server 生成密钥对：

```bash
# 使用 rustdesk-server 生成密钥
./rustdesk-keygen

# 将生成的公钥填入 libs/hbb_common/src/config.rs 的 RS_PUB_KEY
```

### 2. 服务器配置
确保你的服务器运行正常：
- `desk.hsid.cc:21116` - Rendezvous 服务
- `desk.hsid.cc:21117` - Relay 服务
- `deskapi.hsid.cc` - API 服务

### 3. 防火墙设置
确保以下端口开放：
- 21116 (UDP/TCP) - Rendezvous
- 21117 (TCP) - Relay
- 21118 (TCP) - WebSocket Rendezvous (可选)
- 21119 (TCP) - WebSocket Relay (可选)

### 4. 图标资源
建议替换 `res/` 目录下的图标文件：
- `res/32x32.png`
- `res/128x128.png`
- `res/128x128@2x.png`

### 5. 版权声明
建议更新版权信息为你的公司信息。

## 功能验证清单

- [x] 服务器地址配置正确
- [x] 默认密码固定为 sc123.cc
- [x] UI 显示"远程协助"品牌
- [x] 升级检测已禁用
- [x] 官方服务器已移除
- [x] 密码显示固定
- [x] 官方链接已移除

## 故障排除

### 无法连接服务器
检查：
1. DNS 解析是否正确
2. 防火墙是否开放端口
3. 服务器是否正常运行

### 密码错误
检查：
1. 服务器密码配置是否匹配
2. 是否使用了正确的验证模式

### 编译错误
常见问题：
1. 缺少依赖 - 安装所有编译依赖
2. Rust 版本过低 - 使用 Rust 1.75+
3. Flutter 版本不匹配 - 使用项目指定的 Flutter 版本

## 技术支持

如需进一步定制或遇到问题，请参考：
- RustDesk 官方文档
- rustdesk-server 部署文档

## 许可证

基于 RustDesk 修改，遵循原项目许可证。
