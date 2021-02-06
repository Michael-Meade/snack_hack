require 'fileutils'
require 'json'
class Reports
    def initialize(site, content, filename)
        @site     = site
        @content  = content
        @filename = filename
        FileUtils.mkdir_p(File.join("reports", @site))
    end
    def filename
        File.join("reports", @site, @filename)
    end
    def content
        @content
    end
    def save_txt
        File.open(filename, "w") { |file| file.write(content) }
    end
end