require 'rubygems'
require 'digest'
require 'active_support/core_ext/hash'
require 'ostruct'
require 'http'
require 'wechat_pay/signature'
require 'wechat_pay/respond'
require 'wechat_pay/request'
require "wechat_pay/version"
require 'wechat_pay/error'

module WechatPay
  class API
    PAYMENT_TYPES = ['NATIVE', 'JSAPI', 'APP']
    
    def initialize(settings, timeout = 6)
      [:appid,:mch_id,:key,:secret].each do |key|
        raise WechatPay::Error.new, "No #{key} is provided !" unless settings[key]
      end
      @settings = {}
      @settings = @settings.merge(settings)
      @timeout = timeout
    end
    
    # unified order 
    def unified_order(options={})
      url = "https://api.mch.weixin.qq.com/pay/unifiedorder"
      
      #these are must have values.
      [:body, :out_trade_no, :total_fee, :spbill_create_ip, :notify_url, :trade_type].each do |attr|
        raise WechatPay::Error.new, "No #{attr} is provided for unified_order()"  unless options[attr]
      end
      
      WechatPay::Request.new(url, options, @settings)
    end
    
    # order status querying 
    def order_query(options={})
      url = "https://api.mch.weixin.qq.com/pay/orderquery";
      raise WechatPay::Error.new,  "At least provide one of both :transaction_id and :out_trade_no for order_query()" unless options[:transaction_id] or options[:out_trade_no]
      WechatPay::Request.new(url, options, @settings)
    end
    
    def close_order(options={})
      url = "https://api.mch.weixin.qq.com/pay/closeorder";
      raise  WechatPay::Error.new, "At least provide one of both :transaction_id and :out_trade_no for close_order()" unless options[:transaction_id] or options[:out_trade_no]
      WechatPay::Request.new(url, options, @settings)
    end
    
    def refund(options={})
      url = "https://api.mch.weixin.qq.com/secapi/pay/refund";
      raise "At least provide one of both :transaction_id and :out_trade_no!" unless options[:transaction_id] or options[:out_trade_no]
      [:out_refund_no, :total_fee, :refund_fee, :op_user_id].each do |attr|
        raise  WechatPay::Error.new, "No #{attr} is provided for refund()" unless options[attr]
      end
      WechatPay::Request.new(url, options, @settings)
    end
    
    def refund_query(options={})
      url = "https://api.mch.weixin.qq.com/pay/refundquery";
      raise  WechatPay::Error.new, "At least provide one of :transaction_id, :out_trade_no, :out_refund_no, :refund_id for refund_query()" unless options[:transaction_id] or options[:out_trade_no] or options[:out_refund_no] or options[:refund_id]
      WechatPay::Request.new(url, options, @settings)
    end
    
    def download_bill(options={})
      url = "https://api.mch.weixin.qq.com/pay/downloadbill"
      WechatPay::Request.new(url, options, @settings)
    end
    
    def micropay(options={})
      url = "https://api.mch.weixin.qq.com/pay/micropay"
      WechatPay::Request.new(url, options, @settings)
    end
    
    def reverse(options={})
      url = "https://api.mch.weixin.qq.com/secapi/pay/reverse"
      WechatPay::Request.new(url, options, @settings)
    end
    
    def report(options={})
      url = "https://api.mch.weixin.qq.com/payitil/report"
      WechatPay::Request.new(url, options, @settings)
    end
    
    def bizpayurl(options={})
      WechatPay::Request.new(url, options, @settings)
    end
    
    def shorturl(options={})
      WechatPay::Request.new(url, options, @settings)
    end
    
    def notify(post_data)
      WechatPay::NotifyHandler.new(post_data, @settings[:key])
    end
    
    def reply_notify(options={})
      WechatPay::Request.new(url, options, @settings)
    end
    
    def report_cost_time(options={})
      WechatPay::Request.new(url, options, @settings)
    end
    
    def post_xml_curl(options={})
      WechatPay::Request.new(url, options, @settings)
    end
    
    def get_millisecs(options={})
      return Time.now
    end
    
  end
end
