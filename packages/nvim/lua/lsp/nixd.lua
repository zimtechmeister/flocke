return {
    settings = {
        nixd = {
            formatting = {
                -- command = { "nix", "fmt", "--quiet", "--" },
                command = { "alejandra" },
            },
        },
    }
}
