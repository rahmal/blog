class Blog::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_initializer_file
    copy_file "blog.rb", "config/initializers/blog.rb"
  end

  def add_route
    route 'mount Blog::Engine => "/blog"'
  end

  def copy_migrations
    # Normally, we'd just call 'rake
    # "blog:install:migrations"' to do this for us, but it's
    # much more difficult to test.  So we roll our own version.
    copy_matching_files_from_gem('db/migrate/*.rb')
  end

  def copy_locales
    copy_matching_files_from_gem('config/locales/blog.*.yml')
  end

  def copy_sidebar
    copy_matching_files_from_gem('app/views/layouts/blog/_sidebar.html.erb')
  end

  def copy_stylesheets
    copy_matching_files_from_gem('lib/assets/stylesheets/blog/_config.css.scss')
    copy_matching_files_from_gem('lib/assets/stylesheets/blog/layout.css.scss')
    copy_matching_files_from_gem('lib/assets/stylesheets/blog/customizations.css.scss')
  end

  def register_javascripts
    in_root do
      begin
        #if File.exists?('app/assets/javascripts/application.js')
        append_file("app/assets/javascripts/application.js", "//= require blog\n", :before => /^\/\/= require_self/)
      rescue
        puts 'Could not find file: "#{Rails.root}/app/assets/javascripts/application.js"'
        puts 'Checking for: "#{Rails.root}/app/assets/javascripts/application.js.coffee"'
        append_file("app/assets/javascripts/application.js.coffee", "#= require blog\n", :before => /^#= require_self/)
      end
    end
  end

  def register_stylesheets
    in_root do
      begin
        inject_into_file("app/assets/stylesheets/application.css", " *= require blog\n", :before => /^\ *= require/)
      rescue
        puts 'Could not find file: "#{Rails.root}/app/assets/stylesheets/application.css"'
        puts 'Checking for: "#{Rails.root}/app/assets/stylesheets/application.css.scss"'
        inject_into_file("app/assets/stylesheets/application.css.scss", " *= require blog\n", :before => /^\ *= require/)
      end
    end
  end

  private

  def gem_path(path)
    File.expand_path("../../../../../#{path}", __FILE__)
  end

  def copy_matching_files_from_gem(pattern)
    matches = gem_path(pattern)
    Dir[matches].each do |path|
      copy_file path, "#{File.dirname(pattern)}/#{File.basename(path)}"
    end
  end
end
