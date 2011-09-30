task :kill_postgres_connections => :environment do
  if /linux/i === Config::CONFIG["host_os"]
    sudo_flags = "sudo -u postgres"
  else
    sudo_flags = ""
  end

  db_name = "#{File.basename(Rails.root)}_#{Rails.env}"
  sh = <<EOF
echo "Killing PostgreSQL connections to #{db_name}" ;
ps xa \
  | grep postgres: \
  | grep #{db_name} \
  | grep -v grep \
  | awk '{print $1}' \
  | xargs #{sudo_flags} kill
EOF
  puts `#{sh}`
end

task "db:drop" => :kill_postgres_connections
