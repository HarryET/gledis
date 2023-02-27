import gleeunit
import gledis.{Client}
import gleam/io

pub fn main() {
  gleeunit.main()
}

pub fn setup_connection() -> Client {
  gledis.connect()
}

// gleeunit test functions end in `_test`
pub fn set_test() {
  let conn = setup_connection()
  let e = gledis.set(conn, "foo", gledis.string("bar"))
  io.debug(e)
}
