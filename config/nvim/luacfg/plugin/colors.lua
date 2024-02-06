function SetupColor(color)
	color = color or "dracula"
	vim.cmd.colorscheme(color)
end

SetupColor()
