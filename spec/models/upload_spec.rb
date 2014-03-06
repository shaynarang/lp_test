require 'spec_helper'

describe Upload do

  before(:each) do
    @upload = Upload.new
    @upload.file = Rack::Test::UploadedFile.new("features/support/files/test.txt", "text/txt")
    @upload.save
    @content = @upload.file.read
  end

  it "should return content" do
    @content.should_not be_nil
    File.read("features/support/files/test.txt").should match @content
  end

  it "should return sections" do
    @upload.sections.should == ["[header]\\\n  project: Programming Test\\\n  budget : 4.5\\\n  accessed :205\\\n\\\n  ", "[meta data]\\\n  description : This is a tediously long description of the Lonely Planet\\\n    programming test that you are taking. Tedious isn't the right word, but\\\n    it's the first word that comes to mind.\\\n\\\n  correction text: I meant 'moderately,' not 'tediously,' above.\\\n\\\n  ", "[ trailer ]\\\n  budget:all out of budget.\n\\fs26 \\\n"]
  end

  it "should return section names" do
    @upload.section_names.should == ["[header]", "[meta data]", "[ trailer ]"]
  end

  it "should return a section name" do
    sections = @upload.sections
    section = sections[0]
    @upload.section_name(section).should == "header"
  end

  it "should return key value pairs" do
    sections = @upload.sections
    section = sections[0]
    @upload.key_value_pairs(section).should == {"accessed" => "205", "budget" => "4.5", "project" => "Programming Test"}
  end

  it "should return remove slashes" do
    sections = @upload.sections
    section = sections[1]
    @upload.remove_slashes(section).should == "[meta data]\\\n  description : This is a tediously long description of the Lonely Planet programming test that you are taking. Tedious isn't the right word, but it's the first word that comes to mind.\\\n\\\n  correction text: I meant 'moderately,' not 'tediously,' above.\\\n\\\n  "
  end

  it "should format text" do
    text = "Lonely Planet    programming test "
    @upload.format_text(text).should == "Lonely Planet programming test"
  end
    
end
