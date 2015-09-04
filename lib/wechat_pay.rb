require 'rubygems'
require 'digest'
require 'xmlsimple'
require 'ostruct'
require 'rest-client'
require 'wechat_pay/request_handler'
require "wechat_pay/version"
require 'wechat_pay/error'

module WechatPay
  class API
    
    def initialize(options, timeout = 6)
      [:appid,:mch_id,:key,:secret].each do |key|
        raise WechatPay::Error.new, "No #{key} is provided !" unless options[key].present?
      end
      @settings = {}
      @settings = @settings.merge(options)
      @timeout = timeout
    end
    
    # unified order 
    def unified_order(options={})
      url = "https://api.mch.weixin.qq.com/pay/unifiedorder"
      
      #these are must have values.
      [:body, :out_trade_no, :total_fee, :spbill_create_ip, :notify_url, :trade_type].each do |attr|
        raise WechatPay::Error.new, "No #{attr} is provided for unified_order()"  unless options[attr].present?
      end
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    # order status querying 
    def order_query(options={})
      url = "https://api.mch.weixin.qq.com/pay/orderquery";
      raise WechatPay::Error.new,  "At least provide one of both :transaction_id and :out_trade_no for order_query()" unless options[:transaction_id] or options[:out_trade_no]
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def close_order(options={})
      url = "https://api.mch.weixin.qq.com/pay/closeorder";
      raise  WechatPay::Error.new, "At least provide one of both :transaction_id and :out_trade_no for close_order()" unless options[:transaction_id] or options[:out_trade_no]
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def refund(options={})
      url = "https://api.mch.weixin.qq.com/secapi/pay/refund";
      raise "At least provide one of both :transaction_id and :out_trade_no!" unless options[:transaction_id] or options[:out_trade_no]
      [:out_refund_no, :total_fee, :refund_fee, :op_user_id].each do |attr|
        raise  WechatPay::Error.new, "No #{attr} is provided for refund()" unless options[attr].present?
      end
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def refund_query(options={})
      url = "https://api.mch.weixin.qq.com/pay/refundquery";
      raise  WechatPay::Error.new, "At least provide one of :transaction_id, :out_trade_no, :out_refund_no, :refund_id for refund_query()" unless options[:transaction_id].present? or options[:out_trade_no].present? or options[:out_refund_no].present? or options[:refund_id].present?
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def download_bill(options={})
      url = "https://api.mch.weixin.qq.com/pay/downloadbill"
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def micropay(options={})
      url = "https://api.mch.weixin.qq.com/pay/micropay"
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def reverse(options={})
      url = "https://api.mch.weixin.qq.com/secapi/pay/reverse"
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def report(options={})
      url = "https://api.mch.weixin.qq.com/payitil/report"
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def bizpayurl(options={})
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def shorturl(options={})
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def notify(options={})
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def reply_notify(options={})
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def report_cost_time(options={})
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def post_xml_curl(options={})
      WechatPay::RequestHandler.new(url, options, @settings)
    end
    
    def get_millisecs(options={})
      return Time.now
    end
    
  end
end
