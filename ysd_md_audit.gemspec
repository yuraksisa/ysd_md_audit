Gem::Specification.new do |s|
  s.name    = "ysd_md_audit"
  s.version = "0.2.5"
  s.authors = ["Yurak Sisa Dream"]
  s.date    = "2012-03-16"
  s.email   = ["yurak.sisa.dream@gmail.com"]
  s.files   = Dir['lib/**/*.rb','templates/**/*.erb']
  s.summary = "Model extension for audit"
  s.homepage = "http://github.com/yuraksisa/ysd_md_audit"


  s.add_runtime_dependency "data_mapper", "1.2.0"
  s.add_runtime_dependency "ysd_md_profile"         # Users::ConnectedUser  
  s.add_runtime_dependency "ysd-persistence", ">= 0.2.0"      # Persistence system  

end
