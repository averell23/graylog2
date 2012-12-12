base_dir = File.join(File.dirname(__FILE__), '..')
log_level                :info
log_location             STDOUT
node_name                "default_client"
client_name              "default_client"
cache_type               'BasicFile'
cache_options( :path =>  File.join(base_dir, '.chef', 'checksums') )
cookbook_path            [File.join(base_dir, 'cookbooks'), File.join(base_dir, 'own_cookbooks')]
