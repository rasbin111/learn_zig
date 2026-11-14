const std = @import("std");

const ArgsError = error{TooLongArgsError};

fn readable_permission(permission: u64, is_a_file: bool) ![10]u8 {
    var ps = [_]u8{ '-', '-', '-', '-', '-', '-', '-', '-', '-', '-' };
    if (!is_a_file) {
        ps[0] = 'd';
    }

    var gpa = std.heap.DebugAllocator(.{}){};
    const allocator = gpa.allocator();

    const ptext = try std.fmt.allocPrint(allocator, "{o}", .{permission});
    const pnumber = try std.fmt.parseInt(u64, ptext, 0);
    defer allocator.free(ptext);

    const authorNum = pnumber / 100;

    if (authorNum == 7) {
        ps[1] = 'r';
        ps[2] = 'w';
        ps[3] = 'x';
    } else if (authorNum == 6) {
        ps[1] = 'r';
        ps[2] = 'w';
    } else if (authorNum == 5) {
        ps[1] = 'r';
        ps[3] = 'x';
    } else if (authorNum == 4) {
        ps[1] = 'r';
    } else if (authorNum == 3) {
        ps[2] = 'w';
        ps[3] = 'x';
    } else if (authorNum == 2) {
        ps[2] = 'w';
    } else if (authorNum == 1) {
        ps[3] = 'x';
    }

    return ps;
}

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
        const stat = try d.statFile(init.io, content.name, .{});

        var kind: []const u8 = undefined;

        if (content.kind == std.Io.File.Kind.file) {
            kind = "File";
        } else if (content.kind == std.Io.File.Kind.directory) {
            kind = "Directory";
        } else {
            kind = "Others";
        }
        const permission_string = try readable_permission(@as(u64, stat.permissions.toMode() & 0o777), content.kind == std.Io.File.Kind.file);

        std.debug.print("{s} {s} {d}\n", .{ content.name, permission_string, stat.size });
    }
    std.debug.print("\n", .{});
}
