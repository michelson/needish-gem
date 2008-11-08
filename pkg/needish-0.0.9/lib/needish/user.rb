module Needish
  class User
    include EasyClassMaker
       
   attributes :id,:name,:lastname,:nickname,:pictureurl,:displayname,:biography,
   :userneeds
   
    
    class << self
      # Creates a new user from a piece of xml
      def new_from_xml(xml)
        User.new do |u|
       
        
          u.id                           = xml.search("user").first[:id]
          u.name                         = xml.search("user").first[:name]
          u.lastname                     = xml.search("user").first[:lastname]
          u.nickname                   = xml.search("user").first[:nickname]
          u.pictureurl                   = xml.search("user").first[:pictureurl]
          u.displayname                  = xml.search("user").first[:displayname]
          u.biography                   = xml.search('biobraphy').inner_html.gsub!(/\<\!\[CDATA\[(.*)\]\]\>/m, '\1')
          
          
       
        end
      end
    end
  end
end