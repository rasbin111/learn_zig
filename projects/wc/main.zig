const std = @import("std");

pub fn main(init: std.process.Init) !void {
    var args = init.minimal.args.iterate();

    const len_args = args.inner.remaining.len;
    const dir = std.Io.Dir.cwd();

    _ = args.skip();

    if (len_args >= 2) {
        var total_lc: u32 = 0;
        var total_wc: u32 = 0;
        var total_bytes: u32 = 0;
        while (args.next()) |file_path| {
            const file = try dir.openFile(init.io, file_path, .{ .mode = .read_only });

            var reader_buffer: [1024]u8 = undefined;

            var buffer: [1024]u8 = undefined;

            var reader = file.reader(init.io, &reader_buffer);
            var line_count: u32 = 0;
            var word_count: u32 = 0;
            var bytes_count: u32 = 0;

            while (true) {
                const bytes_read = try reader.interface.readSliceShort(&buffer);
                if (bytes_read == 0) break;

                for (buffer[0..bytes_read]) |char| {
                    if (char == '\n') {
                        line_count += 1;
                    }

                    if (std.ascii.isWhitespace(char)) {
                        word_count += 1;
                    }
                    bytes_count += 1;
                }
            }

            std.debug.print("{} {} {} {s}\n", .{ line_count, word_count, bytes_count, file_path });
            total_lc += line_count;
            total_wc += word_count;
            total_bytes += bytes_count;
        }

        std.debug.print("{} {} {} {s}\n", .{ total_lc, total_wc, total_bytes, "Total" });
    }
}
