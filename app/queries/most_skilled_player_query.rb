class MostSkilledPlayerQuery
  attr_reader :query

  def self.call(filters = [])
    new.fetch(filters)
  end

  def initialize
    @query = Player.joins(:player_skills).distinct.order('players.position ASC, player_skills.skill ASC, player_skills.value DESC')
  end

  def fetch(filters = [])
    collection = query

    collection
  end
end
