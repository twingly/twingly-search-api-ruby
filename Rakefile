require "rake"
require "bundler/setup"
require "bundler/gem_tasks"

desc "Run specs"
task :spec do
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = %w(-fd -c)
  end
end

require "github_changelog_generator/task"
GitHubChangelogGenerator::RakeTask.new(:changelog) do |config|
  config.user = "twingly"
  config.project = "twingly-search-api-ruby"
end

desc "Synonym for spec"
task :test => :spec
desc "Synonym for spec"
task :tests => :spec
task :default => :spec
