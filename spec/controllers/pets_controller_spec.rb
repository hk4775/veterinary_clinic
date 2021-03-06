require 'spec_helper'
describe PetsController do
  before do
    let!(:pet) { FactoryGirl.create(:pet) }
    let!(:customer) {FactoryGirl.create(:profile)}
  end
  context 'display form to create new pet' do
    it 'loads list of pet types in  pet form' do
      get :new
      assigns(:pet_type).should == Pet::TYPES
    end

    it 'loads list of customers when display pet form' do
      FactoryGirl.create(:profile)
      get :new
      assigns(:customers).should == Profile.customer
    end
  end

  context 'create new pet' do
    it 'creates pet successfully' do
      post :create, FactoryGirl.attributes_for(:pet, customer: customer.id, name: 'snoopy', pet_type: "Dog", breed: 'Beagle', age: 3, weight: 2.5, date_last_visit: '2013/01/01')
      response.should be_success
    end

    it 'informs user if there is missing attribute' do
      post :create, FactoryGirl.attributes_for(:pet, customer: customer.id, name: nil, pet_type: "Dog", breed: nil, age: 3, weight: 12.5, last_visit: '2013/01/01' )
      assigns(:result).should == 'The following required attributes are missing: name,breed.'
    end

  end

end