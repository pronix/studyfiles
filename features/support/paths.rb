# -*- coding: utf-8 -*-
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^главной странице$/
      '/'
    when /главную страницу/
      root_path
    when /^Мои файлы$/
      '/documents'
    when /страницу логов/
      logs_path
    when /редактирования настроек/
      edit_account_path
    when /страницу дискуссий/
      discussions_path
    when /пользовательскую страницу "(.+)"/
      user_path(User.find_by_email($1))
    when /страницу загрузки документов для пользователя "(.+)"/
      new_user_document_path(User.find_by_email($1))
    when /университетскую страницу "(.+)"/
      university_folders_path(University.find_by_abbreviation($1))
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
