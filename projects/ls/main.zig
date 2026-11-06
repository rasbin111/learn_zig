const std = @import("std");

const ArgsError = error{TooLongArgsError};

pub fn main(init: std.process.Init) !void {
    const cwd = std.Io.Dir.cwd();

    var args = init.minimal.args.iterate();
    const len_args = args.inner.remaining.len;

    var parent_dir: []const u8 = ".";

    if (len_args > 2) {
        return ArgsError.TooLongArgsError;
    } else if (len_args == 2) {
        _ = args.skip();
        if (args.next()) |arg| {
            parent_dir = arg;
        }
    } else {}

    const d = try cwd.openDir(init.io, parent_dir, .{ .iterate = true });

    var contents = d.iterate();

    while (try contents.next(init.io)) |content| {
        std.debug.print("File: {}\n", .{content.inode});
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
