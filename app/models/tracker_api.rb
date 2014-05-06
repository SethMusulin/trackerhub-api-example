class TrackerApi < BaseApi
  def initialize
    @token = ENV["PIVOTAL_TOKEN"]
  end

  def projects
    get("/services/v5/projects", Project)
  end

  def stories(options)
    project_id = options.fetch(:project_id)

    get("/services/v5/projects/#{project_id}/stories", Story)
  end

  def comments(options)
    project_id = options.fetch(:project_id)
    story_ids  = options.fetch(:story_ids)

    story_ids.flat_map do |story_id|
      get("/services/v5/projects/#{project_id}/stories/#{story_id}/comments", TrackerComment)
    end
  end

  private

  def base_url
    "https://www.pivotaltracker.com"
  end

  def get(url, model_class)
    super(url).map do |hash|
      model_class.new(hash)
    end
  end

  def connection
    super.tap do |conn|
      conn.headers["X-TrackerToken"] = @token
    end
  end
end