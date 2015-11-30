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

namespace :yard do
  require "yard"
  require "yard/rake/yardoc_task"

  desc "Generate Yardoc documentation"
  YARD::Rake::YardocTask.new(:generate)

  desc "Start a Yard server"
  task :server do
    sh("yard", "server", "--reload")
  end
end

desc "Synonym for yard:generate"
task yard: "yard:generate"

desc "Synonym for spec"
task test: :spec

desc "Synonym for spec"
task tests: :spec

task default: :spec
