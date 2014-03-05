class Upload < ActiveRecord::Base

  attr_reader :content
  
  def self.import(content)
    @content ||= content.read
  end

  def self.section_names
    section_names = @content.scan(/\[.*?\]/)
  end

  def self.sections
    counter = 0
    section_indices = []
    section_names.each do 
      section_indices << @content.index(section_names[counter])
      counter += 1
    end

    section_indices << -1
    counter = 0
    sections = []
    (section_indices.length - 1).times do 
      sections << @content[section_indices[counter]...section_indices[counter + 1]]
      counter += 1
    end
    sections
  end

  def self.flattened_section_names
    stripped_section_names = @content.scan(/\[(.*?)\]/).flatten
  end

  def self.keys
    keys = @content.scan(/(.+):/).flatten
  end

  def self.values
    values = @content.scan(/:(.+)/).flatten
  end

  def self.stripper(array)
    array.each do |item|
      item.strip!
    end
  end

end