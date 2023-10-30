
defmodule EmailPriorityQueue.EmailWorker do
  use Broadway

  alias EmailPriorityQueue.EmailTask

  @impl Broadway
  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producers: [
        default: [name: EmailPriorityQueue.Producer]
      ],
      processors: [
        default: [stages: 1]
      ],
      batcher: [
        default: [max_batch_size: 10]
      ]
    )
  end

  @impl Broadway
  def init(_opts) do
    {:ok, nil}
  end

  @impl Broadway
  def handle_batch(batch, _context) do
    EmailTask.send_emails(batch)
    {:noreply, batch}
  end
end
