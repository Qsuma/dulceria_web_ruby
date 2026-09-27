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

    it "displays the available celebration packs" do
      get root_path
      expect(response.body).to include("Pack Merienda")
      expect(response.body).to include("Pack Cumpleaños")
      expect(response.body).to include("Pack Fiesta")
      expect(response.body).to include("pack-visual-1")
      expect(response.body).to include("Crea tu <em>propia oferta.")
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

    it "includes the order cart WhatsApp link" do
      get root_path
      expect(response.body).to include("https://wa.me/5353093905")
      expect(response.body).to include("data-order-whatsapp")
    end

    it "labels the order action in Spanish" do
      get root_path
      expect(response.body).to include("Hacer orden")
      expect(response.body).to include("whatsapp-icon")
    end

    it "displays the how-we-work process section" do
      get root_path

      expect(response.body).to include('id="como-trabajamos"')
      expect(response.body).to include("Todo empieza con una")
      expect(response.body).to include("idea dulce.")
      expect(response.body).to include("En Dulces Lore hacemos que encargar tus dulces sea sencillo.")
      expect(response.body).to include("Elige")
      expect(response.body).to include("Personaliza")
      expect(response.body).to include("Confirmamos")
      expect(response.body).to include("Preparamos")
      expect(response.body).to include("Tú imaginas el momento. Nosotros ponemos el dulce.")
    end

    it "displays the quality and care section" do
      get root_path

      expect(response.body).to include('id="calidad-y-cuidado"')
      expect(response.body).to include("Hecho con cuidado.")
      expect(response.body).to include("Pensado para compartir.")
      expect(response.body).to include("Ingredientes y elaboración")
      expect(response.body).to include("Presentación")
      expect(response.body).to include("Pedidos personalizados")
      expect(response.body).to include("Atención cercana")
      expect(response.body).to include("Pequeños detalles hacen grandes momentos.")
    end

    it "adds the institutional sections to the drawer" do
      get root_path

      expect(response.body).to include('href="#como-trabajamos"')
      expect(response.body).to include('href="#calidad-y-cuidado"')
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
