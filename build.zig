const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const linkage = b.option(std.Build.LinkMode, "linkage", "Type of linkage") orelse .static;

    const lib = b.addLibrary(.{
        .name = "sdl_mixer",
        .linkage = linkage,
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });

    lib.addCSourceFiles(.{
        .root = b.path("src"),
        .files = &.{},
    });
    lib.addIncludePath(b.path("include"));

    b.installArtifact(lib);
}
