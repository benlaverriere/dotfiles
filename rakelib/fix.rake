require_relative '../rake_helpers'

desc 'Apply updates to all modules'
task fix: %w[fix:all]

namespace 'fix' do
  task all: %w[fix:brewfile fix:cask fix:formulae fix:git fix:vim fix:qmk] do |_task| # rubocop:disable Rake/Desc
    puts '🍻 done! 🍻'
  end

  desc "Ensure all the formulae specified in this repo's Brewfile are installed and up to date"
  task brewfile: %w[update_homebrew] do |task|
    log_task_start(task)
    homebrew('bundle install --quiet', exclude_lines_like: /^Using /)
    log_task_end(task)
  end

  desc 'Ensure all the formulae installed on the system are up to date'
  task formulae: %w[update_homebrew] do |task|
    log_task_start(task)
    homebrew 'upgrade --quiet'
    log_task_end(task)
  end

  desc 'Ensure all the casks installed on the system are up to date'
  task cask: %w[update_homebrew] do |task|
    log_task_start(task)
    homebrew 'upgrade --cask --quiet'
    log_task_end(task)
  end

  desc 'Ensure all submodules of this repo are up to date'
  task git: %w[fix:vim] do |task|
    log_task_start(task)
    RakeHelpers.system_with_passthrough 'git submodule update --init -- . ":(exclude)vim"'
    log_task_end(task)
  end

  desc 'Ensure all vim-plugin submodules of this repo are up to date'
  task :vim do |task|
    log_task_start(task)
    RakeHelpers.system_with_passthrough 'git submodule update --init -- vim'
    log_task_end(task)
  end

  desc 'Ensure Homebrew is up to date'
  task homebrew: [:update_homebrew]

  desc 'Ensure QMK is installed and set up properly'
  task :qmk do |task|
    log_task_start(task)

    # -y: attempt to fix any problems automatically, don't prompt interactively
    # Ψ: QMK prefixes info-level log lines with this
    RakeHelpers.system_with_passthrough('qmk doctor -y', exclude_lines_like: /Ψ/)
    log_task_end(task)
  end
end
