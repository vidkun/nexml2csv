#! /usr/bin/env ruby

require 'csv'
require 'nokogiri'

doc = Nokogiri::XML(open('report.xml').read)

CSV.open('devices.csv', 'wb') do |csv|
  csv << ["Device", "Port", "Protocol", "Service"]
  doc.search('//service').each do |s|
    device = s.xpath('ancestor::device[1]/@address')
    port = s.attr('port')
    protocol = s.attr('protocol')
    name = s.attr('name')
    csv << [device, port, protocol, name]
  end
end