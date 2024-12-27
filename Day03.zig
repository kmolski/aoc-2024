const std = @import("std");
const aoc = @import("aoc.zig");

const indexOf = std.mem.indexOfPos;

const testInput = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";

test "part1: example" {
    try std.testing.expectEqual(161, part1(testInput));
}

test "part2: example" {
    try std.testing.expectEqual(48, part2(testInput));
}

fn part1(insns: []const u8) u32 {
    const parse = std.fmt.parseInt;

    var sum: u32 = 0;
    var start: usize = 0;
    var end: usize = 0;
    while (start < insns.len) {
        start = indexOf(u8, insns, start + 1, "mul(") orelse break;
        end = indexOf(u8, insns, start, ")") orelse continue;
        const fstEnd = indexOf(u8, insns, start, ",") orelse continue;
        const fst = parse(u32, insns[start + 4 .. fstEnd], 10) catch continue;
        const snd = parse(u32, insns[fstEnd + 1 .. end], 10) catch continue;
        sum += fst * snd;
    }
    return sum;
}

fn part2(insns: []const u8) u32 {
    var sum: u32 = 0;
    var start: usize = 0;
    var end: usize = 0;
    while (start < insns.len) {
        end = indexOf(u8, insns, start, "don't()") orelse insns.len;
        sum += part1(insns[start..end]);
        start = indexOf(u8, insns, end + 7, "do()") orelse break;
    }
    return sum;
}

pub fn main() !void {
    const input = @embedFile("input.txt");

    std.debug.print(
        \\Part 1: {d}
        \\Part 2: {d}
        \\
    , .{ part1(input), part2(input) });
}
