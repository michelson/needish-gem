module Needish
  class Help
    include EasyClassMaker
    
   attributes :id,:created,:helps,:stared,:timediff,:text,
   :user_id,:user_name,:user_lastname,:user_nickname,:pictureurl,:displayname
   
    
    class << self
     
      # Creates a new user from a piece of xml
      def new_from_xml(xml)
       
        result = []

         xml.search("help").each do  |help|
          
          Help.new do |u|
                u.id           =     help[:id] 
                u.created      =     help[:created]
                u.stared        =     help[:stars]
                u.timediff     =     help[:timediff]
                
            (help/:text).each do |text|
              u.text     =     text.inner_html
            end
            
            
            (help/:user).each do |user|
              u.user_id     =     user[:id]
              u.user_name     =     user[:name]
              u.user_lastname     =     user[:lastname]
              u.user_nickname     =     user[:user_nickname]
              u.pictureurl    =     user[:pictureurl]
              u.displayname    =     user[:displayname]
            end
    
    
    
            result << u
            
            
         end  
        end

        return result

      end
    end
  end
end