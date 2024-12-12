"""

"""

load("//@packages/star/github.com/ninja-build/ninja/v1.12.1.star", ninja1_platforms = "platforms")
load("//@sdk/star/cmake.star", "cmake_add")

cmake_add("cmake3", "v3.30.5")

checkout.add_platform_archive(
    rule = {"name": "ninja1"},
    platforms = ninja1_platforms
)


checkout.update_asset(
    rule = {"name": "update_vscode_extensions"},
    asset = {
        "destination": ".vscode/extensions.json",
        "format": "json",
        "value": {
            "recommendations": ["llvm-vs-code-extensions.vscode-clangd", "ms-vscode.cmake-tools"],
        },
    },
)

checkout.update_asset(
    rule = {"name": "update_vscode_settings"},
    asset = {
        "destination": ".vscode/settings.json",
        "format": "json",
        "value": {
            "cmake.buildDirectory": "${workspaceFolder}/cmake_arm",
            "cmake.cmakePath": "${workspaceFolder}/sysroot/bin/cmake",
            "cmake.generator": "Ninja",
            "cmake.buildTask": True,
            "cmake.configureOnEdit": False,
            "cmake.loadCompileCommands": True,
            "cmake.useCMakePresets": "never",
            "cmake.buildEnvironment": {"PATH": "${workspaceFolder}/sysroot/bin"},
        },
    },
)

local_path = info.current_workspace_path()

checkout.add_asset(
    rule = {"name": "clang-format-config"},
    asset = {
        "destination": ".clang-format",
        "content": fs.read_file_to_string("{}/spaces_assets/clang-format".format(local_path)),
    },
)

checkout.add_asset(
    rule = {"name": "clangd-config"},
    asset = {
        "destination": ".clangd",
        "content": fs.read_file_to_string("{}/spaces_assets/clangd.json".format(local_path)),
    },
)

checkout.add_archive(
    rule = {"name": "stratifyos_arm_none_eabi"},
    archive = {
        "url": "https://github.com/StratifyLabs/SDK/releases/download/v11.3.1/stratifyos-arm-none-eabi-11.3.1.zip",
        "sha256": "d32b82768b4d6c1f106a32182b386164fccd72863c7d558b3fef129281780ac4",
        "link": "Hard",
        "add_prefix": "sysroot",
        "allow_gh_for_download": False
    },
)

sl_includes = ["sl"]
macos_sl_universal = {
    "url": "https://github.com/StratifyLabs/sl2/releases/download/v2.0/sl-macos-x86_64.zip",
    "sha256": "5c8f84c23655b6de4222bd4df72a399f3a53efc367bed5ed0db9e9320014ee92",
    "add_prefix": "sysroot/bin",
    "includes": sl_includes,
    "link": "Hard",
    "allow_gh_for_download": False
}

checkout.add_platform_archive(
    rule = {"name": "sl"},
    platforms = {
        "macos-x86_64": macos_sl_universal,
        "macos-aarch64": macos_sl_universal,
        "windows-x86_64": {
            "url": "https://github.com/StratifyLabs/sl2/releases/download/v2.0/sl-windows-x86_64.zip",
            "sha256": "5787d28ee13013cbf5d848b8cd3c115087735781375934e848fa917436031f2a",
            "add_prefix": "sysroot/bin",
            "includes": sl_includes,
            "link": "Hard",
            "allow_gh_for_download": False
        },
    },
)

bin_excludes = ["**/bin/sl"]

macos_arm_none_eabi_universal = {
    "url": "https://github.com/StratifyLabs/SDK/releases/download/v11.3.1/stratifyos-arm-none-eabi-11.3.1-macos-x86_64.zip",
    "sha256": "c58c383fdb95f538fda6bc0484f04500d2acce64d08db18f775e04b2ee3e1746",
    "add_prefix": "sysroot",
    "excludes": bin_excludes,
    "link": "Hard",
    "allow_gh_for_download": False
}

checkout.add_platform_archive(
    rule = {"name": "stratifyos_arm_none_eabi_platform", "deps": ["stratifyos_arm_none_eabi"]},
    platforms = {
        "macos-x86_64": macos_arm_none_eabi_universal,
        "macos-aarch64": macos_arm_none_eabi_universal,
        "windows-x86_64": {
            "url": "https://github.com/StratifyLabs/SDK/releases/download/v11.3.1/stratifyos-arm-none-eabi-11.3.1-windows-x86_64.zip",
            "sha256": "2b56314049456bec812405d168fd5ab62e414817bea167f10d12889ae1b2fbe5",
            "add_prefix": "sysroot",
            "excludes": bin_excludes,
            "link": "Hard",
            "allow_gh_for_download": False
        },
    },
)
