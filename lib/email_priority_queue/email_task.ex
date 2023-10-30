# lib/email_priority_queue/email_task.ex

defmodule EmailPriorityQueue.EmailTask do
  def send_emails(emails) do
    for email <- emails do
      # Send email here
      IO.puts("Sending email: #{email}")
      Process.sleep(1000)
    end
  end

  def enqueue_emails(_context) do
    # Simulate enqueuing emails with different priorities
    emails = ["Email 1", "Email 2", "Email 3", "Email 4"]
    Enum.each(emails, fn email ->
      Broadway.produce(__MODULE__, email)
    end)
  end
end
