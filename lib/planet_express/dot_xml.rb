module DotXml
  class Object
    def self.xml_type
      name.gsub(/([a-z])([A-Z])/,'\1-\2').downcase
    end

    def xml_type
      self.class.xml_type
    end

    def xml( name = nil )
      name ? %{<#{name} type="#{xml_type}">#{self.to_s}</#{name}>} : self.to_s
    end

    def xml!( *args )
      %{<?xml version="1.0" encoding="UTF-8"?>\n} + xml( *args )
    end
  end

  class Integer
    def self.xml_type
      "integer"
    end
  end

  class Array
    def xml( array_name = :array, item_name = :item )
      %|<#{array_name} size="#{self.size}">|+map{|n|n.xml( :item )}.join+"</#{array_name}>"
    end
  end

  class Hash
    def xml( name = nil )
      data = to_a.map{|k,v|v.xml(k)}.join
      name ? "<#{name}>#{data}</#{name}>" : data
    end
  end
end
