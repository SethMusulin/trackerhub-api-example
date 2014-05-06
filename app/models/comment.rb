class Comment
  def initialize(comment_hash)
    @comment_hash = comment_hash
  end

  def text
    @comment_hash["text"]
  end
end