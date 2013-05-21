# BlogDashboard (Alpha)

BlogDashboard is a mountable blog dashboard for Rails apps with Mongodb as backend.

## Goals

  * Manage the typical content of a blog: posts, taxonomies, comments...
  * Not interfere with public controllers or views.
  * Be customizable.


## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'blog_dashboard'
```


And then execute:

    $ bundle

Modify your config/routes.rb and add:

``` ruby
mount BlogDashboard::Engine => '/admin/blog'
```

Include `BlogDashboard::Author` in your 'author' class.
This include a `has_many :posts`

```ruby
class User

  ...
  include BlogDashboard::Author
  ...

  def to_s
    name
  end

end
```ruby



## Configuration

```ruby
BlogDashboard.configure do |config|

  # The name of the before filter we'll call to authenticate the current user.
  # Defaults to :login_required
  config.authentication_method = :authenticate_user!

  # The name of the controller method we'll call to return the current_user.
  config.current_user_method = :current_user


  # Should the routes of the main app be accessible without
  # the "main_app." prefix ?
  config.inline_main_app_named_routes = false


  # Regular expresion for the public path of a post
  # accepted only :id as params
  # example: /posts/:id.html
  config.post_public_path_expresion = nil


  # Defaults to nil, use the layout of the BlogDashboard
  config.layout = nil

end
```

If change the layout you should keept in mind:

  * Add `//= require blog_dashboard/application` to your javascript.
  * Specify the path to te partials `render 'application/admin_menu'` instead of `render 'admin_menu'`.
  * Add prefix `main_app` to the main app routes or set `inline_main_app_named_routes = true`.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
