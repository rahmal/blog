require 'spec_helper'

describe Blog::Filters::Code do
  let(:filter) { Blog::Filters::Code.new }

  describe ".process" do
    it "applies syntax highlighting to code blocks" do
      output = filter.process(<<END_OF_CODE, :lang => 'ruby')
def foo
  42
end
END_OF_CODE
      output.should match(/foo/)
    end
  end
end
