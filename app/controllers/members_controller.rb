class MembersController < ApplicationController
  def index
    @members = if params[:search].present?
      Member.search(params[:search])
    else
      Member.order('created_at DESC')
    end.paginate(page: params[:page])
  end

  def new
    @member = Member.new
  end

  def create
    result = CreateMember.new(member_params).call

    @member = result.object

    if result.success
      flash[:success] = result.message
      redirect_to members_path
    else
      flash[:error] = result.message
      render :new
    end
  end

  def profile
    @member = Member.find_by(id: params[:id])

    if @member.present?
      render :profile
    else
      flash[:error] = 'Member could not be found'
      redirect_to members_path
    end
  end

  def redirect_to_website
    @member = Member.find_by(url_key: params[:key])

    redirect_to @member.website_url, status: 301
  end

  def search
    @members = Member.search(params[:search], params[:member_id]).paginate(page: params[:page])
  end

  private

  def member_params
    params.require(:member).permit(:name, :website_url)
  end
end
