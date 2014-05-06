class BaseApi
  def connection
    Faraday.new(:url => base_url) do |faraday|
      faraday.adapter(Faraday.default_adapter)
    end
  end

  def base_url
    raise "Abstract: Child must implement this"
  end

  def get(url)
    JSON.parse(
      connection.get(url).body
    )
  end
end