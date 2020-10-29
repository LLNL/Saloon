# Saloon

Saloon is a Vim plugin that simplifies Python code linter / fixer configuration and usage.

Saloon's menu lets developers toggle which static analysis tools to use and delegates those changes to [ALE's](https://github.com/dense-analysis/ale) API.
Since [prospector](http://prospector.landscape.io/en/master/) already handles multiple tools, and is integrated with ALE, most of the actual linting will initially be handled via prospector calls.

## Getting Started
Assuming this is run on *nix / macOS, create the path to install your plugins. Skip if already done.
1. `mkdir -p ~/.vim/pack/git_plugins/start/` Vim 8 packages live here. NOTE: **git_plugins** is an example and can be any arbitrary name.
2. Clone this repo into ~/.vim/pack/git_plugins/start/
3. In Vim run: `:helptags ~/.vim/pack/git_plugins/start/saloon/doc/` to make `:help saloon` work
4. Install Dependencies below.

#### Dependencies
Vim 8 compiled with **Python 3** support
- Make sure you have Vim 8 compiled with Python 3 support. `vim --version | grep python3` then look for `+python3` or `+python3/dyn`.

[ALE](https://github.com/dense-analysis/ale) (Asynchronous Lint Engine)
- git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git_plugins/start/ale
- vim -U NONE --cmd "helptags ~/.vim/pack/git_plugins/start/ale/doc/"  (for ALE documentation)

[Prospector](http://prospector.landscape.io/en/master/) with **recommended approach:**
- `pipenv install prospector[with_everything]`
- `pipenv install prospector\[with_everything\]  # for zsh users`

## Getting Involved
TBD

## Contributing
TBD

## Authors

The original developer of Saloon is:

  * David Bloss (bloss1@llnl.gov)

## License

Saloon is release under the BSD 3-Clause License, (BSD-3-Clause or https://opensource.org/licenses/BSD-3-Clause).
See the LICENSE and NOTICE files for more details.

Copyrights and patents in the Saloon project are retained by contributors.
No copyright assignment is required to contribute to Saloon.

See [LICENSE](./LICENSE) for details.

SPDX-License-Identifier: BSD-3-Clause

LLNL-CODE-XXXXXX

## SPDX usage

Individual files contain SPDX tags instead of the full license text.
This enables machine processing of license information based on the SPDX
License Identifiers that are available here: https://spdx.org/licenses/

Files that are licensed as BSD 3-Clause contain the following
text in the license header:

    SPDX-License-Identifier: (BSD-3-Clause)
