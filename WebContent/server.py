"""
An ultra-simple web server that provides slices of a very large (mock) data
source for a dojox.grid.Grid client that uses a dojox.data.QueryReadStore
to page the data on demand
"""

import cherrypy #do an "easy_install cherrypy" to get it
from cherrypy.lib.static import serve_file

import demjson #do an "easy_install demjson" to get it
import os
from random import randint #for building up mock data

json = demjson.JSON(compactly=False)
jsonify = json.encode

NUM_ITEMS = 1000000

class Content:
    def __init__(self):
        """
        maybe you would call out to a db with some sql to get some data
        based on the query string that comes into /data. for now, we'll
        build up some static data to use.
        """

        self.items = []

        possible_item_names = ["Foo", "Bar", "Baz", "Bop"]
        id=0
        for i in xrange(NUM_ITEMS):
            self.items.append({
                    'id' : id,
                    'item' : possible_item_names[randint(0,3)],
                    'quantity' : randint(0,10),
                    'cost' : randint(0,100)
            })
            id +=1

        #keep track of sort order b/c sorting is expensive...
        self.current_sort_order = ""

    @cherrypy.expose
    def data(self, **kw):
        """
        serve up the data via http://localhost:8000/data

        kw will contain whatever is in your store's query. by default
        the query string will come across as something like:
        ?name=*&start=0&count=20 to populate the table 

        note: you may get into trouble if you have multiple users
        trying to access this url and changing the sort order of items
        all at the same time (but relax, this is just a little demo.)
        """

        #sorting the items by values for a given dictionary key...
        if kw.get('sort') and self.current_sort_order != kw.get('sort'):
            if kw['sort'][0] == '-': #descending order, slice off the -
                self.items.sort(lambda m,n:cmp(m.get(kw['sort'][1:]), n.get(kw['sort'][1:])),reverse=True)
            else: #ascending order
                self.items.sort(lambda m,n:cmp(m.get(kw['sort']), n.get(kw['sort'])))
            self.current_sort_order = kw['sort']

        #slicing the data...
        start = int(kw['start'])
        end = start + int(kw['count'])

        #serving up the slice of interest as well as the total size
        return jsonify({'numRows':NUM_ITEMS, 'items':self.items[start:end]})

    @cherrypy.expose
    def grid(self, **kw):
        """
        Serve up the web page through http://localhost:8000/grid
        """
        return serve_file(os.path.join(os.getcwd(), 'grid.html'))

cherrypy.server.socket_port = 8000
cherrypy.quickstart(Content(),'/')