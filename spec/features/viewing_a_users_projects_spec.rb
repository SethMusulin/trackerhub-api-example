require "spec_helper"

feature "a user viewing their projects" do
  scenario "showing all projects for that user" do
    VCR.use_cassette "features/projects" do
      visit "/"

      click_on "View Projects"

      expect(page).to have_content("GitHub Explorer")
      expect(page).to have_content("gSchool.it")
    end
  end
end