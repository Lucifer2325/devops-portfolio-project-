import unittest
from app.app import app as flask_app


class AppTestCase(unittest.TestCase):
    def setUp(self):
        self.client = flask_app.test_client()

    def test_homepage_renders(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"DevOps Pipeline Control Center", response.data)

    def test_status_endpoint(self):
        response = self.client.get("/api/status")
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertEqual(data["status"], "Healthy")
        self.assertIn("timestamp", data)
        self.assertIn("hostname", data)
        self.assertEqual(data["message"], "DevOps Pipeline is fully functional!")


if __name__ == "__main__":
    unittest.main()
