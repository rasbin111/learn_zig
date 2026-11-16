const std = @import("std");

pub fn main(init: std.process.Init) !void {
    var args = init.minimal.args.iterate();

    const len_args = args.inner.remaining.len;
    _ = args.skip();

    const dir = std.Io.Dir.cwd();

    if (len_args >= 2) {
        while (args.next()) |file_path| {
            const file = try dir.openFile(init.io, file_path, .{ .mode = .read_only });

            var reader_buffer: [1024]u8 = undefined;
            var buffer: [1024]u8 = undefined;

            var reader = file.reader(init.io, &reader_buffer);

            while (true) {
                const read_len = try reader.interface.readSliceShort(&buffer);

                if (read_len == 0) break;
                std.debug.print("{s}", .{buffer[0..read_len]});
            }
        }
    }
}
