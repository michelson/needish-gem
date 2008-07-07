module Needish
  class Friend
    include EasyClassMaker
    
   attributes :id,:name,:lastname,:nickname,:pictureurl,:displayname,:biography,
   :userneeds,:biography,:friendstatus
   
    
    class << self
     
      # Creates a new user from a piece of xml
      def new_from_xml(xml)
       
        result = []

        xml.search("user").each do  |user|
          Friend.new do |u|
                u.id                =        user[:id] 
                u.name              =         user[:name]
                u.lastname          =         user[:lastname]
                u.nickname          =         user[:nickname]
                u.pictureurl        =         user[:pictureurl]
                u.displayname       =         user[:displayname]
           result << u
           end
           
        end

        return result
       
        
      end
    end
  end
end