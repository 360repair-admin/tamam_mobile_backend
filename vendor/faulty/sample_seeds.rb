require 'securerandom'

puts "Seeding 100 Faulty Errors with realistic backtraces and code snippets..."

100.times do
  error = Faulty::Error.create!(
    error_class: ["NoMethodError", "RuntimeError", "ArgumentError", "TypeError", "StandardError"].sample,
    message: ["Something went wrong", "Invalid argument", "Unexpected nil value"].sample,
    fingerprint: SecureRandom.hex(10),
    last_event_at: Time.now - rand(0..30).days,
    status: ["unresolved", "resolved"].sample
  )

  rand(1..3).times do
    file_path = "app/#{["controllers", "models", "jobs"].sample}/#{["user", "order", "payment"].sample}.rb"
    line_no   = rand(10..200)
    code_lines = [
      "def perform_task",
      "  user = User.find(params[:id])",
      "  order = Order.find(order_id)",
      "  payment.process!",
      "rescue StandardError => e",
      "  logger.error e.message",
      "end"
    ]

    Faulty::Event.create!(
      error: error,
      backtrace: Array.new(8) { |j| "#{file_path}:#{rand(10..200)}:in `#{["perform","call","process"].sample}`" }.join("\n"),
      context: { params: { id: rand(1..100), action: ["create", "update", "destroy"].sample }, user_id: rand(1..10) },
      code_snippet: [{ file: file_path, line: line_no, context: code_lines.map.with_index(line_no) { |c, i| { number: i, code: c, highlighted: (i == line_no) } } }],
      request_id: SecureRandom.uuid,
      status: ["unresolved", "resolved"].sample
    )
  end
end

puts "✅ Seeding completed: 100 errors with proper backtraces and code snippets!"
