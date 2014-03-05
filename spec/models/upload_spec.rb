require 'spec_helper'

describe Upload do

  before(:each) do
    file = Rack::Test::UploadedFile.new("features/support/files/test.txt", "text/txt")
    Upload.import(file)
  end

  after(:all) do
    file = Rack::Test::UploadedFile.new("features/support/files/test.txt", "text/txt")
    File.delete("public/uploads/lp_test.txt")
  end

  it "should return content" do
    content = Upload.content
    content.should_not be_nil
    content.should include File.read("features/support/files/test.txt")
  end

  it "should return section names" do
    Upload.section_names.should == ["[header]", "[meta data]", "[ trailer ]"]
  end

  it "should return sections" do
    Upload.sections.should == ["[header]\\\n  project: Programming Test\\\n  budget : 4.5\\\n  accessed :205\\\n\\\n  ", "[meta data]\\\n  description : This is a tediously long description of the Lonely Planet\\\n    programming test that you are taking. Tedious isn't the right word, but\\\n    it's the first word that comes to mind.\\\n\\\n  correction text: I meant 'moderately,' not 'tediously,' above.\\\n\\\n  ", "[ trailer ]\\\n  budget:all out of budget.\n\\fs26 \\\n"]
  end

  it "should return flattened section names" do
    Upload.flattened_section_names.should == ["header", "meta data", " trailer "]
  end

  it "should return keys" do
    Upload.keys.should == ["  project", "  budget ", "  accessed ", "  description ", "  correction text", "  budget"]
  end

  it "should return values" do
    Upload.values.should == [" Programming Test\\", " 4.5\\", "205\\", " This is a tediously long description of the Lonely Planet\\", " I meant 'moderately,' not 'tediously,' above.\\", "all out of budget."]
  end

  it "should strip" do
    array = ["  project", "  budget ", "  accessed ", "  description ", "  correction text", "  budget"]
    Upload.stripper(array).should == ["project", "budget", "accessed", "description", "correction text", "budget"]
  end
    
end
