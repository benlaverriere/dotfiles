#!/usr/bin/env ruby

require 'active_support/core_ext/object/blank'
require 'uri'

if ARGV.length < 1 || ARGV.length > 3
  puts 'Usage: add_vim_plugin <URL> [submodule name]'
  return
end

url = URI(ARGV[0])
submodule_name = ARGV[1]&.presence || url.path.split('/').last

system "git submodule add #{url} vim/.vim/pack/benlaverriere/start/#{submodule_name}"
