require 'typhoeus'

hydra = Typhoeus::Hydra.hydra

request = Typhoeus::Request.new(
  "www.baidu.com",
  method: 'get',
  body: "this is a request body",
  params: { field1: "a field" },
  headers: { Accept: "text/html" }
)

request.on_complete do |response|
  #if response.success?
  if response.code == 200
    # hell yeah
    p response.body
  elsif response.timed_out?
    # aw hell no
    p("got a time out")
  elsif response.code == 0
    # Could not get an http response, something's wrong.
    p(response.return_message)
  else
    # Received a non-successful http response.
    p("HTTP request failed: " + response.code.to_s)
  end
end

hydra.queue request

request.run

