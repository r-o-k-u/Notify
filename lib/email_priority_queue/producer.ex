# lib/email_priority_queue/producer.ex

defmodule EmailPriorityQueue.Producer do
  use Broadway.Producer

  alias EmailPriorityQueue.EmailTask

  def start_link(_opts) do
    Broadway.Producer.start_link(__MODULE__,
      name: __MODULE__,
      producer: {EmailPriorityQueue.EmailTask, :enqueue_emails, []}
    )
  end

  @impl true
  def init(_opts) do
    {:ok, nil}
  end

  @impl true
  def handle_produce(_event, _context) do
    :ok
  end
end
