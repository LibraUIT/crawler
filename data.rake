require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'
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
    time = Time.now
    folder = time.to_formatted_s(:number)
    FileUtils::mkdir_p folder
    out_file = File.new("images.txt", "w")
    text = ''
    index = 1
    flag = true
    total = 0
    while flag do
      doc = get_doc("http://xkcn.info/page/#{index}")
      doc.css('.gridphoto').each do |item|
        #puts item['data-photo-250']
        #puts item['data-photo-high']
        text += "#{item['data-photo-high']}\n"
        save_photo(folder, item['data-photo-high'])
        total = total + 1
      end
      index += 1
      # If you dont want export all image from website
      if index == 10
        flag = false
      end
    end
    out_file.puts(text)
    out_file.close
    puts "#{total} images download has been successful."
    puts "All images save in the #{folder} folder. Thanks"
  end

  def get_name(img_url)
    params = img_url.split('/')
    params[params.count - 1]
  end

  def save_photo(folder, img_url)
    name = get_name(img_url)
    open("#{folder}/#{name}", 'wb') do |file|
      file << open(img_url).read
    end
  end

end
