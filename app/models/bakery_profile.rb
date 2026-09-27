# Plain Ruby object (not ActiveRecord) representing the bakery's content, loaded
# from config/bakery.yml. No database is used for this static, single-bakery page.
class BakeryProfile
  Product = Struct.new(:name, :description, :category, :image_path, keyword_init: true)

  class MissingWhatsappNumberError < StandardError
    def initialize
      super("WHATSAPP_CONTACT_NUMBER is not set. Configure it in .env before starting the app.")
    end
  end

  attr_reader :name, :tagline, :address, :business_hours, :products, :whatsapp_number

  WHATSAPP_GREETING = "Hola, quisiera más información sobre sus productos.".freeze

  def self.load
    config = YAML.load_file(Rails.root.join("config", "bakery.yml"))
    new(config)
  end

  def initialize(config)
    @name = config.fetch("name")
    @tagline = config.fetch("tagline")
    @address = config.fetch("address")
    @business_hours = config.fetch("business_hours")
    @products = config.fetch("products", []).map { |p| Product.new(**p.transform_keys(&:to_sym)) }
    @whatsapp_number = ENV["WHATSAPP_CONTACT_NUMBER"]
    raise MissingWhatsappNumberError if @whatsapp_number.blank?
  end

  def whatsapp_greeting
    WHATSAPP_GREETING
  end

  # Unique category names, in the order they first appear in config/bakery.yml.
  def categories
    products.map(&:category).uniq
  end

  # Products grouped by category, preserving category order.
  def products_by_category
    products.group_by(&:category)
  end

  def category_anchor(category)
    category.to_s.parameterize
  end
end
