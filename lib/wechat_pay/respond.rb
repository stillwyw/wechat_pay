module WechatPay
  class Respond < OpenStruct
    attr_reader :xml, :hash

    SUCCESS_STATUS = 'SUCCESS'
    
    def initialize(respond_hash)
      @xml = respond_hash.to_xml
      @hash = respond_hash
      super(respond_hash)
    end
    
    def return_code_success?
      self.return_code == SUCCESS_STATUS
    end

    def result_code_success?
      self.result_code == SUCCESS_STATUS
    end

    def validate!
      fail "return_code is not success (#{self.return_code}): #{self.return_msg}" unless return_code_success?
      fail "result_code is not success (#{self.result_code}): #{self.err_code}:#{self.err_code_des}" unless result_code_success?
    end
  end
end
