package com.screen.entity;

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;




@Entity
@DynamicUpdate
@DynamicInsert
@Table(name = "CONFIG_DED_PARAMS_DTLS")
@AttributeOverride(name = "id", column = @Column(name = "PARAMETER_DTL_ID"))
public class EConfigDedParamsDtls   {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;
  @SuppressWarnings("unused")
  private static final long serialVersionUID = -5812078426767297909L;
  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "PARAMETER_HDR_ID")
  private EConfigDedParamsHdr configDedParamsHdr;

  @Column(name = "PARAMETER_CODE", length = 30)
  private String parameterCode;

//  @Column(name = "PARAMETER_NAME", length = 50)
//  private String parameterName;

  @Column(name = "PARAMETER_VALUE", precision = 15, scale = 0)
  private Long parameterValue;

  @Column(name = "UNITS_DESCRIPTION")
  private String unitsDescription;

  @Column(name = "REMARKS", length = 2000)
  private String remarks;

  

  @Column(name = "IS_ACTIVE", nullable = false)

  private Boolean valid = Boolean.TRUE;

  public Boolean getValid() {
    return valid;
  }

  public void setValid(Boolean valid) {
    this.valid = valid;
    
  }

 
public EConfigDedParamsHdr getConfigDedParamsHdr() {
    return configDedParamsHdr;
  }

  public void setConfigDedParamsHdr(EConfigDedParamsHdr configDedParamsHdr) {
    this.configDedParamsHdr = configDedParamsHdr;
  }

  public String getParameterCode() {
    return parameterCode;
  }

  public void setParameterCode(String parameterCode) {
    this.parameterCode = parameterCode;
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

public Long getId() {
	return id;
}

public void setId(Long id) {
	this.id = id;
}

public static long getSerialversionuid() {
	return serialVersionUID;
}
  

}
