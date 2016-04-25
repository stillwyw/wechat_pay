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
```
	
For more detailed params and variale requirement and list, please refer to WxPay offical documentation.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/wechat_pay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
