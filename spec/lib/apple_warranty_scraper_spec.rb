require 'spec_helper'
require 'apple_warranty_scraper'

RSpec.describe AppleWarrantyScraper do
  let(:expired) { AppleWarrantyScraper.new '013896000639712' }
  let(:active)  { AppleWarrantyScraper.new '013977000323877' }

  describe 'phone with expired warranty' do
    it 'should have expired warranty' do
      expect(expired.warranty).to eq :expired
    end
    it 'should not have expiration date' do
      expect(expired.expiration).to be_nil
    end
  end

  describe 'phone with active warranty' do
    it 'should have active warranty' do
      expect(active.warranty).to eq :active
    end
    it 'should have specific expiration date' do
      expect(active.expiration).to eq Date.parse('2016-08-10')
    end
  end

  describe 'pass incorrect serial' do
    it 'should throw exception' do
      expect {
        AppleWarrantyScraper.new 'xxxxxxxxxxxxxxx'
      }.to raise_error(AppleWarrantyScraper::NoInformationAboutSerial)
    end
  end
end