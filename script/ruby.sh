# Set up a Ruby installation that's entirely within our control, inspired by
# https://github.com/monfresh/install-ruby-on-macos

# Replicating the Brewfile a bit, but this allows us to run ruby.sh before installing the whole Brewfile
brew install ruby-install
brew install chruby

# Install a new Ruby and use it
ruby-install ruby
chruby ruby

# Bundler
gem update --system
gem install bundler && gem update bundler
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))
bundle install
