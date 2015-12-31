log_level               :debug
log_location            STDOUT
cache_type              'BasicFile'
cache_options           path: '~/.chef/checksums'
repo_mode               'everything'
versioned_cookbooks     true
cookbook_copyright      'Vox Media, Inc'
cookbook_email          'operations-team@voxmedia.com'
chef_server_url         ENV['CHEF_SERVER_URL']
node_name               ENV['CHEF_USERNAME']
chef_repo_path          ENV['CHEF_REPO_PATH']
client_key              ENV['CHEF_CLIENT_KEY_PATH']
validation_key          ENV['CHEF_VALIDATION_KEY_PATH']
