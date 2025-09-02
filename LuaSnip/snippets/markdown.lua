local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
	s("cb", {
		t("- [ ] "),
	}),

	s("cbd", {
		t("- [ ] TODO: "),
	}),
}
