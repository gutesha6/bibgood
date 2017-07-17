HighVoltage.configure do |config|
  # Removes '/page' from URI
  config.route_drawer = HighVoltage::RouteDrawers::Root
end
