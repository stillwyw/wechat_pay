module WechatPay
  module Signature    
    def self.sign(hash, key)
      str = hash.sort.map{|m| m.join("=")}.join("&")
      str += "&key=#{key}"
      Digest::MD5.hexdigest(str)      
    end
    
    def self.check_sign(hash, key)
      hash = hash['xml'] || hash[:xml] || hash
      return if (hash[:return_code] || hash['return_code']) == 'FAIL'
      signature = hash[:sign] || hash['sign']
      hash.delete(:sign)
      hash.delete('sign')
      raise WechatPay::Error.new, "Signature does not match! The signature from wechat is #{signature} the one you got is #{sign(hash, key)}" unless signature.upcase == sign(hash, key).upcase
    end
  end
end