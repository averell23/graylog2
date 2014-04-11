default.graylog2.basedir = "/var/graylog2"
default.graylog2.bundle_gems_folder = "/bundle/gems"
default.graylog2.shared_run_directory = "/shared/run"

default.graylog2.server.version = "0.20.1"
default.graylog2.web_interface.version = "0.20.1"
default.graylog2.web_interface.user = "nobody"
default.graylog2.web_interface.group = "nobody"
default.graylog2.web_interface.port = 8080
default.graylog2.mongodb.host = "127.0.0.1"
default.graylog2.mongodb.port = 27017
default.graylog2.mongodb.max_connections = 500
default.graylog2.mongodb.database = "graylog2"
default.graylog2.mongodb.auth = "false"
default.graylog2.mongodb.user = "user"
default.graylog2.mongodb.password = "password"
default.graylog2.send_stream_alarms = true
default.graylog2.send_stream_subscriptions = true
default.graylog2.stream_alarms_cron_minute = "*/15"
default.graylog2.stream_alarms_email = "graylog2alarms@example.org"
default.graylog2.stream_subscriptions_cron_minute = "*/15"
default.graylog2.stream_subscriptions_email = "graylog2alarms@example.org"
default.graylog2.stream.email_web_interface_url = "http://your-graylog2.example.org"
# The number of parallel running processors
# Raise this number if you buffers are filling up
default.graylog2.processbuffer_processors = 5
default.graylog2.outputbuffer_processors = 5
default.graylog2.graphite.enabled = 'false'
default.graylog2.graphite.carbon_host = '127.0.0.1'
default.graylog2.graphite.carbon_tcp_port = '2003'
default.graylog2.graphite.prefix = 'logs'

# Configure the database size. On our system one doc takes less than 0.01 megs,
# So this setting would sum up to 10*1GB with a some margine of error.
default.graylog2.max_docs_per_index = 1000000
default.graylog2.max_indices = 10

# Wait strategy describing how buffer processors wait on a cursor sequence.
# Possible types:
#  - yielding
#     Compromise between performance and CPU usage.
#  - sleeping
#     Compromise between performance and CPU usage. Latency spikes can occur after quiet periods.
#  - blocking
#     High throughput, low latency, higher CPU usage.
#  - busy_spinning
#     Avoids syscalls which could introduce latency jitter. Best when threads can be bound to specific CPU cores.
default.graylog2.processor_wait_strategy = 'blocking'


# Email transport
default.graylog2.transport.email_enabled = "false"
default.graylog2.transport.email_hostname = "mail.example.com"
default.graylog2.transport.email_port = "587"
default.graylog2.transport.email_use_auth = "true"
default.graylog2.transport.email_use_tls = "true"
default.graylog2.transport.email_auth_username = "you@example.com"
default.graylog2.transport.email_auth_password = "secret"
default.graylog2.transport.email_subject_prefix = "[graylog2]"
default.graylog2.transport.email_from_email = "graylog2@example.com"
default.graylog2.transport.email_from_name = "Graylog2"
