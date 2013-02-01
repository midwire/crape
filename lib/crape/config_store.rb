require 'yaml'

class ConfigStore
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def load
    begin
      @config ||= YAML::load(open(file))
      @config = {} if @config.nil?
    rescue Errno::ENOENT
      File.open(file, 'w') {|f| f.write("---\n")}
      retry
    end
    self
  end

  def [](key)
    load
    @config[key]
  end

  def []=(key, value)
    @config[key] = value
  end

  def delete(*keys)
    keys.each { |key| @config.delete(key) }
    save
    self
  end

  def update(c={})
    @config.merge!(c)
    save
    self
  end

  def save
    File.open(file, 'w') { |f| f.write(YAML.dump(@config)) }
    self
  end
end
