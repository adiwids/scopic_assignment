class TopPlayerQuery
  attr_reader :query

  def self.call(filters = [])
    new.fetch(filters)
  end

  def initialize
    @query = Player.joins(:player_skills).distinct.order('player_skills.value DESC')
  end

  def fetch(filters = [])
    collection = query

    collection
  end
end
