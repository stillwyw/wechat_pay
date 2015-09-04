module WechatPay
  class RequestHandler

    attr_reader :respond, :respond_hash, :respond_xml, :out_xml
    
    def initialize(url, options, sets)
      @url = url
      @params = options
      @settings = sets
      @params[:appid] = @settings[:appid]
      @params[:mch_id] = @settings[:mch_id]
      @params[:nonce_str] = options[:nonce_str] || SecureRandom.urlsafe_base64(32)
      @params[:sign] = sign(@params)
      @out_xml = @params.to_xml(:root => :xml, :dasherize => false)
    end
    
    def sign(hash)
      str = hash.sort.map{|m| m.join("=")}.join("&")
      str += "&key=#{@settings[:key]}"
      Digest::MD5.hexdigest(str)
    end
    
    def send
      self.parse(HTTP.post(@url, body: @out_xml))
    end
    
    def parse(res)
      check_sign(@respond_hash = Hash.from_xml(res))
      @respond = OpenStruct.new(@respond_hash['xml'])
    end
    
    def check_sign(hash)
      hash = hash['xml']
      return if (hash[:return_code] || hash['return_code']) == 'FAIL'
      hash.delete(:sign) #TODO has to test if this include retrun_code and return_msg
      raise "Signature does not match!" unless hash['sign'] == sign(hash)
    end
    
  end
end