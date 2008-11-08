module Needish
  class Need
    include EasyClassMaker
    
   attributes :id,:created,:city,:timediff,:helps,:status,:subject,:text,
   :user_id,:user_name,:user_lastname,:user_nickname,:pictureurl,:displayname,:attachments,:biography,
   :attachment_id, :attachment_fileurl,:attachment_type,:attachment_actualurl,:attachment_name
   
   
    
    class << self
     
      # Creates a new user from a piece of xml
      def new_from_xml(xml)
       
        result = []

        xml.search("userNeeds").each do  |userNeeds|
          (userNeeds/:need).each do |need|
          Need.new do |u|
                u.id           =     need[:id] 
                u.created      =     Time.at(need[:created].to_i)
                u.city         =     need[:city]
                u.timediff     =     need[:timediff]
                u.status       =     need[:status]
                (need/:subject).each do |subject|
                u.subject     =         subject.inner_html.gsub!(/\<\!\[CDATA\[(.*)\]\]\>/m, '\1')
              end
              (need/:text).each do |text|
              u.text     =         text.inner_html.gsub!(/\<\!\[CDATA\[(.*)\]\]\>/m, '\1')
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
                u.created      =     Time.at(need[:created].to_i)
                u.city         =     need[:city]
                u.timediff     =     need[:timediff]
                u.status       =     need[:status]
                
               
                
              (need/:subject).each do |subject|
                u.subject     =         subject.inner_html.gsub!(/\<\!\[CDATA\[(.*)\]\]\>/m, '\1')
              end
              (need/:text).each do |text|
              u.text     =         text.inner_html.gsub!(/\<\!\[CDATA\[(.*)\]\]\>/m, '\1')
              end
              
              
            #si hay attachment
            if(need/:attachment)
                (need/:attachment).each do |attch|
                u.attachment_id = attch[:id]
                u.attachment_fileurl = attch[:fileurl]
                u.attachment_type = attch[:type]
                u.attachment_actualurl = attch[:actualurl]
                u.attachment_name = (attch/:name).inner_html.gsub!(/\<\!\[CDATA\[(.*)\]\]\>/m, '\1')
              end
            end
              
              #cargamos al user para helped si existe
            if(need/:user)
              (need/:user).each do |user|
                u.user_id   =  user[:id]
                u.user_name   = user[:name]
                u.user_lastname    = user[:lastname]
                u.pictureurl   = user[:pictureurl]
                u.user_nickname = user[:user_nickname]
                u.biography   = (user/:biography).inner_html.gsub!(/\<\!\[CDATA\[(.*)\]\]\>/m, '\1')
               # u.attachments   = user[:attachments]
              end
            end
              
            result << u
           end
         end 
        end
        return result
      end
      
      
      def generic_view_from_xml(xml)
        result = []

        xml.search("need").each do  |need|
          
          Need.new do |u|
                u.id           =     need[:id] 
                u.created      =     Time.at(need[:created].to_i)
                u.city         =     need[:city]
                u.timediff     =     need[:timediff]
                u.status       =     need[:status]
            
                (need/:subject).each do |subject|
                u.subject     =         subject.inner_html.gsub!(/\<\!\[CDATA\[(.*)\]\]\>/m, '\1')
              end
              
              u.text     =         need.search('text').first.inner_html.gsub!(/\<\!\[CDATA\[(.*)\]\]\>/m, '\1')
       
            result << u
         end 
        end
        return result[0]
      end
     
     
     
      ##
    end
  end
end