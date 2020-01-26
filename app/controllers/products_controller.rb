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
    @q.build_grouping unless @q.groupings.any?
    
    @all_products = @q.result(distinct: true)
    @products = @q.result(distinct: true).order(updated_at: :desc).paginate(page: params[:page], per_page: 10)
    
    if params[:q].present?
      if params[:q][:g].present?
        if params[:q][:g]["0"].present?
          if params[:q][:g]["0"][:title_cont].present?
            product_title = "%" + params[:q][:g]["0"][:title_cont] + "%"
            by_title = Product.send(:sanitize_sql_array, [ 'CASE WHEN title ILIKE ? then 1 else 2 end', product_title ])
            pro_arr = @q.result.order(by_title).uniq
            @products = Product.where(id: pro_arr.map{|h| h["id"]}).paginate(page: params[:page], per_page: 10)
          end
        end
      end
    end
    
    gon.products = @all_products
    
  end
  
  def product_detail
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def product_sorting
    if params[:products].present?
      products = params[:products].permit!.to_hash
      if products.present?
        if params[:sortBy].present?
          sort_by = params[:sortBy]
          case sort_by
          when "Highest Price"
            @products = Product.where(id: products.map{|h| h[1]["id"]}).order(price: :desc).paginate(page: params[:page], per_page: 10)
          when "Lowest Price"
            @products = Product.where(id: products.map{|h| h[1]["id"]}).order(:price).paginate(page: params[:page], per_page: 10)
          when "Newest"
            @products = Product.where(id: products.map{|h| h[1]["id"]}).order(updated_at: :desc).paginate(page: params[:page], per_page: 10)
          else           
            if params[:product_title].present?
              product_title = "%" + params[:product_title] + "%"
              by_title = Product.send(:sanitize_sql_array, [ 'CASE WHEN title ilike ? then 1 else 2 end', product_title ])
              @products = Product.where(id: products.map{|h| h[1]["id"]}).order(by_title).paginate(page: params[:page], per_page: 10)
            end
          end
        end        
      end
    end
    respond_to do |format|
      format.js { render 'products/product_sorting.js.erb', :locals => {:products => @products} }
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
