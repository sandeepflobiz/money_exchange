class ExchangeRate
  attr_accessor :params
  def initialize(params)
    @params =params
  end

  def call
    redis = Redis.current
    redis.set("rupee_dollar",@params[:rupee_dollar])
    redis.set("dollar_rupee",@params[:dollar_rupee])
    redis.set("rupee_pound",@params[:rupee_pound])
    redis.set("pound_rupee",@params[:pound_rupee])
    redis.set("dollar_pound",@params[:dollar_pound])
    redis.set("pound_dollar",@params[:pound_dollar])
  end
end
