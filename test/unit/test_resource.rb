require_relative "../test_helper"

module Unit
  class TestResource < MiniTest::Test

    describe StatusQuo::Resource do

      describe "#initialize" do
        it "stores the passed identifier" do
          resource = StatusQuo::Resource.new(:foo)
          assert_equal resource.instance_variable_get(:@identifier), :foo
        end

        it "executes the given block" do
          object = mock
          object.expects(:foobar)
          StatusQuo::Resource.new(:identifier) do
            object.foobar
          end
        end
      end

      describe "#identifier" do
        it "returns its identifier" do
          resource = StatusQuo::Resource.new(:foo)
          assert_equal resource.identifier, :foo
        end
      end

      describe "#segments" do
        it "returns an array" do
          resource = StatusQuo::Resource.new(:foo)
          assert resource.segments.is_a?(Array)
        end

        it "is memoized" do
          resource = StatusQuo::Resource.new(:foo)
          assert_equal resource.segments.object_id, resource.segments.object_id
        end
      end

      describe "#segment" do
        it "initializes a new Resources::Segment" do
        end

        it "executes the given block to the Resources::Segment" do
        end

        it "appends the initialized segment to Resources.segments" do
        end
      end

    end

  end
end
