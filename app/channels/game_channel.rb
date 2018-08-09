class GameChannel < ApplicationCable::Channel
  def subscribed
    Seek.create(uuid) unless REDIS.smembers("seeks").include? uuid
    stream_from "player_#{uuid}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def move(data)
    Game.move(uuid, data)
  end
end
