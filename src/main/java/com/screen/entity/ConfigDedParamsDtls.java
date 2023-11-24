package com.screen.entity;

import java.util.Date;

public class ConfigDedParamsDtls {

	private Long id;  
	private static final long serialVersionUID = 5847898296531732665L;
	private ConfigDedParamsHdr configDedParamsHdr;
	private String parameterCode;
	private String parameterName;
	private Long parameterValue;
	private String unitsDescription;
	private String remarks;
	private Date configDTLSvalidFrom;
	private String dedParamsHdrList;
	private Date configDTLSvalidTo;
	private Long configDedParamsHdrId;
	private Line line;
	private Boolean valid = Boolean.TRUE;
	private Integer paramCount;
	private boolean addRow = false;
	private boolean duplicate = false;
	private boolean deleteFlag;
	private Long detailId;
	private Boolean readonly = true;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public ConfigDedParamsHdr getConfigDedParamsHdr() {
		return configDedParamsHdr;
	}
	public void setConfigDedParamsHdr(ConfigDedParamsHdr configDedParamsHdr) {
		this.configDedParamsHdr = configDedParamsHdr;
	}
	public String getParameterCode() {
		return parameterCode;
	}
	public void setParameterCode(String parameterCode) {
		this.parameterCode = parameterCode;
	}
	public String getParameterName() {
		return parameterName;
	}
	public void setParameterName(String parameterName) {
		this.parameterName = parameterName;
	}
	public Long getParameterValue() {
		return parameterValue;
	}
	public void setParameterValue(Long parameterValue) {
		this.parameterValue = parameterValue;
	}
	public String getUnitsDescription() {
		return unitsDescription;
	}
	public void setUnitsDescription(String unitsDescription) {
		this.unitsDescription = unitsDescription;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public Date getConfigDTLSvalidFrom() {
		return configDTLSvalidFrom;
	}
	public void setConfigDTLSvalidFrom(Date configDTLSvalidFrom) {
		this.configDTLSvalidFrom = configDTLSvalidFrom;
	}
	public String getDedParamsHdrList() {
		return dedParamsHdrList;
	}
	public void setDedParamsHdrList(String dedParamsHdrList) {
		this.dedParamsHdrList = dedParamsHdrList;
	}
	public Date getConfigDTLSvalidTo() {
		return configDTLSvalidTo;
	}
	public void setConfigDTLSvalidTo(Date configDTLSvalidTo) {
		this.configDTLSvalidTo = configDTLSvalidTo;
	}
	public Long getConfigDedParamsHdrId() {
		return configDedParamsHdrId;
	}
	public void setConfigDedParamsHdrId(Long configDedParamsHdrId) {
		this.configDedParamsHdrId = configDedParamsHdrId;
	}
	public Line getLine() {
		return line;
	}
	public void setLine(Line line) {
		this.line = line;
	}
	public Boolean getValid() {
		return valid;
	}
	public void setValid(Boolean valid) {
		this.valid = valid;
	}
	public Integer getParamCount() {
		return paramCount;
	}
	public void setParamCount(Integer paramCount) {
		this.paramCount = paramCount;
	}
	public boolean isAddRow() {
		return addRow;
	}
	public void setAddRow(boolean addRow) {
		this.addRow = addRow;
	}
	public boolean isDuplicate() {
		return duplicate;
	}
	public void setDuplicate(boolean duplicate) {
		this.duplicate = duplicate;
	}
	public boolean isDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(boolean deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public Long getDetailId() {
		return detailId;
	}
	public void setDetailId(Long detailId) {
		this.detailId = detailId;
	}
	public Boolean getReadonly() {
		return readonly;
	}
	public void setReadonly(Boolean readonly) {
		this.readonly = readonly;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
}
