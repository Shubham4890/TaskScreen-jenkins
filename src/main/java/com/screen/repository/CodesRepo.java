package com.screen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.screen.entity.ECodes;

@Repository
public interface CodesRepo extends JpaRepository<ECodes, Long> {
	List<ECodes> findByCodeType(String codetype);
	
	

}
