namespace :sample do

    desc 'saying hi to cron'
    task :test => [ :environment ] do
       Redis.current.incr("abc")
    end
end
