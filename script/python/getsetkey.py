#!/usr/bin/env python

from twisted.web import server,resource
from twisted.internet import reactor
import twisted
import time
import mimetypes
import os
from cStringIO import StringIO
from pprint import pprint

timestamp = {}

class Root(resource.Resource):
  def __init__(self):
    resource.Resource.__init__(self)

  def getChild(self,name,request):
    self.filename = name
    return self

  def render_GET(self,request):
    content_type = "text/html"
    pprint(request.requestHeaders)
    print(request.getRootURL())
    ret = "set "
    try:
        if (len(request.path) > 1):
            path = (request.path).split('/')
            if (path[1] == "get"):
                ret = timestamp[path[2]]
            else:
                if (path[1] == "set"):
                    p2 = path[2].strip()
                    timestamp[p2] = path[3]
                    ret = ret + path[2] + " to " + path[3] + " ok"
    except Exception, e:
        import traceback
        print 'str(Exception):\t', str(Exception)
        print 'str(e):\t\t', str(e)
        print 'repr(e):\t', repr(e)
        print 'e.message:\t', e.message
        print 'traceback.print_exc():'; traceback.print_exc()
        print 'traceback.format_exc():\n%s' % traceback.format_exc()

    print(ret)
    request.setHeader("Content-Type", content_type)
    data = StringIO()
    data.write(ret)

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
    print("\r\nrequest.requestHeaders:")
    pprint(request.requestHeaders)
    #print("")
    #pprint(request.__dict__)
    #print("")
    print("\r\nrequest.content.getvalue():")
    newdata = request.content.getvalue()
    pprint(newdata)
    print("")
    return (request.requestHeaders)

root = Root()

site = server.Site(root)
reactor.listenTCP(8080, site)
reactor.run()
