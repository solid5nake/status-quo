require_relative "../../test_helper"

module Unit
  module Resource
    class TestSegment < MiniTest::Test

      describe StatusQuo::Resource::Segment do

        describe "#initialize" do
          it "stores the passed resource" do
            segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
            assert_equal :resource, segment.instance_variable_get(:@resource)
          end

          it "stores the passed identifier" do
            segment = StatusQuo::Resource::Segment.new(:resource, :foo)
            assert_equal :foo, segment.instance_variable_get(:@identifier)
          end

          it "executes the given block" do
            object = mock
            object.expects(:foobar)
            StatusQuo::Resource::Segment.new(:resource, :identifier) do
              object.foobar
            end
          end
        end

        describe "#resource" do
          it "returns its resource" do
            segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
            assert_equal :resource, segment.resource
          end
        end

        describe "#identifier" do
          it "returns its identifier" do
            segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
            assert_equal :identifier, segment.identifier
          end
        end

        describe "#recipient" do
          describe "when given an argument" do
            it "stores the passed recipient" do
              segment = StatusQuo::Resource::Segment.new(:resource, :recipient)
              segment.recipient("engelenburg1980@gmail.com")
              assert_equal "engelenburg1980@gmail.com", segment.instance_variable_get(:@recipient)
            end
          end
          describe "when no argument is passed" do
            it "returns the stored recipient" do
              segment = StatusQuo::Resource::Segment.new(:resource, :recipient)
              assert_nil segment.recipient
              segment.instance_variable_set(:@recipient, "engelenburg1980@gmail.com")
              assert_equal "engelenburg1980@gmail.com", segment.recipient
            end
          end
        end

        describe "#schedule" do
          it "stores the passed schedule" do
            segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
            segment.schedule("0 * * * *")
            assert_equal "0 * * * *", segment.instance_variable_get(:@schedule)
          end
        end

        describe "#confirm" do
          it "stores the given block as an instance variable" do
            segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
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
            segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
            object = mock
            object.expects(:foobar)
            segment.confirm do
              object.foobar
              true
            end
            segment.confirm!
          end

          describe "when @confirm returns a non-boolean value" do
            it "raises an InvalidConfirmationError" do
              segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
              segment.confirm do
                :bram
              end
              assert_raises StatusQuo::InvalidConfirmationError do
                segment.confirm!
              end
            end
          end

          describe "when @confirm returns true" do
            it "accepts the true value" do
              segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
              segment.confirm do
                :bram == :bram
              end
              segment.confirm!
            end

            it "invokes #create_event! with true" do
              Time.expects(:now).returns(:now)
              segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
              segment.expects(:create_event!).with(:now, true)
              segment.confirm do
                true
              end
              segment.confirm!
            end
          end

          describe "when @confirm returns false" do
            it "accepts the false value" do
              segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
              segment.confirm do
                :bram == :engel
              end
              segment.confirm!
            end

            it "invokes #create_event! with false" do
              now = Time.now
              Time.expects(:now).at_least_once.returns(now)
              segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
              segment.expects(:create_event!).with(now, false)
              segment.confirm do
                false
              end
              segment.confirm!
            end

            it "invokes #notify" do
              segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
              segment.expects(:notify)
              segment.confirm do
                false
              end
              segment.confirm!
            end
          end
        end

        describe "#create_event!" do
          it "creates an event record 'moment' with time.now in the database" do
            segment = StatusQuo::Resource::Segment.new(:resource, :moment)
            segment.send :create_event!, Time.now, :status
          end

          describe "when passed 'status' true" do
            it "creates an event record in the db with status OK" do
              segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
              segment.send :create_event!, Time.now, true
              assert_equal "OK", StatusQuo::Event.last.status
            end
          end

          describe "when passed 'status' false" do
            it "creates an event record in the db with status FAIL" do
              segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
              segment.send :create_event!, Time.now, false
              assert_equal "FAIL", StatusQuo::Event.last.status
            end
          end
        end

        describe "#notify" do
          describe "when specified recipient" do
            it "sends an email to the recipient" do
              segment = StatusQuo::Resource::Segment.new(:resource, :recipient)
              segment.instance_variable_set(:@recipient, "foo@bar.com")
              segment.send :notify, StatusQuo::Event.new(:resource => "toys", :segment => "lego")
              assert_equal ["foo@bar.com"], ActionMailer::Base.deliveries.last.to
            end
          end
          describe "when no specified recipient" do
            it "does nothing" do
              segment = StatusQuo::Resource::Segment.new(:resource, :identifier)
              segment.send :notify, StatusQuo::Event.new
            end
          end
        end
      end

    end
  end
end
