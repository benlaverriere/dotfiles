" Vimball Archiver by Charles E. Campbell
UseVimball
finish
doc/localvimrc.txt	[[[1
671
*localvimrc*  Localvimrc

===============================================================================
Contents ~

 1. Introduction                                      |localvimrc-introduction|
 2. Commands                                              |localvimrc-commands|
  1. The |LocalVimRC| command
  2. The |LocalVimRCClear| command
  3. The |LocalVimRCCleanup| command
  4. The |LocalVimRCForget| command
  5. The |LocalVimRCEdit| command
  6. The |LocalVimRCEnable| command
  7. The |LocalVimRCDisable| command
  8. The |LocalVimRCDebugShow| command
 3. Functions                                            |localvimrc-functions|
  1. The |LocalVimRCFinish| function
 4. Variables                                            |localvimrc-variables|
  1. The |g:localvimrc_file| variable
  2. The |g:localvimrc_file_dir| variable
  3. The |g:localvimrc_script| variable
  4. The |g:localvimrc_script_dir| variable
  5. The |g:localvimrc_script_unresolved| variable
  6. The |g:localvimrc_script_dir_unresolved| variable
  7. The |g:localvimrc_sourced_once| variable
  8. The |g:localvimrc_sourced_once_for_file| setting
 5. Settings                                              |localvimrc-settings|
  1. The |g:localvimrc_enable| setting
  2. The |g:localvimrc_name| setting
  3. The |g:localvimrc_event| setting
  4. The |g:localvimrc_event_pattern| setting
  5. The |g:localvimrc_reverse| setting
  6. The |g:localvimrc_count| setting
  7. The |g:localvimrc_file_directory_only| setting
  8. The |g:localvimrc_sandbox| setting
  9. The |g:localvimrc_ask| setting
  10. The |g:localvimrc_persistent| setting
  11. The |g:localvimrc_persistence_file| setting
  12. The |g:localvimrc_whitelist| setting
  13. The |g:localvimrc_blacklist| setting
  14. The |g:localvimrc_autocmd| setting
  15. The |g:localvimrc_python2_enable| setting
  16. The |g:localvimrc_python3_enable| setting
  17. The |g:localvimrc_debug| setting
  18. The |g:localvimrc_debug_lines| setting
 6. Autocommands                                      |localvimrc-autocommands|
  1. The |LocalVimRCPre| autocommand
  2. The |LocalVimRCPost| autocommand
 7. Frequently Asked Questions          |localvimrc-frequently-asked-questions|
  1. modeline settings are overwritten by local vimrc |localvimrc-modeline-settings-are-overwritten-by-local-vimrc|
 8. Contribute                                          |localvimrc-contribute|
 9. Credits                                                |localvimrc-credits|
 10. Changelog                                           |localvimrc-changelog|
 11. References                                         |localvimrc-references|

===============================================================================
                                                      *localvimrc-introduction*
Introduction ~

This plugin searches for local vimrc files in the file system tree of the
currently opened file. It searches for all ".lvimrc" files from the directory
of the file up to the root directory. By default those files are loaded in
order from the root directory to the directory of the file. The filename and
amount of loaded files are customizable through global variables.

For security reasons it the plugin asks for confirmation before loading a local
vimrc file and loads it using |:sandbox| command. The plugin asks once per
session and local vimrc before loading it, if the file didn't change since
previous loading.

It is possible to define a whitelist and a blacklist of local vimrc files that
are loaded or ignored unconditionally.

The plugin can be found on Bitbucket [1], GitHub [2] and VIM online [3].

===============================================================================
                                                          *localvimrc-commands*
Commands ~

-------------------------------------------------------------------------------
The *LocalVimRC* command

Resource all local vimrc files for the current buffer.

-------------------------------------------------------------------------------
The *LocalVimRCClear* command

Clear all stored decisions made in the past, when the plugin asked about
sourcing a local vimrc file.

-------------------------------------------------------------------------------
The *LocalVimRCCleanup* command

Remove all stored decisions for local vimrc files that no longer exist.

-------------------------------------------------------------------------------
The *LocalVimRCForget* command

Remove stored decisions for given local vimrc files.

-------------------------------------------------------------------------------
The *LocalVimRCEdit* command

Open the local vimrc file for the current buffer in an split window for
editing. If more than one local vimrc file has been sourced, the user can
decide which file to edit.

-------------------------------------------------------------------------------
The *LocalVimRCEnable* command

Globally enable the loading of local vimrc files if loading has been disabled
by |LocalVimRCDisable| or by setting |g:localvimrc_enable| to '0' during
startup.

Enabling local vimrc using this command will trigger loading of local vimrc
files for the currently active buffer. It will _not_ load the local vimrc files
for any other buffer. This will be done by an autocommand later when another
buffer gets active and the configured |g:localvimrc_event| autocommand gets
active. This is the case for the default |BufWinEnter|.

-------------------------------------------------------------------------------
The *LocalVimRCDisable* command

Globally disable the loading of local vimrc files if loading has been disabled
by |LocalVimRCEnable| or by setting |g:localvimrc_enable| to '1' during
startup.

-------------------------------------------------------------------------------
The *LocalVimRCDebugShow* command

Show all stored debugging messages. To see any message with this command
debugging needs to be enabled with |g:localvimrc_debug|. The number of messages
stored and printed can be limited using the setting |g:localvimrc_debug_lines|.

===============================================================================
                                                         *localvimrc-functions*
Functions ~

-------------------------------------------------------------------------------
The *LocalVimRCFinish* function

After a call to this function the sourcing of any remaining local vimrc files
will be skipped. In combination with the |g:localvimrc_reverse| option it is
possible to end the processing of local vimrc files for example at the root of
the project by adding the following command to the local vimrc file in the root
of the project:
>
  call LocalVimRCFinish()
<
===============================================================================
                                                         *localvimrc-variables*
Variables ~

The plugin provides several convenience variables to make it easier to set up
path dependent setting like for example makeprg. These variables are only
available inside your local vimrc file because they are only unambiguous there.

Adding the following lines to a local vimrc in the root directory of a project
modify the behavior of |:make| to change into a build directory and call make
there:
>
  let &l:makeprg="cd ".g:localvimrc_script_dir_unresolved."/build && make"
<
**NOTE:**

This is only possible if you disable sandbox mode.

Other variables provide a way to prevent multiple execution of commands. They
can be used to implement guards:
>
  " do stuff you want to do on every buffer enter event
  
  " guard to end loading if it has been loaded for the currently edited file
  if g:localvimrc_sourced_once_for_file
    finish
  endif
  
  " do stuff you want to do only once for a edited file
  
  " guard to end loading if it has been loaded for the running vim instance
  if g:localvimrc_sourced_once
    finish
  endif
  
  " do stuff you want to do only once for a running vim instance
<
-------------------------------------------------------------------------------
The *g:localvimrc_file* variable

Fully qualified file name of file that triggered loading the local vimrc file.

-------------------------------------------------------------------------------
The *g:localvimrc_file_dir* variable

Fully qualified directory of file that triggered loading the local vimrc file.

-------------------------------------------------------------------------------
The *g:localvimrc_script* variable

Fully qualified and resolved file name of the currently loaded local vimrc
file.

-------------------------------------------------------------------------------
The *g:localvimrc_script_dir* variable

Fully qualified and resolved directory of the currently loaded local vimrc
file.

-------------------------------------------------------------------------------
The *g:localvimrc_script_unresolved* variable

Fully qualified but unresolved file name of the currently loaded local vimrc
file.

-------------------------------------------------------------------------------
The *g:localvimrc_script_dir_unresolved* variable

Fully qualified but unresolved directory of the currently loaded local vimrc
file.

-------------------------------------------------------------------------------
The *g:localvimrc_sourced_once* variable

Set to '1' if the currently loaded local vimrc file had already been loaded in
this session. Set to '0' otherwise.

-------------------------------------------------------------------------------
The *g:localvimrc_sourced_once_for_file* setting

Set to '1' if the currently loaded local vimrc file had already been loaded in
this session for the currently edited file. Set to '0' otherwise.

===============================================================================
                                                          *localvimrc-settings*
Settings ~

To change settings from their default add similar line to your global |vimrc|
file.
>
  let g:option_name=option_value
<
-------------------------------------------------------------------------------
The *g:localvimrc_enable* setting

Globally enable/disable loading of local vimrc files globally. The behavior can
be changed during runtime using the commands |LocalVimRCEnable| and
|LocalVimRCDisable|.

- Value '0': Disable loading of any local vimrc files.
- Value '1': Enable loading of local vimrc files.
- Default: '1'

-------------------------------------------------------------------------------
The *g:localvimrc_name* setting

List of filenames of local vimrc files. The given name can include a directory
name such as ".config/localvimrc".

Previous versions of localvimrc only supported a single file as string. This is
still supported for backward compatibility.

- Default: '[ ".lvimrc" ]'

-------------------------------------------------------------------------------
The *g:localvimrc_event* setting

List of autocommand events that trigger local vimrc file loading.

- Default: '[ "BufWinEnter" ]'

For more information see |autocmd-events|.

**NOTE:**

BufWinEnter is the default to enable lines like
>
  setlocal colorcolumn=+1
<
in the local vimrc file. Settings "local to window" need to be set for every
time a buffer is displayed in a window.

-------------------------------------------------------------------------------
The *g:localvimrc_event_pattern* setting

String defining the pattern for which the autocommand events trigger local
vimrc file loading.

- Default: '"*"'

For more information see |autocmd-patterns|.

-------------------------------------------------------------------------------
The *g:localvimrc_reverse* setting

Reverse behavior of loading local vimrc files.

- Value '0': Load files in order from root directory to directory of the
  file.

- Value '1': Load files in order from directory of the file to root
  directory.

- Default: '0'

-------------------------------------------------------------------------------
The *g:localvimrc_count* setting

On the way from root, the last localvimrc_count files are sourced.

**NOTE:**

This might load files not located in the edited files directory or even not
located in the projects directory. If this is of concern use the
|g:localvimrc_file_directory_only| setting.

- Default: '-1' (all)

-------------------------------------------------------------------------------
The *g:localvimrc_file_directory_only* setting

Just use local vimrc file located in the edited files directory.

**NOTE:**

This might end in not loading any local vimrc files at all. If limiting the
number of loaded local vimrc files is of concern use the |g:localvimrc_count|
setting.

- Value '0': Load all local vimrc files in the tree from root to file.
- Value '1': Load only file in the same directory as edited file.
- Default: '0'

-------------------------------------------------------------------------------
The *g:localvimrc_sandbox* setting

Source the found local vimrc files in a sandbox for security reasons.

- Value '0': Don't load vimrc file in a sandbox.
- Value '1': Load vimrc file in a sandbox.
- Default: '1'

-------------------------------------------------------------------------------
The *g:localvimrc_ask* setting

Ask before sourcing any local vimrc file. In a vim session the question is only
asked once as long as the local vimrc file has not been changed.

- Value '0': Don't ask before loading a vimrc file.
- Value '1': Ask before loading a vimrc file.
- Default: '1'

-------------------------------------------------------------------------------
The *g:localvimrc_persistent* setting

Make the decisions given when asked before sourcing local vimrc files
persistent over multiple vim runs and instances. The decisions are written to
the file defined by and |g:localvimrc_persistence_file|.

- Value '0': Don't store and restore any decisions.
- Value '1': Store and restore decisions only if the answer was given in
  upper case (Y/N/A).
- Value '2': Store and restore all decisions.
- Default: '0'

-------------------------------------------------------------------------------
The *g:localvimrc_persistence_file* setting

Filename used for storing persistent decisions made when asked before sourcing
local vimrc files.

- Default (_Unix_): "$HOME/.localvimrc_persistent"
- Default (_Windows_): "$HOME/_localvimrc_persistent"

-------------------------------------------------------------------------------
The *g:localvimrc_whitelist* setting

If a local vimrc file matches the regular expression given by
|g:localvimrc_whitelist| this file is loaded unconditionally.

Files matching |g:localvimrc_whitelist| are sourced even if they are matched by
|g:localvimrc_blacklist|.

See |regular-expression| for patterns that are accepted.

Example:
>
  " whitelist all local vimrc files in users project foo and bar
  let g:localvimrc_whitelist='/home/user/projects/\(foo\|bar\)/.*'
  
  " whitelist can also use lists of patterns
  let g:localvimrc_whitelist=['/home/user/project1/', '/opt/project2/', '/usr/local/projects/vim-[^/]*/']
<
- Default: No whitelist

-------------------------------------------------------------------------------
The *g:localvimrc_blacklist* setting

If a local vimrc file matches the regular expression given by
|g:localvimrc_blacklist| this file is skipped unconditionally.

Files matching |g:localvimrc_whitelist| are sourced even if they are matched by
|g:localvimrc_blacklist|.

See |regular-expression| for patterns that are accepted.

Example:
>
  " blacklist all local vimrc files in shared project directory
  let g:localvimrc_blacklist='/share/projects/.*'
  
  " blacklist can also use lists of patterns
  let g:localvimrc_blacklist=['/share/projects/.*', '/usr/share/other-projects/.*']
<
- Default: No blacklist

-------------------------------------------------------------------------------
The *g:localvimrc_autocmd* setting

Emit autocommands |LocalVimRCPre| before and |LocalVimRCPost| after sourcing
every local vimrc file.

- Default: '1'

-------------------------------------------------------------------------------
The *g:localvimrc_python2_enable* setting

Enable probing whether python 2 is available and usable for calculating local
vimrc file checksums, in case |sha256()| is not available.

- Default: '1'

-------------------------------------------------------------------------------
The *g:localvimrc_python3_enable* setting

Enable probing whether python 3 is available and usable for calculating local
vimrc file checksums, in case |sha256()| is not available.

- Default: '1'

-------------------------------------------------------------------------------
The *g:localvimrc_debug* setting

Debug level for this script. The messages can be shown with
|LocalVimRCDebugShow|.

- Default: '0'

-------------------------------------------------------------------------------
The *g:localvimrc_debug_lines* setting

Limit for the number of debug messages stored. The messages can be shown with
|LocalVimRCDebugShow|.

- Default: '100'

===============================================================================
                                                      *localvimrc-autocommands*
Autocommands ~

If enabled localvimrc emits autocommands before and after sourcing a local
vimrc file. The autocommands are emitted as |User| events. Because of that
commands need to be registered in the following way:
>
  autocmd User LocalVimRCPre  echom 'before loading local vimrc'
  autocmd User LocalVimRCPost echom 'after loading local vimrc'
<
-------------------------------------------------------------------------------
The *LocalVimRCPre* autocommand

This autocommand is emitted right before sourcing each local vimrc file.

-------------------------------------------------------------------------------
The *LocalVimRCPost* autocommand

This autocommands is emitted right after sourcing each local vimrc file.

===============================================================================
                                        *localvimrc-frequently-asked-questions*
Frequently Asked Questions ~

-------------------------------------------------------------------------------
                  *localvimrc-modeline-settings-are-overwritten-by-local-vimrc*
modeline settings are overwritten by local vimrc ~

Depending on the |g:localvimrc_event| that is used to trigger loading local
vimrc files it is possible that |modeline| already had been parsed. This might
be cause problems. If for example there is 'set ts=8 sts=4 sw=4 et' in the
local vimrc and a Makefile contains '# vim: ts=4 sts=0 sw=4 noet' this modeline
will not get applied with default settings of localvimrc. There are two
possibilities to solve this.

The first solution is to use |BufRead| as value for |g:localvimrc_event|. This
event is emitted by Vim before modelines are processed.

The second solution is to move all those settings to the local vimrc file and
use different settings depending on the |filetype|:
>
  if &ft == "make"
    setl ts=4 sts=0 sw=4 noet
  else
    setl ts=8 sts=4 sw=4 et
  endif
<
===============================================================================
                                                        *localvimrc-contribute*
Contribute ~

To contact the author (Markus Braun), please send an email to
markus.braun@krawel.de

If you think this plugin could be improved, fork on Bitbucket [1] or GitHub [2]
and send a pull request or just tell me your ideas.

If you encounter a bug please enable debugging, export debugging messages to a
file and create a bug report either on Bitbucket [1] or GitHub [2]. Debug
messages can be enabled temporary and exported to a file called
'localvimrc_debug.txt' on command line with the following command:
>
  vim --cmd "let g:localvimrc_debug=99" -c "redir! > localvimrc_debug.txt" -c "LocalVimRCDebugShow" -c "redir END" your_file
<
===============================================================================
                                                           *localvimrc-credits*
Credits ~

- Simon Howard for his hint about "sandbox"
- Mark Weber for the idea of using checksums
- Daniel Hahler for various patches
- Justin M. Keyes for ideas to improve this plugin
- Lars Winderling for whitelist/blacklist patch
- Michon van Dooren for autocommands patch
- Benoit de Chezell for fix with nested execution

===============================================================================
                                                         *localvimrc-changelog*
Changelog ~

v3.1.0 : 2020-05-20

- add option to disable probing od Python versions
- prevent recursive sourcing of local vimrc files
- better handling of syntax errors in sourced local vimrc files

v3.0.1 : 2018-08-21

- fix a compatibility issue with unavailable |v:true| and |v:false| in Vim
  version 7.4

v3.0.0 : 2018-08-14

- use SHA256 as for calculating checksums and use FNV-1 as fallback.
- add command |LocalVimRCCleanup| to remove all unusable persistence data.
- add command |LocalVimRCForget| to remove persistence data for given files.
- add command |LocalVimRCDebugShow| to show debug messages.
- add setting |g:localvimrc_debug_lines| to limit the number of stored debug
  messages.

v2.7.0 : 2018-03-19

- add setting |g:localvimrc_enable| and commands |LocalVimRCEnable| and
  |LocalVimRCDisable| to globally disable processing of local vimrc files.

- add setting |g:localvimrc_event_pattern| to change the pattern for which
  the autocommand is executed.

v2.6.1 : 2018-02-20

- fix a bug with missing uniq() in Vim version 7.4

v2.6.0 : 2018-01-22

- add command |LocalVimRCEdit| to edit sourced local vimrc files for the
  current buffer.

v2.5.0 : 2017-03-08

- add unit tests.

- settings |g:localvimrc_whitelist| and |g:localvimrc_blacklist| now takes
  optionally a list of regular expressions.

- add convenience variables |g:localvimrc_script_unresolved| and
  |g:localvimrc_script_dir_unresolved|.

- add ability to view local vimrc before sourcing when |g:localvimrc_ask| is
  enabled.

- emit autocommands before and after sourcing files.

- add |g:localvimrc_file_directory_only| to limit sourcing to local vimrc
  files in the same directory as the edited file.

- add |LocalVimRCFinish| function to stop loading of remaining local vimrc
  files from within a local vimrc file.

v2.4.0 : 2016-02-05

- add setting |g:localvimrc_event| which defines the autocommand events that
  trigger local vimrc file loading.

- don't lose persistence file on full partitions.

- make it possible to supply a list of local vimrc filenames in
  |g:localvimrc_name|.

- ask user when sourcing local vimrc fails and |g:localvimrc_sandbox| and
  |g:localvimrc_ask| is set whether the file should be sourced without
  sandbox.

- fix a bug where local vimrc files are sourced in wrong order when some of
  them are symlinks to a different directory.

v2.3.0 : 2014-02-06

- private persistence file to enable persistence over concurrent vim
  instances.

- add convenience variables |g:localvimrc_sourced_once| and
  |g:localvimrc_sourced_once_for_file|.

v2.2.0 : 2013-11-09

- remove redraw calls for better performance and fixing a bug on windows.
- load local vimrc on event BufWinEnter to fix a bug with window local
  settings.
- add |g:localvimrc_reverse| to change order of sourcing local vimrc files.
- add convenience variables |g:localvimrc_file|, |g:localvimrc_file_dir|,
  |g:localvimrc_script| and |g:localvimrc_script_dir|.

v2.1.0 : 2012-09-25

- add possibility to make decisions persistent.
- use full file path when storing decisions.

v2.0.0 : 2012-04-05

- added |g:localvimrc_whitelist| and |g:localvimrc_blacklist| settings.
- ask only once per session and local vimrc before loading it, if it didn't
  change.

v2758 : 2009-05-11

- source .lvimrc in a sandbox to better maintain security, configurable using
  |g:localvimrc_sandbox|.

- ask user before sourcing any local vimrc file, configurable using
  |g:localvimrc_ask|.

v1870 : 2007-09-28

- new configuration variable |g:localvimrc_name| to change filename.
- new configuration variable |g:localvimrc_count| to limit number of loaded
  files.

v1613 : 2007-04-05

- switched to arrays in vim 7.
- escape file/path names correctly.

v1.2 : 2002-10-09

- initial version

===============================================================================
                                                        *localvimrc-references*
References ~

[1] https://bitbucket.org/embear/localvimrc
[2] https://github.com/embear/vim-localvimrc
[3] http://www.vim.org/scripts/script.php?script_id=441

vim: ft=help
plugin/localvimrc.vim	[[[1
1117
" Name:    localvimrc.vim
" Version: 3.1.0
" Author:  Markus Braun <markus.braun@krawel.de>
" Summary: Vim plugin to search local vimrc files and load them.
" Licence: This program is free software: you can redistribute it and/or modify
"          it under the terms of the GNU General Public License as published by
"          the Free Software Foundation, either version 3 of the License, or
"          (at your option) any later version.
"
"          This program is distributed in the hope that it will be useful,
"          but WITHOUT ANY WARRANTY; without even the implied warranty of
"          MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"          GNU General Public License for more details.
"
"          You should have received a copy of the GNU General Public License
"          along with this program.  If not, see <http://www.gnu.org/licenses/>.
"
" Section: Plugin header {{{1

" guard against multiple loads {{{2
if (exists("g:loaded_localvimrc") || &cp)
  finish
endif
let g:loaded_localvimrc = 1

" check for correct vim version {{{2
if version < 702
  finish
endif

" Section: Default settings {{{1

" define default "localvimrc_enable" {{{2
let s:localvimrc_enable = 1
if (exists("g:localvimrc_enable") && type(g:localvimrc_enable) == type(0))
  let s:localvimrc_enable = g:localvimrc_enable
endif

" define default "localvimrc_name" {{{2
" copy to script local variable to prevent .lvimrc modifying the name option.
let s:localvimrc_name = [ ".lvimrc" ]
if (exists("g:localvimrc_name"))
  if type(g:localvimrc_name) == type("")
    let s:localvimrc_name = [ g:localvimrc_name ]
  elseif type(g:localvimrc_name) == type([])
    let s:localvimrc_name = g:localvimrc_name
  endif
endif

" define default "localvimrc_event" {{{2
" copy to script local variable to prevent .lvimrc modifying the event option.
let s:localvimrc_event = [ "BufWinEnter" ]
if (exists("g:localvimrc_event") && type(g:localvimrc_event) == type([]))
  let s:localvimrc_event = g:localvimrc_event
endif

" define default "localvimrc_event_pattern" {{{2
" copy to script local variable to prevent .lvimrc modifying the event pattern
" option.
let s:localvimrc_event_pattern = "*"
if (exists("g:localvimrc_event_pattern") && type(g:localvimrc_event_pattern) == type(""))
  let s:localvimrc_event_pattern = g:localvimrc_event_pattern
endif

" define default "localvimrc_reverse" {{{2
" copy to script local variable to prevent .lvimrc modifying the reverse option.
let s:localvimrc_reverse = 0
if (exists("g:localvimrc_reverse") && type(g:localvimrc_reverse) == type(0))
  let s:localvimrc_reverse = g:localvimrc_reverse
endif

" define default "localvimrc_count" {{{2
" copy to script local variable to prevent .lvimrc modifying the count option.
let s:localvimrc_count = -1
if (exists("g:localvimrc_count") && type(g:localvimrc_count) == type(0))
  let s:localvimrc_count = g:localvimrc_count
endif

" define default "localvimrc_file_directory_only" {{{2
" copy to script local variable to prevent .lvimrc modifying the file
" directory only option.
let s:localvimrc_file_directory_only = 0
if (exists("g:localvimrc_file_directory_only") && type(g:localvimrc_file_directory_only) == type(0))
  let s:localvimrc_file_directory_only = g:localvimrc_file_directory_only
endif

" define default "localvimrc_sandbox" {{{2
" copy to script local variable to prevent .lvimrc disabling the sandbox again.
let s:localvimrc_sandbox = 1
if (exists("g:localvimrc_sandbox") && type(g:localvimrc_sandbox) == type(0))
  let s:localvimrc_sandbox = g:localvimrc_sandbox
endif

" define default "localvimrc_ask" {{{2
" copy to script local variable to prevent .lvimrc modifying the ask option.
let s:localvimrc_ask = 1
if (exists("g:localvimrc_ask") && type(g:localvimrc_ask) == type(0))
  let s:localvimrc_ask = g:localvimrc_ask
endif

" define default "localvimrc_whitelist" {{{2
" copy to script local variable to prevent .lvimrc modifying the whitelist.
let s:localvimrc_whitelist = [ "^$" ] " this never matches a file
if (exists("g:localvimrc_whitelist"))
  if type(g:localvimrc_whitelist) == type("")
    let s:localvimrc_whitelist = [ g:localvimrc_whitelist ]
  elseif type(g:localvimrc_whitelist) == type([])
    let s:localvimrc_whitelist = g:localvimrc_whitelist
  endif
endif

" define default "localvimrc_blacklist" {{{2
" copy to script local variable to prevent .lvimrc modifying the blacklist.
let s:localvimrc_blacklist = [ "^$" ] " this never matches a file
if (exists("g:localvimrc_blacklist"))
  if type(g:localvimrc_blacklist) == type("")
    let s:localvimrc_blacklist = [ g:localvimrc_blacklist ]
  elseif type(g:localvimrc_blacklist) == type([])
    let s:localvimrc_blacklist = g:localvimrc_blacklist
  endif
endif

" define default "localvimrc_persistent" {{{2
" copy to script local variable to prevent .lvimrc modifying the persistent
" option.
let s:localvimrc_persistent = 0
if (exists("g:localvimrc_persistent") && type(g:localvimrc_persistent) == type(0))
  let s:localvimrc_persistent = g:localvimrc_persistent
endif

" define default "localvimrc_persistence_file" {{{2
" copy to script local variable to prevent .lvimrc modifying the persistence
" file.
if has("win16") || has("win32") || has("win64") || has("win95")
  let s:localvimrc_persistence_file = expand('$HOME') . "/_localvimrc_persistent"
else
  let s:localvimrc_persistence_file = expand('$HOME') . "/.localvimrc_persistent"
endif
if (exists("g:localvimrc_persistence_file") && type(g:localvimrc_persistence_file) == type(""))
  let s:localvimrc_persistence_file = g:localvimrc_persistence_file
endif

" define default "localvimrc_autocmd" {{{2
" copy to script local variable to prevent .lvimrc modifying the autocommand
" option.
let s:localvimrc_autocmd = 1
if (exists("g:localvimrc_autocmd") && type(g:localvimrc_autocmd) == type(0))
  let s:localvimrc_autocmd = g:localvimrc_autocmd
endif

" define default "localvimrc_python2_enable" {{{2
" copy to script local variable to prevent .lvimrc modifying the enable
" option.
let s:localvimrc_python2_enable = 1
if (exists("g:localvimrc_python2_enable") && type(g:localvimrc_python2_enable) == type(0))
  let s:localvimrc_python2_enable = g:localvimrc_python2_enable
endif

" define default "localvimrc_python3_enable" {{{2
" copy to script local variable to prevent .lvimrc modifying the enable
" option.
let s:localvimrc_python3_enable = 1
if (exists("g:localvimrc_python3_enable") && type(g:localvimrc_python3_enable) == type(0))
  let s:localvimrc_python3_enable = g:localvimrc_python3_enable
endif

" define default "localvimrc_debug" {{{2
if (!exists("g:localvimrc_debug"))
  let g:localvimrc_debug = 0
endif

" define default "localvimrc_debug_lines" {{{2
" this defines the number of debug messages kept in a buffer
let s:localvimrc_debug_lines = 100
if (exists("g:localvimrc_debug_lines"))
  let s:localvimrc_debug_lines = g:localvimrc_debug_lines
endif

" Section: Autocmd setup {{{1

if has("autocmd")
  augroup localvimrc
    autocmd!

    for event in s:localvimrc_event
      " call s:LocalVimRC() when event occurs
      exec "autocmd ".event." ".s:localvimrc_event_pattern." call s:LocalVimRCDebug(1, 'autocommand triggered on event ".event."')|call s:LocalVimRC()"
    endfor
  augroup END
endif

" Section: Functions {{{1

" Function: s:LocalVimRCSourceScript() {{{2
"
" actually source script file and prevent nested local vimrc triggers by
" setting a guard variable.
"
function! s:LocalVimRCSourceScript(script_path, sandbox)
  let l:command = "source " . fnameescape(a:script_path)

  if a:sandbox == 1
    let l:command = "sandbox " . l:command
  endif

  try
    " prevent nested sourcing possibly triggered by content of sourced script by
    " setting a guard variable
    let s:localvimrc_running = 1

    " execute the command sourcing the local vimrc file
    call s:LocalVimRCDebug(1, "sourcing script, command is: \"" . l:command . "\"")
    exec l:command
  catch /^Vim\%((\a\+)\)\=:E48:/
    " catch sandbox exception and throw special "sandbox" exception that
    " is handled by calling function
    call s:LocalVimRCDebug(1, "sandbox error when sourcing script: \"" . v:exception . "\" (" . v:throwpoint . ")")
    throw "sandbox"
  catch
    " catch all other errors to prevent bad behavior when sourced script
    " contains a syntax error.
    call s:LocalVimRCError("error when sourcing script: \"" . v:exception . "\" (" . v:throwpoint . ")")
  finally
    " release the guard variable
    let s:localvimrc_running = 0
  endtry
endf

" Function: s:LocalVimRC() {{{2
"
" search all local vimrc files from current directory up to root directory and
" source them in reverse order.
"
function! s:LocalVimRC()
  " begin marker
  call s:LocalVimRCDebug(1, "== START LocalVimRC() ============================")

  " finish immediately if localvimrc is disabled
  if s:localvimrc_enable == 0
    call s:LocalVimRCDebug(1, "== END LocalVimRC() (disabled) ===================")
    return
  endif

  " finish immediately if we are being called recursively
  if s:localvimrc_running == 1
    call s:LocalVimRCDebug(1, "== END LocalVimRC() (already running) ============")
    return
  endif

  call s:LocalVimRCDebug(1, "running for file \"" .  fnameescape(expand("%:p")) . "\"")

  " read persistent information
  call s:LocalVimRCReadPersistent()

  " only consider normal buffers (skip especially CommandT's GoToFile buffer)
  " NOTE: in general the buftype is not set for new buffers (BufWinEnter),
  "       e.g. for help files via plugins (pydoc)
  if !empty(&buftype)
    call s:LocalVimRCDebug(1, "not a normal buffer, exiting")
    return
  endif

  " directory of current file (correctly escaped)
  let l:directory = fnameescape(expand("%:p:h"))
  if empty(l:directory)
    let l:directory = fnameescape(getcwd())
  endif
  call s:LocalVimRCDebug(2, "searching directory \"" . l:directory . "\"")

  " check if the local vimrc file shall be searched just in the files
  " directory or in the whole tree
  if s:localvimrc_file_directory_only == 1
    let l:search_option = ""
  else
    let l:search_option = ";"
  endif

  " generate a list of all local vimrc files with absolute file names along path to root
  let l:rcfiles = []
  for l:rcname in s:localvimrc_name
    for l:rcfile in findfile(l:rcname, l:directory . l:search_option, -1)
      let l:rcfile_unresolved = fnamemodify(l:rcfile, ":p")
      let l:rcfile_resolved = resolve(l:rcfile_unresolved)
      call insert(l:rcfiles, { "resolved": l:rcfile_resolved, "unresolved": l:rcfile_unresolved } )
    endfor
  endfor
  call s:LocalVimRCDebug(1, "found files: " . string(l:rcfiles))

  " shrink list of found files
  if (s:localvimrc_count >= 0 && s:localvimrc_count < len(l:rcfiles))
    call remove(l:rcfiles, 0, len(l:rcfiles) - s:localvimrc_count - 1)
  endif

  " reverse order of found files if reverse loading is requested
  if (s:localvimrc_reverse != 0)
    call reverse(l:rcfiles)
  endif

  call s:LocalVimRCDebug(1, "candidate files: " . string(l:rcfiles))

  " source all found local vimrc files in l:rcfiles variable
  let s:localvimrc_finish = 0
  let l:answer = ""
  let l:sandbox_answer = ""
  let l:sourced_files = []
  for l:rcfile_dict in l:rcfiles
    " get values from dictionary
    let l:rcfile = l:rcfile_dict["resolved"]
    let l:rcfile_unresolved = l:rcfile_dict["unresolved"]
    call s:LocalVimRCDebug(2, "processing \"" . l:rcfile . "\"")

    let l:rcfile_load = "unknown"

    if filereadable(l:rcfile)
      " extract information
      if has_key(s:localvimrc_data, l:rcfile)
        if len(s:localvimrc_data[l:rcfile]) == 2
          let [ l:stored_answer, l:stored_checksum ] = s:localvimrc_data[l:rcfile]
          let l:stored_sandbox_answer = ""
        elseif len(s:localvimrc_data[l:rcfile]) == 3
          let [ l:stored_answer, l:stored_sandbox_answer, l:stored_checksum ] = s:localvimrc_data[l:rcfile]
        else
          let l:stored_answer = ""
          let l:stored_sandbox_answer = ""
          let l:stored_checksum = ""
        endif
      else
        let l:stored_answer = ""
        let l:stored_sandbox_answer = ""
        let l:stored_checksum = ""
      endif
      call s:LocalVimRCDebug(3, "stored information: answer = '" . l:stored_answer . "' sandbox answer = '" . l:stored_sandbox_answer . "' checksum = '" . l:stored_checksum . "'")

      " check if checksum is the same
      let l:checksum_is_same = s:LocalVimRCCheckChecksum(l:rcfile, l:stored_checksum)

      " reset answers if checksum changed
      if (!l:checksum_is_same)
        call s:LocalVimRCDebug(2, "checksum mismatch, not reusing answer")
        let l:stored_answer = ""
        let l:stored_sandbox_answer = ""
      else
        call s:LocalVimRCDebug(2, "reuse previous answer = '" . l:stored_answer . "' sandbox answer = '" . l:stored_sandbox_answer . "'")
      endif

      " check if whitelisted
      if (l:rcfile_load == "unknown")
        if s:LocalVimRCMatchAny(l:rcfile, s:localvimrc_whitelist)
          call s:LocalVimRCDebug(2, l:rcfile . " is whitelisted")
          let l:rcfile_load = "yes"
        endif
      endif

      " check if blacklisted
      if (l:rcfile_load == "unknown")
        if s:LocalVimRCMatchAny(l:rcfile, s:localvimrc_blacklist)
          call s:LocalVimRCDebug(2, l:rcfile . " is blacklisted")
          let l:rcfile_load = "no"
        endif
      endif

      " check if an answer has been given for the same file
      if !empty(l:stored_answer)
        " check the answer
        if (l:stored_answer =~? '^y$')
          let l:rcfile_load = "yes"
        elseif (l:stored_answer =~? '^n$')
          let l:rcfile_load = "no"
        endif
      endif

      " ask if in interactive mode
      if (l:rcfile_load == "unknown")
        if (s:localvimrc_ask == 1)
          if (l:answer !~? "^a$")
            call s:LocalVimRCDebug(2, "need to ask")
            let l:answer = ""
            let l:message = ""
            while (l:answer !~? '^[ynaq]$')
              if (s:localvimrc_persistent == 0)
                let l:message .= "localvimrc: source " . l:rcfile . "? ([y]es/[n]o/[a]ll/[s]how/[q]uit) "
              elseif (s:localvimrc_persistent == 1)
                let l:message .= "localvimrc: source " . l:rcfile . "? ([y]es/[n]o/[a]ll/[s]how/[q]uit ; persistent [Y]es/[N]o/[A]ll) "
              else
                let l:message .= "localvimrc: source " . l:rcfile . "? ([y]es/[n]o/[a]ll/[s]how/[q]uit) "
              endif

              " turn off possible previous :silent command to force this
              " message to be printed
              unsilent let l:answer = inputdialog(l:message)
              call s:LocalVimRCDebug(2, "answer is \"" . l:answer . "\"")

              if empty(l:answer)
                call s:LocalVimRCDebug(2, "aborting on empty answer")
                let l:answer = "q"
              endif

              " add the content of the file for repeating the question
              let l:message = ""
              if (l:answer =~? "^s$")
                let l:message .= "localvimrc: >>>>>>>> start content of " . l:rcfile . "\n"
                let l:content_max = 10
                let l:content = readfile(l:rcfile, "", l:content_max + 1)
                for l:line in l:content
                  let l:message .= "localvimrc: " . l:line . "\n"
                endfor
                if len(l:content) > l:content_max
                  let l:message .= "localvimrc: ======== TRUNCATED AFTER " . l:content_max . " LINES!\n"
                endif
                let l:message .= "localvimrc: <<<<<<<< end  content of " . l:rcfile . "\n"
              endif
            endwhile
          endif

          " make answer upper case if persistence is 2 ("force")
          if (s:localvimrc_persistent == 2)
            let l:answer = toupper(l:answer)
          endif

          " store y/n answers
          if (l:answer =~? "^y$")
            let l:stored_answer = l:answer
          elseif (l:answer =~? "^n$")
            let l:stored_answer = l:answer
          elseif (l:answer =~# "^a$")
            let l:stored_answer = "y"
          elseif (l:answer =~# "^A$")
            let l:stored_answer = "Y"
          endif

          " check the answer
          if (l:answer =~? '^[ya]$')
            let l:rcfile_load = "yes"
          elseif (l:answer =~? "^q$")
            call s:LocalVimRCDebug(1, "ended processing files")
            break
          endif
        endif
      endif

      " load unconditionally if in non-interactive mode
      if (l:rcfile_load == "unknown")
        if (s:localvimrc_ask == 0)
          let l:rcfile_load = "yes"
        endif
      endif

      " should this rc file be loaded?
      if (l:rcfile_load == "yes")
        " store name and directory of file
        let g:localvimrc_file = resolve(expand("<afile>:p"))
        let g:localvimrc_file_dir = fnamemodify(g:localvimrc_file, ":h")
        call s:LocalVimRCDebug(3, "g:localvimrc_file = " . g:localvimrc_file . ", g:localvimrc_file_dir = " . g:localvimrc_file_dir)

        " store name and directory of script
        let g:localvimrc_script = l:rcfile
        let g:localvimrc_script_dir = fnamemodify(g:localvimrc_script, ":h")
        call s:LocalVimRCDebug(3, "g:localvimrc_script = " . g:localvimrc_script . ", g:localvimrc_script_dir = " . g:localvimrc_script_dir)

        " store name and directory of unresolved script
        let g:localvimrc_script_unresolved = l:rcfile_unresolved
        let g:localvimrc_script_dir_unresolved = fnamemodify(g:localvimrc_script_unresolved, ":h")
        call s:LocalVimRCDebug(3, "g:localvimrc_script_unresolved = " . g:localvimrc_script_unresolved . ", g:localvimrc_script_dir_unresolved = " . g:localvimrc_script_dir_unresolved)

        " reset if checksum changed
        if (!l:checksum_is_same)
          if has_key(s:localvimrc_sourced, l:rcfile)
            unlet s:localvimrc_sourced[l:rcfile]
            call s:LocalVimRCDebug(2, "resetting 'sourced' information")
          endif
        endif

        " detect if this local vimrc file had been loaded
        let g:localvimrc_sourced_once = 0
        let g:localvimrc_sourced_once_for_file = 0
        if has_key(s:localvimrc_sourced, l:rcfile)
          let g:localvimrc_sourced_once = 1
          if index(s:localvimrc_sourced[l:rcfile], g:localvimrc_file) >= 0
            let g:localvimrc_sourced_once_for_file = 1
          else
            call add(s:localvimrc_sourced[l:rcfile], g:localvimrc_file)
          endif
        else
          let s:localvimrc_sourced[l:rcfile] = [ g:localvimrc_file ]
        endif
        call s:LocalVimRCDebug(3, "g:localvimrc_sourced_once = " . g:localvimrc_sourced_once . ", g:localvimrc_sourced_once_for_file = " . g:localvimrc_sourced_once_for_file)

        " emit an autocommand before sourcing
        if (s:localvimrc_autocmd == 1)
          call s:LocalVimRCUserAutocommand('LocalVimRCPre')
        endif

        " add 'sandbox' if requested
        if (s:localvimrc_sandbox != 0)
          call s:LocalVimRCDebug(2, "using sandbox")
          try
            " execute the command
            call s:LocalVimRCSourceScript(l:rcfile, 1)
          catch /^sandbox$/
            let l:message = printf("localvimrc: unable to use sandbox for \"" . l:rcfile . "\".")
            call s:LocalVimRCDebug(1, l:message)

            if (s:localvimrc_ask == 1)
              if (l:sandbox_answer !~? "^a$")
                if l:stored_sandbox_answer != ""
                  let l:sandbox_answer = l:stored_sandbox_answer
                  call s:LocalVimRCDebug(2, "reuse previous sandbox answer \"" . l:stored_sandbox_answer . "\"")
                else
                  call s:LocalVimRCDebug(2, "need to ask")
                  let l:sandbox_answer = ""
                  while (l:sandbox_answer !~? '^[ynaq]$')
                    if (s:localvimrc_persistent == 0)
                      let l:message .= "\nlocalvimrc: Source it anyway? ([y]es/[n]o/[a]ll/[q]uit) "
                    elseif (s:localvimrc_persistent == 1)
                      let l:message .= "\nlocalvimrc: Source it anyway? ([y]es/[n]o/[a]ll/[q]uit ; persistent [Y]es/[N]o/[A]ll) "
                    else
                      let l:message .= "\nlocalvimrc: Source it anyway? ([y]es/[n]o/[a]ll/[q]uit) "
                    endif

                    " turn off possible previous :silent command to force this
                    " message to be printed
                    unsilent let l:sandbox_answer = inputdialog("\n" . l:message)
                    call s:LocalVimRCDebug(2, "sandbox answer is \"" . l:sandbox_answer . "\"")

                    if empty(l:sandbox_answer)
                      call s:LocalVimRCDebug(2, "aborting on empty sandbox answer")
                      let l:sandbox_answer = "q"
                    endif
                  endwhile
                endif
              endif

              " make sandbox_answer upper case if persistence is 2 ("force")
              if (s:localvimrc_persistent == 2)
                let l:sandbox_answer = toupper(l:sandbox_answer)
              endif

              " store y/n answers
              if (l:sandbox_answer =~? "^y$")
                let l:stored_sandbox_answer = l:sandbox_answer
              elseif (l:sandbox_answer =~? "^n$")
                let l:stored_sandbox_answer = l:sandbox_answer
              elseif (l:sandbox_answer =~# "^a$")
                let l:stored_sandbox_answer = "y"
              elseif (l:sandbox_answer =~# "^A$")
                let l:stored_sandbox_answer = "Y"
              endif

              " check the sandbox_answer
              if (l:sandbox_answer =~? '^[ya]$')
                " execute the command
                call s:LocalVimRCSourceScript(l:rcfile, 0)
              elseif (l:sandbox_answer =~? "^q$")
                call s:LocalVimRCDebug(1, "ended processing files")
                break
              endif
            endif
          endtry
        else
          " execute the command
          call s:LocalVimRCSourceScript(l:rcfile, 0)
        endif

        " emit an autocommands after sourcing
        if (s:localvimrc_autocmd == 1)
          call s:LocalVimRCUserAutocommand('LocalVimRCPost')
        endif

        call add(l:sourced_files, l:rcfile)

        " remove global variables again
        unlet g:localvimrc_file
        unlet g:localvimrc_file_dir
        unlet g:localvimrc_script
        unlet g:localvimrc_script_dir
        unlet g:localvimrc_script_unresolved
        unlet g:localvimrc_script_dir_unresolved
        unlet g:localvimrc_sourced_once
        unlet g:localvimrc_sourced_once_for_file
      else
        call s:LocalVimRCDebug(1, "skipping " . l:rcfile)
      endif

      " calculate checksum for each processed file
      let l:stored_checksum = s:LocalVimRCCalcChecksum(l:rcfile)

      " store information again
      let s:localvimrc_data[l:rcfile] = [ l:stored_answer, l:stored_sandbox_answer, l:stored_checksum ]

      " check if sourcing of files should be ended by variable set by
      " local vimrc file
      if (s:localvimrc_finish != 0)
        break
      endif
    endif
  endfor

  " store information about source local vimrc files in buffer local variable
  if exists("b:localvimrc_sourced_files")
    call extend(l:sourced_files, b:localvimrc_sourced_files)
  endif
  if exists("*uniq")
    call uniq(sort(l:sourced_files))
  else
    let l:sourced_files_uniq = {}
    for l:file in l:sourced_files
      let l:sourced_files_uniq[l:file] = 1
    endfor
    let l:sourced_files = sort(keys(l:sourced_files_uniq))
  endif
  let b:localvimrc_sourced_files = l:sourced_files

  " make information persistent
  call s:LocalVimRCWritePersistent()

  " end marker
  call s:LocalVimRCDebug(1, "== END LocalVimRC() ==============================")
endfunction

" Function: s:LocalVimRCUserAutocommand(event) {{{2
"
function! s:LocalVimRCUserAutocommand(event)
  if exists('#User#'.a:event)
    call s:LocalVimRCDebug(1, 'executing User autocommand '.a:event)
    if v:version >= 704 || (v:version == 703 && has('patch442'))
      exec 'doautocmd <nomodeline> User ' . a:event
    else
      exec 'doautocmd User ' . a:event
    endif
  endif
endfunction

" Function: s:LocalVimRCMatchAny(str, patterns) {{{2
"
" check if any of the regular expressions given in the list patterns matches the
" string. If there is a match, return value is "1". If there is no match,
" return value is "0".
"
function! s:LocalVimRCMatchAny(str, patterns)
  for l:pattern in a:patterns
    if (match(a:str, l:pattern) != -1)
      return 1
    endif
  endfor
  return 0
endfunction

" Function: s:LocalVimRCCalcFNV() {{{2
"
" implementation of Fowler–Noll–Vo (FNV-1) hash function calculated on given
" string (https://en.wikipedia.org/wiki/Fowler-Noll-Vo_hash_function)
"
function! s:LocalVimRCCalcFNV(text)
  " initialize the hash with defined offset value
  let l:prime = 0x01000193
  let l:checksum = 0x811c9dc5

  " loop over all characters
  for i in range(0, len(a:text)-1)
    let l:checksum = and((l:checksum * prime), 0xFFFFFFFF)
    let l:checksum = xor(l:checksum, char2nr(a:text[i]))
  endfor

  return l:checksum
endfunction

" Function: s:LocalVimRCCalcSHA256() {{{2
"
" calculate sha256 checksum using python hashlib
"
function! s:LocalVimRcCalcSHA256(text)
  exec s:localvimrc_python_command . " text = vim.eval('a:text')"
  exec s:localvimrc_python_command . " checksum = hashlib.sha256(text.encode('utf-8'))"
  exec s:localvimrc_python_command . " vim.command('return \"%s\"' % checksum.hexdigest())"
endfunction

" Function: s:LocalVimRCCalcChecksum(filename) {{{2
"
" calculate checksum. depending on Vim version this is done with sha256 or
" with FNV-1
"
function! s:LocalVimRCCalcChecksum(file)
  let l:content = join(readfile(a:file))
  let l:checksum = s:localvimrc_checksum_func(l:content)

  call s:LocalVimRCDebug(3, "checksum calc -> " . fnameescape(a:file) . " : " . l:checksum)

  return l:checksum
endfunction

" Function: s:LocalVimRCCheckChecksum(filename, checksum) {{{2
"
" Check checksum. Return "0" if it does not exist, "1" otherwise
"
function! s:LocalVimRCCheckChecksum(file, checksum)
  let l:return = 0
  let l:checksum = s:LocalVimRCCalcChecksum(a:file)

  if (a:checksum == l:checksum)
    let l:return = 1
  endif

  return l:return
endfunction

" Function: s:LocalVimRCReadPersistent() {{{2
"
" read decision variables from persistence file
"
function! s:LocalVimRCReadPersistent()
  if (s:localvimrc_persistent >= 1)
    " check if persistence file is readable
    if filereadable(s:localvimrc_persistence_file)

      " check if reading is needed
      let l:checksum = s:LocalVimRCCalcChecksum(s:localvimrc_persistence_file)
      if l:checksum != s:localvimrc_persistence_file_checksum

        " read persistence file
        let l:serialized = readfile(s:localvimrc_persistence_file)
        call s:LocalVimRCDebug(3, "read persistent data: " . string(l:serialized))

        " deserialize stored persistence information
        for l:line in l:serialized
          let l:columns = split(l:line, '[^\\]\zs|\|^|', 1)
          if len(l:columns) != 3 && len(l:columns) != 4
            call s:LocalVimRCError("error in persistence file")
          else
            if len(l:columns) == 3
              let [ l:key, l:answer, l:checksum ] = l:columns
              let l:sandbox = ""
            elseif len(l:columns) == 4
              let [ l:key, l:answer, l:sandbox, l:checksum ] = l:columns
            endif
            let l:key = substitute(l:key, '\\|', '|', "g")
            let l:answer = substitute(l:answer, '\\|', '|', "g")
            let l:sandbox = substitute(l:sandbox, '\\|', '|', "g")
            let l:checksum = substitute(l:checksum, '\\|', '|', "g")
            let s:localvimrc_data[l:key] = [ l:answer, l:sandbox, l:checksum ]
          endif
        endfor
      else
        call s:LocalVimRCDebug(3, "persistence file did not change")
      endif
    else
      call s:LocalVimRCDebug(1, "unable to read persistence file '" . s:localvimrc_persistence_file . "'")
    endif
  endif
endfunction

" Function: s:LocalVimRCWritePersistent() {{{2
"
" write decision variables to persistence file
"
function! s:LocalVimRCWritePersistent()
  if (s:localvimrc_persistent >= 1)
    " select only data relevant for persistence
    let l:persistent_data = filter(copy(s:localvimrc_data), 'v:val[0] =~# "^[YN]$" || v:val[1] =~# "^[YN]$"')

    " if there are answers to store and global variables are enabled for viminfo
    if (len(l:persistent_data) > 0)
      if l:persistent_data != s:localvimrc_persistent_data
        " check if persistence file is writable
        if filereadable(s:localvimrc_persistence_file) && filewritable(s:localvimrc_persistence_file) ||
              \ !filereadable(s:localvimrc_persistence_file) && filewritable(fnamemodify(s:localvimrc_persistence_file, ":h"))
          let l:serialized = [ ]
          for [ l:key, l:value ] in items(l:persistent_data)
            if len(l:value) == 2
              let [ l:answer, l:checksum ] = l:value
              let l:sandbox = ""
            elseif len(l:value) == 3
              let [ l:answer, l:sandbox, l:checksum ] = l:value
            else
              let l:answer = ""
              let l:sandbox = ""
              let l:checksum = ""
            endif

            " delete none persisten answers
            if l:answer !~# "^[YN]$"
              let l:answer = ""
            endif
            if l:sandbox !~# "^[YN]$"
              let l:sandbox = ""
            endif

            call add(l:serialized, escape(l:key, '|') . "|" . escape(l:answer, '|') . "|" . escape(l:sandbox, '|') . "|" . escape(l:checksum, '|'))
          endfor

          call s:LocalVimRCDebug(3, "write persistent data: " . string(l:serialized))

          " check if there is a exising persistence file
          if filereadable(s:localvimrc_persistence_file)
            " first write backup file to avoid lost persistence information
            " on write errors if partition is full. Done this way because
            " write/rename approach causes permission problems with sudo.
            let l:backup_name = s:localvimrc_persistence_file . "~"
            let l:backup_content = readfile(s:localvimrc_persistence_file, "b")
            if writefile(l:backup_content, l:backup_name, "b") == 0
              if writefile(l:serialized, s:localvimrc_persistence_file) == 0
                call delete(l:backup_name)
              else
                call s:LocalVimRCError("error while writing persistence file, backup stored in '" . l:backup_name . "'")
              endif
            else
              call s:LocalVimRCError("unable to write persistence file backup '" . l:backup_name . "'")
            endif
          else
            " there is no persistence file to backup, just write new one
            if writefile(l:serialized, s:localvimrc_persistence_file) != 0
              call s:LocalVimRCError("unable to write persistence file '" . s:localvimrc_persistence_file . "'")
            endif
          endif
        else
          call s:LocalVimRCError("unable to write persistence file '" . s:localvimrc_persistence_file . "'")
        endif

        " store persistence file checksum
        let s:localvimrc_persistence_file_checksum = s:LocalVimRCCalcChecksum(s:localvimrc_persistence_file)
      endif
      let s:localvimrc_persistent_data = l:persistent_data
    endif
  else
    " delete persistence file
    if filewritable(s:localvimrc_persistence_file)
      call delete(s:localvimrc_persistence_file)
    endif
  endif

  " remove old persistence data
  if exists("g:LOCALVIMRC_ANSWERS")
    unlet g:LOCALVIMRC_ANSWERS
  endif
  if exists("g:LOCALVIMRC_CHECKSUMS")
    unlet g:LOCALVIMRC_CHECKSUMS
  endif

endfunction

" Function: s:LocalVimRCClear() {{{2
"
" clear all stored persistence data
"
function! s:LocalVimRCClear()
  let s:localvimrc_data = {}
  call s:LocalVimRCDebug(3, "cleared local data")

  let s:localvimrc_persistence_file_checksum = ""
  call s:LocalVimRCDebug(3, "cleared persistence file checksum")

  let s:localvimrc_persistent_data = {}
  call s:LocalVimRCDebug(3, "cleared persistent data")

  if filewritable(s:localvimrc_persistence_file)
    call delete(s:localvimrc_persistence_file)
    call s:LocalVimRCDebug(3, "deleted persistence file")
  endif
endfunction

" Function: s:LocalVimRCCleanup() {{{2
"
" cleanup stored persistence data
"
function! s:LocalVimRCCleanup()
  " read persistent information
  call s:LocalVimRCReadPersistent()
  call s:LocalVimRCDebug(3, "read persistent data")

  " loop over all persistent data entries
  for l:file in keys(s:localvimrc_data)
    if !filereadable(l:file)
      unlet s:localvimrc_data[l:file]
      call s:LocalVimRCDebug(3, "removed file '".l:file."' from persistence file")
    else
      call s:LocalVimRCDebug(3, "keeping file '".l:file."' in persistence file")
    endif
  endfor

  " make information persistent
  call s:LocalVimRCWritePersistent()
  call s:LocalVimRCDebug(3, "write persistent data")
endfunction

" Function: s:LocalVimRCForget(...) {{{2
"
" forget stored persistence data for given files
"
function! s:LocalVimRCForget(...)
  " read persistent information
  call s:LocalVimRCReadPersistent()
  call s:LocalVimRCDebug(3, "read persistent data")

  " loop over all persistent data entries
  for l:file in a:000
    if !filereadable(l:file)
      let l:file = resolve(fnamemodify(l:file, ":p"))
      if has_key(s:localvimrc_data, l:file)
        unlet s:localvimrc_data[l:file]
        call s:LocalVimRCDebug(3, "removed file '".l:file."' from persistence file")
      else
        call s:LocalVimRCDebug(3, "file '".l:file."' does not exist in persistence file")
      endif
    endif
  endfor

  " make information persistent
  call s:LocalVimRCWritePersistent()
  call s:LocalVimRCDebug(3, "write persistent data")
endfunction

" Function: LocalVimRCEnable() {{{2
"
" enable processing of local vimrc files
"
function! s:LocalVimRCEnable()
  " if this call really enables the plugin load the local vimrc files for the
  " current buffer
  if s:localvimrc_enable == 0
    call s:LocalVimRCDebug(1, "enable processing of local vimrc files")
    let s:localvimrc_enable = 1
    call s:LocalVimRC()
  endif
endfunction

" Function: LocalVimRCDisable() {{{2
"
" disable processing of local vimrc files
"
function! s:LocalVimRCDisable()
  call s:LocalVimRCDebug(1, "disable processing of local vimrc files")
  let s:localvimrc_enable = 0
endfunction

" Function: LocalVimRCFinish() {{{2
"
" finish processing of local vimrc files
"
function! LocalVimRCFinish()
  call s:LocalVimRCDebug(1, "will finish sourcing files after this file")
  let s:localvimrc_finish = 1
endfunction

" Function: s:LocalVimRCEdit() {{{2
"
" open the local vimrc file for the current buffer in an split window for
" editing. If more than one local vimrc file has been sourced, the user
" can decide which file to edit.
"
function! s:LocalVimRCEdit()
  if exists("b:localvimrc_sourced_files")
    let l:items = len(b:localvimrc_sourced_files)
    if l:items == 0
      call s:LocalVimRCError("No local vimrc file has been sourced")
    elseif l:items == 1
      " edit the only sourced file
      let l:file = b:localvimrc_sourced_files[0]
    elseif l:items > 1
      " build message for asking the user
      let l:message = [ "Select local vimrc file to edit:" ]
      call extend(l:message, map(copy(b:localvimrc_sourced_files), 'v:key+1 . " " . v:val'))

      " ask the user which one should be edited
      let l:answer = inputlist(l:message)
      if l:answer =~ '^\d\+$' && l:answer > 0 && l:answer <= l:items
        let l:file = b:localvimrc_sourced_files[l:answer-1]
      endif
    endif

    if exists("l:file")
      execute 'silent! split ' . fnameescape(l:file)
    endif
  endif
endfunction

" Function: s:LocalVimRCError(text) {{{2
"
" output error message
"
function! s:LocalVimRCError(text)
  echohl ErrorMsg | echom "localvimrc: " . a:text | echohl None

  " put every error message to the debug message array
  call s:LocalVimRCDebug(0, a:text)
endfunction

" Function: s:LocalVimRCDebug(level, text) {{{2
"
" store debug message, if this message has high enough importance
"
function! s:LocalVimRCDebug(level, text)
  if (g:localvimrc_debug >= a:level)
    call add(s:localvimrc_debug_message, a:text)

    " if the list is too long remove the first element
    if len(s:localvimrc_debug_message) > s:localvimrc_debug_lines
      call remove(s:localvimrc_debug_message, 0)
    endif
  endif
endfunction

" Function: s:LocalVimRCDebugShow() {{{2
"
" output stored debug message
"
function! s:LocalVimRCDebugShow()
  for l:message in s:localvimrc_debug_message
    echo l:message
  endfor
endfunction

" Section: Initialize internal variables {{{1

" initialize data dictionary {{{2
" key: localvimrc file
" value: [ answer, sandbox_answer, checksum ]
let s:localvimrc_data = {}

" initialize sourced dictionary {{{2
" key: localvimrc file
" value: [ list of files triggered sourcing ]
let s:localvimrc_sourced = {}

" initialize persistence file checksum {{{2
let s:localvimrc_persistence_file_checksum = ""

" initialize persistent data {{{2
let s:localvimrc_persistent_data = {}

" initialize nested execution guard {{{2
let s:localvimrc_running = 0

" initialize processing finish flag {{{2
let s:localvimrc_finish = 0

" initialize debug message buffer {{{2
let s:localvimrc_debug_message = []

" determine which function shall be used to calculate checksums {{{2
let s:localvimrc_python_command = "not checked for python"
let s:localvimrc_python_available = 0

if exists("*sha256")
  let s:localvimrc_checksum_func = function("sha256")
else
  " determine python version
  " for each available python version try to load the required modules and use
  " this version only if loading worked
  let s:localvimrc_python_command = "no working python available"

  if s:localvimrc_python_available == 0
        \ && s:localvimrc_python2_enable == 1
        \ && has("python")
    try
      python import hashlib, vim
      let s:localvimrc_python_available = 1
      let s:localvimrc_python_command = "python"
    catch
      call s:LocalVimRCDebug(1, "python is available but not working")
    endtry
  endif

  if s:localvimrc_python_available == 0
        \ && s:localvimrc_python3_enable == 1
        \ && has("python3")
    try
      python3 import hashlib, vim
      let s:localvimrc_python_available = 1
      let s:localvimrc_python_command = "python3"
    catch
      call s:LocalVimRCDebug(1, "python3 is available but not working")
    endtry
  endif

  if s:localvimrc_python_available == 1
    let s:localvimrc_checksum_func = function("s:LocalVimRcCalcSHA256")
  else
    let s:localvimrc_checksum_func = function("s:LocalVimRCCalcFNV")
  endif
endif

" Section: Report settings {{{1

call s:LocalVimRCDebug(1, "== START settings ================================")
call s:LocalVimRCDebug(1, "localvimrc_enable = \"" . string(s:localvimrc_enable) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_name = \"" . string(s:localvimrc_name) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_event = \"" . string(s:localvimrc_event) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_event_pattern = \"" . string(s:localvimrc_event_pattern) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_reverse = \"" . string(s:localvimrc_reverse) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_count = \"" . string(s:localvimrc_count) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_file_directory_only = \"" . string(s:localvimrc_file_directory_only) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_sandbox = \"" . string(s:localvimrc_sandbox) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_ask = \"" . string(s:localvimrc_ask) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_whitelist = \"" . string(s:localvimrc_whitelist) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_blacklist = \"" . string(s:localvimrc_blacklist) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_persistent = \"" . string(s:localvimrc_persistent) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_persistence_file = \"" . string(s:localvimrc_persistence_file) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_autocmd = \"" . string(s:localvimrc_autocmd) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_python2_enable = \"" . string(s:localvimrc_python2_enable) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_python3_enable = \"" . string(s:localvimrc_python3_enable) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_debug = \"" . string(g:localvimrc_debug) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_debug_lines = \"" . string(s:localvimrc_debug_lines) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_checksum_func = \"" . string(s:localvimrc_checksum_func) . "\"")
call s:LocalVimRCDebug(1, "localvimrc_python_command = \"" . string(s:localvimrc_python_command) . "\"")
call s:LocalVimRCDebug(1, "== END settings ==================================")

" Section: Commands {{{1

command! LocalVimRC        call s:LocalVimRC()
command! LocalVimRCClear   call s:LocalVimRCClear()
command! LocalVimRCCleanup call s:LocalVimRCCleanup()
command! -nargs=+ -complete=file LocalVimRCForget  call s:LocalVimRCForget(<f-args>)
command! LocalVimRCEdit    call s:LocalVimRCEdit()
command! LocalVimRCEnable  call s:LocalVimRCEnable()
command! LocalVimRCDisable call s:LocalVimRCDisable()
command! LocalVimRCDebugShow call s:LocalVimRCDebugShow()

" vim600: foldmethod=marker foldlevel=0 :
