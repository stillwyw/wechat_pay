module WechatPay
  class Request

    attr_reader :respond, :respond_hash, :respond_xml, :out_xml
    
    def initialize(url, options)
      @url = url
      @params = options
      @params[:appid] = options[:appid] || WechatPay::Config.appid
      @params[:mch_id] = options[:mch_id] || WechatPay::Config.mch_id
      @params[:nonce_str] = options[:nonce_str] || SecureRandom.urlsafe_base64(16)
      @params[:sign] = WechatPay::Signature.sign(@params, WechatPay::Config.key)
      @out_xml = @params.to_xml(:root => :xml, :dasherize => false)
    end
    
    def send
      self.parse(HTTP.post(@url, body: @out_xml))
    end
    
    def parse(res)
      WechatPay::Signature.check_sign(@respond_hash = Hash.from_xml(res), WechatPay::Config.key)
      WechatPay::Respond.new @respond_hash['xml']
    end
    
  end
  
end