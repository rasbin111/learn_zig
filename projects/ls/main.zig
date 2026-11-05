const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const cwd = std.Io.Dir.cwd();
    const d = try cwd.openDir(init.io, ".", .{ .iterate = true });

    var contents = d.iterate();

    while (try contents.next(init.io)) |content| {
        if (content.kind == std.Io.File.Kind.file) {
            std.debug.print("File: {s}\n", .{content.name});
        } else if (content.kind == std.Io.File.Kind.directory) {
            std.debug.print("Dir: {s}/\n", .{content.name});
        } else {
            std.debug.print("Others: {s}\n", .{content.name});
        }
    }
    std.debug.print("\n", .{});
}
