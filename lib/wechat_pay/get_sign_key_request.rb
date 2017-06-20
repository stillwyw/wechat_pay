module WechatPay
  class GetSignKeyRequest < Request
    def initialize(url, options)
      @url = url
      @params = options
      @params[:mch_id] = options[:mch_id] || WechatPay::Config.mch_id
      @params[:nonce_str] = options[:nonce_str] || SecureRandom.urlsafe_base64(16)
      @params[:sign] = WechatPay::Signature.sign(@params)
      @out_xml = @params.to_xml(:root => :xml, :dasherize => false)
    end

    def send
      headers = WechatPay::Config.http_headers.dup || {}
      headers[:content_type] = 'application/xml'

      requret = HTTP.with_headers(headers)
      self.parse(requret.post(@url, body: @out_xml))
    end

    def check_sign(hash)
      hash = hash['xml']
      fail "WechatPay::GetSignKeyRequest fail: #{hash.inspect}" if hash['return_code'] == 'FAIL'

      signature = hash.delete('sign')

      str = hash.sort.map{|m| m.join("=")}.join("&")
      str += "&key=#{WechatPay::Config.key}"
      expect_sign = Digest::MD5.hexdigest(str).upcase

      raise WechatPay::Error.new "Signature does not match! The signature from wechat is #{expect_sign} the one you got is #{signature}" unless signature.upcase == expect_sign.upcase
    end

    def parse(res)
      self.check_sign(@respond_hash = Hash.from_xml(res))
      WechatPay::Respond.new @respond_hash['xml']
    end
  end
end
