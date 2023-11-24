package com.screen.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Where;

@Entity
@DynamicUpdate
@DynamicInsert
@Table(name = "CONFIG_DED_PARAMS_HDR")
public class EConfigDedParamsHdr {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(targetEntity = Line.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "LINE_ID", nullable = false)
	@Where(clause = "IS_ACTIVE = 1")
	private Line line;

	@Column(name = "REMARKS", length = 2000)
	private String remarks;

	@Column(name = "BUFFER_DAYS")
	private Integer bufferDays;

	@Column(name = "INSTRUCTION_TYPE", nullable = false)
	private String instructionType;

	@Column(name = "EXCLUDE_TYPE")
	private String exclude;

	@Column(name = "IS_ACTIVE", nullable = false)
	private boolean valid;

	@Column(name = "VALID_FROM", nullable = false)
	private String validFrom;

	@Column(name = "VALID_TO", nullable = true)
	private String validTo;

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

	public boolean isValid() {
		return valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

	public Line getLine() {
		return line;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setLine(Line line) {
		this.line = line;
	}

	public Integer getBufferDays() {
		return bufferDays;
	}

	public void setBufferDays(Integer bufferDays) {
		this.bufferDays = bufferDays;
	}

	public String getInstructionType() {
		return instructionType;
	}

	public void setInstructionType(String instructionType) {
		this.instructionType = instructionType;
	}

	public String getExclude() {
		return exclude;
	}

	public void setExclude(String exclude) {
		this.exclude = exclude;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "configDedParamsHdr")
	private Set<EConfigDedParamsDtls> configDedParamsDtlses = new HashSet<EConfigDedParamsDtls>(0);

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Set<EConfigDedParamsDtls> getConfigDedParamsDtlses() {
		return configDedParamsDtlses;
	}

	public void setConfigDedParamsDtlses(Set<EConfigDedParamsDtls> configDedParamsDtlses) {
		this.configDedParamsDtlses = configDedParamsDtlses;
	}

}
