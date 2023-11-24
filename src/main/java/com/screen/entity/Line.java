package com.screen.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="LINE")
public class Line {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long lineId;
	
	@Column(name="LINE_CODE")
	private String lineCode;
	
	@Column(name="LINE_NAME")
	private String lineName;
	
	
	
}
