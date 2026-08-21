require "rails_helper"

RSpec.describe "Bakery page", type: :request do
  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("WHATSAPP_CONTACT_NUMBER").and_return("+5353093905")
  end

  describe "GET /" do
    it "returns success" do
      get root_path
      expect(response).to have_http_status(:ok)
    end

    it "displays the bakery name and tagline in Spanish" do
      get root_path
      expect(response.body).to include("Dulces Lore")
      expect(response.body).to include("Panadería artesanal con el sabor de siempre")
    end

    it "displays at least one product highlight" do
      get root_path
      expect(response.body).to include("Pan de Yuca")
    end

    it "displays the address and business hours" do
      get root_path
      expect(response.body).to include("Calle Principal 123, Santa Clara, Cuba")
      expect(response.body).to include("Lunes a Sábado, 9:00 a.m. – 7:00 p.m.")
    end

    it "displays a social media coming soon section" do
      get root_path
      expect(response.body).to match(/redes sociales.*pr[oó]ximamente/i)
    end

    it "includes a WhatsApp contact link with the correct number and greeting" do
      get root_path
      expect(response.body).to include("https://wa.me/5353093905?text=")
      expect(response.body).to include(ERB::Util.url_encode("Hola, quisiera más información sobre sus productos."))
    end

    it "labels the WhatsApp link in Spanish" do
      get root_path
      expect(response.body).to include("Contactar por WhatsApp")
    end
  end

  describe "when WHATSAPP_CONTACT_NUMBER is missing" do
    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("WHATSAPP_CONTACT_NUMBER").and_return(nil)
    end

    it "fails fast with a clear configuration error" do
      expect { get root_path }.to raise_error(BakeryProfile::MissingWhatsappNumberError)
    end
  end
end
