require 'test_helper'

class LogMailerTest < ActionMailer::TestCase
  test "contact" do
    @expected.subject = 'LogMailer#contact'
    @expected.body    = read_fixture('contact')
    @expected.date    = Time.now

    assert_equal @expected.encoded, LogMailer.create_contact(@expected.date).encoded
  end

end
