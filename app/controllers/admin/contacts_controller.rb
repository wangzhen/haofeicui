# coding: utf-8
class Admin::ContactsController < Admin::BaseController

  # GET /admin_contacts
  # GET /admin_contacts.xml
  def index

    @search = Contact.new_search(params[:search])
    @contacts = @search.all.paginate(:page => params[:page] , :per_page => 20)
   

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_contacts }
    end
  end

  # GET /admin_contacts/1
  # GET /admin_contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /admin_contacts/new
  # GET /admin_contacts/new.xml
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /admin_contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /admin_contacts
  # POST /admin_contacts.xml
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        flash[:notice] = 'Admin::Contact was successfully created.'
        format.html { redirect_to(@contact) }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_contacts/1
  # PUT /admin_contacts/1.xml
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        flash[:notice] = 'Admin::Contact was successfully updated.'
        format.html { redirect_to(@contact) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_contacts/1
  # DELETE /admin_contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to(admin_contacts_url) }
      format.xml  { head :ok }
    end
  end
end
