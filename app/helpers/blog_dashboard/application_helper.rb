module BlogDashboard
  module ApplicationHelper
    def title(page_title, show_title = true)
      @show_title = show_title
      if @show_title
        content_for(:title) { h(page_title.to_s) }
      end
    end

    def show_title?
      @show_title
    end

    def custom_label(object, field, title = nil)
      "#{title || field.to_s.humanize} #{object.translatable?(field) ? '<abbr title="Translatable"><i class="icon-flag"></i></abbr> ' : nil}".html_safe
    end

    # Can search for named routes directly in the main app, omitting
    # the "main_app." prefix
    def method_missing method, *args, &block
      if main_app_url_helper?(method)
        main_app.send(method, *args)
      else
        super
      end
    end

    private

    def main_app_url_helper?(method)
      BlogDashboard::configuration.inline_main_app_named_routes and
        (method.to_s.end_with?('_path') or method.to_s.end_with?('_url')) and
        main_app.respond_to?(method)
    end

  end
end
