require "rack"
require "open-uri"

app = lambda do |env|
  begin
    # We are fetching data from github because:
    # - it will be always more up-to-date
    # - I don't want to worry about security issues
    #   when serving files from disk based on path
    # - it just works
    user = env["PATH_INFO"].sub("/", "").strip
    key = open("https://raw.github.com/monterail/keys/master/#{user}.pub").read
    [200, {"Content-Type" => "text/plain"}, [key]]
  rescue OpenURI::HTTPError
    [404, {}, []]
  end
end

run app
