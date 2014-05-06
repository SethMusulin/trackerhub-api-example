class TrackerApi
  def initialize
    @token = ENV["PIVOTAL_TOKEN"]
  end

  def projects
    get("/projects", Project)
  end

  def stories(options)
    project_id = options.fetch(:project_id)

    get("/projects/#{project_id}/stories", Story)
  end

  def comments(options)
    project_id = options.fetch(:project_id)
    story_ids  = options.fetch(:story_ids)

    story_ids.flat_map do |story_id|
      get("/projects/#{project_id}/stories/#{story_id}/comments", Comment)
    end
  end

  private

  def get(url, model_class)
    get_json(url).map do |hash|
      model_class.new(hash)
    end
  end

  def get_json(url)
    JSON.parse(
      connection.get("/services/v5#{url}").body
    )
  end

  def connection
    Faraday.new(:url => "https://www.pivotaltracker.com") do |faraday|
      faraday.adapter(Faraday.default_adapter)
    end.tap do |conn|
      conn.headers["X-TrackerToken"] = @token
    end
  end
end