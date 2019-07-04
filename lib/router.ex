defmodule Hackathon.Router do
    use Plug.Router
    use Plug.Builder
    #use Plug.Parsers
    
    
    if Mix.env == :dev do
        IO.puts("In DEBUG environment")
        use Plug.Debugger
    end

    plug Plug.Static, at: "/public", from: :hackathon
    
    plug :match
    plug :dispatch
    plug Plug.Parsers, parsers: [:urlencoded, :json],
                                json_decoder: Poison
    
    get "/" do
        idx = Path.join("#{:code.priv_dir(:hackathon)}", "static/index.html")
        send_file(conn, 200, idx)
    end
    
   post "/savejson" do
    
    {:ok, data, _conn} = read_body(conn)
    
    IO.puts(data)
    
    p = Poison.decode! data, as: Hackathon.User
    
    IO.puts(p.email)
    
    conn
    |>send_resp(200, p.name)
   end
   
   post "/save" do
    {:ok, data, _conn} = read_body(conn)
    
    
    IO.puts(data)
    #name = data.params["name"]
    
    
    conn = parse(conn)
    name = conn.params["name"]
    IO.puts(name)
    conn
    |>send_resp(200, data)
   end

    match _ do
        conn
        |>send_resp(404, "404'd")
        |>halt
    end
    
    def parse(conn, opts \\ []) do
        opts = Keyword.put_new(opts, :parsers, [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
        Plug.Parsers.call(conn, Plug.Parsers.init(opts))
    end
end
