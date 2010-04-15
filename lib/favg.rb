require "open-uri"

class Favg
  class << self
    def fetch(domain)
      download(domain)
    end

    def save(domain, filename)
      favicon = download(domain)
      file = File.open(filename, "w")
      file.write favicon
      file
    end

    private


    def download(domain)
      favicon = Kernel.open("http://www.google.com/s2/favicons?domain=#{domain}").read
      if favicon == default_favicon
        favicon = Kernel.open("http://www.google.com/s2/favicons?domain=www.#{domain}").read
      end

      favicon
    end

    def default_favicon
      @@default_favicon ||= File.read File.join(File.dirname(__FILE__), "fixtures", "generic.png")
    end
  end
end