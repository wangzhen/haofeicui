# coding: utf-8
class Admin::ProductContactsController < Admin::BaseController
  # GET /admin_prodcut_contacts
  # GET /admin_prodcut_contacts.xml
  def index
    products = Product.find_all_by_user_id(session[:user_id])
   @prodcut_contacts  = ProductContact.find_all_by_product_id(products.map(&:id)).paginate(:page => params[:page],
      :per_page => 20)

  end




  # GET /admin_prodcut_contacts/1/edit
  def edit
    @prodcut_contact = ProductContact.find(params[:id])
  end

  # PUT /admin_prodcut_contacts/1
  # PUT /admin_prodcut_contacts/1.xml
  def update
    @product_contact = ProductContact.find(params[:id])

    respond_to do |format|
#      if @prodcut_contact.update_attributes(params[:prodcut_contact])
      if @product_contact.update_attributes({:reply => params[:product_contact][:reply]})
        flash[:notice] = 'Admin::ProdcutContact was successfully updated.'
        format.html { redirect_to admin_product_contacts_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prodcut_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_prodcut_contacts/1
  # DELETE /admin_prodcut_contacts/1.xml
  def destroy
    @prodcut_contact = Admin::ProdcutContact.find(params[:id])
    @prodcut_contact.destroy

    respond_to do |format|
      format.html { redirect_to(admin_prodcut_contacts_url) }
      format.xml  { head :ok }
    end
  end
end
