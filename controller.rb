class Controller
  def initialize(args={})
    @view = args.fetch(:view)
    @client_id = args.fetch(:client_id)
    @client_secret = args.fetch(:client_secret)
    run
  end

  def run
    p @client_id
    p @client_secret
  end
end