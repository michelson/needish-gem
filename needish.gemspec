Gem::Specification.new do |s|
  s.name = %q{needish}
  s.version = "0.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Miguel Michelson Martinez"]
  s.date = %q{2008-11-08}
  s.default_executable = %q{needish}
  s.description = %q{This gem provides methods to access the needish.com api}
  s.email = ["miguelmichelson@gmail.com"]
  s.executables = ["needish"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "PostInstall.txt", "README.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "PostInstall.txt", "README.txt", "Rakefile", "bin/needish", "lib/needish.rb", "lib/needish/version.rb", "lib/needish/base.rb", "lib/needish/easy_class_maker.rb", "lib/needish/friend.rb", "lib/needish/help.rb", "lib/needish/need.rb", "lib/needish/user.rb", "lib/needish/command.rb", "test/test_helper.rb", "test/test_needish.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://needish-gem.rubyforge.org}
  s.post_install_message = %q{Instalation Success!! 

For more information on needish gem, see http://animalita.cl/needish-gem

cheers!




}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{needish-gem}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{This gem provides methods to access the needish.com api}
  s.test_files = ["test/test_helper.rb", "test/test_needish.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
