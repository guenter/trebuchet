class Trebuchet::Backend::Memory

  def initialize
    @hash = {}
  end

  def get_strategy(feature_name)
    @hash.fetch(feature_name, nil)
  end

  def set_strategy(feature, strategy, options = nil)
    @hash.store(feature, [strategy, options])
  end

  def append_strategy(feature, strategy, options = nil)
    @hash.store(feature, get_strategy(feature) + [strategy, options])
  end
  
  def get_features
    @hash.keys
  end

end
