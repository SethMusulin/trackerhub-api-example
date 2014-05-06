require "spec_helper"

feature "a user viewing their projects" do
  scenario "showing all projects and project stories for that user" do
    VCR.use_cassette "features/projects" do
      visit "/"

      click_on "View Projects"

      expect(page).to have_content("GitHub Explorer")
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
end