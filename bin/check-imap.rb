#! /usr/bin/env ruby
#
#   check0imap
#
# DESCRIPTION:
#   This is a simple IMAP check script for Sensu, Uses Ruby IMAP library
#   and authenticates with the given credentials
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem: <?>
#
# USAGE:
#   check-imap.rb -h host -m mech -u user -p pass  => mech - auth mechanisms
#
# NOTES:
#   Supported Auth mechanisms "login", "plain", "cram-md5"
#
#   Refer your IMAP server settings to find which mechanism to use
#
# LICENSE:
#   Deepak Mohan Dass   <deepakmdass88@gmail.com>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/check/cli'
require 'net/imap'
require 'timeout'

class CheckIMAP < Sensu::Plugin::Check::CLI
  option :host,
         description: 'IMAP host',
         short: '-h host',
         long: '--host host',
         default: '127.0.0.1'

  option :mech,
         description: 'IMAP authentication mechanism',
         short: '-m mech',
         long: '--mechanism mech',
         default: 'plain'

  option :user,
         description: 'IMAP username',
         short: '-u user',
         long: '--user user',
         default: 'test'

  option :pass,
         description: 'IMAP user password',
         short: '-p pass',
         long: '--password pass',
         default: 'yoda'

  option :port,
         description: 'Server port',
         long: '--port port',
         default: '993'

  option :disable_tls,
         description: 'Forces plain text connection instead of using TLS',
         long: '--disable-tls'

  def run
    Timeout.timeout(15) do
      imap = if config[:disable_tls] && config[:port].to_i != 993
               # TLS is disabled and port is given
               Net::IMAP.new(config[:host].to_s, config[:port].to_i)

             elsif config[:disable_tls]
               # TLS is disabled, so default to port from Ruby's net/imap
               Net::IMAP.new(config[:host].to_s)

             else
               # Default: Connect using TLS based encryption
               Net::IMAP.new(config[:host].to_s,
                             config[:port].to_i,
                             true)
             end

      status = imap.authenticate(config[:mech].to_s,
                                 config[:user].to_s,
                                 config[:pass].to_s)
      unless status.nil?
        ok 'IMAP SERVICE WORKS FINE'
        imap.disconnect
      end
    end
  rescue Timeout::Error
    critical 'IMAP Connection timed out'
  rescue => e
    critical "Connection error: #{e.message}"
  end
end
