require 'rails_helper'

RSpec.describe ApiCall, :type => :model do

  before(:each) do
    @api_call = FactoryGirl.build(:api_call)
  end

  it 'is invalid when empty' do
    api_call = ApiCall.new
    expect(api_call.invalid?).to be true
  end

  it 'must have a source' do
    @api_call.source = nil
    expect(@api_call.invalid?).to be true

    @api_call.source = :web
    expect(@api_call.valid?).to be true
  end

  it 'must have a status' do
    @api_call.status = nil
    expect(@api_call.invalid?).to be true

    @api_call.status = :web
    expect(@api_call.valid?).to be true
  end
end