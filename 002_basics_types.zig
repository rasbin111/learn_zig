const std = @import("std");

pub fn main() !void{
    const a: u8 = 10;
    const b: u8 = 20;
    const result: u8 = a + b;
    _ = result;
    // std.debug.print("Result: {d}\n", .{result});
    
    const f1: f32 = 20.30;
    const f2: f32 = 30.01;
    const result2: f32 = f1 * f2;
    _ = result2;
    // std.debug.print("Result: {d}\n", .{result2});
    
    const c1: u8 = 'b';
    std.debug.print("Char: {c}\n", .{c1});
}
