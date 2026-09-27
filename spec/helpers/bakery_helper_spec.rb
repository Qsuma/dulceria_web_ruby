require "rails_helper"

RSpec.describe BakeryHelper, type: :helper do
  describe "#whatsapp_link" do
    it "builds a wa.me URL with digits-only number and URL-encoded greeting" do
      profile = instance_double(BakeryProfile,
        whatsapp_number: "+53 5309 3905",
        whatsapp_greeting: "Hola, quisiera más información sobre sus productos.")

      link = helper.whatsapp_link(profile)

      expect(link).to eq(
        "https://wa.me/5353093905?text=" \
        "#{ERB::Util.url_encode('Hola, quisiera más información sobre sus productos.')}"
      )
    end
  end
end
