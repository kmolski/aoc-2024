const std = @import("std");

var gpa = std.heap.GeneralPurposeAllocator(.{}){};

pub const Nums = std.ArrayList(i32);
pub var alloc = gpa.allocator();

pub fn readPairs(input: []const u8) !struct { Nums, Nums } {
    var left = Nums.init(alloc);
    var right = Nums.init(alloc);

    var lines = std.mem.tokenizeScalar(u8, input, '\n');
    while (lines.next()) |line| {
        var numbers = std.mem.tokenizeScalar(u8, line, ' ');
        try left.append(try std.fmt.parseInt(i32, numbers.next() orelse "", 10));
        try right.append(try std.fmt.parseInt(i32, numbers.next() orelse "", 10));
    }

    return .{ left, right };
}

pub fn readSequences(input: []const u8) !std.ArrayList(Nums) {
    var seqs = std.ArrayList(Nums).init(alloc);

    var lines = std.mem.tokenizeScalar(u8, input, '\n');
    while (lines.next()) |line| {
        var sequence = Nums.init(alloc);
        var numbers = std.mem.tokenizeScalar(u8, line, ' ');
        while (numbers.next()) |num| {
            try sequence.append(try std.fmt.parseInt(i32, num, 10));
        }
        try seqs.append(sequence);
    }

    return seqs;
}
