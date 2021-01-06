require 'open3'

module RakeHelpers
  def self.submodules_are_current(git_output)
    no_input = git_output.strip.empty?
    all_current = git_output.split("\n").all? { |line| line.start_with?(' ') }
    no_input || all_current
  end

  def self.system_with_passthrough(command, include_lines_like: /.*/, exclude_lines_like: /^\b$/)
    results = ''
    exit_code = nil
    Open3.popen2e(command) do |_stdin, stdout_and_stderr, thread|
      while (line = stdout_and_stderr.gets)
        puts line if line.match(include_lines_like) && !line.match(exclude_lines_like)
        results << line
      end
      exit_code = thread.value
    end
    {
      output: results,
      exit_code: exit_code.exitstatus
    }
  end
end
