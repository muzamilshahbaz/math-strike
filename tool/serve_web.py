"""Serve build/web locally with caching disabled.

Python's default http.server sends no cache headers, so browsers keep
running a stale main.dart.js after a rebuild. This variant forbids caching
so every reload runs the latest build.

Usage:  python tool/serve_web.py [port]   (default 8765)
"""
import functools
import http.server
import sys


class NoCacheHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cache-Control", "no-store, must-revalidate")
        self.send_header("Expires", "0")
        super().end_headers()


if __name__ == "__main__":
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8765
    handler = functools.partial(NoCacheHandler, directory="build/web")
    http.server.ThreadingHTTPServer(("127.0.0.1", port), handler).serve_forever()
