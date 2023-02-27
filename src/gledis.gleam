import gleam/option.{None, Option}

pub external type Argument

pub external fn null() -> Argument =
  "gledis_ffi" "null"

pub external fn bool(Bool) -> Argument =
  "gledis_ffi" "coerce"

pub external fn int(Int) -> Argument =
  "gledis_ffi" "coerce"

pub external fn float(Float) -> Argument =
  "gledis_ffi" "coerce"

pub external fn string(String) -> Argument =
  "gledis_ffi" "coerce"

pub external fn bytea(BitString) -> Argument =
  "gledis_ffi" "coerce"

pub external type Client

pub external fn connect() -> Client =
  "gledis_ffi" "connect"

pub type Options {
  Options(
    host: Option(String),
    port: Option(Int),
    username: Option(String),
    password: Option(String),
    database: Option(Int),
    reconnect_sleep: Option(Int),
    connect_timeout: Option(Int),
  )
}

pub fn default_options() -> Options {
  Options(
    host: None,
    port: None,
    username: None,
    password: None,
    database: None,
    reconnect_sleep: None,
    connect_timeout: None,
  )
}

pub external fn connect_with_opts(Options) -> Client =
  "gledis_ffi" "connect"

pub external fn close(client: Client) -> Nil =
  "gledis_ffi" "close"

external fn query_ffi(
  client: Client,
  query: List(Argument),
) -> Result(v, String) =
  "gledis_ffi" "query"

pub fn get(client: Client, key: String) -> Result(v, String) {
  query_ffi(client, [string("GET"), string(key)])
}

pub fn set(client: Client, key: String, value: Argument) -> Result(v, String) {
  query_ffi(client, [string("SET"), string(key), value])
}
