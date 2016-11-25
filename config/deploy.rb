lock "3.6.1"

set :linked_dirs, %w{log public/assets public/system public/uploads tmp/pids tmp/cache tmp/sockets vendor/bundle }
set :linked_files, %w{config/database.yml config/secrets.yml}

set :bundle_jobs, 4
set :bundle_without, %w{development test}.join(' ')

set :puma_preload_app, false
set :puma_threads, [ 8, 32 ]
set :puma_workers, 1

set :deploy_to, "/var/www/dawn_patrol"
set :repo_url, "git://github.com/scottwillson/dawn-patrol.git"

set :user, "dawn_patrol"

task :compress_assets_7z do
  on roles(:app) do
    assets_path = release_path.join('public', fetch(:assets_prefix))
    execute "find -L #{assets_path} \\( -name *.js -o -name *.css -o -name *.ico \\) -exec bash -c '[ ! -f {}.gz ] && 7z a -tgzip -mx=9 {}.gz {}' \\; "
  end
end

after 'deploy:normalize_assets', 'compress_assets_7z'
