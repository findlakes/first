require 'typhoeus'

class Single

  def initialize()
    @hash_ary = []
  end

  def append(hash)
    @hash_ary << hash
  end

  def build()
    @hash_ary.each do |hash|

      req = hash['request']
      res = hash['response']
      request = Typhoeus::Request.new(
        "www.baidu.com",
        method:  req['method'],
        params:  req['params'],
        headers: req['headers']
      )
      request.on_complete do |response|
        #if response.success?
        if response.code == res['code']
          #p response.body
          flag = true
          check_response(flag, response, res)
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

    end

  end

  def check_response(flag, response, res)
    if !res['body'].nil? and !res['body'].empty?
      if response.body.include?(res['body']) then
        flag = true
      else
        flag = false
      end
    end
    if !res['body!'].nil? and !res['body!'].empty?
      if !response.body.include?(res['body!']) then
        flag = true
      else
        flag = false
      end
    end
  end

end

