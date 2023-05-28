if status is-interactive
    # Commands to run in interactive sessions can go here
end

function vi
	command nvim $argv
end

function ls
	command ls --color=auto $argv
end
