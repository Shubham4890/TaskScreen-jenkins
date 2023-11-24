package com.screen.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.screen.entity.ConfigDedParamsDtls;
import com.screen.entity.ConfigDedParamsHdr;
import com.screen.entity.EConfigDedParamsDtls;
import com.screen.entity.EConfigDedParamsHdr;
import com.screen.entity.Line;
import com.screen.repository.DEDConfigParamHdrRepo;
import com.screen.repository.LineRepo;

import io.micrometer.core.instrument.util.StringUtils;

@Service
public class DEDScoringService {
	@Autowired
	DEDConfigParamHdrRepo dedConfigParamHdrRepo;

	@Autowired
	LineRepo lineRepo;

	public ConfigDedParamsHdr createOrUpdateConfigDedParamsHdr(ConfigDedParamsHdr configDedParamsHdr) {
		EConfigDedParamsHdr existingEntry = dedConfigParamHdrRepo.findByLine_LineNameAndInstructionType(
				configDedParamsHdr.getLine().getLineName(), configDedParamsHdr.getInstructionType());

		if (existingEntry != null) {

			// Entry exists, update its values
			existingEntry.setBufferDays(configDedParamsHdr.getBufferDays());
			existingEntry.setRemarks(configDedParamsHdr.getRemarks());
			existingEntry.setInstructionType(configDedParamsHdr.getInstructionType());
			existingEntry.setExclude(configDedParamsHdr.getExclude());
			existingEntry.setValid(configDedParamsHdr.getValid());
			existingEntry.setValidFrom(configDedParamsHdr.getValidFrom());
			existingEntry.setValidTo(configDedParamsHdr.getValidTo());

			// Update ConfigDedParamsDtls if needed
			Set<EConfigDedParamsDtls> existingDtls = existingEntry.getConfigDedParamsDtlses();
			Set<EConfigDedParamsDtls> newDtls = new HashSet<>();

			for (ConfigDedParamsDtls configDedParamsDtl : configDedParamsHdr.getConfigDedParamsDtlsList()) {
				EConfigDedParamsDtls existingDtl = findMatchingDtl(existingDtls, configDedParamsDtl);

				if (existingDtl != null) {
					// Update existing detail
					existingDtl.setParameterCode(configDedParamsDtl.getParameterCode());
					existingDtl.setParameterValue(configDedParamsDtl.getParameterValue());
					// existingDtl.setParameterName(configDedParamsDtl.getParameterName());
					existingDtl.setUnitsDescription(configDedParamsDtl.getUnitsDescription());
					existingDtl.setValid(configDedParamsDtl.getValid());
					existingDtl.setRemarks(configDedParamsDtl.getRemarks());
					existingDtl.setConfigDedParamsHdr(existingEntry);
					newDtls.add(existingDtl);
				} else {
					// Create a new detail
					EConfigDedParamsDtls newDtl = new EConfigDedParamsDtls();
					newDtl.setParameterCode(configDedParamsDtl.getParameterCode());
					newDtl.setParameterValue(configDedParamsDtl.getParameterValue());
					// newDtl.setParameterName(configDedParamsDtl.getParameterName());
					newDtl.setUnitsDescription(configDedParamsDtl.getUnitsDescription());
					newDtl.setValid(configDedParamsDtl.getValid());
					newDtl.setRemarks(configDedParamsDtl.getRemarks());
					newDtl.setConfigDedParamsHdr(existingEntry);
					newDtls.add(newDtl);
				}
			}

			// Update the set of details
			existingEntry.setConfigDedParamsDtlses(newDtls);

			// Save the updated entity
			dedConfigParamHdrRepo.save(existingEntry);

		} else {
			// Entry doesn't exist, create a new one
			EConfigDedParamsHdr eConfigDedParamsHdr = new EConfigDedParamsHdr();
			Set<EConfigDedParamsDtls> configDedParamsDtls = new HashSet<>();

			Line code = lineRepo.findByLineName(configDedParamsHdr.getLine().getLineName());

			eConfigDedParamsHdr.setBufferDays(configDedParamsHdr.getBufferDays());
			eConfigDedParamsHdr.setRemarks(configDedParamsHdr.getRemarks());
			eConfigDedParamsHdr.setInstructionType(configDedParamsHdr.getInstructionType());
			eConfigDedParamsHdr.setExclude(configDedParamsHdr.getExclude());
			eConfigDedParamsHdr.setLine(code);
			eConfigDedParamsHdr.setValid(configDedParamsHdr.getValid());
			eConfigDedParamsHdr.setValidFrom(configDedParamsHdr.getValidFrom());
			eConfigDedParamsHdr.setValidTo(configDedParamsHdr.getValidTo());

			for (ConfigDedParamsDtls configDedParamsDtl : configDedParamsHdr.getConfigDedParamsDtlsList()) {
				EConfigDedParamsDtls configDedParamsDtle = new EConfigDedParamsDtls();
				configDedParamsDtle.setParameterCode(configDedParamsDtl.getParameterCode());
				configDedParamsDtle.setParameterValue(configDedParamsDtl.getParameterValue());
//	            configDedParamsDtle.setParameterName(configDedParamsDtl.getParameterName());
				configDedParamsDtle.setUnitsDescription(configDedParamsDtl.getUnitsDescription());
				configDedParamsDtle.setValid(configDedParamsDtl.getValid());
				configDedParamsDtle.setRemarks(configDedParamsDtl.getRemarks());
				configDedParamsDtle.setConfigDedParamsHdr(eConfigDedParamsHdr);
				configDedParamsDtls.add(configDedParamsDtle);
			}

			eConfigDedParamsHdr.setConfigDedParamsDtlses(configDedParamsDtls);
			dedConfigParamHdrRepo.save(eConfigDedParamsHdr);
		}

		return configDedParamsHdr;
	}

	private EConfigDedParamsDtls findMatchingDtl(Set<EConfigDedParamsDtls> dtls, ConfigDedParamsDtls targetDtl) {
		for (EConfigDedParamsDtls dtl : dtls) {
			if (dtl.getParameterCode().equals(targetDtl.getParameterCode())) {
				return dtl;
			}
		}
		return null;
	}

	public ConfigDedParamsHdr findByLineIdAndInstructionType(String lineName, String instrctionType) {
		EConfigDedParamsHdr configDedParamsHdr = dedConfigParamHdrRepo.findByLine_LineNameAndInstructionType(lineName,
				instrctionType);
		ConfigDedParamsHdr type = new ConfigDedParamsHdr();
		if (configDedParamsHdr != null) {

			List<ConfigDedParamsDtls> configDedParamsDtls = new ArrayList<ConfigDedParamsDtls>();
			type.setLine(configDedParamsHdr.getLine());
			type.setId(configDedParamsHdr.getId());
			type.setBufferDays(configDedParamsHdr.getBufferDays());
			type.setRemarks(configDedParamsHdr.getRemarks());
			type.setInstructionType(configDedParamsHdr.getInstructionType());
			type.setExclude(configDedParamsHdr.getExclude());
			type.setValid(configDedParamsHdr.isValid());
			type.setValidFrom(configDedParamsHdr.getValidFrom()); //changes
			type.setValidTo(configDedParamsHdr.getValidTo());
			
			for (EConfigDedParamsDtls configDedParamsDtl : configDedParamsHdr.getConfigDedParamsDtlses()) {

				ConfigDedParamsDtls configDedParamsDtle = new ConfigDedParamsDtls();

				configDedParamsDtle.setParameterCode(configDedParamsDtl.getParameterCode());
				configDedParamsDtle.setParameterValue(configDedParamsDtl.getParameterValue());
				// configDedParamsDtle.setParameterName(configDedParamsDtl.getParameterName());
				configDedParamsDtle.setUnitsDescription(configDedParamsDtl.getUnitsDescription());
				configDedParamsDtle.setValid(configDedParamsDtl.getValid());
				configDedParamsDtle.setRemarks(configDedParamsDtl.getRemarks());
				configDedParamsDtl.setConfigDedParamsHdr(configDedParamsHdr);
				configDedParamsDtls.add(configDedParamsDtle);

			}
			type.setConfigDedParamsDtlsList(configDedParamsDtls);
		}
		return type;

	}

	public List<ConfigDedParamsHdr> findByAllBySearchCriteria(ConfigDedParamsHdr configDedParamsHdr) {

		List<EConfigDedParamsHdr> findAll = this.dedConfigParamHdrRepo
				.findAll(findBySearchCriteria(configDedParamsHdr));
		Map<String, String> map = new HashMap<>();
		map.put("0100", "DPA CONVENIENCE");
		map.put("0101", "MT RELEASE ONLY");
		map.put("0102", "OFFHIRE DELIVERY");
		map.put("0103", "SALES DELIVERY");
		map.put("0104", "MT OUT EXP IN FOR SCRAP");
		
			
		List<ConfigDedParamsHdr> typeList = new ArrayList<ConfigDedParamsHdr>();
		if (findAll != null) {
			for (EConfigDedParamsHdr eConfigDedParamsHdr : findAll) {
				StringBuilder stringBuilder=new StringBuilder();
				ConfigDedParamsHdr type = new ConfigDedParamsHdr();
				List<ConfigDedParamsDtls> configDedParamsDtls = new ArrayList<ConfigDedParamsDtls>();
				type.setLine(eConfigDedParamsHdr.getLine());
				type.setId(eConfigDedParamsHdr.getId());
				type.setBufferDays(eConfigDedParamsHdr.getBufferDays());
				type.setRemarks(eConfigDedParamsHdr.getRemarks());
				type.setInstructionType(eConfigDedParamsHdr.getInstructionType());
				type.setExclude(eConfigDedParamsHdr.getExclude());
				type.setValid(eConfigDedParamsHdr.isValid());
				type.setValidFrom(eConfigDedParamsHdr.getValidFrom());//changes
				type.setValidTo(eConfigDedParamsHdr.getValidTo());
				for(String str:eConfigDedParamsHdr.getInstructionType().split(",")) {
					if(stringBuilder.length()>0)
					stringBuilder.append(",");
					stringBuilder.append(map.get(str));
				}
				
				type.setInstructionTypeDtls(stringBuilder.toString());
				for (EConfigDedParamsDtls configDedParamsDtl : eConfigDedParamsHdr.getConfigDedParamsDtlses()) {

					ConfigDedParamsDtls configDedParamsDtle = new ConfigDedParamsDtls();

					configDedParamsDtle.setParameterCode(configDedParamsDtl.getParameterCode());
					configDedParamsDtle.setParameterValue(configDedParamsDtl.getParameterValue());
					// configDedParamsDtle.setParameterName(configDedParamsDtl.getParameterName());
					configDedParamsDtle.setUnitsDescription(configDedParamsDtl.getUnitsDescription());
					configDedParamsDtle.setValid(configDedParamsDtl.getValid());
					configDedParamsDtle.setRemarks(configDedParamsDtl.getRemarks());
					// configDedParamsDtl.setConfigDedParamsHdr(type);
					configDedParamsDtls.add(configDedParamsDtle);

				}
				type.setConfigDedParamsDtlsList(configDedParamsDtls);
				typeList.add(type);
			}
		}
		return typeList;

	}
	public Boolean checkIfInstructionTypeExist(ConfigDedParamsHdr configDedParamsHdr, String lineName ) {
		
		Map<Integer, String> map = new HashMap<>();
		map.put(0100, "DPA CONVENIENCE");
		map.put(0101, "MT RELEASE ONLY");
		map.put(0102, "OFFHIRE DELIVERY");
		map.put(0103, "SALES DELIVERY");
		map.put(0104, "MT OUT EXP IN FOR SCRAP");


		Boolean deatilsExist = false;
		if (configDedParamsHdr != null & lineName != null && configDedParamsHdr.getInstructionType() != null) {

			List<EConfigDedParamsHdr> configDedParamsHdrsList = dedConfigParamHdrRepo.findByLine_LineName(lineName);
			if (configDedParamsHdrsList != null) {
				for (EConfigDedParamsHdr configDedParamsHdrRcrd : configDedParamsHdrsList) {
					if (configDedParamsHdrRcrd != null) {
						if (configDedParamsHdr.getId() != null
								&& configDedParamsHdr.getId().equals(configDedParamsHdrRcrd.getId())) {
							continue;
						} else if (configDedParamsHdrRcrd.getInstructionType() != null) {
							String[] listInstructionType = configDedParamsHdrRcrd.getInstructionType().split(",");
							String[] instructionType = configDedParamsHdr.getInstructionType().split(",");

							for (String s : listInstructionType) {
								if (Arrays.asList(instructionType).contains(s)) {
									return deatilsExist = true;
								}
							}
						}
					}
				}
			}

		}

		return deatilsExist;
	}
	
public String checkIfInstructionTypeExist1(ConfigDedParamsHdr configDedParamsHdr, String lineName ) {
        
        Map<String, String> map = new HashMap<>();
        map.put("0100", "DPA CONVENIENCE");
        map.put("0101", "MT RELEASE ONLY");
        map.put("0102", "OFFHIRE DELIVERY");
        map.put("0103", "SALES DELIVERY");
        map.put("0104", "MT OUT EXP IN FOR SCRAP");
                


        Boolean deatilsExist = false;
        if (configDedParamsHdr != null & lineName != null && configDedParamsHdr.getInstructionType() != null) {

            List<EConfigDedParamsHdr> configDedParamsHdrsList = dedConfigParamHdrRepo.findByLine_LineName(lineName);
            if (configDedParamsHdrsList != null) {
                for (EConfigDedParamsHdr configDedParamsHdrRcrd : configDedParamsHdrsList) {
                    if (configDedParamsHdrRcrd != null) {
                        if (configDedParamsHdr.getId() != null
                                && configDedParamsHdr.getId().equals(configDedParamsHdrRcrd.getId())) {
                            continue;
                        } else if (configDedParamsHdrRcrd.getInstructionType() != null) {
                            String[] listInstructionType = configDedParamsHdrRcrd.getInstructionType().split(",");
                            String[] instructionType = configDedParamsHdr.getInstructionType().split(",");

                            for (String s : listInstructionType) {
                                if (Arrays.asList(instructionType).contains(s)) {
                                    StringBuilder instrctin = new StringBuilder();
                                    for (String k : listInstructionType) {
                                        instrctin.append(map.get(k));
                                        instrctin.append("  ");
                                    }
                                    return instrctin.toString();
                                }
                            }
                        }
                    }
                }
            }

        }

        return null;
    }

	public ConfigDedParamsHdr findById(Long id) {
		ConfigDedParamsHdr type = new ConfigDedParamsHdr();
		StringBuilder stringBuilder=new StringBuilder();
		Map<String, String> map = new HashMap<>();
		map.put("0100", "DPA CONVENIENCE");
		map.put("0101", "MT RELEASE ONLY");
		map.put("0102", "OFFHIRE DELIVERY");
		map.put("0103", "SALES DELIVERY");
		map.put("0104", "MT OUT EXP IN FOR SCRAP");
		
		StringBuilder stringBuilde1=new StringBuilder();
		Map<String, String> map1 = new HashMap<>();
		map1.put("100", "Off-Hire");
		map1.put("101", "Mt Release");
		map1.put("102", "Sale");
	                
		try {
			if (id != null) {
				Optional<EConfigDedParamsHdr> findById = dedConfigParamHdrRepo.findById(id);				
						
						if (findById.isPresent()) { //
							List<ConfigDedParamsDtls> configDedParamsDtls = new ArrayList<ConfigDedParamsDtls>();
							EConfigDedParamsHdr configDedParamsHdr=	findById.get();
							type.setLine(configDedParamsHdr.getLine());
							type.setId(configDedParamsHdr.getId());
							type.setBufferDays(configDedParamsHdr.getBufferDays());
							type.setRemarks(configDedParamsHdr.getRemarks());
							type.setInstructionType(configDedParamsHdr.getInstructionType());
							for(String str:configDedParamsHdr.getInstructionType().split(",")) {
								if(stringBuilder.length()>0)
								stringBuilder.append(",");
								stringBuilder.append(map.get(str));
							}
							
							type.setInstructionTypeDtls(stringBuilder.toString());
							if(StringUtils.isNotBlank(configDedParamsHdr.getExclude()))
							type.setExcludeDtls(map1.get(configDedParamsHdr.getExclude()));
							type.setExclude(configDedParamsHdr.getExclude());
							
							type.setValid(configDedParamsHdr.isValid());
							type.setValidFrom(configDedParamsHdr.getValidFrom());
							type.setValidTo(configDedParamsHdr.getValidTo());
							for (EConfigDedParamsDtls configDedParamsDtl : configDedParamsHdr.getConfigDedParamsDtlses()) {

								ConfigDedParamsDtls configDedParamsDtle = new ConfigDedParamsDtls();

								configDedParamsDtle.setParameterCode(configDedParamsDtl.getParameterCode());
								configDedParamsDtle.setParameterValue(configDedParamsDtl.getParameterValue());
								// configDedParamsDtle.setParameterName(configDedParamsDtl.getParameterName());
								configDedParamsDtle.setUnitsDescription(configDedParamsDtl.getUnitsDescription());
								configDedParamsDtle.setValid(configDedParamsDtl.getValid());
								configDedParamsDtle.setRemarks(configDedParamsDtl.getRemarks());
								configDedParamsDtle.setConfigDedParamsHdr(type);
								configDedParamsDtls.add(configDedParamsDtle);

							}
							type.setConfigDedParamsDtlsList(configDedParamsDtls);
						}
						return type;
			}
	}catch(Exception e) {
		
	}
		return null;
	}
	
	// new method 
	public ConfigDedParamsHdr UpdateConfigDedParamsHdr(ConfigDedParamsHdr configDedParamsHdr) {
	 Optional<EConfigDedParamsHdr> findById = dedConfigParamHdrRepo.findById(configDedParamsHdr.getId());

		if (findById.isPresent()) {
			EConfigDedParamsHdr	existingEntry=findById.get();

			// Entry exists, update its values
			existingEntry.setBufferDays(configDedParamsHdr.getBufferDays());
			existingEntry.setRemarks(configDedParamsHdr.getRemarks());
			existingEntry.setInstructionType(configDedParamsHdr.getInstructionType());
			existingEntry.setExclude(configDedParamsHdr.getExclude());
			existingEntry.setValid(configDedParamsHdr.getValid());
			existingEntry.setValidFrom(configDedParamsHdr.getValidFrom());
			existingEntry.setValidTo(configDedParamsHdr.getValidTo());

			// Update ConfigDedParamsDtls if needed
			Set<EConfigDedParamsDtls> existingDtls = existingEntry.getConfigDedParamsDtlses();
			Set<EConfigDedParamsDtls> newDtls = new HashSet<>();

			for (ConfigDedParamsDtls configDedParamsDtl : configDedParamsHdr.getConfigDedParamsDtlsList()) {
				EConfigDedParamsDtls existingDtl = findMatchingDtl(existingDtls, configDedParamsDtl);

				if (existingDtl != null) {
					// Update existing detail
					existingDtl.setParameterCode(configDedParamsDtl.getParameterCode());
					existingDtl.setParameterValue(configDedParamsDtl.getParameterValue());
					// existingDtl.setParameterName(configDedParamsDtl.getParameterName());
					existingDtl.setUnitsDescription(configDedParamsDtl.getUnitsDescription());
					existingDtl.setValid(configDedParamsDtl.getValid());
					existingDtl.setRemarks(configDedParamsDtl.getRemarks());
					existingDtl.setConfigDedParamsHdr(existingEntry);
					newDtls.add(existingDtl);
				} else {
					// Create a new detail
					EConfigDedParamsDtls newDtl = new EConfigDedParamsDtls();
					newDtl.setParameterCode(configDedParamsDtl.getParameterCode());
					newDtl.setParameterValue(configDedParamsDtl.getParameterValue());
					// newDtl.setParameterName(configDedParamsDtl.getParameterName());
					newDtl.setUnitsDescription(configDedParamsDtl.getUnitsDescription());
					newDtl.setValid(configDedParamsDtl.getValid());
					newDtl.setRemarks(configDedParamsDtl.getRemarks());
					newDtl.setConfigDedParamsHdr(existingEntry);
					newDtls.add(newDtl);
				}
			}

			// Update the set of details
			existingEntry.setConfigDedParamsDtlses(newDtls);

			// Save the updated entity
			dedConfigParamHdrRepo.save(existingEntry);

		} 

		return configDedParamsHdr;
	}

	public Specification<EConfigDedParamsHdr> findBySearchCriteria(ConfigDedParamsHdr configDedParamsHdr) {

		return new Specification<EConfigDedParamsHdr>() {

			@Override
			public Predicate toPredicate(Root<EConfigDedParamsHdr> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				List<Predicate> predicates = new ArrayList<>();
				if (configDedParamsHdr.getLine() != null && configDedParamsHdr.getLine().getLineName() != null) {
					predicates.add(
							cb.equal(root.get("line").get("lineName"), configDedParamsHdr.getLine().getLineName()));
				}
				if (StringUtils.isNotEmpty(configDedParamsHdr.getInstructionType())) {
					predicates.add(cb.equal(root.get("instructionType"), configDedParamsHdr.getInstructionType()));
				}

				return cb.and(predicates.toArray(new Predicate[] {}));
			}

		};

	}
	
	
	public Optional<EConfigDedParamsHdr> getByLineNameById(Long id) {
		Optional<EConfigDedParamsHdr> hdr	= dedConfigParamHdrRepo.findById(id);
		return hdr;
		
	}
	
	public Line findByLineName(String lineName) {
		return lineRepo.findByLineName(lineName);
	}
	public Line findByLineId(Long lineId) {
		 Optional<Line> findById = lineRepo.findById(lineId);
		 if(findById.isPresent())
			 return findById.get();
		return null;
	}
	
}
