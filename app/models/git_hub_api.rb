class GitHubApi
  def comments_for(options)
    tracker_comments = options.fetch(:tracker_comments)

    commit_comments = tracker_comments.select(&:commit_comment?)

    commit_comments .flat_map do |tracker_comment|
      text       = tracker_comment.text.split("/")
      owner      = text[3]
      project_id = text[4]
      commit_sha = text[6].split(" ").first

      get("/repos/#{owner}/#{project_id}/commits/#{commit_sha}/comments").map do |comment_hash|
        GitHubComment.new(comment_hash)
      end
    end
  end

  private

  def get_json(url)
    JSON.parse(
      connection.get(url).body
    )
  end

  alias :get :get_json

  def connection
    Faraday.new(:url => "https://api.github.com") do |faraday|
      faraday.adapter(Faraday.default_adapter)
    end
  end
end