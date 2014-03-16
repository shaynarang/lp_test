class Upload < ActiveRecord::Base
  before_create :read_file

  attr_accessor :file
  attr_accessor :content

  has_many :sections, :dependent => :destroy
  accepts_nested_attributes_for :sections

  has_many :keys, :through => :sections
  accepts_nested_attributes_for :keys

  has_many :values, :through => :keys
  accepts_nested_attributes_for :values

  default_scope { order :id }

  def read_file
    file.rewind
    self.content = file.read
    set_properties(self.file)
  end

  def set_properties file
    self.file_name = file.original_filename

    all_sections.each do |single_section|
      title = section_name(single_section)
      section = self.sections.build(title: title)
      pairs = key_value_pairs(single_section)
      pairs.each do |pair|
        title = pair[0]
        content = pair[1]
        key = section.keys.build(title: title)
        key.values.build(content: content)
      end
    end
  end

  def all_sections
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