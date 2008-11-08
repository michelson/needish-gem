# very inspired in twitter gem
# This is the base class for the needish library. It makes all the requests 
# to needish, parses the xml (using hpricot) and returns ruby objects to play with.
# The private methods in this one are pretty fun. Be sure to check out users, needs and helps...
module Needish
  class UnNeedishable < StandardError; end
  class CantConnect < UnNeedishable; end
  class BadResponse < UnNeedishable; end
  class UnknownTimeline < ArgumentError; end
  
  class Base
    # Needish's url, duh!
    @@api_url   = 'api.needish.com'
    # Timelines exposed by the needish api
    @@timelines = [:friends, :public, :user]
    
    def self.timelines
      @@timelines
    end
    
    # Initializes the configuration for making requests to needish
    def initialize(email, password, apikey)
      @config, @config[:email], @config[:password],@config[:apikey] = {}, email, password,"?app_key=#{apikey}"
    end
    
   
    
   #returns user data information
    def me
        users(request("users/authenticate.xml", :auth => true))
    end
    
    # Returns the profile of a given user, 
    def user_profile(id)
      users(request("users/profile/#{id}.xml", :auth => true))
    end
    
    # Returns the profile of a given user, including the recent needs. The needs are ordered by descending date of creation. 
    def user_needs(id)
      needs_data(request("users/profile/#{id}.xml", :auth => true))
    end
    
     # Returns an array of users who are in your friends list
    def friends(id)
     friends_data(request("users/friends/#{id}.xml", :auth => true))
    end
    
    # Returns the most active needs, ordered by descending number of recent helps. 
    def hot_needs
      needs_generic_data(request("needs/hot.xml", :auth => true))
    end
    
    # Returns up to 100 recent public needs, ordered by descending date of creation. 
    def all_needs
      needs_generic_data(request("needs/all.xml", :auth => true))
    end
    
    #Returns up to 100 recent needs of the authenticating user friends, ordered by descending date of creation. 
    def friends_needs
      needs_generic_data(request("needs/friends.xml", :auth => true))
    end
    
    #Returns up to 100 recent public needs created by the given user, ordered by descending date of creation. 
    def needs_from_user(id)
      needs_generic_data(request("needs/user/#{id}.xml", :auth => true))
    end
    
    #Returns the given need
    def view_need(id)
      needs_view_data(request("needs/view/#{id}.xml", :auth => true))
    end
    
    # Returns up to 100 helps for the given need, ordered by date of creation. 
    def helps(id)
      helps_data(request("needs/helps/#{id}.xml", :auth => true))
    end
    
    #Returns up to 100 recent needs helped by the authenticating user, ordered by descending date of creation of the need.     def helped(id)
    def helped
      needs_generic_data(request("needs/helped.xml", :auth => true))
    end
    
    #Returns up to 100 recent needs matching the terms sent, ordered by descending date of creation. 
    def tag(tag)
      needs_generic_data(request("needs/tag/#{tag}.xml", :auth => true))
    end
    
    def search(term)
      needs_generic_data(request("needs/search/#{term}.xml", :auth => true))
    end
  
  
   #Send data 
   # Post a new Need for the authenticating user
   # http://api.needish.com/needs/add.format
     def add_need(subject, text)
        url = URI.parse("http://#{@@api_url}/needs/add.xml#{@config[:apikey]}")
       req = Net::HTTP::Post.new(url.path+@config[:apikey])

        req.basic_auth(@config[:email], @config[:password])
            req.set_form_data({'text'=>text, 'subject'=>subject})

        res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    # puts req   
    ## puts url.path
    # puts  res
     needs_view_data(parse(res.body))
     
     
     
     
     
       
      end
      
      # Post a new Need for the authenticating user.
      
      def add_help(id, text)
         url = URI.parse("http://#{@@api_url}/helps/add/#{id}.xml#{@config[:apikey]}")
         req = Net::HTTP::Post.new(url.path+@config[:apikey])

         req.basic_auth(@config[:email], @config[:password])
         req.set_form_data({'text' => text})

         response = Net::HTTP.new(url.host).start { |http| http.request(req) }
           parse(response.body)

          end
    
    #to do
   # twitter style
    # Befriends the user specified in the ID parameter as the authenticating user.
   
   # def create_friendship(id_or_screenname)
    #  users(request("friends/add/#{id_or_screenname}.xml", :auth => true)).first
    #end
    
    #def destroy_friendship(id_or_screenname)
     # users(request("friends/destroy/#{id_or_screenname}.xml", :auth => true)).first
    #end
    
    #def follow(id_or_screenname)
    #  users(request("notifications/follow/#{id_or_screenname}.xml", :auth => true)).first
    #end
    
    #def leave(id_or_screenname)
    #  users(request("notifications/leave/#{id_or_screenname}.xml", :auth => true)).first
    #end
    
    
    private
      # Converts an hpricot doc to an array of statuses
     
      # Converts an hpricot doc to an array of ..
     
      def users(doc)
        #(doc/:user).inject([]) { |users, user| users << User.new_from_xml(user); users }
         User.new_from_xml(doc)
      end
      
      def friends_data(doc)
       # (doc/:user).inject([]) { |users, user| users << Friend.new_from_xml(user); users }
        
        Friend.new_from_xml(doc)
      end
      
      def needs_data(doc)
        Need.new_from_xml(doc)
      end
      
      def needs_generic_data(doc)
        Need.generic_from_xml(doc)
      end
      def needs_view_data(doc)
        Need.generic_view_from_xml(doc)
      end
      
      def helps_data(doc)
        Help.new_from_xml(doc)
      end
      
      # Calls whatever api method requested that deals with statuses
      # 
      # ie: call(:public_timeline, :auth => false)
      def call(method, options={})
        options.reverse_merge!({ :auth => true, :args => {} })
        path    = "statuses/#{method.to_s}.xml"
        path   += '?' + options[:args].inject('') { |qs, h| qs += "#{h[0]}=#{h[1]}&"; qs } unless options[:args].blank?        
        request(path, options)
      end
      
      def request(path, options={})
        options.reverse_merge!({:headers => { "User-Agent" => @config[:email] }})
        begin
          response = Net::HTTP.start(@@api_url, 80) do |http|
              req = Net::HTTP::Get.new('/' + path+@config[:apikey], options[:headers])
              req.basic_auth(@config[:email], @config[:password]) if options[:auth]
              http.request(req)
          end
              #puts req.body

          raise BadResponse unless response.message == 'OK'
          parse(response.body)
        rescue
          raise CantConnect
        end
      end
      
      def parse(response)
        Hpricot.XML(response)
      end
  end
end
