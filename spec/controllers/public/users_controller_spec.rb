require 'rails_helper'
RSpec.describe Public::UsersController, type: :controller do
    describe "#top" do
        # 正常にレスポンスを返すこと 
        it "responds successfully" do
            get :top
            expect(response).to be_successful
        end
    end
    # 200レスポンスを返すこと
    it "returns a 200 response" do
        get :top
        expect(response).to have_http_status "200" 
    end
end
