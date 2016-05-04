require 'rubygems'
require 'digest'
require 'active_support/core_ext/hash'
require 'ostruct'
require 'http'
require 'wechat_pay/signature'
require 'wechat_pay/notify_handler'
require 'wechat_pay/respond'
require 'wechat_pay/request'
require "wechat_pay/version"
require 'wechat_pay/error'

module WechatPay
  module Config
    class << self
      attr_accessor :appid, :mch_id, :key, :secret
    end
  end
  
  module API
    PAYMENT_TYPES = ['NATIVE', 'JSAPI', 'APP']
    
    # unified order 
    def self.unified_order(options={})
      url = "https://api.mch.weixin.qq.com/pay/unifiedorder"
      
      #these are must have values.
      [:body, :out_trade_no, :total_fee, :spbill_create_ip, :notify_url, :trade_type].each do |attr|
        raise WechatPay::Error.new, "No #{attr} is provided for unified_order()"  unless options[attr]
      end
      
      WechatPay::Request.new(url, options)
    end
    
    # order status querying 
    def self.order_query(options={})
      url = "https://api.mch.weixin.qq.com/pay/orderquery";
      raise WechatPay::Error.new,  "At least provide one of both :transaction_id and :out_trade_no for order_query()" unless options[:transaction_id] or options[:out_trade_no]
      WechatPay::Request.new(url, options)
    end
    
    def self.close_order(options={})
      url = "https://api.mch.weixin.qq.com/pay/closeorder";
      raise  WechatPay::Error.new, "At least provide one of both :transaction_id and :out_trade_no for close_order()" unless options[:transaction_id] or options[:out_trade_no]
      WechatPay::Request.new(url, options)
    end
    
    def self.refund(options={})
      url = "https://api.mch.weixin.qq.com/secapi/pay/refund";
      raise "At least provide one of both :transaction_id and :out_trade_no!" unless options[:transaction_id] or options[:out_trade_no]
      [:out_refund_no, :total_fee, :refund_fee, :op_user_id].each do |attr|
        raise  WechatPay::Error.new, "No #{attr} is provided for refund()" unless options[attr]
      end
      WechatPay::Request.new(url, options)
    end
    
    def self.refund_query(options={})
      url = "https://api.mch.weixin.qq.com/pay/refundquery";
      raise  WechatPay::Error.new, "At least provide one of :transaction_id, :out_trade_no, :out_refund_no, :refund_id for refund_query()" unless options[:transaction_id] or options[:out_trade_no] or options[:out_refund_no] or options[:refund_id]
      WechatPay::Request.new(url, options)
    end
    
    def self.download_bill(options={})
      url = "https://api.mch.weixin.qq.com/pay/downloadbill"
      WechatPay::Request.new(url, options)
    end
    
    def self.micropay(options={})
      url = "https://api.mch.weixin.qq.com/pay/micropay"
      WechatPay::Request.new(url, options)
    end
    
    def self.reverse(options={})
      url = "https://api.mch.weixin.qq.com/secapi/pay/reverse"
      WechatPay::Request.new(url, options)
    end
    
    def self.report(options={})
      url = "https://api.mch.weixin.qq.com/payitil/report"
      WechatPay::Request.new(url, options)
    end
    
    def self.bizpayurl(options={})
      WechatPay::Request.new(url, options)
    end
    
    def self.shorturl(options={})
      WechatPay::Request.new(url, options)
    end
    
    def self.notify(post_data)
      WechatPay::NotifyHandler.new(post_data)
    end
    
    def self.reply_notify(options={})
      WechatPay::Request.new(url, options)
    end
    
    def self.report_cost_time(options={})
      WechatPay::Request.new(url, options)
    end
    
    def self.post_xml_curl(options={})
      WechatPay::Request.new(url, options)
    end
    
    def self.get_millisecs(options={})
      return Time.now
    end
    
  end
end
