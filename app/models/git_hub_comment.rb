class GitHubComment
  def initialize(comment_hash)
    @comment_hash = comment_hash
  end

  def id
    @comment_hash.fetch("id")
  end

  def text
    @comment_hash.fetch("body")
  end
end