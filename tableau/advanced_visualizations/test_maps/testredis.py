import redis

class TestRedis:
  def __init__(self):
    r = redis.Redis(host='localhost', port=6379, decode_responses=True,username="default", password="admin", db=0)
    r.set("foo","bar")
    print(r.get("foo"))

t = TestRedis()