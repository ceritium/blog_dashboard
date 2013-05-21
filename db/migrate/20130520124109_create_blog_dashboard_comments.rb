class CreateBlogDashboardComments < ActiveRecord::Migration
  def change
    create_table :blog_dashboard_comments do |t|

      t.timestamps
    end
  end
end
