# git-makefile 1

## NAME

git-makefile -- Copy a language-specifc Makefile into a project

## SYNOPSIS

`git makefile` [OPTIONS]

## DESCRIPTION

Copy a Makefile in `$HOME/.local/share/git-hooks-and-extensions/makefile`
into the git project directory.

## OPTIONS

`-d`, `--dir` <path>
    Path to git repository (default: current directory)

## EXAMPLES

Add a Makefile to the current repository (defaults to `Go`):
    `git makefile`

Add a Makefile to a specific repository:
    `git makefile --dir $HOME/projects/foo --lang c`

## AUTHOR

Benjamin Toll ben@benjamintoll.com
