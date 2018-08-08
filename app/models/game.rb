class Game
  def self.start(uuid1, uuid2)
    x, o = [uuid1, uuid2].shuffle

    ActionCable.server.broadcast "player_#{x}", {action: "game_start", msg: "X"}
    ActionCable.server.broadcast "player_#{o}", {action: "game_start", msg: "O"}

    REDIS.set("opponent_for:#{x}", o)
    REDIS.set("opponent_for:#{o}", x)
  end
end
