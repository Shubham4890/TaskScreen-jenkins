package com.screen.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name = "CONFIG_CODES")
@DynamicInsert
@DynamicUpdate
public class ECodes {
@Id
@GeneratedValue(strategy = GenerationType.AUTO)
private long id; 
  @Column(name = "CODE_TYPE", nullable = false, length = 15)
  private String codeType;

  @Column(name = "SHORT_CODE", nullable = false, length = 30)
  private String shortCode;

  @Column(name = "LONG_CODE", nullable = false, length = 50)
  private String longCode;

  @Column(name = "CODE_GROUP", length = 50)
  private String codeGroup;

  @Column(name = "SHORT_DESCRIPTION", nullable = false, length = 200)
  private String shortDescription;

  @Column(name = "LONG_DESCRIPTION", nullable = false, length = 500)
  private String longDescription;

  @Column(name = "NUMARIC_VALUE", precision = 10, scale = 2)
  private BigDecimal numericVal;

  @Column(name = "REMARKS", length = 2000)
  private String remarks;

  @Column(name = "IS_ACTIVE", nullable = false)
  @Transient
  private Boolean valid = Boolean.TRUE;

  public Boolean getValid() {
    return valid;
  }

  public void setValid(Boolean valid) {
    this.valid = valid;
  }


  public String getCodeType() {
    return codeType;
  }

  public void setCodeType(String codeType) {
    this.codeType = codeType;
  }

  public String getShortCode() {
    return shortCode;
  }

  public void setShortCode(String shortCode) {
    this.shortCode = shortCode;
  }

  public String getLongCode() {
    return longCode;
  }

  public void setLongCode(String longCode) {
    this.longCode = longCode;
  }

  public String getCodeGroup() {
    return codeGroup;
  }

  public void setCodeGroup(String codeGroup) {
    this.codeGroup = codeGroup;
  }

  public String getShortDescription() {
    return shortDescription;
  }

  public void setShortDescription(String shortDescription) {
    this.shortDescription = shortDescription;
  }

  public String getLongDescription() {
    return longDescription;
  }

  public void setLongDescription(String longDescription) {
    this.longDescription = longDescription;
  }

  public BigDecimal getNumericVal() {
    return numericVal;
  }

  public void setNumericVal(BigDecimal numericVal) {
    this.numericVal = numericVal;
  }

  public String getRemarks() {
    return remarks;
  }

  public void setRemarks(String remarks) {
    this.remarks = remarks;
  }

  public long getId() {
	return id;
}

public void setId(long id) {
	this.id = id;
}

@Override
  public String toString() {
    return "Codes [codeType=" + codeType + ", shortCode=" + shortCode + ", longCode=" + longCode
        + ", codeGroup=" + codeGroup + ", shortDescription=" + shortDescription
        + ", longDescription=" + longDescription + ", numericVal=" + numericVal + ", remarks="
        + remarks + "]";
  }

}