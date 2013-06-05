module BlogDashboard

  class DemoGeneratorViewsPosts < Rails::Generators::Base
    source_root File.expand_path("../../../../../app/views/blog_dashboard/demo/posts", __FILE__)

    def copy_view_files
      copy_file "index.html.haml", 'app/views/demo/posts/index.html.haml'
      copy_file "_post.html.haml", 'app/views/demo/posts/_post.html.haml'
      copy_file "_new_comment.html.haml", 'app/views/demo/posts/_new_comment.html.haml'
      copy_file "show.html.haml", 'app/views/demo/posts/show.html.haml'
      copy_file "_comment.html.haml", 'app/views/demo/posts/_comment.html.haml'
    end

  end

  class DemoGeneratorLayout < Rails::Generators::Base
    source_root File.expand_path("../../../../../app/views/layouts/blog_dashboard", __FILE__)

    def copy_layout
      copy_file "demo.html.haml", 'app/views/layouts/demo.html.haml'
    end

  end


  class DemoGeneratorControllerPosts < Rails::Generators::Base

    def copy_controller
      file_path = File.expand_path("../../app/controllers/blog_dashboard/demo/posts_controller.rb")

      file = File.read(file_path)
      file.gsub!('BlogDashboard::Demo::PostsController', 'Demo::PostsController')
      file.gsub!("layout 'blog_dashboard/demo'", "layout 'demo'")
      create_file 'app/controllers/demo/posts_controller.rb', file
    end

  end


  class DemoGenerator < Rails::Generators::Base
     desc "Copy demo blog to your application."

     invoke DemoGeneratorViewsPosts
     invoke DemoGeneratorLayout
     invoke DemoGeneratorControllerPosts


     def add_demo_routes

       demo_routes = <<ROUTES
namespace :demo do
    root to: "posts#index"
    resources :posts  do
      post 'create_comment', on: :member
    end
  end
ROUTES

      route demo_routes
    end
  end
end