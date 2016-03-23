class IgnoredMacro
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def execute(translator, _, _)
    translator.finish_command
  end

  def to_s
    "#{self.class}"
  end
end