# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:config) { TeleRb::TelegramConfig.new("123456789") }
  let(:bot) { TeleRb::TelegramBot.new(:config) }

  describe "Video Message Sending" do
    it "send a video" do
      chat_id = "123"
      video_path = "./spec/fixtures/exemple.mp4"
      caption = "Watch this video!"
      allow(bot).to receive(:send_media).with(chat_id, video_path, caption, nil, "sendVideo",
                                              :video).and_return("Video Sent with success!")
      expect(bot.send_video(chat_id, video_path, caption)).to eq("Video Sent with success!")
    end
  end
end
