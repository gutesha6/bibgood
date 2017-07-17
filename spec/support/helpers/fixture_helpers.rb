module FixtureHelpers
  def fixture_file(file)
    File.read Rails.root.join('spec/fixtures', file)
  end
end
