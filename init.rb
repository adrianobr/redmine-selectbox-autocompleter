require 'redmine'
require 'selectbox_autocompleter/patches/application_helper_patch'

Redmine::Plugin.register :selectbox_autocompleter do
  name 'Selectbox Autocompleter plugin'
  author 'heriet'
  description 'This plugin generate Autocomplete box for Select box'
  version '1.2.１'
  url 'https://github.com/heriet/redmine-selectbox-autocompleter'
  author_url 'http://heriet.info'

  settings(:default => {
    'target_list' => [
       'issue_assigned_to_id',
       'values_assigned_to_id_1',
       'values_author_id_1',
       'wiki_page_parent_id',
       'project_quick_jump_box'
     ].join("\r\n"),
     'autocomplete_type' => 'select2',
  }, :partial => 'selectbox_autocompleter/settings')

  unless ApplicationHelper.included_modules.include?(ApplicationHelperPatch)
    ApplicationHelper.prepend(ApplicationHelperPatch)
  end

end

ActiveSupport::Reloader.to_prepare do
  require File.expand_path('../app/helpers/selectbox_autocompleter_helper', __FILE__)
  ActionView::Base.send :include, SelectboxAutocompleterHelper
end

require_dependency 'selectbox_autocompleter/hooks'
