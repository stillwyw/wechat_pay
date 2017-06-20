module WechatPay
  module Signature
    def self.current_key
      WechatPay::Config.sandbox ? WechatPay::Config.sandbox_key : WechatPay::Config.key
    end

    def self.sign(hash)
      key = current_key
      str = hash.sort.map{|m| m.join("=")}.join("&")
      str += "&key=#{key}"
      Digest::MD5.hexdigest(str)      
    end
    
    def self.check_sign(hash)
      hash = hash['xml'] || hash[:xml] || hash
      key = current_key
      return if (hash[:return_code] || hash['return_code']) == 'FAIL'
      signature = hash[:sign] || hash['sign']
      hash.delete(:sign)
      hash.delete('sign')
      raise WechatPay::Error.new "Signature does not match! The signature from wechat is #{signature} the one you got is #{sign(hash)}" unless signature.upcase == sign(hash).upcase
    end
  end
end
