# frozen_string_literal: true

module ApplicationHelper
  include SettingsHelper

  def nav_bar(&)
    content_tag(:ul, class: "navbar-nav", &)
  end

  def nav_link(path, &)
    options = current_page?(path) ? { class: "nav-item active" } : { class: "nav-item" }
    content_tag(:li, options) do
      link_to(path, class: "nav-link", &)
    end
  end

  def settings_nav_link(&)
    options = current_page?(edit_space_path(@space)) || roles_page? ? { class: "nav-item active" } : { class: "nav-item" }
    content_tag(:li, options) do
      link_to(edit_space_path(@space), class: "nav-link", &)
    end
  end

  def roles_page?
    controller = "spaces/roles"
    actions = %w[index new edit]
    actions.any? { |action| params[:controller] == controller && params[:action] == action }
  end

  def user_spaces
    @user_spaces ||= current_user.spaces.order(:name).filter(&:active?)
  end

  def abbrev_name(name)
    name.blank? ? "?" : name.split.map(&:first).join(".")
  end

  def demo_mode?
    ENV["DEMO_MODE"] == "true"
  end
end
