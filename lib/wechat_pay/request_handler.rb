module WechatPay
  class RequestHandler
    
    attr_accessor :params, :url, :settings, :respond, :respond_hash
    
    def initialize(url, opt, sets)
      params = options
      settings = sets
      params[:appid] = settings[:appid]
      params[:mch_id] = settings[:mch_id]
      params[:nonce] = options[:nonce_str] || SecureRandom.urlsafe_base64(32)
      params[:sign] = sign(params)
    end
    
    def sign(hash)
      str = hash.sort.map{|m| m.join("=")}.join("&")
      str += "&key=#{settings[:key]}"
      Digest::MD5.hexdigest(str)
    end
    
    def send
      xml = {xml: params}
      self.parse(RestClient.post(url, params: XmlSimple.xml_out(xml)))
    end
    
    def parse(res)
      check_sign(respond_hash = XmlSimple.xml_in(res))
      respond = OpenStruct.new(respond_hash)
    end
    
    def check_sign(hash)
      return if (hash[:return_code] || hash['return_code']) == 'FAIL'
      hash.delete(:sign) #TODO has to test if this include retrun_code and return_msg
      raise "Signature does not match!" unless respond.sign == sign(hash)
    end
    
  end
end