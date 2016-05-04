module WechatPay
  module Signature    
    def self.sign(hash)
      key = WechatPay::Config.key
      str = hash.sort.map{|m| m.join("=")}.join("&")
      str += "&key=#{key}"
      Digest::MD5.hexdigest(str)      
    end
    
    def self.check_sign(hash)
      hash = hash['xml'] || hash[:xml] || hash
      key = WechatPay::Config.key
      return if (hash[:return_code] || hash['return_code']) == 'FAIL'
      signature = hash[:sign] || hash['sign']
      hash.delete(:sign)
      hash.delete('sign')
      raise WechatPay::Error.new, "Signature does not match! The signature from wechat is #{signature} the one you got is #{sign(hash, key)}" unless signature.upcase == sign(hash).upcase
    end
  end
end