import gleeunit
import gledis.{Client}

pub fn main() {
  gleeunit.main()
}

pub fn setup_connection() -> Client {
  assert Ok(conn) = gledis.connect()
  conn
}

// gleeunit test functions end in `_test`
pub fn set_test() {
  let conn = setup_connection()
  assert Ok(_) = gledis.set(conn, "foo", gledis.string("bar"))
}
