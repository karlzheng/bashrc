#!/usr/bin/env python

from twisted.web import server,resource
from twisted.internet import reactor
import twisted
import time
import mimetypes
import os
from cStringIO import StringIO
from pprint import pprint

class Root(resource.Resource):
  def __init__(self):
    resource.Resource.__init__(self)
  def getChild(self,name,request):
    self.filename = name
    return self

  def render_GET(self,request):
    #content_type = "text/html"
    #request.setHeader("Cache-Control", "max-age=1000")
    print type(request)
    data = StringIO()
    print "file:%s"%(self.filename)
    if self.filename != "":
      return open(self.filename).read()
    else:
      request.setHeader("Content-Type", content_type)
      data.write("test abc")

    print request
    return data.getvalue()

  def gen_img_request(self, filename_pre):
    data = ""
    try:
      value = int(filename_pre)
      cnt = 0
      while cnt < value:
        data += """<img src= %d.jpg />"""%(cnt)
        data += """%d"""%(cnt)
        cnt += 1
    except:
      data = "this is a test page"
    return data

  def render_POST(self, request):
    """
          test case:
          curl --data-urlencode "name=karl" --data-urlencode 'token=abc+def' http://127.0.0.1:8080
    """
    #return '<html><body>You submitted: %s</body></html>' % (cgi.escape(request.args["the-field"][0]),)
    #return self.render_GET(request)
    print("")
    pprint(request.requestHeaders)
    print("")
    pprint(request.__dict__)
    print("")
    newdata = request.content.getvalue()
    pprint(newdata)
    print("")
    return (request.requestHeaders)

root = Root()

site = server.Site(root)
reactor.listenTCP(8080, site)
reactor.run()
