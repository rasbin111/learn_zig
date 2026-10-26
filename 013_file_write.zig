const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const currentDir = std.Io.Dir.cwd();
    const file = try std.Io.Dir.createFile(currentDir, init.io, "hello.txt", .{
        .read = true,
    });
    defer file.close(init.io);

    var writerBuffer: [1000]u8 = undefined;
    var file_writer = file.writer(init.io, &writerBuffer);
    const writer_interface = &file_writer.interface;

    try writer_interface.writeAll("Something in the way\n");
    try writer_interface.writeAll("     - By Nirvana\n");

    try writer_interface.flush();
}
