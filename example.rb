require_relative 'lib/apple_warranty_scraper'

def print_phone_info(info)
  result =  "serial: #{info.serial}"
  result += ", warranty: #{info.warranty}"
  result += ", expiration date: #{info.expiration}" if info.warranty == :active
  puts result
end

print_phone_info AppleWarrantyScraper.new '013896000639712'
print_phone_info AppleWarrantyScraper.new '013977000323877'