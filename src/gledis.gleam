pub external type Client

pub external fn connect() -> Client =
  "gledis_ffi" "connect"

pub external fn query(client: Client, query: List(String)) -> Result(v, String) =
  "gledis_ffi" "query"

pub external fn close(client: Client) -> Nil =
  "gledis_ffi" "close"

pub fn set(client: Client, key: String, value: String) -> Result(v, String) {
  query(client, ["SET", key, value])
}

pub fn get(client: Client, key: String) -> Result(v, String) {
  query(client, ["GET", key])
}
