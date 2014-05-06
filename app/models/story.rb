class Story
  def initialize(story_hash)
    @story_hash = story_hash
  end

  def name
    @story_hash["name"]
  end
end