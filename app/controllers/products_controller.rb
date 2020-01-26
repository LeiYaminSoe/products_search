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
    #debugger
    #sort_val = "title ILIKE %" + params[:q][:g]["0"][:title_cont] + "%"
    @q = Product.ransack(params[:q])
    @q.build_grouping unless @q.groupings.any?
    
    #@q.sorts = [sort_val] if @q.sorts.empty?
    #@q.sorts = ['title = "Zeta" asc'] if @q.sorts.empty?
    #@q.sorts = ['title desc'] if @q.sorts.empty?
    @products = @q.result(distinct: true).page(params[:page]).per(10)
    #order("title = 'Rhinestone' asc")
    gon.products = @products
    #debugger
  end
  
  def product_detail
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def product_sorting
    if params[:products].present?
   # debugger
      products = params[:products].permit!.to_hash
      #products = params[:products].to_hash
      #params[:products].to_hash.sort_by{|k,v| v["id"]}.reverse
      
      #products.sort_by { |k, v| v[:created_at] }
      
      if products.present?
        #@products = products.sort_by &:created_at
        #@products = products.order(:created_at)
        if params[:sortBy].present?
          sort_by = params[:sortBy]
          case sort_by
          when "Highest Price"
            @ps = products.sort_by{|k,v| v["price"]}.reverse
          when "Lowest Price"
            @ps = products.sort_by{|k,v| v["price"]}
          when "Newest"
            @ps = products.sort_by{|k,v| v["updated_at"]}.reverse
          else
            @ps = products.sort_by{|k,v| v["title"]}
          end
          #debugger
    #@products = Product.where(id: @ps.values.map{|h| puts h["id"]})
    @products = Product.where(id: @ps.map{|h| h[1]["id"]}).page(params[:page]).per(10)
    #products.values.map{|h| puts h["id"] }
    #{ where(id: ARRAY_COLLECTION.map(&:id)) }
    #Job.where(id: array.map(&:id))
        end        
      end
    end
    #debugger
   render json: @products 
   #render :partial => 'list'
   # format.js {render layout: false}
    #render partial: 'list', locals: { :products => @products }
    #render :partial => 'list', locals: { :products => @products }
    #render json: { html: render_to_string(partial: 'list', locals: { :products => @products }) }
    # respond_to do |format|
      # format.html { render 'products/_list.html.erb'}
    # end    
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
