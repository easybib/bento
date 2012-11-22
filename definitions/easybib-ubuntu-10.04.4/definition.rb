require File.dirname(__FILE__) + "/../.ubuntu/session.rb"
require 'net/http'
require 'json'

iso = "ubuntu-10.04.4-server-amd64.iso"

resp = Net::HTTP.get_response(URI.parse("http://jsonip.com/"))
json = resp.body
data = JSON.parse(json)

resp = Net::HTTP.get_response(URI.parse("http://freegeoip.net/json/#{data["ip"]}"))
json = resp.body
data = JSON.parse(json)
code = data["country_code"].downcase

session =
  UBUNTU_SESSION.merge( :iso_file => iso,
                        :iso_md5 => "9b218654cdcdf9722171648c52f8a088",
                        :iso_src => "http://#{code}.releases.ubuntu.com/10.04.4/#{iso}" )

Veewee::Session.declare session
