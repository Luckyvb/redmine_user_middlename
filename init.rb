Redmine::Plugin.register :user_middlename do
  name 'User Middlename plugin'
  author '!Lucky'
  description 'Add middle name to user'
  version '0.0.1'
  url 'https://github.com/redmine_user_middlename'
  author_url 'https://github.com/Luckyvb'

  settings partial: 'settings/middlename',
    default: {
      'field_id' => nil
    }

end

def init
  Dir::foreach(File.join(File.dirname(__FILE__), 'lib')) do |file|
    next unless /\.rb$/ =~ file
    require_dependency file
  end
end

if Rails::VERSION::MAJOR >= 5
  ActiveSupport::Reloader.to_prepare do
    init
  end
elsif Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    init
  end
else
  Dispatcher.to_prepare :user_middlename do
    init
  end
end

Rails.application.config.to_prepare do
  UserMiddlename.apply_patch
end
