require_relative "../test_helper"

module Unit
  class TestStatusQuo < MiniTest::Test

    describe StatusQuo do
      it "has the current version" do
        version = File.read(project_file("VERSION")).strip
        assert_equal version, StatusQuo::VERSION
        assert File.read(project_file("CHANGELOG.rdoc")).include?("Version #{version} ")
      end

      describe ".resources" do
        it "returns an array" do
          assert StatusQuo.resources.is_a?(Array)
        end

        it "is memoized" do
          assert_equal StatusQuo.resources.object_id, StatusQuo.resources.object_id
        end
      end

      describe ".watch" do
        it "initializes a new StatusQuo::Resource" do
          StatusQuo::Resource.expects(:new).with(:identifier)
          StatusQuo.watch(:identifier)
        end

        it "executes the given code block to the StatusQuo::Resource" do
          object = mock
          object.expects(:foobar)
          StatusQuo.watch(:identifier) do
            object.foobar
          end
        end

        it "appends the initialized resource to StatusQuo.resources" do
          resource = mock
          StatusQuo::Resource.expects(:new).with(:identifier).returns(resource)
          StatusQuo.watch(:identifier)
          assert_equal StatusQuo.resources.last.object_id, resource.object_id
        end
      end
    end

  end
end
