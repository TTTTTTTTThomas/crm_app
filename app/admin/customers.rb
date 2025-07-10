ActiveAdmin.register Customer do
  menu priority: 2
  
  permit_params :full_name, :phone_number, :email_address, :notes, :image

  # Completely disable all features that might cause issues
  config.filters = false
  config.batch_actions = false
  config.sort_order = 'full_name_asc'
  
  # Custom controller to avoid any Ransack issues
  controller do
    def index
      @customers = Customer.all.order(:full_name)
      @page_title = "Customers"
    end
    
    def show
      @customer = Customer.find(params[:id])
    end
    
    def new
      @customer = Customer.new
    end
    
    def create
      @customer = Customer.new(permitted_params[:customer])
      if @customer.save
        redirect_to admin_customer_path(@customer), notice: 'Customer created successfully.'
      else
        render :new
      end
    end
    
    def edit
      @customer = Customer.find(params[:id])
    end
    
    def update
      @customer = Customer.find(params[:id])
      if @customer.update(permitted_params[:customer])
        redirect_to admin_customer_path(@customer), notice: 'Customer updated successfully.'
      else
        render :edit
      end
    end
    
    def destroy
      @customer = Customer.find(params[:id])
      @customer.destroy
      redirect_to admin_customers_path, notice: 'Customer deleted successfully.'
    end
  end

  # Simple index page without any complex features
  index title: 'Customers' do
    column :id
    column :full_name do |customer|
      link_to customer.full_name, admin_customer_path(customer)
    end
    column :phone_number
    column :email_address do |customer|
      customer.email_address.present? ? customer.email_address : span('No email', style: 'color: #999; font-style: italic;')
    end
    column :image do |customer|
      customer.image.attached? ? span('📷 Has image', style: 'color: green;') : span('No image', style: 'color: #999;')
    end
    column :created_at
    actions
  end

  # Show page
  show do |customer|
    attributes_table do
      row :id
      row :full_name
      row :phone_number
      row :email_address do |customer|
        customer.email_address.present? ? customer.email_address : em('No email provided')
      end
      row :notes do |customer|
        customer.notes.present? ? simple_format(customer.notes) : em('No notes')
      end
      row :image do |customer|
        if customer.image.attached?
          begin
            image_tag customer.image, style: 'max-width: 300px; height: auto; border: 1px solid #ddd; border-radius: 4px;'
          rescue => e
            p "Image error: #{e.message}", style: 'color: red;'
          end
        else
          em 'No image uploaded'
        end
      end
      row :created_at
      row :updated_at
    end
  end

  # Simple form
  form html: { multipart: true } do |f|
    f.inputs 'Customer Information' do
      f.input :full_name, required: true
      f.input :phone_number, required: true  
      f.input :email_address, required: false
      f.input :notes, as: :text, input_html: { rows: 5 }
      f.input :image, as: :file, hint: 'Upload customer photo (optional)', input_html: { accept: 'image/*' }
    end
    f.actions
  end
end
