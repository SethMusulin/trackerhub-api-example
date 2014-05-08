require "spec_helper"

describe GitHubApi do
  describe "#comments_for" do
    it "returns all comments based on tracker comments" do
      VCR.use_cassette "github/project/tracker-api-example/commit_comment" do
        tracker_comments = [TrackerComment.new("text" => "Commit by Jeff Taggart https://github.com/jetaggart/tracker-api-example/commit/9bb903237447a032c80ba87cd6437c6769dfcd8c [#70776466] Implement comments on projects"),
                            TrackerComment.new("text" => "Commit by Jeff Taggart https://github.com/jetaggart/tracker-api-example/commit/bb670aa13fbd5228871fd1170f047b4e12ccd555 [#70780910] Added tracker comments for all stories")]

        commit_comments = GitHubApi.new.comments_for(:tracker_comments => tracker_comments)

        expect(commit_comments.length).to eq(2)

        texts = commit_comments.map(&:text)
        expect(texts).to include("This is a comment on this commit")
        expect(texts).to include("This is a second commit comment")
      end
    end

    it "rejects comments that aren't commit comments" do
      tracker_comment = TrackerComment.new("text" => "This is another commit")

      commit_comments = GitHubApi.new.comments_for(:tracker_comments => [tracker_comment])
      expect(commit_comments.length).to eq(0)
    end
  end

  describe "#create_comment" do
    it "creates a comment in github" do
      VCR.use_cassette "github/project/tracker-api-example/commit_comment/create" do
        git_hub_api = GitHubApi.new

        comment = git_hub_api.create_comment(:owner => "jetaggart",
                                             :repo  => "tracker-api-example",
                                             :sha   => "bb670aa13fbd5228871fd1170f047b4e12ccd555",
                                             :text  => "This is the comment text")

        expect(comment.id).to be
        expect(comment.text).to eq("This is the comment text")
      end
    end
  end
end