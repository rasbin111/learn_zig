const std = @import("std");

test "test for loop" {
    const arr = [_]u8{ 1, 2, 3, 4, 5 };

    var sum: u8 = 0;
    for (arr) |item| {
        sum += item;
    }

    try std.testing.expectEqual(15, sum);
}

test "test labeled for" {
    var count: i32 = 0;
    outer: for (1..6) |_| {
        for (1..6) |_| {
            count += 1;
            continue :outer;
        }
    }
    try std.testing.expectEqual(5, count);
}
