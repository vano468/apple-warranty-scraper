require 'date'
require 'rest-client'

class AppleWarrantyScraper
  URL = 'https://selfsolve.apple.com/wcResults.do'

  attr_accessor :serial, :warranty, :expiration

  def initialize(serial)
    @serial     = serial
    @warranty   = get_warranty
    @expiration = get_expiration if @warranty == :active
  end

private

  def get_response
    @response ||= RestClient.post(
        URL,
        post_data
    )[/warrantyPage.warrantycheck.displayHWSupportInfo\(.*?\);/]
  end

  def get_warranty
    if get_response[/'Repairs and Service Coverage:.*?'/].include? 'Expired'
      :expired
    else
      :active
    end
  end

  def get_expiration
    Date.parse get_response.split('Estimated Expiration Date: ')[1].split('<')[0]
  end

  def post_data
    {
        sn:     @serial,
        caller: '',
        num:    '0'
    }
  end
end

warranty = AppleWarrantyScraper.new('013977000323877')
puts warranty.warranty
puts warranty.expiration