# -*- encoding: utf-8 -*-
lib = File.expand_path('../',__FILE__)
lib_up = File.expand_path('../../', __FILE__)
$:.unshift lib unless $:.include?(lib)
$:.unshift lib_up unless $:.include?(lib_up)
require 'json'

ENV['GEM_PATH']=ENV['BUNDLE_INSTALL_PATH'] if ENV['BUNDLE_INSTALL_PATH']
ENV['GEM_HOME']=ENV['BUNDLE_INSTALL_PATH'] if ENV['BUNDLE_INSTALL_PATH']

name = File.split(lib)[-1]||""
raise ArgumentError, '', caller if name.empty?
@name=name

Gem.use_paths(ENV['BUNDLE_INSTALL_PATH'],[]) if ENV['BUNDLE_INSTALL_PATH']

Gem::Specification.new do |s|

  md             = JSON.parse(File.read(File.expand_path('../metadata.json', __FILE__)))

  # Required attributes (gem build fails without these)
  s.name         = @name
  s.version      = md['version'] && !md['version'].empty? ? md['version'] : '0'
  s.files        = Dir.glob('**/*') #.map{|f| File.expand_path(f)}
  s.summary      = md['description'] ? md['description'] : "The Chef cookbook for #{s.name}"

  # Optional attributes (gem build warning raised without these)
  s.author            = md['maintainer'] ? md['maintainer'] : 'No acknowledged maintainer'
  s.description       = md['long_description'] ? md['long_description'] : s.summary
  s.email             = md['maintainer_email'] ? md['maintainer_email'] : 'No acknowledged maintainer email'
  s.homepage          = 'http://www.opscode.com'
  md['dependencies'].each { |k,v| s.add_dependency(k,v) };

  s.post_install_message = "Installed Chef Cookbook #{s.name}\n#{s.description}"

end
