const std = @import("std");
const aoc = @import("aoc.zig");

const testInput =
    \\3   4
    \\4   3
    \\2   5
    \\1   3
    \\3   9
    \\3   3
;

test "part1: example" {
    const lists = try aoc.readPairs(testInput);
    try std.testing.expectEqual(11, part1(lists[0], lists[1]));
}

test "part2: example" {
    const lists = try aoc.readPairs(testInput);
    try std.testing.expectEqual(31, part2(lists[0], lists[1]));
}

fn part1(left: aoc.Nums, right: aoc.Nums) !i32 {
    std.mem.sort(i32, left.items, {}, std.sort.asc(i32));
    std.mem.sort(i32, right.items, {}, std.sort.asc(i32));
    var distanceSum: i32 = 0;
    for (left.items, right.items) |l, r| {
        distanceSum += @intCast(@abs(l - r));
    }
    return distanceSum;
}

fn part2(left: aoc.Nums, right: aoc.Nums) !i32 {
    var distanceSum: i32 = 0;
    for (left.items) |l| {
        distanceSum += l * @as(i32, @intCast(std.mem.count(i32, right.items, &.{l})));
    }
    return distanceSum;
}

pub fn main() !void {
    const input = @embedFile("input.txt");
    const lists = try aoc.readPairs(input);
    defer _ = lists[0].deinit();
    defer _ = lists[1].deinit();
    std.debug.print(
        \\Part 1: {d}
        \\Part 2: {d}
        \\
    , .{ try part1(lists[0], lists[1]), try part2(lists[0], lists[1]) });
}
