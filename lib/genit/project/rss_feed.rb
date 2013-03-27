# -*- encoding: utf-8 -*-

require 'rss/maker'

module Genit

  # RssFeed could generate the RSS (version 2.0) file of the project.
  # To generate the RSS file, we need data from the project config
  # file (.config) and the list of the news.
  class RssFeed

    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    # news_files  - An Array filled with the full path name
    #               of the news files
    # config      - A Hash representing the project config file (.config)
    def initialize working_dir, news_files, config
      @working_dir = working_dir
      @news_files = news_files
      @config = config
      @destination = File.join(@working_dir, 'rss.xml')
    end

    # Public: Generate the RSS file (named rss.xml) at the web site
    # root (www/).
    def generate_rss
      content = RSS::Maker.make("2.0") do |feed|
        RssFeedMeta.fill feed, @config
        RssFeedItems.new(feed, @news_files, @config).fill
      end
      File.open(@destination, "w") { |file| file.write(content) }
    end

  end

  # Meta data of an RSS Field
  class RssFeedMeta
    def self.fill feed, config
      channel = feed.channel
      channel.title = config[:rss_title]
      channel.link = config[:address]
      channel.description = config[:rss_description]
      feed.items.do_sort = true
    end
  end

  # Items of an RSS Field
  class RssFeedItems
 
    def initialize feed, news_files, config
      @feed = feed
      @news_files = news_files
      @config = config
    end

    def fill
      @news_files.each do |news|
        item = @feed.items.new_item
        item.title = RssFeedItemTitle.new(news).title
        item.link = @config[:address]
        item.date = Time.parse(NewsUtils.get_date_from_filename(news))
      end
    end

  end

  # Retrieve the title element of an item element of an RSS feed
  # from a news article.
  class RssFeedItemTitle

    # Public: Get the first title content from a news article.
    #
    # We first search for <h1> header level, then <h2>, etc to <h6>.
    # If the news article doesn't contains any <h*> element, the
    # title() method returns the ISO date string (yyyy-mm-dd) found
    # in the news article pathname.
    #
    # Returns the String title of the news article.
    attr_reader :title

    def initialize news_pathname
      @news_pathname = news_pathname
      @title = NewsUtils.get_date_from_filename @news_pathname
      doc = HtmlDocument.open_fragment(@news_pathname)
      ('h1'..'h6').each do |header|
        tag = doc.at_css(header)
        if tag
          @title = tag.inner_html
          break
        end
      end
    end
 
  end

end
