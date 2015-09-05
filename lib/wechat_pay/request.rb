module WechatPay
  class Request

    attr_reader :respond, :respond_hash, :respond_xml, :out_xml
    
    def initialize(url, options, sets)
      @url = url
      @params = options
      @settings = sets
      @params[:appid] = @settings[:appid]
      @params[:mch_id] = @settings[:mch_id]
      @params[:nonce_str] = options[:nonce_str] || SecureRandom.urlsafe_base64(32)
      @params[:sign] = WechatPay::Signature.sign(@params, @settings[:ey])
      @out_xml = @params.to_xml(:root => :xml, :dasherize => false)
    end
    
    def send
      self.parse(HTTP.post(@url, body: @out_xml))
    end
    
    def parse(res)
      WechatPay::Signature.check_sign(@respond_hash = Hash.from_xml(res), key)
      WechatPay::Respond.new @respond_hash['xml']
    end
    
  end
  
end