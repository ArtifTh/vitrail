usingnamespace @import("vitrail.zig");
pub const Window = @import("Window.zig");
pub const Layout = @import("Layout.zig");
pub const Tile = @import("Tile.zig");
pub const DesktopWindow = @import("SystemInteraction.zig").DesktopWindow;

const Self = @This();

window: *Window,
layout: *Layout,
event_handlers: Window.EventHandlers,
desktop_windows: []DesktopWindow,
hInstance: w.HINSTANCE,
allocator: *std.mem.Allocator,
click_handler: Tile.EventHandlers = .{
    .onClick = onClickHandler
},

fn onClickHandler(tile_event_handlers: *Tile.EventHandlers, button: *Tile) !void {
    const self = @fieldParentPtr(Self, "click_handler", tile_event_handlers);

    std.debug.warn("Click!\n", .{});
}

fn onDestroyHandler(event_handlers: *Window.EventHandlers, window: *Window) !void {
    _ = w.PostQuitMessage(0);
}

pub fn create(hInstance: w.HINSTANCE, allocator: *std.mem.Allocator) !*Self {
    const windowConfig = Window.WindowParameters { 
        .width = 1024,
        .height = 768,
        .title = toUtf16const("MainWindow")
    };

    var self = try allocator.create(Self);
    self.* = .{
        .window = undefined,
        .layout = undefined,
        .event_handlers = .{
            .onDestroy = onDestroyHandler,
        },
        .desktop_windows = undefined,
        .hInstance = hInstance,
        .allocator = allocator
    };

    var window = try Window.create(windowConfig, &self.event_handlers, hInstance, allocator);
    self.window = window;

    self.layout = try Layout.create(hInstance, window, allocator);

    return self;
}

pub fn setDesktopWindows(self: *Self, desktopWindows: []DesktopWindow) !void {
    self.desktop_windows = desktopWindows;
    try self.updateBoxes();
}

fn updateBoxes(self: *Self) !void {
    try self.layout.clear();

    for (self.desktop_windows) |dw| {
        var button = Tile.create(self.hInstance, self.layout.window, dw, &self.click_handler, self.allocator);
    }
}