module TeX2md
  class EndDocument
    attr_reader :name
    def initialize
      @name = nil
    end

    def execute(translator, _, _)
      translator.finish_command
      translator.finish_document
    end

    def to_s
      "#{self.class}"
    end
  end
end