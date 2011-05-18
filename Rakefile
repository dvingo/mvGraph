require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name         = "mvgraph"
  s.summary      = "A generic graph implementation, useful for solving problems where some sort of search is needed."
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.requirements = [ 'None' ]
  s.version      = "0.0.1" 
  s.author       = "Jon Mckenzie, Dan Vingo"
  s.email        = "danvingo@gmail.com"
  s.homepage     = ""
  s.platform     = Gem::Platform::RUBY
  s.required_ruby_version = '>=1.9.2p180'
  s.files        = Dir['**/**']
  s.executables  = []
  s.test_files   = Dir["test/test*.rb"]
  s.has_rdoc     = false
end
Rake::GemPackageTask.new(spec).define

task :default => [:test]

task :test do
  ruby "test/test_mvQueue.rb"
  ruby "test/test_mvGraph.rb"
end
