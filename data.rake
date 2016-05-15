require 'rubygems'
require 'nokogiri'
require 'open-uri'
namespace :data do

  desc 'Crawl xkcn.info'
  task :xkcn => :environment do
    xkcn
  end

  def get_doc(path)
    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
    Nokogiri::HTML.parse(open(path, {'User-Agent' => user_agent}))
  end

  def xkcn
    out_file = File.new("out.txt", "w")
    text = ''
    index = 1
    flag = true
    while flag do
      doc = get_doc("http://xkcn.info/page/#{index}")
      doc.css('.gridphoto').each do |item|
        #puts item['data-photo-250']
        #puts item['data-photo-high']
        text += "#{item['data-photo-high']}\n"
      end
      index += 1
      puts index
=begin
      # If you dont want export all image from website
      if index == 10
        flag = false
      end
=end
    end

    out_file.puts(text)
    out_file.close
  end

end
