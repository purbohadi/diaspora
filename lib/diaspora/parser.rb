#   Copyright (c) 2010, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

module Diaspora
  module Parser
    def self.from_xml(xml)
      doc = Nokogiri::XML(xml) { |cfg| cfg.noblanks }
      doc.xpath('/XML/post').children.inject([]) do |result, object|
        class_name = object.name.gsub('-', '/')
        marshalled_object = class_name.camelize.constantize.from_xml object.to_s
        result << marshalled_object
      end
    end
  end
end
