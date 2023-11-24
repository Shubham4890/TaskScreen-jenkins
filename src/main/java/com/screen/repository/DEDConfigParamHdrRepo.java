package com.screen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.screen.entity.EConfigDedParamsHdr;

@Repository
public interface DEDConfigParamHdrRepo extends JpaRepository<EConfigDedParamsHdr, Long> , JpaSpecificationExecutor<EConfigDedParamsHdr> {
	
	//EConfigDedParamsHdr	findByLine_LineCodeAndInstructionType(String lineCode , String instructionType);

	EConfigDedParamsHdr findByLine_LineNameAndInstructionType(String lineName, String instructionType);

	List<EConfigDedParamsHdr> findByLine_LineName(String lineName);

	
	//EConfigDedParamsHdr findByLineId(Long amendId);
	

}
