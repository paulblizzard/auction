class ParticipantsController < ApplicationController
	layout 'global'
  # GET /participants
  # GET /participants.xml
  def index

		if params[:type]=='donor'
				@participants = Participant.find(:all,:conditions => { :state => "CREATED", :participant_type => "DONOR"})
		else
			@participants = Participant.find(:all,:conditions => { :state => "CREATED", :participant_type => "BIDDER"})
	end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @participants }
    end
  end

  # GET /participants/1
  # GET /participants/1.xml
  def show
    @participant = Participant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @participant }
    end
  end

  # GET /participants/new
  # GET /participants/new.xml
  def new
    @participant = Participant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @participant }
    end
  end

  # GET /participants/1/edit
  def edit
    @participant = Participant.find(params[:id])
  end

  # POST /participants
  # POST /participants.xml
  def create (participant)
  	
		participant.create_date=Time.now
		participant.modified_date=Time.now
		participant.state='CREATED'

		respond_to do |format|
		    if participant.save
		      flash[:notice] = 'Participant was successfully created.'
		      format.html { redirect_to(participant) }
		      format.xml  { render :xml => participant, :status => :created, :location => participant }
		    else
		      format.html { render :action => "new" }
		      format.xml  { render :xml => participant.errors, :status => :unprocessable_entity }
		    end
		  end
  end

  # PUT /participants/1
  # PUT /participants/1.xml
  def update
    @participant = Participant.find(params[:id])
	@participant.modified_date=Time.now

    respond_to do |format|
      if @participant.update_attributes(params[:participant])
        flash[:notice] = 'Participant was successfully updated.'
        format.html { redirect_to(@participant) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @participant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.xml
  def destroy
    @participant = Participant.find(params[:id])
    @participant.modified_date=Time.now
		@participant.state='DELETED'

	respond_to do |format|
      if @participant.update_attributes(params[:participant])
        flash[:notice] = 'Participant was deleted.'
        format.html { redirect_to(participants_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @participant.errors, :status => :unprocessable_entity }
      end
    end
  end
	def get_participant_type
		if params[:type]=='donor'
			"Donors"
		else
			"Bidders"
		end	
	end
end