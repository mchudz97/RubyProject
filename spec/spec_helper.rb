if ENV['TRAVIS'].to_s.empty?
  require 'simplecov'
  SimpleCov.coverage_dir("coverage/spec")
end

