namespace :tj do
  desc "Run metrics with proper rcov configuration"
  task :metrics do
    MetricFu::Configuration.run do |config|
      config.rcov[:rcov_opts] << "-Ispec"
    end
    Rake::Task['metrics:all'].invoke
  end

  desc "Run spcs with rcov"
  RSpec::Core::RakeTask.new("rcov") do |t|
    t.rcov = true
    t.rcov_opts = %w{--rails --include views -Ispec --exclude gems\/,spec\/,features\/,seeds\/}
  end
end
