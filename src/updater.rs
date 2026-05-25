use crate::hbbs_http::create_http_client_with_url;
use hbb_common::{log, ResultType};

enum UpdateMsg {
    CheckUpdate,
    Exit,
}

pub fn update_controlling_session_count(count: usize) {
    // 禁用升级，此函数空实现
}

#[allow(dead_code)]
pub fn start_auto_update() {
    // 禁用升级
}

#[allow(dead_code)]
pub fn manually_check_update() -> ResultType<()> {
    // 禁用升级
    Ok(())
}

#[allow(dead_code)]
pub fn stop_auto_update() {
    // 禁用升级
}

fn has_no_active_conns() -> bool {
    let conns = crate::Connection::alive_conns();
    conns.is_empty()
}

fn has_no_controlling_conns() -> bool {
    true
}

fn start_auto_update_check() -> std::sync::mpsc::Sender<UpdateMsg> {
    let (tx, _rx) = std::sync::mpsc::channel();
    tx
}

fn check_update(_manually: bool) -> ResultType<()> {
    // 禁用升级检测
    Ok(())
}

pub fn get_download_file_from_url(url: &str) -> Option<std::path::PathBuf> {
    let filename = url.split('/').last()?;
    Some(std::env::temp_dir().join(filename))
}
