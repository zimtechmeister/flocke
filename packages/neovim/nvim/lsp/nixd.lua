return {
    settings = {
        nixd = {
            formatting = {
                command = { "alejandra" },
            },
            -- https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
            -- nixpkgs = {
            --     expr = "import <nixpkgs> { }",
            --     expr = 'import (builtins.getFlake "/home/tim/nixos").inputs.nixpkgs {}',
            -- },
            -- options = {
            --     --If you integrated with your system flake,
            --     --you should use inputs.self as the path to your system flake
            --     -- that way it will ALWAYS work, regardless
            --     -- of where your config actually was.
            --     nixos = {
            --         -- expr = '(builtins.getFlake "github:zimtech/nixos").nixosConfigurations.desktop.options',
            --         expr = '(builtins.getFlake "/home/tim/nixos").nixosConfigurations.desktop.options',
            --     },
            --     home_manager = {
            --         expr = '(builtins.getFlake "/home/tim/nixos").homeConfigurations.tim.options',
            --     },
            -- }
        },
    }
}
