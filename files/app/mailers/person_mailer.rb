class PersonMailer < ApplicationMailer
  def test(person:)
    @person = person

    mail(
      to: person.email,
      subject: 'This is a test'
    )
  end
end
