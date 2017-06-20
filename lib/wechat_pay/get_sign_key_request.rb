module WechatPay
  class GetSignKeyRequest < Request
    def initialize(url, options)
      @url = url
      @params = options
      @params[:mch_id] = options[:mch_id] || WechatPay::Config.mch_id
      @params[:nonce_str] = options[:nonce_str] || SecureRandom.urlsafe_base64(16)
      @params[:sign] = WechatPay::Signature.sign(@params, WechatPay::Config.key)
      @out_xml = @params.to_xml(:root => :xml, :dasherize => false)
    end

    def parse(res)
      @respond_hash = Hash.from_xml(res)
      WechatPay::Respond.new @respond_hash['xml']
    end
  end
end
