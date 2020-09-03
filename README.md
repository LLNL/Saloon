# Saloon

Saloon is a Vim plugin that simplifies Python code linter / fixer configuration and usage.

Saloon's menu lets developers toggle which static analysis tools to use and delegates those changes to [ALE's](https://github.com/dense-analysis/ale) API.
Since [prospector](http://prospector.landscape.io/en/master/) already handles multiple tools, and is integrated with ALE, most of the actual linting will initially be handled via prospector calls.

## Getting Started
Not final, automated setup being developed...
- Clone this repo into ~/.vim/pack/**<PLACE_HOLDER>**/start
- In Vim run: `:helptags ~/.vim/pack/<PLACE_HOLDER>/start/saloon/doc/` to make `:help saloon` work
- NOTE: Substitute **<PLACE_HOLDER>** with your directory name

#### Dependencies
- [Vim 8](https://lc.llnl.gov/gitlab/python-vim/vim-8) compiled with **Python 3** support
- [ALE](https://github.com/dense-analysis/ale)
- [Prospector](http://prospector.landscape.io/en/master/)

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
