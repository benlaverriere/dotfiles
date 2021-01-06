require_relative 'rake_helpers'

task default: %w[help]

desc 'Display usage information'
task :help do
  puts 'Top-level tasks:'
  puts '  - help: display this message'
  puts '  - check: check all modules for updates, but do not apply any changes'
  puts '  - fix: apply updates to all modules'
  puts 'Modules: '
  puts %w[brewfile cask formulae homebrew git vim qmk].map { |target| "  - #{target}" }.join("\n")
end

desc 'Test the system_with_passthrough helper with a slow command'
task :slow do |task|
  log_task_start(task)
  results = RakeHelpers.system_with_passthrough('for x in 1 2 3 4 5 6 7 8 9 10; do echo $x; sleep 1; done')
  pp results
  log_task_end(task)
end

initial_advice = ['', '🍻 results 🍻']
advice = initial_advice

desc 'Check all modules for updates, but do not apply any changes'
task check: %w[check:all]

desc 'Apply updates to all modules'
task fix: %w[fix:all]

def log_task_start(task)
  puts "┏━ Begin #{task.name}"
end

def log_task_end(task)
  puts "┗━ End #{task.name}"
end

def homebrew(arg_string, **kwargs)
  RakeHelpers.system_with_passthrough("HOMEBREW_NO_AUTO_UPDATE=1 brew #{arg_string}", **kwargs)
end

namespace 'check' do
  task all: %w[check:brewfile check:cask check:formulae check:git check:vim check:qmk] do |_task|
    puts advice if advice.length > initial_advice.length
  end

  desc "Check that all the formulae specified in this repo's Brewfile are installed and up to date"
  task brewfile: [:update_homebrew] do |task|
    log_task_start(task)
    results = homebrew 'bundle check --verbose'
    up_to_date = results[:exit_code]
    unless up_to_date
      advice << 'Brewfile dependencies are out of date.'
      advice << '  Fix all with `fix:brewfile`, or individually with `brew bundle [install]`.'
    end
    log_task_end(task)
  end

  desc 'Check that all the formulae installed on the system are up to date'
  task formulae: [:update_homebrew] do |task|
    log_task_start(task)
    updates_pending = homebrew 'outdated'
    unless updates_pending.empty?
      advice << 'Homebrew-installed formulae outside the Brewfile are out of date.'
      advice << '  Fix all with `fix:formulae`, or individually with `brew upgrade <formula>`.'
    end
    log_task_end(task)
  end

  desc 'Check that all the casks installed on the system are up to date'
  task cask: [:update_homebrew] do |task|
    log_task_start(task)
    updates_pending = homebrew 'outdated --cask'
    unless updates_pending.empty?
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
    # Ψ: QMK prefixes info-level log lines with this
    results = RakeHelpers.system_with_passthrough('qmk doctor -n', exclude_lines_like: /Ψ/)
    if results[:exit_code] != 0
      # At least as of January 2021, `qmk doctor` uses exit codes sensibly:
      # https://github.com/qmk/qmk_firmware/blob/master/lib/python/qmk/cli/doctor.py
      advice << "QMK environment/dependencies aren't set up or current."
      advice << '  Fix automatically with `fix:qmk`, or interactively with `qmk doctor`.'
    end
    log_task_end(task)
  end
end

namespace 'fix' do
  task all: %w[fix:brewfile fix:cask fix:formulae fix:git fix:vim fix:qmk] do |_task|
    puts advice if advice.length > 2
  end

  desc "Ensure all the formulae specified in this repo's Brewfile are installed and up to date"
  task brewfile: %w[update_homebrew] do |task|
    log_task_start(task)
    homebrew 'bundle install'
    log_task_end(task)
  end

  desc 'Ensure all the formulae installed on the system are up to date'
  task formulae: %w[update_homebrew] do |task|
    log_task_start(task)
    homebrew 'upgrade'
    log_task_end(task)
  end

  desc 'Ensure all the casks installed on the system are up to date'
  task cask: %w[update_homebrew] do |task|
    log_task_start(task)
    homebrew 'upgrade --cask'
    log_task_end(task)
  end

  desc 'Ensure all submodules of this repo are up to date'
  task git: %w[fix:vim] do |task|
    log_task_start(task)
    RakeHelpers.system_with_passthrough 'git submodule update --init --remote -- . ":(exclude)vim"'
    log_task_end(task)
  end

  desc 'Ensure all vim-plugin submodules of this repo are up to date'
  task :vim do |task|
    log_task_start(task)
    RakeHelpers.system_with_passthrough 'git submodule update --init --remote -- vim'
    log_task_end(task)
  end

  task homebrew: [:update_homebrew]

  desc 'Ensure QMK is installed and set up properly'
  task :qmk do |task|
    log_task_start(task)

    # -y: attempt to fix any problems automatically, don't prompt interactively
    RakeHelpers.system_with_passthrough 'qmk doctor -y'
    log_task_end(task)
  end
end

task :update_homebrew do |task|
  log_task_start(task)
  homebrew('update --quiet', exclude_lines_like: /Already up-to-date./)
  log_task_end(task)
end
