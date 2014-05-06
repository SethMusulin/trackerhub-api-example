require "spec_helper"

describe GitHubApi do
  describe "#comments_for" do
    it "returns all comments based on tracker comments" do
      VCR.use_cassette "github/project/tracker-api-example/commit_comment" do
        tracker_comment = TrackerComment.new("text" => "Commit by Jeff Taggart https://github.com/jetaggart/tracker-api-example/commit/9bb903237447a032c80ba87cd6437c6769dfcd8c [#70776466] Implement comments on projects")

        commit_comments = GitHubApi.new.comments_for(:tracker_comments => [tracker_comment])
        expect(commit_comments.length).to eq(1)
        expect(commit_comments.first.text).to eq("This is a comment on this commit")
      end
    end

    it "rejects comments that aren't commit comments" do
      tracker_comment = TrackerComment.new("text" => "This is another commit")

      commit_comments = GitHubApi.new.comments_for(:tracker_comments => [tracker_comment])
      expect(commit_comments.length).to eq(0)
    end
  end
end