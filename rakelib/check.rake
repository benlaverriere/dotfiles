require_relative '../rake_helpers'

initial_advice = ['', '🍻 results 🍻']
*advice = *initial_advice

task check: %w[check:most]

most_tasks = %w[check:brewfile check:cask check:formulae check:git check:vim].freeze
all_tasks = (most_tasks + %w[check:qmk]).freeze

namespace 'check' do
  desc 'Check commonly-used modules for update, but do not apply any changes'
  task most: most_tasks do |_task|
    if advice.length > initial_advice.length
      puts(advice)
    else
      puts '🍻 everything looks good! 🍻'
    end
  end

  desc 'Check all modules for updates, but do not apply any changes'
  task all: all_tasks do |_task|
    if advice.length > initial_advice.length
      puts(advice)
    else
      puts '🍻 everything looks good! 🍻'
    end
  end

  desc "Check that all the formulae specified in this repo's Brewfile are installed and up to date"
  task brewfile: [:update_homebrew] do |task|
    log_task_start(task)
    results = homebrew 'bundle check --verbose'
    unless results[:exit_code].zero?
      advice << 'Brewfile dependencies are out of date.'
      advice << '  Fix all with `fix:brewfile`, or individually with `brew bundle [install]`.'
    end
    log_task_end(task)
  end

  desc 'Check that all the formulae installed on the system are up to date'
  task formulae: [:update_homebrew] do |task|
    log_task_start(task)
    updates_pending = homebrew 'outdated'
    unless updates_pending[:output].empty?
      advice << 'Homebrew-installed formulae outside the Brewfile are out of date.'
      advice << '  Fix all with `fix:formulae`, or individually with `brew upgrade <formula>`.'
    end
    log_task_end(task)
  end

  desc 'Check that all the casks installed on the system are up to date'
  task cask: [:update_homebrew] do |task|
    log_task_start(task)
    updates_pending = homebrew 'outdated --cask'
    unless updates_pending[:output].empty?
      advice << 'Homebrew casks are out of date.'
      advice << '  Fix all with `fix:cask`, or individually with `brew cask upgrade <formula>`.'
    end
    log_task_end(task)
  end

  desc 'Check that all submodules of this repo are up to date'
  task git: %w[check:vim] do |task|
    log_task_start(task)

    # exclude lines that don't start with some character representing a diff
    results = RakeHelpers.system_with_passthrough(
      'git submodule status -- . ":(exclude)vim"',
      exclude_lines_like: /^ /
    )
    unless RakeHelpers.submodules_are_current(results[:output])
      advice << 'Git submodules are out of date.'
      advice << '  Fix all with `fix:git`, or individually with `git submodule checkout ...`.'
    end
    log_task_end(task)
  end

  desc 'Check that all vim-plugin submodules of this repo are up to date'
  task :vim do |task|
    log_task_start(task)

    # exclude lines that don't start with some character representing a diff
    results = RakeHelpers.system_with_passthrough('git submodule status -- vim', exclude_lines_like: /^ /)
    unless RakeHelpers.submodules_are_current(results[:output])
      advice << 'Vim plugin git submodules are out of date.'
      advice << '  Fix all with `fix:vim`, or individually with `git submodule checkout ...`.'
    end
    log_task_end(task)
  end

  desc 'Check whether QMK is installed and set up properly'
  task :qmk do |task|
    log_task_start(task)

    # -n: only check for and report problems, don't interactively prompt to fix them
    results = RakeHelpers.system_with_passthrough('qmk doctor -n',
                                                  exclude_lines_like: RakeHelpers.qmk_exclude_lines_like)
    if results[:exit_code] != 0
      # At least as of January 2021, `qmk doctor` uses exit codes sensibly:
      # https://github.com/qmk/qmk_firmware/blob/master/lib/python/qmk/cli/doctor.py
      advice << "QMK environment/dependencies aren't set up or current."
      advice << '  Fix automatically with `fix:qmk`, or interactively with `qmk doctor`.'
    end
    log_task_end(task)
  end
end
