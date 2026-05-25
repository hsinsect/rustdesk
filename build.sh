#!/bin/bash
# 远程协助 - 编译脚本
# 用于 Linux 系统

set -e

echo "========================================"
echo "远程协助 - 编译脚本"
echo "========================================"
echo ""

# 检查是否安装了必要的依赖
check_dependencies() {
    echo "检查编译依赖..."
    
    # 检查 Rust
    if ! command -v cargo &> /dev/null; then
        echo "错误：未找到 cargo，请安装 Rust"
        echo "安装命令：curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
        exit 1
    fi
    
    # 检查 clang
    if ! command -v clang &> /dev/null; then
        echo "警告：未找到 clang，尝试安装..."
        sudo apt-get update && sudo apt-get install -y clang
    fi
    
    # 检查 cmake
    if ! command -v cmake &> /dev/null; then
        echo "警告：未找到 cmake，尝试安装..."
        sudo apt-get update && sudo apt-get install -y cmake
    fi
    
    # 检查 GTK 开发库
    if ! dpkg -l | grep -q libgtk-3-dev; then
        echo "警告：未找到 GTK3 开发库，尝试安装..."
        sudo apt-get update && sudo apt-get install -y libgtk-3-dev
    fi
    
    # 检查 Wayland 开发库
    if ! dpkg -l | grep -q libwayland-dev; then
        echo "警告：未找到 Wayland 开发库，尝试安装..."
        sudo apt-get update && sudo apt-get install -y libwayland-dev
    fi
    
    # 检查 X11 开发库
    if ! dpkg -l | grep -q libxdo3-dev; then
        echo "警告：未找到 XDo 开发库，尝试安装..."
        sudo apt-get update && sudo apt-get install -y libxdo3-dev libxfixes-dev
    fi
    
    # 检查音频开发库
    if ! dpkg -l | grep -q libpulse-dev; then
        echo "警告：未找到 PulseAudio 开发库，尝试安装..."
        sudo apt-get update && sudo apt-get install -y libpulse-dev libasound2-dev
    fi
    
    echo "依赖检查完成 ✓"
    echo ""
}

# 更新 Rust 依赖
update_deps() {
    echo "更新 Rust 依赖..."
    cargo update
    echo "依赖更新完成 ✓"
    echo ""
}

# 编译 Release 版本
build_release() {
    echo "开始编译 Release 版本..."
    echo "这将需要一些时间，请耐心等待。"
    echo ""
    
    cargo build --release --features flutter
    
    echo ""
    echo "编译完成 ✓"
    echo ""
}

# 显示编译产物信息
show_artifacts() {
    echo "========================================"
    echo "编译产物"
    echo "========================================"
    echo ""
    
    if [ -f "target/release/remote-assist" ]; then
        echo "主程序：target/release/remote-assist"
        ls -lh target/release/remote-assist
        echo ""
    fi
    
    if [ -f "target/release/service" ]; then
        echo "服务程序：target/release/service"
        ls -lh target/release/service
        echo ""
    fi
    
    if [ -f "target/release/naming" ]; then
        echo "命名工具：target/release/naming"
        ls -lh target/release/naming
        echo ""
    fi
    
    echo "========================================"
    echo "打包建议"
    echo "========================================"
    echo ""
    echo "运行以下命令打包："
    echo "  cd target/release"
    echo "  tar -czf remote-assist-linux-x64.tar.gz remote-assist service naming"
    echo ""
}

# 主流程
main() {
    check_dependencies
    update_deps
    build_release
    show_artifacts
    
    echo ""
    echo "========================================"
    echo "编译成功！"
    echo "========================================"
    echo ""
    echo "下一步："
    echo "1. 测试程序运行：./target/release/remote-assist"
    echo "2. 打包分发：创建 tar.gz 压缩包"
    echo "3. 部署到目标机器"
    echo ""
    echo "服务器配置："
    echo "  - Rendezvous: desk.hsid.cc:21116"
    echo "  - API: deskapi.hsid.cc"
    echo "  - 默认密码：sc123.cc"
    echo ""
}

# 执行主流程
main "$@"
