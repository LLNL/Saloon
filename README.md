# Saloon

Saloon is the Vim plugin that eases Python code linter / fixer configuration all from the comfort of a sidebar.

Saloon's menu lets developers toggle which static analysis tools to use and delegates those changes to [ALE's](https://github.com/dense-analysis/ale) API.
Since [prospector](http://prospector.landscape.io/en/master/) already handles multiple tools, and knows what to do with ALE, most of the actual linting will be done through prospector calls.

## Installation
- Clone this repo into ~/.vim/pack/**<PLACE_HOLDER>**/start
- In Vim run: `:helptags ~/.vim/pack/<PLACE_HOLDER>/start/saloon/doc/` to make `:help saloon` work
- NOTE: Substitute **<PLACE_HOLDER>** with your directory name

## Dependencies
- [Vim 8](https://lc.llnl.gov/gitlab/python-vim/vim-8) compiled with **Python 3** support
- [ALE](https://github.com/dense-analysis/ale)
- [Prospector](http://prospector.landscape.io/en/master/)