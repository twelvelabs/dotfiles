log_level               :debug
log_location            STDOUT
cache_type              'BasicFile'
cache_options           path: '~/.chef/checksums'
repo_mode               'everything'
versioned_cookbooks     true
cookbook_copyright      'Vox Media, Inc'
cookbook_email          'operations-team@voxmedia.com'
chef_server_url         'https://chef.voxops.net'

node_name               ENV['CHEF_USERNAME'] 'skip'
chef_repo_path          ENV['CHEF_REPO_PATH'] '~/Projects/chef-berkshelf'
client_key              ENV['CHEF_CLIENT_KEY_PATH'] '~/.secrets/chef-client.pem'
validation_key          ENV['CHEF_VALIDATION_KEY_PATH'] '~/.secrets/chef-validator.pem'
