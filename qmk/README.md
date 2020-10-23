# QMK configs and build environment

`./zsa_qmk_firmware` is a submodule, containing ZSA's fork of QMK's firmware repo, which is guaranteed (supposedly) to
work cleanly with their boards.

`./keyboards` holds my own keymaps, in parallel structure to the ZSA (and QMK) repo, and will end up getting symlinked
(by `script/stow_it_all`) *into* the ZSA submodule.

This is all so that (1) I can cleanly version-contol my own keymaps, and (2) I can still update the ZSA submodule when
it changes, and (3) do so without fear of overwriting my keymaps or doing something weird with `git submodule update`
options.
