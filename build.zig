const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // TODO: add other options
    const linkage = b.option(std.builtin.LinkMode, "linkage", "Type of linkage") orelse .static;

    const upstream = b.dependency("sdl_mixer", .{
        .target = target,
        .optimize = optimize,
    });

    const sdl = b.dependency("sdl", .{
        .target = target,
        .optimize = optimize,
    });

    const lib = b.addLibrary(.{
        .name = "sdl_mixer",
        .version = .{
            .major = 2,
            .minor = 8,
            .patch = 1,
        },
        .linkage = linkage,
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });

    lib.addCSourceFiles(.{
        .root = upstream.path("src"),
        .files = &.{
            "SDL_mixer.c",
            "SDL_mixer_metadata_tags.c",
            "SDL_mixer_spatialization.c",
            "decoder_aiff.c",
            "decoder_au.c",
            "decoder_drflac.c",
            "decoder_drmp3.c",
            "decoder_flac.c",
            "decoder_fluidsynth.c",
            "decoder_gme.c",
            "decoder_mpg123.c",
            "decoder_opus.c",
            "decoder_raw.c",
            "decoder_sinewave.c",
            "decoder_stb_vorbis.c",
            "decoder_timidity.c",
            "decoder_voc.c",
            "decoder_vorbis.c",
            "decoder_wav.c",
            "decoder_wavpack.c",
            "decoder_xmp.c",
        },
        .flags = &.{
            "-std=c99",
        },
    });
    lib.addIncludePath(sdl.path("include"));
    lib.addIncludePath(upstream.path("include"));

    b.installArtifact(lib);
}
