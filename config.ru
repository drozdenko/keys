require "rack"
require "open-uri"

app = lambda do |env|
  user = env["PATH_INFO"].sub("/", "").strip

  if user == "team"
    keys = Dir[File.join(File.dirname(__FILE__), "files", "*.pub")].map do |file|
      File.read(file).strip
    end.join("\n")

    [200, {"Content-Type" => "text/plain"}, [keys + "\n"]]
  else
    # We are fetching data from github because:
    # - it will be always more up-to-date
    # - I don't want to worry about security issues
    #   when serving files from disk based on path
    # - it just works

    sources = [
      "https://raw.github.com/monterail/keys/master/files/#{user}.pub",
      "https://github.com/#{user}.keys"
    ]

    key = nil
    until key || sources.empty?
      begin
        key = open(sources.shift).readlines.first.strip
      rescue OpenURI::HTTPError
      end
    end

    if key
      [200, {"Content-Type" => "text/plain"}, [key + "\n"]]
    else
      [404, {}, []]
    end
  end
end

run app
