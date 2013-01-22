module ActsAsFilterable

  class Configuration

    def add_filter(name, &block)
      ActsAsFilterable.filtering.send :add_filter, name, &block
    end

  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end

end
