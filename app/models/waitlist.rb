class Waitlist
  def self.add(uuid)
    if opponent = REDIS.spop("waiting")
      # spop gets a random member
      Game.start(uuid, opponent)
    else
      REDIS.sadd("waiting", uuid)
    end
  end

  def self.remove(uuid)
    REDIS.srem("waiting", uuid)
  end
end
