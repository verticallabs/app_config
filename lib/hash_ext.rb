class Hash
  # upcoming rails features, see
  # https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/hash/keys.rb
  def transform_keys
    result = {}
    each_key do |key|
      result[yield(key)] = self[key]
    end
    result
  end

  def transform_keys!
    keys.each do |key|
      self[yield(key)] = delete(key)
    end
    self
  end

  def deep_transform_keys(&block)
    result = {}
    each do |key, value|
      result[yield(key)] = value.is_a?(Hash) ? value.deep_transform_keys(&block) : value
    end
    result
  end

  def deep_transform_keys!(&block)
    keys.each do |key|
      value = delete(key)
      self[yield(key)] = value.is_a?(Hash) ? value.deep_transform_keys!(&block) : value
    end
    self
  end

  def deep_symbolize_keys
    deep_transform_keys{ |key| key.to_sym rescue key }
  end

  def deep_symbolize_keys!
    deep_transform_keys!{ |key| key.to_sym rescue key }
  end

  def deep_stringify_keys
    deep_transform_keys{ |key| key.to_s }
  end

  def deep_stringify_keys!
    deep_transform_keys!{ |key| key.to_s }
  end
end
