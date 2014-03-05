class Upload < ActiveRecord::Base
  
  def self.import(file)
    name = "lp_test.txt"
    directory = "public/uploads"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(file.read) }
  end

  def self.content
    file = File.open("public/uploads/lp_test.txt")
    content = ""
    file.each_line do |line|
      content << line
    end
    content
  end

  def self.section_names
    section_names = content.scan(/\[.*?\]/)
  end

  def self.sections
    counter = 0
    section_indices = []
    section_names.each do 
      section_indices << content.index(section_names[counter])
      counter += 1
    end

    section_indices << -1
    counter = 0
    sections = []
    (section_indices.length - 1).times do 
      sections << content[section_indices[counter]...section_indices[counter + 1]]
      counter += 1
    end
    sections
  end

  def self.flattened_section_names
    stripped_section_names = content.scan(/\[(.*?)\]/).flatten
  end

  def self.keys
    keys = content.scan(/(.+):/).flatten
  end

  def self.values
    values = content.scan(/:(.+)/).flatten
  end

  def self.stripper(array)
    array.each do |item|
      item.strip!
    end
  end

end