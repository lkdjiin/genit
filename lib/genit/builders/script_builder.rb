# -*- encoding: utf-8 -*-

module Genit

  # Modify script tags.
  class ScriptBuilder < Relativizer

    # Public: Relativize the <script src=""> tags of a particular page.
    #
    # page_name - The string filename of the page.
    #
    # Returns the modified Nokogiri::XML::Document
    def build_for_page page_name
      build page_name,  @document.css("script")
    end

    private

      def update link
        super link, "src"
      end

  end

end
