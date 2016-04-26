module WechatPay
  class NotifyHandler
    
    attr_reader :hash, :result
    
    def initialize(post_data)
      @hash = Hash.from_xml(post_data)
      key = WechatPay::Config.key
      WechatPay::Signature.check_sign(@hash, key)
      
      @result = OpenStruct.new(@hash) 
    end
    
  end
end