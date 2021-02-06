require 'fileutils'
require 'json'
class Reports
    def initialize(site, content, filename)
        @site     = site,
        @content  = content,
        @filename = filename
        FileUtils.mkdir_p(File.join("reports", clean_http))
    end
    def clean_http
        @site[0].gsub("HTTPS://", "").to_s.gsub("https://", "").to_s.gsub("http://", "").to_s.gsub("HTTP://", "").to_s
    end
    def filename
        File.join("reports", clean_http, @filename)
    end
    def content
        @content
    end
    def save_txt
        File.open(filename, "w") { |file| file.write(content) }
    end
    def save_json
        p content.class
        j = JSON.pretty_generate(content)
        File.open(filename, "w") { |file| file.write(j) }
    end
end