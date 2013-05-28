module BlogDashboard
  class Engine < ::Rails::Engine
    isolate_namespace BlogDashboard

    config.generators do |g|
      g.orm             :mongoid
      g.template_engine :haml
      g.test_framework  :test_unit
    end
  end
end
