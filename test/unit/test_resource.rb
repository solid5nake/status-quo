require_relative "../test_helper"

module Unit
  class TestResource < MiniTest::Test

    describe StatusQuo::Resource do

      describe "#initialize" do
        it "stores the passed identifier" do
          resource = StatusQuo::Resource.new(:foo)
          assert_equal :foo, resource.instance_variable_get(:@identifier)
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
          assert_equal :foo, resource.identifier
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
        it "initializes a new StatusQuo::Resource::Segment" do
          resource = StatusQuo::Resource.new(:foo)
          StatusQuo::Resource::Segment.expects(:new).with(:foo, :identifier)
          resource.segment(:identifier)
        end

        it "executes the given code block indirectly (the segment instance actually executes it)" do
          object = mock
          object.expects(:foobar)
          resource = StatusQuo::Resource.new(:identifier)
          resource.segment(:identifier) do
            object.foobar
          end
        end

        it "appends the initialized segment to StatusQuo::Resource#segments" do
          segment = mock
          StatusQuo::Resource::Segment.expects(:new).with(:identifier, :foo).returns(segment)
          resource = StatusQuo::Resource.new(:identifier)
          resource.segment(:foo)
          assert_equal segment.object_id, resource.segments.last.object_id
        end
      end

      describe "#confirm!" do
        it "iterates through its segments and invokes #confirm! on them" do
          resource = StatusQuo::Resource.new(:identifier)
          segment1 = mock
          segment2 = mock
          segment1.expects(:confirm!)
          segment2.expects(:confirm!)
          resource.segments.push(segment1, segment2)
          resource.confirm!
        end
      end
    end

  end
end
