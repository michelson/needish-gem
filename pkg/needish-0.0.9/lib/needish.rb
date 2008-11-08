%w(uri cgi net/http yaml rubygems hpricot active_support).each { |f| require f }

$:.unshift(File.dirname(__FILE__)) unless
 $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))



require 'needish/version'
require 'needish/easy_class_maker'
require 'needish/base'
require 'needish/user'
require 'needish/friend'
require 'needish/need'
require 'needish/help'