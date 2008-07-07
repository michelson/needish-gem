module Needish
  class Need
    include EasyClassMaker
    
   attributes :id,:created,:city,:timediff,:helps,:status,:subject,:text
   
    
    class << self
     
      # Creates a new user from a piece of xml
      def new_from_xml(xml)
       
        result = []

        xml.search("userNeeds").each do  |userNeeds|
          (userNeeds/:need).each do |need|
          Need.new do |u|
                u.id           =     need[:id] 
                u.created      =     need[:created]
                u.city         =     need[:city]
                u.timediff     =     need[:timediff]
                u.status       =     need[:status]
                (need/:subject).each do |subject|
                u.subject     =         subject.inner_html
              end
              (need/:text).each do |text|
              u.text     =         text.inner_html
            end
            result << u
           end 
         end  
        end
        return result
      end
      
      
      
      
      
      def generic_from_xml(xml)
       
        result = []

        xml.search("needs").each do  |userNeeds|
          (userNeeds/:need).each do |need|
          Need.new do |u|
                u.id           =     need[:id] 
                u.created      =     need[:created]
                u.city         =     need[:city]
                u.timediff     =     need[:timediff]
                u.status       =     need[:status]
                
                (need/:subject).each do |subject|
                u.subject     =         subject.inner_html
              end
              (need/:text).each do |text|
              u.text     =         text.inner_html
            end
            result << u
           end
         end 
        end
        return result
      end
      
      
      def generic_view_from_xml(xml)
        result = []
        #:help_id, :help_created, :help_stars, :help_timediff,:help_text,
        # :help_user_id,:help_user_name,:help_user_nickname,:help_user_picture_url,:help_user_displayname,:help_user_text
        

        xml.search("need").each do  |need|
          
          Need.new do |u|
                u.id           =     need[:id] 
                u.created      =     need[:created]
                u.city         =     need[:city]
                u.timediff     =     need[:timediff]
                u.status       =     need[:status]
            
                (need/:subject).each do |subject|
                u.subject     =         subject.inner_html
              end
              
              u.text     =         need.search('text').first.inner_html
            
            
        
            
            result << u
         end 
        end
        return result[0]
      end
     
     
     
      
    end
  end
end