class CreateMember < Base
  def initialize(params)
    @params = params
  end

  def call
    create_member
  end

  private

  def create_member
    member = Member.new(@params)

    if member.save
      ParseWebsiteContent.new(member).call
      success('Member created successfully', member)
    else
      failure(member.errors.full_messages.join(', '), member)
    end
  end
end
