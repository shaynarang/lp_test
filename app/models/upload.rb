class Upload < ActiveRecord::Base
  
  def self.import(file)
    name = "lp_test.txt"
    directory = "public/uploads"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(file.read) }
  end

end