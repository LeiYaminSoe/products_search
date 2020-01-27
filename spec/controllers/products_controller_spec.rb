require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #index" do
    it 'routes GET to #index to ProductsController#index' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "products" do
    let(:valid_title) { "%zeta%" }
    let(:invalid_title) { "%unknown%" }
    
    let(:valid_description) { "%zeta%" }
    let(:invalid_description) { "%unknown%" }
    
    let(:valid_description) { "%zeta%" }
    let(:invalid_description) { "%unknown%" }
      
    it "can search by title" do
      valid_products = Product.where("title ILIKE ?", valid_title)
      get :index
      valid_products.each do |valid_product| 
        expect(valid_product.title).to include( "Zeta" )
      end
      
     # # get :index, :q => {:title_cont => 'zeta'}
      # #get :index, params[:q][:g][:title_cont] = 'zeta'
      # get :index, q: {title_cont: 'zeta'}
       # #:params => { :q => params }
      # assigns(:products).each do |product| 
        # expect(product.title).to include( "Zeta" )
      # end
            
    end
    
    #[:q][:name_cont]
    
    it "can't search by title" do
      invalid_products = Product.where("title ILIKE ?", invalid_title)
      get :index
      expect(invalid_products).not_to be_present
    end
    
    it "can search by description" do
      valid_products = Product.where("description ILIKE ?", valid_description)
      get :index
      valid_products.each do |valid_product| 
        expect(valid_product.description).to include( "Zeta" )
      end
    end
    
    it "can't search by description" do
      invalid_products = Product.where("description ILIKE ?", invalid_description)
      get :index
      expect(invalid_products).not_to be_present
    end
    
    it "can search by description" do
      valid_products = Product.where("description ILIKE ?", valid_description)
      get :index
      valid_products.each do |valid_product| 
        expect(valid_product.description).to include( "Zeta" )
      end
    end
    
    it "can't search by description" do
      invalid_products = Product.where("description ILIKE ?", invalid_description)
      get :index
      expect(invalid_products).not_to be_present
    end
    
  end
  
end


# RSpec.describe CoursesController , type: :controller do
    # describe "#index" do
        # let!(:search_params) { 'math' }
        # let!(:tutor) { create :user, user_type: :tutor }
        # let!(:math_course) { create(:post, title: "math", user_id: tutor.id) }
        # let(:assigns_courses) { assigns(:courses) }

    # before { @request.env['devise.mapping'] = Devise.mappings[:user] }
    # before { sign_in tutor }



        # it "get all records match the key words" do

            # get :search, q: {title_or_description_or_tagnames_title_cont: 'math'}

            # expect(assigns_courses).to include math_course
        # end
    # end
# end