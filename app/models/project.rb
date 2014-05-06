class Project
  def initialize(project_hash)
    @project_hash = project_hash
  end

  def name
    @project_hash["name"]
  end

  def id
    @project_hash["id"]
  end
end