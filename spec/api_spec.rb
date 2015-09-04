require_relative '../lib/wechat_pay'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
RSpec.describe WechatPay::API do
  describe ".initialize" do
    it "Should initialize a WechatPay::Api instance." do
      api = WechatPay::API.new({
        appid: '33333',
        mch_id: '333333',
        key: 'aaaaaaa',
        secret: 'dddddddd'
      })
    end
  end
  
  describe ".unified_order" do
    it "should initialize a WechatPay::RequestHandler instance." do
      api = WechatPay::API.new({
        appid: '33333',
        mch_id: '333333',
        key: 'aaaaaaa',
        secret: 'dddddddd'
      })
      
      request_handler = api.unified_order({
        out_trade_no: '303024032043',
        body: 'ddfdfdfdf',
        total_fee: 900,
        spbill_create_ip: '8.8.8.8',
        notify_url: '127.0.0.1/notify_url',
        trade_type: 'ABDC'
      })
      
      puts request_handler.out_xml
      
      expect(request_handler.class).to eq(WechatPay::RequestHandler)
      
      respond = request_handler.send
      
      expect(respond.return_code).to eq("FAIL")
    end
  end
  
  
end