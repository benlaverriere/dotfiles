require_relative '../../rake_helpers'

RSpec.describe RakeHelpers, '.submodules_are_current' do
  it 'considers empty input to be up-to-date' do
    expect(described_class.submodules_are_current('')).to be true
  end

  it "detects submodules that aren't initialized" do
    git_out = '-6e668caba5ce17a2364812c8eb34418b83301766 vim/.vim/pack/benlaverriere/start/vimtex (v2.1-14-g6e668cab)'
    expect(described_class.submodules_are_current(git_out)).to be false
  end

  it 'detects submodules that are out of date with the specified commit' do
    git_out = '+6e668caba5ce17a2364812c8eb34418b83301766 vim/.vim/pack/benlaverriere/start/vimtex (v2.1-14-g6e668cab)'
    expect(described_class.submodules_are_current(git_out)).to be false
  end

  it 'detects submodules that have merge conflicts' do
    git_out = 'U6e668caba5ce17a2364812c8eb34418b83301766 vim/.vim/pack/benlaverriere/start/vimtex (v2.1-14-g6e668cab)'
    expect(described_class.submodules_are_current(git_out)).to be false
  end

  it 'identifies submodules that are up to date' do
    git_out = ' 6e668caba5ce17a2364812c8eb34418b83301766 vim/.vim/pack/benlaverriere/start/vimtex (v2.1-14-g6e668cab)'
    expect(described_class.submodules_are_current(git_out)).to be true
  end

  it 'handles multiple submodules with different statuses' do
    git_out = <<~GIT
      +6e668caba5ce17a2364812c8eb34418b83301766 vim/.vim/pack/benlaverriere/start/vimtex (v2.1-14-g6e668cab)
       6e668caba5ce17a2364812c8eb34418b83301766 vim/.vim/pack/benlaverriere/start/vimtex (v2.1-14-g6e668cab)
    GIT
    expect(described_class.submodules_are_current(git_out)).to be false
  end

  it 'handles multiple submodules that are all current' do
    git_out = <<-GIT
 6e668caba5ce17a2364812c8eb34418b83301766 vim/.vim/pack/benlaverriere/start/vimtex (v2.1-14-g6e668cab)
 6e668caba5ce17a2364812c8eb34418b83301766 vim/.vim/pack/benlaverriere/start/vimtex (v2.1-14-g6e668cab)
    GIT
    expect(described_class.submodules_are_current(git_out)).to be true
  end
end
