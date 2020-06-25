const std = @import("std");
const w = @import("win32").c;

pub const ComError = error {
    FailedToCreateComObject
};

pub const CLSCTX_INPROC_SERVER      = 0x1;
pub const CLSCTX_INPROC_HANDLER     = 0x2;
pub const CLSCTX_LOCAL_SERVER       = 0x4;
pub const CLSCTX_INPROC_SERVER16    = 0x8;
pub const CLSCTX_REMOTE_SERVER      = 0x10;
pub const CLSCTX_INPROC_HANDLER16       = 0x20;
pub const CLSCTX_RESERVED1          = 0x40;
pub const CLSCTX_RESERVED2          = 0x80;
pub const CLSCTX_RESERVED3          = 0x100;
pub const CLSCTX_RESERVED4          = 0x200;
pub const CLSCTX_NO_CODE_DOWNLOAD       = 0x400;
pub const CLSCTX_RESERVED5          = 0x800;
pub const CLSCTX_NO_CUSTOM_MARSHAL      = 0x1000;
pub const CLSCTX_ENABLE_CODE_DOWNLOAD   = 0x2000;
pub const CLSCTX_NO_FAILURE_LOG     = 0x4000;
pub const CLSCTX_DISABLE_AAA        = 0x8000;
pub const CLSCTX_ENABLE_AAA         = 0x10000;
pub const CLSCTX_FROM_DEFAULT_CONTEXT   = 0x20000;
pub const CLSCTX_ACTIVATE_32_BIT_SERVER = 0x40000;
pub const CLSCTX_ACTIVATE_64_BIT_SERVER = 0x80000;
pub const CLSCTX_INPROC         = CLSCTX_INPROC_SERVER|CLSCTX_INPROC_HANDLER;
pub const CLSCTX_SERVER         = CLSCTX_INPROC_SERVER|CLSCTX_LOCAL_SERVER|CLSCTX_REMOTE_SERVER;
pub const CLSCTX_ALL            = CLSCTX_SERVER|CLSCTX_INPROC_HANDLER;

pub const REFIID = [*c]const w.IID;
pub const REFGUID = [*c]const w.GUID;