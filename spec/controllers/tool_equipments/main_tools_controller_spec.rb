require 'rails_helper'

RSpec.describe ToolEquipments::MainToolsController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:main_tool_attributes) { FactoryGirl.attributes_for(:main_tool) }
  let(:unvalid_main_tool_attributes) { FactoryGirl.attributes_for(:main_tool,
                                                                  title: '',
                                                                  type: '',
                                                                  serial_number: '',
                                                                  passport_number: '',
                                                                  date: '',
                                                                  brand: '')}
  let!(:main_tool) { FactoryGirl.create(:main_tool) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it { expect { post :create, main_tool: main_tool_attributes, format: :js }.to change(MainTool, :count).by(1) }
    it 'not add main_tool for none current user', :skip_before do
      expect {
        post :create, { main_tool: main_tool_attributes, format: :js }
      }.to_not change(MainTool, :count)
    end
    it { expect { post :create, main_tool: unvalid_main_tool_attributes, format: :js }.to_not change(MainTool, :count) }
  end

  describe '#update' do
    before do
      put :update, { id: main_tool.id, main_tool: main_tool_attributes, format: :json }
      main_tool.reload
    end

    it { expect(main_tool.title).to eql(main_tool_attributes[:title]) }
    it { expect(main_tool.type).to eql(main_tool_attributes[:type]) }
    it { expect(main_tool.serial_number).to eql(main_tool_attributes[:serial_number].to_s) }
    it { expect(main_tool.passport_number).to eql(main_tool_attributes[:passport_number]) }
    it { expect(main_tool.brand).to eql(main_tool_attributes[:brand]) }
  end

  describe '#destroy' do
    it { expect { delete :destroy, id: main_tool.id, format: :js }.to change(MainTool, :count).by(-1) }
  end
end
