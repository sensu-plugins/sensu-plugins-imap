require_relative '../bin/check-imap.rb'

# Class Stub for the check
class CheckIMAP
  at_exit do
    @autorun = false
  end

  def critical(*); end

  def warning(*); end

  def ok(*); end
end

describe 'CheckIMAP' do
  describe '#run' do
    it 'opens a TLS connection by default' do
      check = CheckIMAP.new
      expect(Net::IMAP).to receive(:new).with(check.config[:host].to_s,
                                              993,
                                              true)
      check.run
    end

    it 'opens a plain text connection when TLS is disabled' do
      check = CheckIMAP.new('--disable-tls'.split(' '))
      expect(Net::IMAP).to receive(:new).with(check.config[:host].to_s)
      check.run
    end

    it 'opens a plain text connection with a specified host on request' do
      check = CheckIMAP.new('--disable-tls --port 143'.split(' '))
      expect(check.config[:disable_tls]).to be true
      expect(check.config[:port].to_i).to eq(143)
      expect(Net::IMAP).to receive(:new).with(check.config[:host].to_s, 143)
      check.run
    end
  end
end
