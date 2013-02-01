# encoding: ISO-8859-1
# encoding: utf-8
# encoding: ascii-8bit
require 'time'

module Craigslist

  class Scraper
    CRAPEDIR    = "#{ENV['HOME']}/.crape"
    CONFIG_FILE = "#{CRAPEDIR}/config.yml"
    DATA_FILE   = "#{CRAPEDIR}/data.yml"
    LOG_FILE    = "#{CRAPEDIR}/crape.log"
    THRESHOLD   = 900 # 15 mins.

    def initialize(options = {})
      FileUtils.mkdir_p(CRAPEDIR)
      @options      = options
      @config       = ConfigStore.new(CONFIG_FILE)
      @data         = ConfigStore.new(DATA_FILE)
      @logger       = Logger.new(LOG_FILE, 'daily')
      @item_count   = 0
      @last_runtime = nil
    end

    def log
      @logger
    end

    def set_last_runtime(query, tm = Time.now)
      @data[@options[:category]] = {} if @data[@options[:category]].nil?
      @data[@options[:category]][query] = {} if @data[@options[:category]][query].nil?
      @data[@options[:category]][query]['last_runtime'] = tm.to_s
      puts(">>> setting last_runtime: #{@data[@options[:category]][query]['last_runtime']}") if @options[:verbose]
      @data.save
      tm
    end

    def get_last_runtime(query)
      return @last_runtime unless @last_runtime.nil?
      begin
        @last_runtime = Time.parse(@data[@options[:category]][query]['last_runtime'])
      rescue
        # Initially set last_runtime to a date far in the past
        @last_runtime = set_last_runtime(query, Time.parse("2000-01-01 12:00:00 -0600"))
      end
      puts(">>> getting last_runtime: #{@last_runtime}") if @options[:verbose]
      return @last_runtime
    end

    def notify(text)
      log.info("notify: #{text}")
      puts(">>> sending sms to #{@config['mail']['to']}") if @options[:verbose]
      mail = Mail.new
      mail.to = @config['mail']['to'].to_s
      mail.from = @config['mail']['from'].to_s
      mail.body = text
      mail.deliver!
    end

    def search(query)
      puts(">>> searching [#{@options[:category]}] for: '#{query}' in: #{@options[:in]}") if @options[:verbose]
      time_started = Time.now
      Craigler.search(@options[:category], :in => @options[:in], :for => query) do |item|
        if item[:published_at] > get_last_runtime(query)
          @item_count += 1
          formatted_msg = <<-stop.here_with_pipe(true)
            |┃#{item[:title].yellow.bold}
            |┃#{item[:url].blue.bold.underline}
            |╰#{'━'*60}┫#{item[:published_at].strftime("%D, %a @%R")}
          stop
          raw_msg = <<-stop.here_with_pipe(true)
            |#{item[:title]}
            |> #{item[:url]}
            |> #{item[:published_at].strftime("%D, %a @%R")}
          stop
          if @options[:color]
            puts(formatted_msg)
          else
            puts(raw_msg)
          end
          notify(raw_msg) if @options[:notify]
        end
      end
      set_last_runtime(query, time_started) if @item_count > 0
    end

  end

end
