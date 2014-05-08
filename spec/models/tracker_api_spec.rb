require "spec_helper"

describe TrackerApi do
  describe "#projects" do
    it "lists all the projects for the current API token" do
      VCR.use_cassette "projects" do
        projects = TrackerApi.new.projects

        names = projects.map(&:name)

        expect(names).to include("Github Issues - In class example")
        expect(names).to include("gSchool.it")
      end
    end
  end

  describe "#stories" do
    it "lists all the stories for a project id" do
      VCR.use_cassette "projects/1073652/stories" do
        stories = TrackerApi.new.stories(:project_id => 1073652)

        expect(stories.length).to eq(7)

        names = stories.map(&:name)
        expect(names).to include("As a user, I can view all of my projects")
        expect(names).to include("As a user, I can view all of the stories for a project")
      end
    end
  end

  describe "#comments" do
    it "lists all comments for all stories" do
      VCR.use_cassette "projects/1073652/stories/comments" do
        story_ids = [70776396, 70776466, 70776286]

        comments = TrackerApi.new.comments(:project_id => 1073652,
                                           :story_ids  => story_ids)

        expect(comments.length).to eq(4)

        names = comments.map(&:text)
        expect(names).to include("This is a test comment on the first story")
        expect(names).to include("This is a second test comment on the first story")
        expect(names).to include("This is a comment on the comment story")
      end
    end
  end
end