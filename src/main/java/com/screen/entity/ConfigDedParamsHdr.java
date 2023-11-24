package com.screen.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ConfigDedParamsHdr {

	private Long id;
	private String parameterCode;
	private String parameterName;
	private Long parameterValue;
	private String unitsDescription;
	private String remarks;
	private Terminal masterTerminal;
	private Line line;
	private String dedScoringParamList;
	private String validFrom;
	private String validTo;
//	private Date validFrom;
//	private Date validTo;
	private ConfigDedParamsHdr configDedParamsHdr;
	private Long configDedParamsHdrId;
	private String dedParamsHdrList;
	private List<ConfigDedParamsDtls> configDedParamsDtlsList = new ArrayList<ConfigDedParamsDtls>();
	private ConfigDedParamsDtls configDedParamsDtls;
	private Boolean valid = Boolean.TRUE;
	private String instructionType;
	private String exclude;
	private String excludeDtls;
	private boolean addRow = false;
	private Integer bufferDays;
	private boolean recordFound = false;
	private String instructionTypeDtls;
	private String instructionTypeEnq;
	private Long lineIdEnq;

	public String getInstructionType() {
		return instructionType;
	}

	public void setInstructionType(String instructionType) {
		this.instructionType = instructionType;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public Terminal getMasterTerminal() {
		return masterTerminal;
	}

	public void setMasterTerminal(Terminal masterTerminal) {
		this.masterTerminal = masterTerminal;
	}

	public Line getLine() {
		return line;
	}

	public void setLine(Line line) {
		this.line = line;
	}

	public String getDedScoringParamList() {
		return dedScoringParamList;
	}

	public void setDedScoringParamList(String dedScoringParamList) {
		this.dedScoringParamList = dedScoringParamList;
	}

	public String getValidFrom() {
		return validFrom;
	}

	public void setValidFrom(String validFrom) {
		this.validFrom = validFrom;
	}

	public String getValidTo() {
		return validTo;
	}

	public void setValidTo(String validTo) {
		this.validTo = validTo;
	}

	public ConfigDedParamsHdr getConfigDedParamsHdr() {
		return configDedParamsHdr;
	}

	public void setConfigDedParamsHdr(ConfigDedParamsHdr configDedParamsHdr) {
		this.configDedParamsHdr = configDedParamsHdr;
	}

	public Long getConfigDedParamsHdrId() {
		return configDedParamsHdrId;
	}

	public void setConfigDedParamsHdrId(Long configDedParamsHdrId) {
		this.configDedParamsHdrId = configDedParamsHdrId;
	}

	public String getDedParamsHdrList() {
		return dedParamsHdrList;
	}

	public void setDedParamsHdrList(String dedParamsHdrList) {
		this.dedParamsHdrList = dedParamsHdrList;
	}

	public List<ConfigDedParamsDtls> getConfigDedParamsDtlsList() {
		return configDedParamsDtlsList;
	}

	public void setConfigDedParamsDtlsList(List<ConfigDedParamsDtls> configDedParamsDtlsList) {
		this.configDedParamsDtlsList = configDedParamsDtlsList;
	}

	public ConfigDedParamsDtls getConfigDedParamsDtls() {
		return configDedParamsDtls;
	}

	public void setConfigDedParamsDtls(ConfigDedParamsDtls configDedParamsDtls) {
		this.configDedParamsDtls = configDedParamsDtls;
	}

	public Boolean getValid() {
		return valid;
	}

	public void setValid(Boolean valid) {
		this.valid = valid;
	}

	public String getExclude() {
		return exclude;
	}

	public void setExclude(String exclude) {
		this.exclude = exclude;
	}

	public boolean isAddRow() {
		return addRow;
	}

	public void setAddRow(boolean addRow) {
		this.addRow = addRow;
	}

	public Integer getBufferDays() {
		return bufferDays;
	}

	public void setBufferDays(Integer bufferDays) {
		this.bufferDays = bufferDays;
	}

	public boolean isRecordFound() {
		return recordFound;
	}

	public void setRecordFound(boolean recordFound) {
		this.recordFound = recordFound;
	}

	public String getInstructionTypeDtls() {
		return instructionTypeDtls;
	}

	public void setInstructionTypeDtls(String instructionTypeDtls) {
		this.instructionTypeDtls = instructionTypeDtls;
	}

	public String getInstructionTypeEnq() {
		return instructionTypeEnq;
	}

	public void setInstructionTypeEnq(String instructionTypeEnq) {
		this.instructionTypeEnq = instructionTypeEnq;
	}

	public Long getLineIdEnq() {
		return lineIdEnq;
	}

	public void setLineIdEnq(Long lineIdEnq) {
		this.lineIdEnq = lineIdEnq;
	}

	public String getExcludeDtls() {
		return excludeDtls;
	}

	public void setExcludeDtls(String excludeDtls) {
		this.excludeDtls = excludeDtls;
	}

}
