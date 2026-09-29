const std = @import("std");

pub fn build(b: *std.Build) void {
    // 1. 设置 RISC-V 交叉编译目标 (BL618: RV32IMAFC)
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

    // 2. 在 0.16 中，需要先用 b.createModule 创建模块
    const app_module = b.createModule(.{
        .root_source_file = b.path("src/run.zig"),
        .target = target,
        .optimize = optimize,
    });

    // 3. 0.16 使用 b.addLibrary，并指定 linkage 为 .static
    const lib = b.addLibrary(.{
        .name = "run",
        .linkage = .static,
        .root_module = app_module,
    });

    // 4. 将生成的 libapp.a 安装到 zig-out/lib/
    b.installArtifact(lib);
}
