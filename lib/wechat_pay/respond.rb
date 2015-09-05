module WechatPay
  class Respond < OpenStruct
    attr_reader :xml, :hash

    def initialize(respond_hash)
      @xml = respond_hash.to_xml
      @hash = respond_hash
      super(respond_hash)
    end
  end
end