require 'open-uri'
require 'json'
require 'net/http'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.destroy_all
Product.destroy_all
Cart.destroy_all
Order.destroy_all
c = Category.create(title:'Iphone')

#!/usr/bin/env ruby

require 'time'
require 'uri'
require 'openssl'
require 'base64'

# Your Access Key ID, as taken from the Your Account page
ACCESS_KEY_ID = "AKIAIONONMVS5BPD3WDQ"

# Your Secret Key corresponding to the above ID, as taken from the Your Account page
SECRET_KEY = "0yLyluDzN2uPUZdtBW08EufGagHq7natiqh+tLro"

# The region you are interested in
ENDPOINT = "webservices.amazon.com"

REQUEST_URI = "/onca/xml"

params = {
  "Service" => "AWSECommerceService",
  "Operation" => "ItemSearch",
  "AWSAccessKeyId" => "AKIAIONONMVS5BPD3WDQ",
  "AssociateTag" => "storetestapp-20",
  "SearchIndex" => "All",
  "Keywords" => c.title.to_s,
  "ResponseGroup" => "Images,ItemAttributes,Offers"
}

# Set current timestamp if not set
params["Timestamp"] = Time.now.gmtime.iso8601 if !params.key?("Timestamp")

# Generate the canonical query
canonical_query_string = params.sort.collect do |key, value|
  [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=')
end.join('&')

# Generate the string to be signed
string_to_sign = "GET\n#{ENDPOINT}\n#{REQUEST_URI}\n#{canonical_query_string}"

# Generate the signature required by the Product Advertising API
signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), SECRET_KEY, string_to_sign)).strip()

# Generate the signed URL
request_url = "http://#{ENDPOINT}#{REQUEST_URI}?#{canonical_query_string}&Signature=#{URI.escape(signature, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"

puts "Signed URL: \"#{request_url}\""

@categories = Category.all
@doc = Net::HTTP.get_response(URI.parse(request_url)).body
@doc =  JSON.parse Hash.from_xml(@doc).to_json
@doc = @doc['ItemSearchResponse']['Items']['Item']
@doc.each do |json|
  begin
    price = json['ItemAttributes']['ListPrice']['Amount'].to_i/100
  rescue
     price = 10
  end

  begin
    image = json['LargeImage']['URL']
  rescue
     image = ''
  end

  puts price
  puts '888888888888888888888888888888888888888888888888888888888888'
  # if !json['ItemAttributes']['ListPrice'].try(:FormattedPrice).nil?
  puts Product.create!(title: json['ItemAttributes']['Title'], price: price, category_id: c.id, image: image)
  #   puts p
  # end
  # @price.push(json['ItemAttributes']['ListPrice']['FormattedPrice'])
end
