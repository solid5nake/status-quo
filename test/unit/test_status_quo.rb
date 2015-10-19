require_relative "../test_helper"

module Unit
  class TestStatusQuo < MiniTest::Test

    describe StatusQuo do
      it "has the current version" do
        version = File.read(project_file("VERSION")).strip
        assert_equal version, StatusQuo::VERSION
        assert File.read(project_file("CHANGELOG.rdoc")).include?("Version #{version} ")
      end
    end

  end
end
