module BlogDashboard

  class DemoGeneratorViewsPosts < Rails::Generators::Base
    source_root File.expand_path("../../../../../app/views/blog_dashboard/demo/posts", __FILE__)

    def copy_view_files
      copy_file "index.html.haml", 'app/views/demo/posts/index.html.haml'
      copy_file "_post.html.haml", 'app/views/demo/posts/_post.html.haml'
      copy_file "_new_comment.html.haml", 'app/views/demo/posts/_new_comment.html.haml'
      copy_file "show.html.haml", 'app/views/demo/posts/show.html.haml'
    end

  end

  class DemoGeneratorControllerPosts < Rails::Generators::Base
    # source_root File.expand_path("../../../../../app/controllers/blog_dashboard/demo/", __FILE__)

    def copy_controller
      file_path = File.expand_path("../../app/controllers/blog_dashboard/demo/posts_controller.rb")

      file = File.read(file_path)
      file.gsub('BlogDashboard::Demo::PostsController', 'Demo::PostsController')
      create_file 'app/controllers/demo/posts_controller.rb', file
      # copy_file "posts_controller.rb", 'app/controllers/demo/posts_controller.rb'
    end

  end


  class DemoGenerator < Rails::Generators::Base
     desc "Copy demo blog to your application."

     invoke DemoGeneratorViewsPosts
     invoke DemoGeneratorControllerPosts

     def add_demo_routes
      # FIXME: destroy don´t work

demo_routes = %Q{
  namespace :demo do
    root to: "posts#index"
    resources :posts  do
      post 'create_comment', on: :member
    end
  end
}
      route demo_routes
    end
  end

end