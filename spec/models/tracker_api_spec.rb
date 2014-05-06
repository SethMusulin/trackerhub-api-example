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

  describe "#stories" do
    it "lists all the stories for a project id" do
      VCR.use_cassette "projects/1073652/stories" do
        stories = TrackerApi.new.stories(:project_id => 1073652)

        expect(stories.length).to eq(3)

        names = stories.map(&:name)
        expect(names).to include("As a user, I can view all of my projects")
        expect(names).to include("As a user, I can view all of the stories for a project")
        expect(names).to include("As a user, I can view comments for a story")
      end
    end
  end
end