package com.dojoproject.grid;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dojoproject.grid.util.Item;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.json.JettisonMappedXmlDriver;
import com.thoughtworks.xstream.io.json.JsonHierarchicalStreamDriver;
import com.thoughtworks.xstream.io.json.JsonWriter;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class DynamicGrid
 */
@WebServlet("/data")
public class DynamicGrid extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Item itemdata;
	private List<Item> list=new ArrayList<Item>();
	private String[] possible_item_names={"Foo", "Bar", "Baz", "Bop"};
	private static int NUM_ITEMS = 10000;
	private int id=0;
	Random rn = new Random();
    /**
     * Default constructor. 
     */
    public DynamicGrid() {
    	for(int i=0;i<=NUM_ITEMS;i++){
    		list.add(new Item(id,possible_item_names[rn.nextInt(3)],rn.nextInt(10),rn.nextInt(100)));
    		id +=1;
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int start=Integer.parseInt(request.getParameter("start"));
		int count=start+Integer.parseInt(request.getParameter("count"));
		List<Item> listcopy=new ArrayList<Item>();
		response.setContentType("application/json");
		for(int i=start;i<=count;i++){
			listcopy.add(list.get(i));
		}
		XStream xstream = new XStream(new JsonHierarchicalStreamDriver() {
		    public HierarchicalStreamWriter createWriter(Writer writer) {
		        return new JsonWriter(writer, JsonWriter.DROP_ROOT_MODE);
		    }
		});
		//xstream.setMode(XStream.NO_REFERENCES);
		
		xstream.alias("items", com.dojoproject.grid.util.Item.class);
		String str=xstream.toXML(listcopy);
		str="{'numRows':10000,'items':"+str+"}";
		PrintWriter out = response.getWriter();
		String jsonstr="{'numRows':10000, 'items':[{'id':0,'item':'Foo','quantity':'8','cost':'400'},{'id':0,'item':'Foo','quantity':'8','cost':'400'},{'id':0,'item':'Foo','quantity':'8','cost':'400'},{'id':0,'item':'Foo','quantity':'8','cost':'400'},{'id':0,'item':'Foo','quantity':'8','cost':'400'}]}";
		out.print(str);
		out.flush();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
