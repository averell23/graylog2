default.graylog2.unicorn.worker_timeout = 180
default.graylog2.unicorn.worker_processes = 4
default.graylog2.unicorn.port = 8499
default.graylog2.unicorn.gem_home = nil
default.graylog2.unicorn.stderr_path = 'log/stderr.log'
default.graylog2.unicorn.stdout_path = 'log/stdout.log'
default.graylog2.unicorn.logger = 'log/unicorn.log'
default.graylog2.unicorn.pid = 'unicorn.pid'
default.graylog2.unicorn.process_name = 'unicorn'
default.graylog2.unicorn.options = ":tcp_nodelay => true, :backlog => 4096"
default.graylog2.unicorn.socket.file = "unicorn.socket"
default.graylog2.unicorn.socket.options = ":backlog => 64"