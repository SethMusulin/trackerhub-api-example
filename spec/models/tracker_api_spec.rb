require "spec_helper"

describe TrackerApi do
  describe "#projects" do
    it "lists all the projects for the current API token" do
      VCR.use_cassette "projects" do
        projects = TrackerApi.new.projects

        names = projects.map(&:name)

        expect(names).to include("GitHub Explorer")
        expect(names).to include("gSchool.it")
      end
    end
  end
end