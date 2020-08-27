require 'open_food_network/paperclippable'

class ContentConfiguration < Spree::Preferences::FileConfiguration
  include OpenFoodNetwork::Paperclippable

  # Header
  preference :logo, :file
  preference :logo_mobile, :file
  preference :logo_mobile_svg, :file
  has_attached_file :logo, default_url: "/assets/hto-logo-black.png"
  has_attached_file :logo_mobile
  has_attached_file :logo_mobile_svg, default_url: "/assets/hto-mobile.svg"

  # Home page
  preference :home_page_alert_html, :text
  preference :home_hero, :file
  preference :home_show_stats, :boolean, default: true
  has_attached_file :home_hero, default_url: "/default_images/home.jpg"

  # Map
  preference :open_street_map_enabled, :boolean, default: false
  preference :open_street_map_provider_name, :string, default: "OpenStreetMap.Mapnik"
  preference :open_street_map_provider_options, :text, default: "{}"
  preference :open_street_map_default_latitude, :string, default: "-37.4713077"
  preference :open_street_map_default_longitude, :string, default: "144.7851531"

  # Producer sign-up page
  # All the following defaults using I18n don't work.
  # https://github.com/openfoodfoundation/openfoodnetwork/issues/3816
  preference :producer_signup_pricing_table_html, :text, default: I18n.t(:content_configuration_pricing_table)
  preference :producer_signup_case_studies_html, :text, default: I18n.t(:content_configuration_case_studies)
  preference :producer_signup_detail_html, :text, default: I18n.t(:content_configuration_detail)

  # Hubs sign-up page
  preference :hub_signup_pricing_table_html, :text, default: I18n.t(:content_configuration_pricing_table)
  preference :hub_signup_case_studies_html, :text, default: I18n.t(:content_configuration_case_studies)
  preference :hub_signup_detail_html, :text, default: I18n.t(:content_configuration_detail)

  # Groups sign-up page
  preference :group_signup_pricing_table_html, :text, default: I18n.t(:content_configuration_pricing_table)
  preference :group_signup_case_studies_html, :text, default: I18n.t(:content_configuration_case_studies)
  preference :group_signup_detail_html, :text, default: I18n.t(:content_configuration_detail)

  # Main URLs
  preference :menu_1, :boolean, default: true
  preference :menu_1_icon_name, :string, default: "ofn-i_019-map-pin"
  preference :menu_2, :boolean, default: true
  preference :menu_2_icon_name, :string, default: "ofn-i_037-map"
  preference :menu_3, :boolean, default: true
  preference :menu_3_icon_name, :string, default: "ofn-i_036-producers"
  preference :menu_4, :boolean, default: true
  preference :menu_4_icon_name, :string, default: "ofn-i_035-groups"
  preference :menu_5, :boolean, default: true
  preference :menu_5_icon_name, :string, default: "ofn-i_013-help"
  preference :menu_6, :boolean, default: false
  preference :menu_6_icon_name, :string, default: "ofn-i_035-groups"
  preference :menu_7, :boolean, default: false
  preference :menu_7_icon_name, :string, default: "ofn-i_013-help"

  # Footer
  preference :footer_logo, :file
  has_attached_file :footer_logo, default_url: "/assets/hto-logo-black.png"

  # Other
  preference :footer_facebook_url, :string, default: "https://www.facebook.com/harvesttoorder/"
  preference :footer_twitter_url, :string, default: ""
  preference :footer_instagram_url, :string, default: ""
  preference :footer_linkedin_url, :string, default: ""
  preference :footer_googleplus_url, :string, default: ""
  preference :footer_pinterest_url, :string, default: ""
  preference :footer_email, :string, default: "contact@harvesttoorder.com"
  preference :community_forum_url, :string, default: ""
  preference :footer_links_md, :text, default: <<-EOS.strip_heredoc
    [Newsletter sign-up](/)

    [News](/)

    [Calendar](/)
  EOS

  preference :footer_about_url, :string, default: ""

  # User Guide
  preference :user_guide_link, :string, default: 'https://guide.openfoodnetwork.org/'
end
