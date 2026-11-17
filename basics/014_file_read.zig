const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const curDir = std.Io.Dir.cwd();

    const file = try std.Io.Dir.openFile(curDir, init.io, "hello.txt", .{ .mode = .read_only });
    defer file.close(init.io);

    var readerBuffer: [1024]u8 = undefined;
    var fileReader = file.reader(init.io, &readerBuffer);
    var reader = &fileReader.interface;

    while (true) {
        var buffer: [1024]u8 = undefined;
        const bytes = try reader.readSliceShort(&buffer);
        if (bytes == 0) break;

        std.debug.print("{s}", .{buffer});
    }
}
