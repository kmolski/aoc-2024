const std = @import("std");
const aoc = @import("aoc.zig");

const testInput =
    \\7 6 4 2 1
    \\1 2 7 8 9
    \\9 7 6 2 1
    \\1 3 2 4 5
    \\8 6 4 4 1
    \\1 3 6 7 9
;

test "part1: example" {
    const seqs = try aoc.readSequences(testInput);
    try std.testing.expectEqual(2, solve(seqs.items, false));
}

test "part2: example" {
    const seqs = try aoc.readSequences(testInput);
    try std.testing.expectEqual(4, solve(seqs.items, true));
}

fn isSafeSeq(sequence: aoc.Nums) bool {
    const ascending = sequence.items[1] > sequence.items[0];
    for (sequence.items[0 .. sequence.items.len - 1], sequence.items[1..]) |fst, snd| {
        const diff = snd - fst;
        const absDiff: i32 = @intCast(@abs(diff));
        if ((absDiff < 1 or absDiff > 3) or ((diff > 0) != ascending)) {
            return false;
        }
    }
    return true;
}

fn solve(seqs: []aoc.Nums, tryRemovingLevels: bool) !i32 {
    var safeSeqs: i32 = 0;
    for (seqs) |sequence| {
        var isSafe = false;
        if (isSafeSeq(sequence)) {
            isSafe = true;
        } else if (tryRemovingLevels) {
            for (0..sequence.items.len) |i| {
                var tmp = try sequence.clone();
                defer tmp.deinit();
                _ = tmp.orderedRemove(i);
                if (isSafeSeq(tmp)) {
                    isSafe = true;
                }
            }
        }
        if (isSafe) {
            safeSeqs += 1;
        }
    }
    return safeSeqs;
}

pub fn main() !void {
    const input = @embedFile("input.txt");
    const seqs = try aoc.readSequences(input);
    defer seqs.deinit();
    defer for (seqs.items) |sequence| sequence.deinit();

    std.debug.print(
        \\Part 1: {d}
        \\Part 2: {d}
        \\
    , .{ try solve(seqs.items, false), try solve(seqs.items, true) });
}
