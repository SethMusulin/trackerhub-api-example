class TrackerApi
  def initialize
    @token = ENV["PIVOTAL_TOKEN"]
  end

  def projects
    project_hashes = JSON.parse(
      connection.get("/services/v5/projects").body
    )

    project_hashes.map do |project_hash|
      Project.new(project_hash)
    end
  end

  def stories(options)
    project_id = options.fetch(:project_id)

    stories_hashes = JSON.parse(
      connection.get("/services/v5/projects/#{project_id}/stories").body
    )

    stories_hashes.map do |story_hash|
      Story.new(story_hash)
    end
  end

  private

  def connection
    Faraday.new(:url => "https://www.pivotaltracker.com") do |faraday|
      faraday.adapter(Faraday.default_adapter)
    end.tap do |conn|
      conn.headers["X-TrackerToken"] = @token
    end
  end
end