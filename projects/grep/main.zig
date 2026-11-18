const std = @import("std");

pub fn main(init: std.process.Init) !void {
    var args = init.minimal.args.iterate();

    const len_args = args.inner.remaining.len;
    const dir = std.Io.Dir.cwd();

    _ = args.skip();

    if (len_args >= 3) {
        const search_string = args.next().?;
        const file_path = args.next().?;

        const file = try dir.openFile(init.io, file_path, .{ .mode = .read_only });

        var reader_buffer: [1024]u8 = undefined;
        var buffer: [1024]u8 = undefined;

        var reader = file.reader(init.io, &reader_buffer);
        while (true) {
            const read_len = try reader.interface.readSliceShort(&buffer);
            if (read_len == 0) break;
            var last_line_end_pos: usize = 0;
            if (std.mem.indexOf(u8, buffer[0..read_len], search_string)) |index| {
                for (buffer[0..index], 0..index) |rev_char, idx| {
                    if (rev_char == '\n') {
                        last_line_end_pos = idx;
                    }
                }

                inner: for (buffer[last_line_end_pos + 1 .. read_len], last_line_end_pos + 1..read_len) |char, idx_char| {
                    if (char == '\n') {
                        const our_line = buffer[last_line_end_pos + 1 .. idx_char];
                        std.debug.print("{s}\n", .{our_line});
                        break :inner;
                    }
                }
            }
        }
    }
}
