file '.rubocop.yml', <<~'CODE'.strip_heredoc
  AllCops:
    Exclude:
      - 'bin/**/*'
      - 'db/schema.rb'
      - 'db/migrate/**/*'
      - 'node_modules/**/*'

  # Ignoring these cops. Delete these lines if you want them included.
  Layout/LineLength:
    Enabled: false
  Style/Documentation:
    Enabled: false
  Style/ClassAndModuleChildren:
    Enabled: false

  # New-ish cops.
  Lint/RaiseException:
    Enabled: true
  Lint/StructNewOverride:
    Enabled: true
  Style/HashEachMethods:
    Enabled: true
  Style/HashTransformKeys:
    Enabled: true
  Style/HashTransformValues:
    Enabled: true
CODE
