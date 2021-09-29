require 'rubocop/rake_task'

task default: %w[lint test]

task :test do
  ruby 'test/game_match_test.rb'
end

RuboCop::RakeTask.new(:lint) do |task|
   task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
   task.fail_on_error = false
 end
