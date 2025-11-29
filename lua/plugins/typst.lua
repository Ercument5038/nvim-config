return {
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		version = "1.*",
		opts = {
			follow_cursor = false,
			dependencies_bin = { ["tinymist"] = "tinymist" },
		}, -- lazy.nvim will implicitly calls `setup {}`
	},
}
