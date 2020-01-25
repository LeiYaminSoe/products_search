class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if params[:price_compare].present?
      price_compare = params[:price_compare]
      case price_compare
      when "Cheaper than"
        params[:q][:price_eq] = ""
        params[:q][:price_gt] = ""
      when "Exactly that"
        params[:q][:price_lt] = ""
        params[:q][:price_gt] = ""
      else
        params[:q][:price_lt] = ""
        params[:q][:price_eq] = ""
      end
    end
    @q = Product.ransack(params[:q])
    
    shared_context = Ransack::Context.for(Product)
    search_parents = Product.ransack(params[:q], context: shared_context)
    search_children = Product.ransack(
      { tags_name_eq:  params[:q][:tags_name_cont]}, context: shared_context
    )    
    shared_conditions = [search_parents, search_children].map { |search|
      Ransack::Visitor.new.accept(search.base)
    }
    
    @products = Product.joins(shared_context.join_sources).where(shared_conditions.reduce(&:or)).result(distinct: true).page(params[:page]).per(10)
  
#debugger  
    
    
    
    
    # @products = @q.result(distinct: true).page(params[:page]).per(10)
    
    # if params[:q].present?
      # if params[:q][:tags_name_cont].present?
        # @relevance_products = Product.joins(:tags).where(:tags => {:name => params[:q][:tags_name_cont]})
      # end
    # end
  end
  
  def product_detail
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    product_detail = Product.find(params[:id])
    respond_to do |format|
      format.js { render 'products/product_detail.js.erb', :locals => {:product_detail => product_detail} }
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.fetch(:product, {})
    end
end
