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
      success('Member created successfully', member)
    else
      failure(member.errors.full_messages.join(', '), member)
    end
  end
end
