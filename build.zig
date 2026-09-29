const std = @import("std");

pub fn build(b: *std.Build) void {
    // 1. Configure the RISC-V cross-compilation target (BL618: RV32IMAFC)
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .riscv32,
        .os_tag = .freestanding,
        .abi = .none,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            .m, .a, .f, .c,
        }),
    });

    const optimize = b.standardOptimizeOption(.{
        .preferred_optimize_mode = .ReleaseSmall,
    });

    // 2. In Zig 0.16, create the module first
    const app_module = b.createModule(.{
        .root_source_file = b.path("src/run.zig"),
        .target = target,
        .optimize = optimize,
    });

    // 3. In Zig 0.16, use b.addLibrary with static linkage
    const lib = b.addLibrary(.{
        .name = "run",
        .linkage = .static,
        .root_module = app_module,
    });

    // 4. Install the generated librun.a into zig-out/lib/
    b.installArtifact(lib);
}
