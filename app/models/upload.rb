class Upload < ActiveRecord::Base
  before_validation :set_properties
  attr_accessor :file
  attr_accessor :content

  def set_properties
    self.properties = parse(self.file)
  end

  def parse file
    file.rewind
    self.content = file.read
    
    content_hash = {}

    sections.each do |section|
      content_hash[section_name(section)] = key_value_pairs(section)
    end 
    content_hash
  end

  def sections
    section_indices = section_names.map { |section_name| content.index(section_name) }
    section_indices << -1

    counter = 0
    sections = []
    (section_indices.length - 1).times do 
      sections << content[section_indices[counter]...section_indices[counter + 1]]
      counter += 1
    end
    sections
  end

  def section_names
    content.scan(/\[.*?\]/)
  end

  def section_name section
    format_text(section[/\[.*?\]/])
  end

  def key_value_pairs section
    pairs = {}
    section = remove_slashes(section)
    chunks = section.scan(/\w+\s*\w+?\s*:\s*.+$/)
    chunks.each do |chunk|
      chunk = chunk.split(":")
      pairs[format_text(chunk[0])] = format_text(chunk[1])
    end
    pairs
  end

  def remove_slashes section
    section.gsub(/\\\s{5}/, " ")
  end

  def format_text text
    text.gsub(/[\[\]\/\\]/, "").squish.strip
  end

end