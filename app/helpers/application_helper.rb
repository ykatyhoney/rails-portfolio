module ApplicationHelper
    def login_helper style = ''
        if current_user.is_a?(GuestUser)
            (link_to "Register", new_user_registration_path, class: style) + " " +
            (link_to "Login", new_user_session_path, class: style)
        else
            link_to "Logout", destroy_user_session_path, method: :delete, class: style
        end
    end

    def source_helper layout_name
        if session[:source]
            greeting = "Thanks for visiting from #{session[:source]}!"
            content_tag(:p, greeting, class: "source-#{layout_name}")
        end
    end

    def copyright_generator
        @copyright = ChznbaumViewTool::Renderer.copyright 'Chazona Baum', 'All rights reserved'
    end

    def nav_items
        [
            {
                url: root_path,
                title: 'Home'
            },
            {
                url: about_path,
                title: 'About'
            },
            {
                url: portfolios_path,
                title: 'Portfolio'
            },
            {
                url: contact_path,
                title: 'Contact'
            },
            {
                url: blogs_path,
                title: 'Blog'
            },
        ]
    end

    def nav_helper style, tag_type
        nav_links = ''
        nav_items.each do |item|
            nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
        end

        nav_links.html_safe
    end

    def active? path
        "active" if current_page? path
    end

    def alerts
        if flash[:alert]
            alert = flash[:alert]
            alert_image = :warning
            alert_title = "Alert"
        elsif flash[:error]
            alert = flash[:error]
            alert_image = :error
            alert_title = "Error"
        elsif flash[:notice]
            alert = flash[:notice]
            alert_image = :notice
            alert_title = "Notice"
        end
        
        if alert
            alert_generator alert, alert_image, alert_title
        end
    end

    def alert_generator msg, image, title
        js add_gritter(msg, image: image, title: title, sticky: false)
    end
end
