require 'spec_helper'

describe Ethon::Easies::Http::Actions::Head do
  let(:easy) { Ethon::Easy.new }
  let(:url) { "http://localhost:3001/" }
  let(:params) { nil }
  let(:form) { nil }
  let(:head) { described_class.new(url, {:params => params, :body => form}) }

  describe "#setup" do
    before { head.setup(easy) }

    it "sets nobody" do
      easy.nobody.should be
    end

    it "sets url" do
      easy.url.should eq(url)
    end

    context "when params" do
      let(:params) { {:a => "1&"} }

      it "attaches escaped to url" do
        easy.url.should eq("#{url}?a=1%26")
      end

      context "when requesting" do
        before do
          easy.prepare
          easy.perform
        end

        it "has no body" do
          easy.response_body.should be_empty
        end
      end
    end
  end
end