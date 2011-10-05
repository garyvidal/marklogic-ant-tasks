package com.marklogic.ant.taskdefs;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Properties;
import java.util.Vector;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.types.FileSet;
import org.xqdoc.conversion.*;

import com.marklogic.xcc.ResultSequence;

import net.sf.saxon.Configuration;
import net.sf.saxon.query.StaticQueryContext;
import net.sf.saxon.query.DynamicQueryContext;
import net.sf.saxon.query.XQueryExpression;
import net.sf.saxon.query.QueryResult;
import net.sf.saxon.trans.XPathException;

import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import net.sf.saxon.om.*;

import javax.xml.transform.OutputKeys;

/**
 * Generates a XQDoc output using modules located in a filesystem.
 * Code was adapted from XQDocs
 * 
 * @author Gary Vidal, gary.vidal@marklogic.com
 *
 */
/**
 * @author gvidal
 *
 */

public class XQDoc extends Task {
	// Will contain the suffix value specified in the parms for XQDocLite
	public static String SUFFIX;
	// Standard XPath F&O prefix and uri
	protected static final String XPATH_PREFIX = "fn";
	//XPath F&O URI for May 2003
	protected static final String XPATH_MAY2003_URI = "http://www.w3.org/2003/05/xpath-functions";
	//XPath F&O URI for Nov 2003
	protected static final String XPATH_NOV2003_URI = "http://www.w3.org/2003/11/xpath-functions";
	//XPath F&O URI for Oct 2004
	protected static final String XPATH_OCT2004_URI = "http://www.w3.org/2004/10/xpath-functions";
	//XPath F&O URI for Apr 2005
	protected static final String XPATH_APR2005_URI = "http://www.w3.org/2005/04/xpath-functions";
	//XPath F&O URI for Sep 2005
	protected static final String XPATH_SEP2005_URI = "http://www.w3.org/2005/xpath-functions";
	//XPath F&O URI for Nov 2005
	protected static final String XPATH_NOV2005_URI = "http://www.w3.org/2005/xpath-functions";
	//XPath F&O URI for Jan 2007
	protected static final String XPATH_JAN2007_URI = "http://www.w3.org/2005/xpath-functions";
	
 	private Vector<FileSet> filesets = new Vector<FileSet>();
 	private String outputDir = null;
 	private String version = "ML10";
 	private String defaultFO = "";
 	private String nsmapping = null;
 	private String display = "xqdoc-display";
 	private boolean failOnError = true;
 	
 	
	/**
	 * Determines if the task should fail on an error condition during task execution
	 * 
	 * @param failOnError if "false" then will not fail during task execution. Default value is "true". 
	 */
	public void setFailOnError(boolean failOnError )
	{
		this.failOnError = failOnError;
	}	
	
	/**
	 * Sets the XQuery version to use to generate the docs.
	 * 
	 * @param version Version of XQuery syntax to generate comments possible values are 
	 *        JAN2007, NOV2005, SEP2005,APR2005, OCT2004, NOV2003, MAY2003, ML10
	 */
	public void setVersion(String version) {
		this.version = version;
	}


	/**
	 * Set the default XPath Version Functions and Operator Namespace
	 * 
	 * @param defaultFO Default F&amp;O namespace
	 */
	public void setDefaultFO(String defaultFO) {
		this.defaultFO = defaultFO;
	}

	
	/**
	 * @param nsmapping
	 */
	public void setNsmapping(String nsmapping) {
		this.nsmapping = nsmapping;
	}

	/**
	 * @param display
	 */
	public void setDisplay(String display) {
		this.display = display;
	}

	/**
	 * @param outputDir
	 */
	public void setOutputDir(String outputDir) {
		this.outputDir = outputDir;
	}

	/**
	 * @param fileset
	 */
	public void addConfiguredFileset(FileSet fileset) {
		if (!filesets.contains(fileset)) {
			filesets.add(fileset);
		}
	}
	
	/**
	 * @return
	 */
	public FileSet[] getFileSets() {
		FileSet[] fs = new FileSet[filesets.size()];
		fs = filesets.toArray(fs);
		return fs;
	}

  
	/**
	 * This method is used to determine whether an input parameter
	 * (xqueryVersion) specifies a valid XQuery specification. If it does, the
	 * string literal for the corresponding version specified in XQDocController
	 * will be returned. If not, a value of 'null' will be returned.
	 * 
	 * @param xqueryVersion
	 *            XQuery version specified in the input parms for XQDocLite
	 * @return The XQuery specification 'literal' from XQDocController
	 */
	protected static String getXQuerySpecification(String xqueryVersion) {
		String xquerySpecification = null;

		if (xqueryVersion.compareTo(XQDocController.MAY2003) == 0)
			xquerySpecification = XQDocController.MAY2003;
		else if (xqueryVersion.compareTo(XQDocController.NOV2003) == 0)
			xquerySpecification = XQDocController.NOV2003;
		else if (xqueryVersion.compareTo(XQDocController.OCT2004) == 0)
			xquerySpecification = XQDocController.OCT2004;
		else if (xqueryVersion.compareTo(XQDocController.APR2005) == 0)
			xquerySpecification = XQDocController.APR2005;
		else if (xqueryVersion.compareTo(XQDocController.SEP2005) == 0)
			xquerySpecification = XQDocController.SEP2005;
		else if (xqueryVersion.compareTo(XQDocController.NOV2005) == 0)
			xquerySpecification = XQDocController.NOV2005;
		else if (xqueryVersion.compareTo(XQDocController.JAN2007) == 0)
			xquerySpecification = XQDocController.JAN2007;	
		else if (xqueryVersion.compareTo(XQDocController.ML10) == 0)
			xquerySpecification = XQDocController.ML10;	
		else
			xquerySpecification = XQDocController.ML10;

		return xquerySpecification;
	}

	/**
	 * This method is used to return the default function namespace URI (for the
	 * XPATH F&O) associated with the XQuery version.
	 * 
	 * @param xquerySpecification
	 *            XQuery specification literal contained in XQDocController
	 * @return The URI for the XPATH F&O associated with the XQuery
	 *         specification
	 */
	protected static String getDefaultFunctionNamespace(
			String xquerySpecification) {
		String defaultFunctionNamespace = null;

		if (xquerySpecification == XQDocController.MAY2003)
			defaultFunctionNamespace = XPATH_MAY2003_URI;
		else if (xquerySpecification == XQDocController.NOV2003)
			defaultFunctionNamespace = XPATH_NOV2003_URI;
		else if (xquerySpecification == XQDocController.OCT2004)
			defaultFunctionNamespace = XPATH_OCT2004_URI;
		else if (xquerySpecification == XQDocController.APR2005)
			defaultFunctionNamespace = XPATH_APR2005_URI;
		else if (xquerySpecification == XQDocController.SEP2005)
			defaultFunctionNamespace = XPATH_SEP2005_URI;
		else if (xquerySpecification == XQDocController.NOV2005)
			defaultFunctionNamespace = XPATH_NOV2005_URI;
		else if (xquerySpecification == XQDocController.JAN2007)
			defaultFunctionNamespace = XPATH_JAN2007_URI;		
		else
			defaultFunctionNamespace = XPATH_JAN2007_URI;

		return defaultFunctionNamespace;
	}

	/**
	 * This method will parse the input parm for XQDocLite, extract the
	 * namespace and prefix mappings, and add them to the HashMap.
	 * 
	 * @param parm
	 *            String of namespace prefix=uri mappings. Each pair will be
	 *            delimited by a semicolon.
	 * @param uriMap
	 *            The HashMap of namespace prefix to uri mappings. The defualt
	 *            function namespace mapping might exist in the map when this
	 *            method is called.
	 * @return The HashMap for the namespace prefix to uri mappings.
	 */
	protected static HashMap<String,String> getPredefinedFunctionNamespaces(String parm,
			HashMap<String,String> uriMap) {
		if (parm.compareTo("none") == 0) {
			System.out
					.println("No predefined mapping prefix to namespace uri was specified");
			return uriMap;
		}
		String[] list = parm.split(";");
		for (int i = 0; i < list.length; i++) {
			String[] entry = list[i].split("=");
			if (entry.length != 2) {
				System.out
						.println("Problems mapping prefix to namespace uri ... '"
								+ list[i] + "'");
			} else {
				System.out.println("Prefix '" + entry[0] + "' mapped to '"
						+ entry[1] + "'");
				uriMap.put(entry[0], entry[1]);
			}
		}
		return uriMap;
	}
	public void execute()
	{
		if(this.filesets.size() == 0){
			throw new BuildException("No Filesets have been defined");
		}
		if(this.outputDir == null ||this.outputDir.isEmpty()){
			throw new BuildException("Please specify an output directory");
		}
		try {
			doExecute();
		} catch (XQDocException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void doExecute() throws XQDocException{
		String xQuerySpec = getXQuerySpecification(this.version);
		String xPathUri = getDefaultFunctionNamespace(this.defaultFO);
		HashMap<String,String> uriMap = new HashMap<String,String>();
		XQDocController controller = new XQDocController(xQuerySpec);
		
		if(defaultFO.compareTo("default") == 0){
			controller.setDefaultFunctionNamespace(xPathUri);
		}
		else {
			controller.setDefaultFunctionNamespace(this.defaultFO);
			uriMap.put(XPATH_PREFIX, xPathUri);
		}
		
		//Now Do the processing
		DirectoryScanner ds = null;
		
		for( FileSet fs : filesets ) {
			ds = fs.getDirectoryScanner(getProject());
			System.out.println(ds.getBasedir().getName());
			File baseDir = ds.getBasedir();
			log("Generating Docs From: " + baseDir, Project.MSG_DEBUG);
			for( String fileName : ds.getIncludedFiles() ) {
				
			    try {
			    	generateDoc(baseDir + baseDir.separator + fileName, controller);
				} 
			    catch (Exception e) {
			    	e.printStackTrace();
				    log("XQDocError:" + e.getMessage()	,Project.MSG_ERR);
					if(failOnError){
					   throw new BuildException("XQDocError:" + e.getMessage() + e.toString());
					}
			    }	
			}
		}
	}
	@SuppressWarnings("deprecation")
	private void generateDoc(String fileName,XQDocController controller) throws XPathException, IOException, XQDocException{
		File file = null;
		FileInputStream fstream = new FileInputStream(fileName);

			File theFile = new File(fileName);
			System.out.println("Processing " + theFile.getName());
			XQDocPayload payload = controller.process(fstream, theFile
					.getName());
			file = new File("xqdoc-lite-tmp");
			if (!file.createNewFile()) {
				file.delete();
				file.createNewFile();
			}
			PrintWriter outputStream = new PrintWriter(new FileWriter(
					file));
			outputStream.println(payload.getXQDocXML());
			outputStream.close();

			//----------------------------
			// Begin execute against SAXON
			//----------------------------

			Configuration config = new Configuration();
			StaticQueryContext staticContext = new StaticQueryContext(
					config,false);
			// Check if an alternate location for the XQuery module was
			// specified by the user. If so, try to use it ...
			// otherwise, use the one contained in the xqdoc_conv.jar.
			XQueryExpression exp = null;
			if (new File(display).exists()) {
				exp = staticContext
						.compileQuery(new FileReader(display));
			} else {
				ClassLoader loader = ClassLoader.getSystemClassLoader();
				InputStream in = loader
						.getResourceAsStream("xqdoc-display.xqy");
			
				exp = staticContext.compileQuery(in, null);
			}
			DynamicQueryContext dynamicContext = new DynamicQueryContext(
					config);
			dynamicContext.setContextItem(staticContext
					.buildDocument(new StreamSource(file)));
			dynamicContext.setParameter("module", "xqdoc-lite-tmp");
			SequenceIterator books = exp.iterator(dynamicContext);
			Properties props = new Properties();
			props.setProperty(OutputKeys.METHOD, "html");
			props.setProperty(OutputKeys.INDENT, "no");
			props.setProperty(OutputKeys.DOCTYPE_PUBLIC,
					"-//W3C//DTD HTML 4.01 Transitional//EN");

			while (true) {
				NodeInfo book = (NodeInfo) (books.next());
				if (book == null)
					break;
				QueryResult.serialize(book, new StreamResult(new File(
						outputDir + File.separator + theFile.getName()
								+ ".html")), props);
				System.out.println("Created --> '" + theFile.getName()
						+ ".html'");

			}

			//----------------------------
			// End execute against SAXON
			//----------------------------
		
	}



}
