# frozen_string_literal: true

require 'rubocop/rake_task'
require 'rake/testtask'

task default: %w[lint test]

task :test do
  ruby 'test/game_match_test.rb'
  ruby 'test/board_block_test.rb'
  ruby 'test/board_actions_test.rb'
  ruby 'test/board_creation_test.rb'
  ruby 'test/mark_diagonal_cells_test.rb'
  ruby 'test/mark_nesw_cells_test.rb'
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end

# Run simplecov for all files
Rake::TestTask.new('test:all') do |t|
  t.libs = ['lib']
  t.warning = true
  t.test_files = FileList['test/**/*_test.rb']
end
