import gleam/dynamic.{Dynamic}

pub external type Client

pub external fn connect() -> Client =
  "gledis_ffi" "connect"

pub external fn query(client: Client, query: List(Dynamic)) -> Result(v, String) =
  "gledis_ffi" "query"

pub external fn close(client: Client) -> Nil =
  "gledis_ffi" "close"

pub fn set(client: Client, key: Dynamic, value: Dynamic) -> Result(v, String) {
  query(client, [dynamic.from("SET"), key, value])
}

pub fn get(client: Client, key: Dynamic) -> Result(v, String) {
  query(client, [dynamic.from("GET"), key])
}
