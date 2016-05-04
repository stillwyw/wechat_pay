module WechatPay
  class NotifyHandler
    
    attr_reader :hash, :result
    
    def initialize(post_data)
      @hash = Hash.from_xml(post_data)
      key = WechatPay::Config.key
      WechatPay::Signature.check_sign(@hash)
      @result = OpenStruct.new(@hash['xml']||@hash[:xml]) 
    end
    
  end
end