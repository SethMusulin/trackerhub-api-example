class GitHubApi < BaseApi
  def comments_for(options)
    tracker_comments = options.fetch(:tracker_comments)
    commit_comments  = tracker_comments.select(&:commit_comment?)

    commit_comments.flat_map do |tracker_comment|
      url = comments_url(
        owner: tracker_comment.owner,
        repo:  tracker_comment.repo,
        sha:   tracker_comment.sha
      )
      get(url).map do |comment_hash|
        GitHubComment.new(comment_hash)
      end
    end
  end

  def create_comment(options)
    body = {
      body: options.fetch(:text)
    }

    GitHubComment.new(
      post(comments_url(options), body)
    )
  end

  def comments_url(options)
    owner = options.fetch(:owner)
    repo  = options.fetch(:repo)
    sha   = options.fetch(:sha)

    "/repos/#{owner}/#{repo}/commits/#{sha}/comments"
  end

  private

  def post(url, body)
    JSON.parse(
      connection.post(url, body.to_json).body
    )
  end

  def base_url
    "https://api.github.com"
  end

  def connection
    super.tap do |conn|
      conn.basic_auth(ENV["GITHUB_USERNAME"], ENV["GITHUB_PASSWORD"])
    end
  end
end