class ExchangeRate
  attr_accessor :params
  def initialize(params)
    @params =params
  end

  def call
    redis = $redis
    # redis = Redis.current
    # use better DS Instead of set , use base currency for conversion (use USD)
    redis.set("rupee",@params[:rupee])
    redis.set("pound",@params[:pound])
    redis.set("yen",@params[:rupee])
    redis.set("taka",@params[:pound])
    redis.set("dollar",1.00)
  end
end
