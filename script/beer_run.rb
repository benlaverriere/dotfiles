#!/usr/bin/env ruby

require 'open3'

# Pushing the Homebrew metaphor to the breaking point: check for missing Brewfile dependencies, out of date formulas,
# and out of date casks. Also update vim plugin submodules for good measure.

$mode = :check
$target = :all
def check?
  $mode == :check
end

def help?
  $mode == :help
end

def fix?
  $mode == :fix
end

def homebrew(arg_string)
  result = `HOMEBREW_NO_AUTO_UPDATE=1 brew #{arg_string}`
  puts result
  result
end

unless ARGV.nil?
  command = ARGV[0]
  $target = ARGV[1].to_s
  case command
  when 'fix', '--fix', 'f', '-f'
    $mode = :fix
  when 'help', '--help', 'h', '-h'
    $mode = :help
  end
end

if help?
  puts 'Usage: beer_run.rb [help|check|fix] [vim]'
  puts '(Specify "vim" to only update submodules.)'
end

advice = ['', '🍻 results 🍻']

system 'git submodule update --remote --merge' if fix?
system 'git submodule status' if check?

return unless $target == :all

# we know homebrew is likely to update itself the first time we call it, so let's get that out of the way
if check?
  puts 'Updating homebrew...'
  homebrew 'update'
  puts '...done!'
end

# see if we've got everything installed we expect to
if check?
  puts 'Checking Brewfile dependencies...'
  up_to_date = system 'HOMEBREW_NO_AUTO_UPDATE=1 brew bundle check'
  puts '...done!'
  unless up_to_date
    advice << 'Brewfile dependencies are out of date.'
    advice << '  Fix all with `beer_run fix`, or individually with `brew bundle [install]`.'
  end
elsif fix?
  puts 'Installing/upgrading Brewfile dependencies...'
  homebrew 'bundle install'
  puts '...done!'
end

# what formulas are outdated? (brew bundle will take care of everything in the Brewfile but we may have other things
# installed)
if check?
  puts 'Checking formulae...'
  updates_pending = homebrew 'outdated'
  puts '...done!'
  unless updates_pending.empty?
    advice << 'Homebrew-installed formulae outside the Brewfile are out of date.'
    advice << '  Fix all with `beer_run fix`, or individually with `brew upgrade <formula>`.'
  end
elsif fix?
  puts 'Upgrading Homebrew formulae beyond Brewfile...'
  homebrew 'upgrade'
  puts '...done!'
end

# what casks are outdated? and rejigger the format so we have one package per line like the formula output
if check?
  puts 'Checking casks...'
  updates_pending = homebrew 'cask outdated'
  puts '...done!'
  unless updates_pending.empty?
    advice << 'Homebrew casks are out of date.'
    advice << '  Fix all with `beer_run fix`, or individually with `brew cask upgrade <formula>`.'
  end
elsif fix?
  puts 'Upgrading Homebrew casks...'
  homebrew 'cask upgrade'
  puts '...done!'
end

puts advice if check? && advice.length > 2
