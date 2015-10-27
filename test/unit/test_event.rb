require_relative "../test_helper"

module Unit
  class TestEvent < MiniTest::Test

    describe StatusQuo::Event do
      it "inherits from ActiveRecord::Base" do
        assert StatusQuo::Event.new.is_a?(ActiveRecord::Base)
      end
    end

  end
end
