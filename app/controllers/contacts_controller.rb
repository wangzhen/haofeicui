# coding: utf-8
class ContactsController < ApplicationController

  # GET /contacts/1
  # GET /contacts/1.xml
  def index
    redirect_to :action =>  :new
  end

  def show
    @contact = Contact.find_by_serial(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end


  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        UserMailer.deliver_contact(@contact)
        UserMailer.deliver_contact_to_user(@contact)
        flash[:notice] = '谢谢您的咨询，我们会尽快回复！'
        format.html { redirect_to contact_path(@contact.serial) }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end


end
