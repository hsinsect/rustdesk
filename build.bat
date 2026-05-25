@echo off
REM 远程协助 - Windows 编译脚本
REM 用于 Windows 系统

echo ========================================
echo 远程协助 - 编译脚本 (Windows)
echo ========================================
echo.

REM 检查 Rust 安装
echo 检查 Rust 安装...
where cargo >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo 错误：未找到 cargo，请安装 Rust
    echo 安装地址：https://rustup.rs/
    pause
    exit /b 1
)
echo Rust 已安装 ✓
echo.

REM 显示 Cargo 版本
cargo --version
echo.

REM 更新依赖
echo 更新 Rust 依赖...
cargo update
if %ERRORLEVEL% neq 0 (
    echo 警告：依赖更新失败，继续编译...
)
echo.

REM 开始编译
echo ========================================
echo 开始编译 Release 版本...
echo 这将需要一些时间，请耐心等待。
echo ========================================
echo.

cargo build --release --features flutter
if %ERRORLEVEL% neq 0 (
    echo.
    echo 编译失败！请检查错误信息。
    pause
    exit /b 1
)

echo.
echo ========================================
echo 编译完成 ✓
echo ========================================
echo.

REM 显示编译产物
echo 编译产物:
echo.
if exist "target\release\remote-assist.exe" (
    echo 主程序：target\release\remote-assist.exe
    dir target\release\remote-assist.exe
    echo.
)

if exist "target\release\service.exe" (
    echo 服务程序：target\release\service.exe
    dir target\release\service.exe
    echo.
)

if exist "target\release\naming.exe" (
    echo 命名工具：target\release\naming.exe
    dir target\release\naming.exe
    echo.
)

echo ========================================
echo 打包建议
echo ========================================
echo.
echo 创建一个包含以下文件的 ZIP 包：
echo   - remote-assist.exe
echo   - service.exe
echo   - naming.exe
echo.
echo 可选：重命名可执行文件携带服务器配置
echo   远程协助-host=desk.hsid.cc,api=deskapi.hsid.cc.exe
echo.

echo ========================================
echo 编译成功！
echo ========================================
echo.
echo 下一步:
echo 1. 测试程序运行：target\release\remote-assist.exe
echo 2. 打包分发：创建 ZIP 压缩包
echo 3. 部署到目标机器
echo.
echo 服务器配置：
echo   - Rendezvous: desk.hsid.cc:21116
echo   - API: deskapi.hsid.cc
echo   - 默认密码：sc123.cc
echo.

pause
