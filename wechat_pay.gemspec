# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wechat_pay/version'

Gem::Specification.new do |spec|
  spec.name          = "wechat_pay"
  spec.version       = WechatPay::VERSION
  spec.authors       = ["yunwei"]
  spec.email         = ["stillwyw@gmail.com"]
  spec.summary       = %q{A non-offical ruby API for wechat pay.}
  spec.description   = %q{This is a non-offical ruby API gem for wechat payment.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'http'
  spec.add_dependency 'builder'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
