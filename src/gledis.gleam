import gleam/dynamic.{Dynamic}
import gleam/list

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

pub external fn dynamic(Dynamic) -> Argument =
  "gledis_ffi" "coerce"

/// Covers commonly used Redis commands with an escape hatch for custom commands or less used ones
pub type Query {
  Keys(pattern: String)
  Get(key: String)
  Set(key: String, value: Argument)
  Del(key: String)
  Exists(key: String)
  RandomKey
  /// This can causes crashes and should be avoided at all costs
  Custom(command: String, args: List(Argument))
}

fn build_query(query: Query) -> List(Dynamic) {
  case query {
    Get(key) -> [dynamic.from("GET"), dynamic.from(key)]
    Set(key, value) -> [
      dynamic.from("SET"),
      dynamic.from(key),
      dynamic.from(value),
    ]
    Del(key) -> [dynamic.from("DEL"), dynamic.from(key)]
    Exists(key) -> [dynamic.from("EXISTS"), dynamic.from(key)]
    Keys(pattern) -> [dynamic.from("KEYS"), dynamic.from(pattern)]
    RandomKey -> [dynamic.from("RANDOMKEY")]
    Custom(command, args) -> [
      dynamic.from(command),
      ..list.map(args, dynamic.from)
    ]
  }
}

pub external type Client

pub external fn connect() -> Client =
  "gledis_ffi" "connect"

pub external fn close(client: Client) -> Nil =
  "gledis_ffi" "close"

external fn query_ffi(client: Client, query: List(Dynamic)) -> Result(v, String) =
  "gledis_ffi" "query"

pub fn query(client: Client, query: Query) -> Result(v, String) {
  query_ffi(client, build_query(query))
}
