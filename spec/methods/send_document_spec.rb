# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:config) { TeleRb::TelegramConfig.new("123456789") }
  let(:bot) { TeleRb::TelegramBot.new(:config) }

  describe "Document Message Sending" do
    it "send a document" do
      chat_id = "123"
      document_path = "./spec/fixtures/exemple.rar"
      caption = "Check out this document!"
      allow(bot).to receive(:send_media).with(chat_id, document_path, caption, nil, "sendDocument",
                                              :document).and_return("Document Sent with success!")
      expect(bot.send_document(chat_id, document_path, caption)).to eq("Document Sent with success!")
    end
  end
end
