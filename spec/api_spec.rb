require_relative '../lib/wechat_pay'
WechatPay::Config.appid  = '333333'
WechatPay::Config.mch_id = '333333'
WechatPay::Config.key    = 'ddddddddddd'
WechatPay::Config.secret = 'ddddddddddd'
RSpec.describe WechatPay::API do

  describe ".unified_order" do
    it "should initialize a WechatPay::Request instance." do
      
      request_handler = WechatPay::API.unified_order({
        out_trade_no: '303024032043',
        body: 'ddfdfdfdf',
        total_fee: 900,
        spbill_create_ip: '8.8.8.8',
        notify_url: '127.0.0.1/notify_url',
        trade_type: 'ABDC'
      })
      
      puts request_handler.out_xml
      
      respond = request_handler.send
      
      expect(respond.return_msg).to eq("appid参数长度有误")
      
      expect(respond.return_code).to eq("FAIL")

    end
  end
  
  
end