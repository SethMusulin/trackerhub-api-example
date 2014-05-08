require "spec_helper"

feature "a user viewing their projects" do
  scenario "showing all projects and project stories for that user" do
    VCR.use_cassette "features/projects" do
      visit "/"

      click_on "View Projects"

      expect(page).to have_content("Github Issues - In class example")
      expect(page).to have_content("gSchool.it")
    end
  end
  
  scenario "shows the all stories for a project" do
    VCR.use_cassette "features/projects/finished_stories" do
      visit "/"

      click_on "View Projects"
      click_on "Tracker Explorer"

      expect(page).to have_content("As a user, I can view all of my projects")
      expect(page).to have_content("As a user, I can view all of the stories for a project")
    end
  end

  scenario "viewing comments on a story" do
    VCR.use_cassette "features/projects/story_comments" do
      visit "/projects/1073652"
      
      expect(page).to have_content("This is a test comment on the first story")
      expect(page).to have_content("This is a second test comment on the first story")
      expect(page).to have_content("This is a comment on the comment story")
    end
  end
  
  scenario "viewing github comments associated with stories" do
    VCR.use_cassette "features/projects/github_comments" do
      visit "/projects/1073652"

      expect(page).to have_content("[#70776466] Implement comments on projects")
      expect(page).to have_content("This is a comment on this commit")
    end
  end
end