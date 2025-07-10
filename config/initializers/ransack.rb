# config/initializers/ransack.rb
Ransack.configure do |config|
  # Allow searching on ActiveStorage::Attachment attributes
  config.add_predicate 'null', 
    arel_predicate: 'null',
    formatter: proc { |v| v == '1' ? true : false },
    validator: proc { |v| v.in?(['1', '0', 'true', 'false']) },
    type: :boolean

  config.add_predicate 'not_null',
    arel_predicate: 'not_null', 
    formatter: proc { |v| v == '1' ? true : false },
    validator: proc { |v| v.in?(['1', '0', 'true', 'false']) },
    type: :boolean
end
