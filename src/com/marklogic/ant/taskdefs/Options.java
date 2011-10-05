package com.marklogic.ant.taskdefs;

import java.math.BigInteger;
import java.util.Locale;
import java.util.TimeZone;

import org.apache.tools.ant.types.DataType;

public class Options extends DataType {
	private boolean cacheResults;
	private String xqueryVersion;
	private BigInteger effectivePointInTime;
	private Locale local;
	private int autoRetryDelayMillis;
	private int maxAutoRetry;
	private String requestName;
	private int requestTimeLimit;
	private int resultBufferSize;
	private int timeoutMillis;
	private TimeZone timeZone;
	
	/**
	 * @return the cacheResults
	 */
	public boolean isCacheResults() {
		return cacheResults;
	}
	/**
	 * @param cacheResults the cacheResults to set
	 */
	public void setCacheResults(boolean cacheResults) {
		this.cacheResults = cacheResults;
	}
	/**
	 * @return the xqueryVersion
	 */
	public String getXqueryVersion() {
		return xqueryVersion;
	}
	/**
	 * @param xqueryVersion the xqueryVersion to set
	 */
	public void setXqueryVersion(String xqueryVersion) {
		this.xqueryVersion = xqueryVersion;
	}
	/**
	 * @return the effectivePointInTime
	 */
	public BigInteger getEffectivePointInTime() {
		return effectivePointInTime;
	}
	/**
	 * @param effectivePointInTime the effectivePointInTime to set
	 */
	public void setEffectivePointInTime(BigInteger effectivePointInTime) {
		this.effectivePointInTime = effectivePointInTime;
	}
	/**
	 * @return the local
	 */
	public Locale getLocal() {
		return local;
	}
	/**
	 * @param local the local to set
	 */
	public void setLocal(Locale local) {
		this.local = local;
	}
	/**
	 * @return the autoRetryDelayMillis
	 */
	public int getAutoRetryDelayMillis() {
		return autoRetryDelayMillis;
	}
	/**
	 * @param autoRetryDelayMillis the autoRetryDelayMillis to set
	 */
	public void setAutoRetryDelayMillis(int autoRetryDelayMillis) {
		this.autoRetryDelayMillis = autoRetryDelayMillis;
	}
	/**
	 * @return the maxAutoRetry
	 */
	public int getMaxAutoRetry() {
		return maxAutoRetry;
	}
	/**
	 * @param maxAutoRetry the maxAutoRetry to set
	 */
	public void setMaxAutoRetry(int maxAutoRetry) {
		this.maxAutoRetry = maxAutoRetry;
	}
	/**
	 * @return the requestName
	 */
	public String getRequestName() {
		return requestName;
	}
	/**
	 * @param requestName the requestName to set
	 */
	public void setRequestName(String requestName) {
		this.requestName = requestName;
	}
	/**
	 * @return the requestTimeLimit
	 */
	public int getRequestTimeLimit() {
		return requestTimeLimit;
	}
	/**
	 * @param requestTimeLimit the requestTimeLimit to set
	 */
	public void setRequestTimeLimit(int requestTimeLimit) {
		this.requestTimeLimit = requestTimeLimit;
	}
	/**
	 * @return the resultBufferSize
	 */
	public int getResultBufferSize() {
		return resultBufferSize;
	}
	/**
	 * @param resultBufferSize the resultBufferSize to set
	 */
	public void setResultBufferSize(int resultBufferSize) {
		this.resultBufferSize = resultBufferSize;
	}
	/**
	 * @return the timeoutMillis
	 */
	public int getTimeoutMillis() {
		return timeoutMillis;
	}
	/**
	 * @param timeoutMillis the timeoutMillis to set
	 */
	public void setTimeoutMillis(int timeoutMillis) {
		this.timeoutMillis = timeoutMillis;
	}
	/**
	 * @return the timeZone
	 */
	public TimeZone getTimeZone() {
		return timeZone;
	}
	/**
	 * @param timeZone the timeZone to set
	 */
	public void setTimeZone(TimeZone timeZone) {
		this.timeZone = timeZone;
	}
}
