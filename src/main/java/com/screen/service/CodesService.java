package com.screen.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.screen.entity.ECodes;
import com.screen.entity.Line;
import com.screen.repository.CodesRepo;
import com.screen.repository.LineRepo;

@Service
public class CodesService {
	@Autowired
	private CodesRepo codesRepo;
	
	@Autowired LineRepo lineRepo;

	public List<ECodes> findAll() {
		return this.codesRepo.findAll();
	}
	
	
	 public ECodes saveECodes(ECodes eCodes) {
	        return codesRepo.save(eCodes);
	    }
	 
	 
	 public List<String> fetchLineNamesByTerm(String term) {
		    List<Line> lines = lineRepo.findByLineNameContainingIgnoreCase(term);
		    List<String> lineNames = new ArrayList<String>();
		    for (Line line : lines) {
		        lineNames.add(line.getLineName());
		    }
		    return lineNames;
		}

}
