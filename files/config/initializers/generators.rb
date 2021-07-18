return unless Rails.env.development?

Rails.application.configure do
  config.generators do |g|
    g.assets false              # default: true
    # g.force_plural            # default: false
    g.helper false              # default: true
    # g.integration_tool        # default: :test_unit
    # g.system_tests            # default: :test_unit
    # g.orm                     # default: false / :active_record
    # g.resource_controller     # default: :controller
    # g.resource_route          # default: true
    # g.scaffold_controller     # default: :scaffold_controller
    g.stylesheets false         # default: true
    # g.stylesheet_engine       # default: :css
    g.scaffold_stylesheet false # default: true
    # g.test_framework          # default: false / :minitest
    # g.template_engine :slim   # default: :erb
  end
end
