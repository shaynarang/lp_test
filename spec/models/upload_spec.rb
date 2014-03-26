require 'spec_helper'

describe Upload do

  before(:all) do
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
    @upload.all_sections.should == ["[header]\\\n  project: Programming Test\\\n  budget : 4.5\\\n  accessed :205\\\n\\\n  ", "[meta data]\\\n  description : This is a tediously long description of the Lonely Planet\\\n    programming test that you are taking. Tedious isn't the right word, but\\\n    it's the first word that comes to mind.\\\n\\\n  correction text: I meant 'moderately,' not 'tediously,' above.\\\n\\\n  ", "[ trailer ]\\\n  budget:all out of budget.\n\\fs26 \\\n"]
  end

  it "should return section names" do
    @upload.section_names.should == ["[header]", "[meta data]", "[ trailer ]"]
  end

  it "should return a section name" do
    sections = @upload.all_sections
    section = sections[0]
    @upload.section_name(section).should == "header"
  end

  it "should return key value pairs" do
    sections = @upload.all_sections
    section = sections[0]
    @upload.key_value_pairs(section).should == {"accessed" => "205", "budget" => "4.5", "project" => "Programming Test"}
  end

  it "should return remove slashes" do
    sections = @upload.all_sections
    section = sections[1]
    @upload.remove_slashes(section).should == "[meta data]\\\n  description : This is a tediously long description of the Lonely Planet programming test that you are taking. Tedious isn't the right word, but it's the first word that comes to mind.\\\n\\\n  correction text: I meant 'moderately,' not 'tediously,' above.\\\n\\\n  "
  end

  it "should format text" do
    text = "Lon[ely Planet    progra]]mming test "
    @upload.format_text(text).should == "Lonely Planet programming test"
  end

  it "should return a filename without extension" do
    @upload.file_name_without_ext.should == "test"
  end

  it "should format for download" do
    upload_string =
    '<div class="parsed_file">
      <div id="section">
        <p class="section_title"> [header] </p>
          <p> project: Programming Test </p>
          <p> budget: 4.5 </p>
          <p> accessed: 205 </p>
      </div>
      <div id="section">
        <p class="section_title"> [meta data] </p>
          <p> description: This is a tediously long description of the Lonely Planet programming test that you are taking. Tedious isn&#39;t the right word, but it&#39;s the first word that comes to mind. </p>
          <p> correction text: I meant &#39;moderately,&#39; not &#39;tediously,&#39; above. </p>
      </div>
      <div id="section">
        <p class="section_title"> [trailer] </p>
          <p> budget: all out of budget. </p>
      </div>
    </div>'
    tags = ['<div>', '</div>', '&quot;', '<div class="parsed_file">', '<div id="section">', '<p>', '</p>', '&#39;']
    tags.each do |tag|
      Upload.format_for_download(upload_string).should_not include tag
    end
  end

  it "should check for duplicate section names" do
    @upload.duplicate_section_names?.should == false
  end

  it "should check for duplicate key names" do
    @upload.duplicate_key_names?.should == false
  end
    
end
