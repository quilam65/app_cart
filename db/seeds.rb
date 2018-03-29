require 'open-uri'
require 'json'
require 'net/http'
require 'openssl'
require 'base64'
require 'time'
require 'uri'

Category.delete_all
Product.delete_all
Cart.delete_all
Order.delete_all
Category.create(title:'Iphone')
Category.create(title:'Samsung')
Category.create(title:'Sony')
Category.create(title:'Huawai')
Category.create(title:'LG')
category = Category.all

# Your Access Key ID, as taken from the Your Account page
ACCESS_KEY_ID = "AKIAIONONMVS5BPD3WDQ"

# Your Secret Key corresponding to the above ID, as taken from the Your Account page
SECRET_KEY = "0yLyluDzN2uPUZdtBW08EufGagHq7natiqh+tLro"

# The region you are interested in
ENDPOINT = "webservices.amazon.com"

REQUEST_URI = "/onca/xml"

category.each do |cate|
  params = {
    "Service" => "AWSECommerceService",
    "Operation" => "ItemSearch",
    "AWSAccessKeyId" => "AKIAIONONMVS5BPD3WDQ",
    "AssociateTag" => "storetestapp-20",
    "SearchIndex" => "All",
    "Keywords" => cate.title.to_s,
    "ResponseGroup" => "Medium"
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

  @doc = Net::HTTP.get_response(URI.parse(request_url)).body
  @doc =  JSON.parse Hash.from_xml(@doc).to_json
  @doc = @doc['ItemSearchResponse']['Items']['Item']
  @doc.each do |json|
    begin
      price = json['ItemAttributes']['ListPrice']['Amount'].to_i/100
    rescue
      price = 100
    end
    Product.create!(title: json['ItemAttributes']['Title'], price: price, category_id: cate.id, image: json['LargeImage']['URL'])
  end
end
puts 'Get Product success!: '
puts Product.all.count
