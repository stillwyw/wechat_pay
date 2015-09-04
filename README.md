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
#initialize a api instance.
api = WechatPay::API.new({
		:appid  => 'YOUR_APP_ID',
		:mch_id => 'YOUR_MCH_ID',
		:key    => 'YOUR_KEY',
		:secret => 'YOUR_SECRET'
	})

#prepare the request.
request = api.unified_order({
		:body => 'A very cool product.', 
		:out_trade_no => '1000001', 
		:total_fee => '1000', 
		:spbill_create_ip => '8.8.8.8', 
		:notify_url => 'http://yoursite.com/notify_url', 
		:trade_type => 'JSAPI'   #JSAPI，NATIVE，APP，WAP
	})

#send the request and get the respond. The respond will be formed into `OpenStruct` object.
respond = request.send

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
