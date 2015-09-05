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
      hash.delete(:sign)
      raise WechatPay::Error.new, "Signature does not match!" unless hash['sign'] == sign(hash, key)      
    end
  end
end