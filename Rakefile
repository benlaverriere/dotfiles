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

task :update_homebrew do |task| # rubocop:disable Rake/Desc
  log_task_start(task)
  homebrew('update --quiet', exclude_lines_like: /Already up-to-date./)
  log_task_end(task)
end

desc 'Test the system_with_passthrough helper with a slow command'
task :slow do |task|
  log_task_start(task)
  results = RakeHelpers.system_with_passthrough('for x in 1 2 3 4 5 6 7 8 9 10; do echo $x; sleep 1; done')
  pp results
  log_task_end(task)
end

def log_task_start(task)
  puts "┏━ Begin #{task.name}"
end

def log_task_end(task)
  puts "┗━ End #{task.name}"
end

def homebrew(arg_string, **kwargs)
  RakeHelpers.system_with_passthrough("HOMEBREW_NO_AUTO_UPDATE=1 brew #{arg_string}", **kwargs)
end
