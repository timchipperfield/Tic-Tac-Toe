class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{uuid}"
    WaitList.create(uuid)
    # stream_from "some_channel"
  end

  def unsubscribed
    WaitList.remove(uuid)
    # Any cleanup needed when channel is unsubscribed
  end
end
