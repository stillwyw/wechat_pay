# WechatPay

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'wechat_pay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wechat_pay

## Usage
```ruby
# setting
WechatPay::Config.appid        = 'appid'
WechatPay::Config.mch_id       = 'mch_id'
WechatPay::Config.key          = 'api_key'
WechatPay::Config.secret       = 'xxxxxx'
WechatPay::Config.sandbox      = false # true | false
WechatPay::Config.sandbox_key  = 'sandbox api_key' # post the http request by production api_key : WechatPay::Signature::get_sandbox_key_from_api
WechatPay::Config.http_headers = { user_agent: 'WwchatPay-API-Client/1.0' }

#prepare the request.
      request_handler = WechatPay::API.unified_order({
        out_trade_no: '303024032043',
        body: 'ddfdfdfdf',
        total_fee: 900,
        spbill_create_ip: '8.8.8.8',
        notify_url: '127.0.0.1/notify_url',
        trade_type: 'ABDC'
      })
      
#send the request and get the respond. The respond will be formed into `OpenStruct` object.
      respond = request_handler.send

#some example 
return_msg = respond.return_code #=> 'SUCCESS' or maybe 'FAIL'
return_code = respond.return_msg

respond.validate!  # raise error if return_code != 'success' or result_code != 'success'
```
	
For more detailed params and variale requirement and list, please refer to WxPay offical documentation.

## Contributing

1. Fork it ( https://github.com/stillwyw/wechat_pay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
