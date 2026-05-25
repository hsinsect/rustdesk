# RustDesk 自定义品牌配置需求

## 用户需求

### 1. 服务器配置
- ** rendezvous 服务器**: desk.hsid.cc
- ** API 服务器**: deskapi.hsid.cc
- **中继服务器**: 只使用自己的中继 (去掉官方服务器)

### 2. 密码设置
- **默认密码**: sc123.cc
- **不显示动态密码**: 被控端不显示随机密码
- **不提示输入密码**: 控制端和被控端都不显示密码输入提示

### 3. 软件名称
- **控制端名称**: 远程协助
- **被控端名称**: 远程协助
- APP_NAME 从 "RustDesk" 改为 "远程协助"

### 4. 升级提示
- **去掉升级提示**: 控制端和被控端都不提示升级

### 5. 官方服务器
- **去掉官方中继**: 只使用自己的中继服务器
- **修改 RENDEZVOUS_SERVERS**: 移除 rs-ny.rustdesk.com

## 需要修改的文件

### 1. 服务器配置
- `/workspace/libs/hbb_common/src/config.rs`
  - 修改 `RENDEZVOUS_SERVERS` 数组
  - 修改 `RS_PUB_KEY`

### 2. 软件名称
- `/workspace/libs/hbb_common/src/config.rs`
  - 修改 `APP_NAME` 初始值
- `/workspace/Cargo.toml`
  - 修改 `ProductName`
  - 修改 `FileDescription`
- `/workspace/src/lang/cn.rs`
  - 翻译所有 "RustDesk" 为 "远程协助"

### 3. 密码配置
- 查找密码相关代码并修改默认行为

### 4. 升级提示
- 查找 `SOFTWARE_UPDATE_URL` 相关代码并禁用

### 5. 中继服务器
- 配置默认只使用自定义中继

## 编译后分发

### Windows
- 编译生成 `远程协助.exe`
- 可以配置文件名参数来携带服务器信息

### Linux
- 编译生成对应的可执行文件
