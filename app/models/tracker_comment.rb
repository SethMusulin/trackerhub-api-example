class TrackerComment
  def initialize(comment_hash)
    @comment_hash = comment_hash
  end

  def text
    @comment_hash["text"]
  end

  def owner
    text.split("/")[3]
  end

  def repo
    text.split("/")[4]
  end

  def sha
    text.split("/")[6].split(" ").first
  end

  def commit_comment?
    text.include?("Commit by")
  end
end