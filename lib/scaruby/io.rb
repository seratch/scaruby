# -*- encoding: utf-8 -*-

require 'net/http'
require 'uri'

module Scaruby
  module IO
    class Source

      attr :string_io

      def initialize(string_io)
        assert_type(string_io, StringIO)
        @string_io = string_io
      end

      def self.from_bytes(bytes, encoding='UTF-8')
        content = bytes.to_a.pack('c*').force_encoding(encoding)
        Source.new(StringIO.new(content))
      end

      def self.from_file(file, encoding='UTF-8')
        content = ''
        File::open(file, "r:#{encoding}") do |file|
          while line = file.gets
            content += line
          end
        end
        Source.new(StringIO.new(content))
      end

      def self.from_url(url, encoding='UTF-8')
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.is_a?(URI::HTTPS)
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        http.start {|http|
          req = Net::HTTP::Get.new(uri.request_uri)
          res = http.request(req)
          Source.new(StringIO.new(res.body))
        }
      end

      def get_lines
        Seq.new(@string_io.map {|line| line })
      end

      def to_seq
        chars = []
        while @string_io.eof? do
          chars.push(@string_io.getc)
        end
        Seq.new(chars)
      end

    end
  end
end

include Scaruby::IO

