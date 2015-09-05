module WechatPay
  class NotifyHandler
    
    attr_reader :hash, :result
    
    def initialize(post_data,key)
      @hash = Hash.from_xml(post_data)
      
      WechatPay::Signature.check_sign(@hash, key)
      
      @result = OpenStruct.new(@hash) 
    end
    
  end
end