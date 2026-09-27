module BakeryHelper
  # Builds a wa.me link that works on both mobile (opens the WhatsApp app) and
  # desktop (opens WhatsApp Web / prompts for the desktop app).
  def whatsapp_link(profile)
    digits = profile.whatsapp_number.gsub(/\D/, "")
    "https://wa.me/#{digits}?text=#{ERB::Util.url_encode(profile.whatsapp_greeting)}"
  end
end
