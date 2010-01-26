require 'haml'

module Haml::Filters
  module HikiDoc
    include Base
    lazy_require 'hikidoc'

    def render_with_options(text, options)
      method = [:html4, :html5].include?(options[:format]) ? :to_html : :to_xhtml
      ::HikiDoc.send(method, text, options[:hikidoc] || {})
    end
  end
end
