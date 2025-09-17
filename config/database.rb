# required in lib/database.rb
DATABASE_CONFIG = {
  'development' => {
    'adapter' => 'postgresql',
    'database' => 'rb_active_record_repository_pattern_development',
    'username' => 'matthewgoodwin', # my pg username (could hide this)
    'password' => '',
    'host' => 'localhost',
    'port' => 5432
  },
  'test' => {
    'adapter' => 'postgresql',
    'database' => 'rb_active_record_repository_pattern_test',
    'username' => 'matthewgoodwin', # my pg username (could hide this)
    'password' => '',
    'host' => 'localhost',
    'port' => 5432
  }
}