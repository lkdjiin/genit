# -*- encoding: utf-8 -*-

module Genit

  # Utily methods for a news (an article).
  class NewsUtils

    def self.get_date_from_filename filename
       File.basename(filename).gsub(/\..*$/, '')
    end

  end

end
