#!/usr/bin/env ruby
#
# Check Pingdom single alert (checks down)
# ===
#
# Alerts if the check associated with the given check ID is down in the Pingdom account.
#
# Usage
#   Authentication
#     Pingdom's API requires 3 parameters for authentication:
#       --user: the user's email
#       --password: the user's password
#       --application-key: create one at https://my.pingdom.com/account/appkeys
#       --check-id: Pingdom ID for the specific check you want to alert on
#         The Pingdom ID for a check is easily discoverable in the URL for the report or editing
#         the check. Examples:
#           https://my.pingdom.com/reports/uptime#check=[CHECK_ID]&daterange=7days&tab=uptime_tab
#           https://my.pingdom.com/newchecks/checks#check=[CHECK_ID]
#
# Dependencies
#
# gem 'rest-client'
# gem 'json'
#
# Created by Maggie Moreno, 2017
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.

require 'sensu-plugin/check/cli'
require 'rest-client'
require 'json'

class CheckPingdomAggregates < Sensu::Plugin::Check::CLI
  option :user,
         short: '-u EMAIL',
         required: true
  option :password,
         short: '-p PASSWORD',
         required: true
  option :application_key,
         short: '-k APP_KEY',
         long: '--application-key APP_KEY',
         required: true
  option :check_id,
         short: '-i CHECK_ID',
         long: '--check-id CHECK_ID',
         required: true
  option :timeout,
         short: '-t SECS',
         default: 10

  def run
    check_data = api_call[:check]
    message = "Pingdom check #{check_data[:name]} is #{check_data[:status]}"
    if check_data[:status] == 'down'
      critical message
    elsif check_data[:status] == 'up'
      ok message
    else
      unknown message
    end
  end

  def api_call
    resource = RestClient::Resource.new(
      "https://api.pingdom.com/api/2.0/checks/#{config[:check_id]}/",
      user: config[:user],
      password: config[:password],
      headers: { 'App-Key' => config[:application_key] },
      timeout: config[:timeout]
    )
    JSON.parse(resource.get, symbolize_names: true)

  rescue RestClient::RequestTimeout
    warning 'Connection timeout'
  rescue SocketError
    warning 'Network unavailable'
  rescue Errno::ECONNREFUSED
    warning 'Connection refused'
  rescue RestClient::RequestFailed
    warning 'Request failed'
  rescue RestClient::RequestTimeout
    warning 'Connection timed out'
  rescue RestClient::Unauthorized
    warning 'Missing or incorrect API credentials'
  rescue JSON::ParserError
    warning 'API returned invalid JSON'
  end
end
