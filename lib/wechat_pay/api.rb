module WechatPay
  class API
    
    def initialize(options, timeout = 6)
      @app_id = options[:app_id]
      @mcht_id = options[:mcht_id]
      @nonce_str = options[:nonce_str]  #TODO make it a method.
      @timeout = timeout
    end
    # unified order 
    def unified_order
      url = "https://api.mch.weixin.qq.com/pay/unifiedorder"
      
    end
    
    # order status querying 
    def order_query
      
    end
    
    def close_order
      
    end
    
    def refund
      
    end
    
    def refund_query
      
    end
    
    def download_bill
      
    end
    
    def micropay
      
    end
    
    def reverse
      
    end
    
    def report
      
    end
    
    def bizpayurl
      
    end
    
    def shorturl
      
    end
    
    def notify
      
    end
    
    def get_nonce(length = 32)
      
    end
    
    def reply_notify
      
    end
    
    def report_cost_time
      
    end
    
    def post_xml_curl
      
    end
    
    def get_millisecs
      return Time.now
    end
    
  end
end