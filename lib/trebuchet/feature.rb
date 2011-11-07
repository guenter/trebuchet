class Trebuchet::Feature

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.find(name)
    new(name)
  end
  
  def self.all
    Trebuchet.backend.get_features.map{|name| new(name)}
  end

  def strategy
    Trebuchet::Strategy.for_feature(self)
  end
  
  def valid?
    begin
      !!Trebuchet::Strategy.for_feature(self)
    rescue ArgumentError
      return false
    end
  end

  def launch_at?(user)
    !user.nil? && strategy.launch_at?(user)
  end

  def aim(strategy_name, options = nil)
    if chained?
      Trebuchet.backend.append_strategy(self.name, strategy_name, options)
    else
      Trebuchet.backend.set_strategy(self.name, strategy_name, options)
    end
    @chained = true
    self
  end
  
  def as_json(options = {})
    {:name => @name}.tap do |h|
      h[:strategy] = strategy if valid?
    end
  end

  private

  def chained?
    @chained
  end

end
