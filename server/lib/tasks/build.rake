namespace :build do
  task :client do
    `cd ../client && lineman build`
    `rm -rf ./public/css`
    `rm -rf ./public/js`
    `mv ../client/dist/* ./public`
    puts "You're good to go."
  end
end