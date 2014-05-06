class TrackerApi
  def initialize
    @token = ENV["PIVOTAL_TOKEN"]
  end

  def projects
    get("/services/v5/projects").map do |project_hash|
      Project.new(project_hash)
    end
  end

  def stories(options)
    project_id = options.fetch(:project_id)

    get("/services/v5/projects/#{project_id}/stories").map do |story_hash|
      Story.new(story_hash)
    end
  end

  def get(url)
    JSON.parse(
      connection.get(url).body
    )
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