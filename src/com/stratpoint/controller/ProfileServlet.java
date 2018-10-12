package com.stratpoint.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;

public class ProfileServlet extends HttpServlet implements Servlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
/**METHOD: doGET
 * This method accepts the request parameter from the home
 * page and sets the dispatch page to home.jsp as default if action
 * parameter is not available, initiate 'readJsonFromURL' that reads 
 * all the data from profile list JSON API url, this method also sets
 * request and response attribute that contains the data that will be 
 * passed to the dispatch page. 
 * The page also create a error message to be displayed in the page if
 * an error occur fetching datas from the JSON API.
 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String page = "/home.jsp";
		String action = request.getParameter("action");
		action = action == null ? "" : request.getParameter("action");
		if(action.equals("viewProfile")) page = "/core/pages/profile.jsp";
		String error ="";
		JSONArray json = null;
			try {
				json = readJsonFromUrl("http://s3-ap-southeast-1.amazonaws.com/fundo/js/profiles.json");
			} catch (IOException e) {
				error = "Something went wrong in connecting with the API.\n "
						+ "Please reload the page!";
				e.printStackTrace();	
			}finally{
				request.setAttribute("SystemError", error);
				if(error.equals("")){
					request.setAttribute("message", json.toString());
					request.setAttribute("id", request.getParameter("id"));
				}
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
	}
	
/**METHOD: readJsonFromUrl
 * This method accepts a String type parameter(the URL) 
 * and read all the data from the list JSON API into a 
 * JSON array with UTF-8 charset and then return the a
 * JSONArray type parameter.
*/
	public static JSONArray readJsonFromUrl(String url) throws IOException, JSONException {
		InputStream is = new URL(url).openStream();
		try {
			BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			String jsonText = readAllJsonFile(rd);
			JSONArray json = new JSONArray(jsonText);
			return json;
		} finally {
			is.close();
		}
	}
	
/**METHOD: readAllJsonFile
 * This method is being called at readJsonFromUrl, accepts data from BufferedREader 
 * and read all the contents of the JSON API and return the acquired information
 * as a string.
 */
	private static String readAllJsonFile(Reader file) throws IOException {
		StringBuilder content = new StringBuilder();
		int cp;
		while ((cp = file.read()) != -1) {
			content.append((char) cp);
		}
		return content.toString();
	}
	
}
