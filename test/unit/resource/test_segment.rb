require_relative "../../test_helper"

module Unit
  module Resource
    class TestSegment < MiniTest::Test

      describe StatusQuo::Resource::Segment do

        describe "#initialize" do
          it "stores the passed identifier" do
            segment = StatusQuo::Resource::Segment.new(:foo)
            assert_equal :foo, segment.instance_variable_get(:@identifier)
          end

          it "executes the given block" do
            object = mock
            object.expects(:foobar)
            StatusQuo::Resource::Segment.new(:identifier) do
              object.foobar
            end
          end
        end

        describe "#identifier" do
          it "returns its identifier" do
            segment = StatusQuo::Resource::Segment.new(:identifier)
            assert_equal :identifier, segment.identifier
          end
        end

        describe "#schedule" do
          it "stores the passed schedule" do
            segment = StatusQuo::Resource::Segment.new(:identifier)
            segment.schedule("0 * * * *")
            assert_equal "0 * * * *", segment.instance_variable_get(:@schedule)
          end
        end

        describe "#confirm" do
          it "stores the given block as an instance variable" do
            segment = StatusQuo::Resource::Segment.new(:identifier)
            object = mock
            object.expects(:foobar)

            segment.confirm do
              object.foobar
            end

            assert segment.instance_variable_get(:@confirm).is_a?(Proc)
            segment.instance_variable_get(:@confirm).call
          end
        end

        describe "#confirm!" do
          it "executes the block given to #confirm" do
            segment = StatusQuo::Resource::Segment.new(:identifier)
            object = mock
            object.expects(:foobar)

            segment.confirm do
              object.foobar
              true
            end

            segment.confirm!
          end

          describe "return value validation" do
            describe "when @confirm returns true" do
              it "accepts the true value" do
                segment = StatusQuo::Resource::Segment.new(:identifier)
                segment.confirm do
                  :bram == :bram
                end
                segment.confirm!
              end
            end

            describe "when @confirm returns false" do
              it "accepts the false value" do
                segment = StatusQuo::Resource::Segment.new(:identifier)
                segment.confirm do
                  :bram == :engel
                end
                segment.confirm!
              end
            end

            describe "when @confirm returns a non-boolean value" do
              it "raises an InvalidConfirmationError" do
                segment = StatusQuo::Resource::Segment.new(:identifier)
                segment.confirm do
                  :bram
                end
                assert_raises StatusQuo::InvalidConfirmationError do
                  segment.confirm!
                end
              end
            end
          end

          describe "when @confirm returns true" do
            it "invokes #create_event! with true" do
              segment = StatusQuo::Resource::Segment.new(:identifier)
              segment.expects(:create_event!).with(true)
              segment.confirm do
                true
              end
              segment.confirm!
            end
          end
        end

        describe "#create_event!" do
          it "" do

          end
        end
      end

    end
  end
end
