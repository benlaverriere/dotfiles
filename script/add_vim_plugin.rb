#!/usr/bin/env ruby

require 'active_support/core_ext/object/blank'
require 'uri'

puts 'Usage: add_vim_plugin <URL> [submodule name]' if ARGV.empty?

url = URI(ARGV[0])
submodule_name = ARGV[1]&.presence || url.path.split('/').last

system "git submodule add #{url} vim/.vim/pack/benlaverriere/start/#{submodule_name}"
