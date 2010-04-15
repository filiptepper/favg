require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Favg" do
  before :all do
    @generic_favicon = File.read File.join(File.dirname(__FILE__), "fixtures", "generic.png")
    @google_favicon = File.read File.join(File.dirname(__FILE__), "fixtures", "google.png")
  end

  before :each do
    @response = mock("Stream")
    Kernel.stub!(:open).with(anything).and_return @response
  end

  context "fetch class method" do
    it "calls Kernel.open once when site has a favicon" do
      @response.stub!(:read).and_return @google_favicon
      Kernel.should_receive(:open).once.and_return @response

      favicon = Favg.fetch("killingcreativity.com")
      favicon.should == @google_favicon
    end

    it "calls Kernel.open twice when site has no favicon" do
      @response.stub!(:read).and_return @generic_favicon
      Kernel.should_receive(:open).twice.and_return @response

      favicon = Favg.fetch("killingcreativity.com")
      favicon.should == @generic_favicon
    end

    it "fetches website's favicon" do
      @response.stub!(:read).and_return @generic_favicon

      favicon = Favg.fetch("killingcreativity.com")
      favicon.should == @generic_favicon
    end
  end

  context "save class method" do
    it "saves website's favicon" do
      @response.stub!(:read).and_return @generic_favicon

      @file = mock("File")
      @file.should_receive(:write).once
      File.should_receive(:open).once.and_return @file

      favicon = Favg.save("killingcreativity.com", "killingcreavity.png")
      favicon.should == @file
    end
  end
end