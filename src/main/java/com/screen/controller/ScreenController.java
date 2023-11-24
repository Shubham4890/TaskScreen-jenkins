package com.screen.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.screen.entity.ConfigDedParamsDtls;
import com.screen.entity.ConfigDedParamsHdr;
import com.screen.entity.ECodes;
import com.screen.entity.EConfigDedParamsHdr;
import com.screen.entity.Line;
import com.screen.service.CodesService;
import com.screen.service.DEDScoringService;

import io.micrometer.core.instrument.util.StringUtils;

@Controller
public class ScreenController {
	@Autowired
	CodesService codesService;
	@Autowired
	DEDScoringService dedScoringService;

	@GetMapping("/fetch")
	public String screen2(@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr,
			ModelMap modelMap) throws CloneNotSupportedException {
		return "FetchScreen";
	}

	@GetMapping("/amend")
	public String screen3(@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr,
			ModelMap modelMap) throws CloneNotSupportedException {
		return "amend";
	}

	@GetMapping("/success")
	public String screen4(@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr,
			ModelMap modelMap) throws CloneNotSupportedException {
		return "SuccessFull";
	}

	@RequestMapping("/addContrScoringParameter")
	public String addContrScoringParameter(@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr,
			ModelMap modelMap) throws CloneNotSupportedException {

		ConfigDedParamsDtls configDedParamsDtls = new ConfigDedParamsDtls();
		List<ConfigDedParamsDtls> configDedParamsDetails = configDedParamsHdr.getConfigDedParamsDtlsList();
		ConfigDedParamsHdr tmpConfigDedParamsHdr = (ConfigDedParamsHdr) configDedParamsHdr;

		if (configDedParamsHdr.isAddRow()) {
			if (!configDedParamsHdr.getConfigDedParamsDtlsList().isEmpty()) {
				configDedParamsDetails = configDedParamsHdr.getConfigDedParamsDtlsList();
				List<ECodes> parametersList = codesService.findAll();

				List<ECodes> parameterCode = getParameterCode(configDedParamsDetails, parametersList);
				if (configDedParamsDetails.size() == parametersList.size()) {
					modelMap.put("promisException", "No more parameter to be added");
				} else {

					configDedParamsDetails.add(configDedParamsDtls);
					modelMap.put("parameterList", parameterCode);
				}
			}
			configDedParamsHdr.setAddRow(false);
			configDedParamsDtls.setReadonly(false);
		}
		if (configDedParamsHdr.getLine() != null) {
			String checkIfInstructionTypeExist = this.dedScoringService.checkIfInstructionTypeExist1(configDedParamsHdr,
					configDedParamsHdr.getLine().getLineName());
			if (checkIfInstructionTypeExist != null) {
				modelMap.addAttribute("promisException",
						"Details Already Exists In The selected InstructionType  : " + checkIfInstructionTypeExist);
			}
			modelMap.addAttribute("configDedParamsHdr", configDedParamsHdr);
		}

		/*
		 * if (configDedParamsHdr.getLine() != null) { Boolean
		 * checkIfInstructionTypeExist =
		 * this.dedScoringService.checkIfInstructionTypeExist(configDedParamsHdr,
		 * configDedParamsHdr.getLine().getLineName()); if (checkIfInstructionTypeExist)
		 * { modelMap.addAttribute("promisException",
		 * "Configuration Already Exist In The Instruction Type : "
		 * +checkIfInstructionTypeExist); } }
		 */
		modelMap.addAttribute("configDedParamsHdr", configDedParamsHdr);
		return "DED";
	}

	@RequestMapping("/searchScoringParameter")
	public String searchContrScoringParameter(
			@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr, ModelMap modelMap)
			throws CloneNotSupportedException {

		List<ConfigDedParamsDtls> configDedParamsDetails = new ArrayList<>();
		ConfigDedParamsHdr tmpConfigDedParamsHdr = (ConfigDedParamsHdr) configDedParamsHdr;

		for (ECodes code : codesService.findAll()) {
			ConfigDedParamsDtls configDedParamsDtls = new ConfigDedParamsDtls();
			configDedParamsDtls.setParameterValue(code.getNumericVal().longValue());
			configDedParamsDtls.setParameterCode(code.getShortCode());
			configDedParamsDtls.setRemarks(code.getRemarks());
			configDedParamsDtls.setUnitsDescription(code.getLongDescription());

			configDedParamsDetails.add(configDedParamsDtls);
		}

		configDedParamsHdr.setConfigDedParamsDtlsList(configDedParamsDetails);
		configDedParamsHdr.setValidFrom(new Date().toString());
		configDedParamsHdr.setValidTo("Thu Nov 30 11:59:59 IST 2023");
		modelMap.addAttribute("configDedParamsHdr", configDedParamsHdr);
		return "DED";
	}

	@RequestMapping("/searchContrScoringParameterBack")
	public String searchContrScoringParameterback(
			@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr, ModelMap modelMap)
			throws CloneNotSupportedException {
		if(configDedParamsHdr.getLineIdEnq()!=null)
		configDedParamsHdr.setLine(dedScoringService.findByLineId(configDedParamsHdr.getLineIdEnq()));
		configDedParamsHdr.setInstructionType(configDedParamsHdr.getInstructionTypeEnq());
		ConfigDedParamsHdr tmpConfigDedParamsHdr = null;
		if (configDedParamsHdr != null && configDedParamsHdr.getLine() != null) {
			tmpConfigDedParamsHdr = (ConfigDedParamsHdr) configDedParamsHdr;

			try {
				List<ConfigDedParamsHdr> findByAllBySearchCriteria = dedScoringService
						.findByAllBySearchCriteria(configDedParamsHdr);
				if (configDedParamsHdr.getId() == null) {
					modelMap.put("promisException", "No data Found");
				}
				modelMap.addAttribute("configDedParamsHdrList", findByAllBySearchCriteria);
			} catch (Exception e) {

				modelMap.put("promisException", "Error");

				return "FetchScreen";
			}

		}

		/*
		 * if (configDedParamsHdr.getLine() == null) {
		 * configDedParamsHdr.setLine(tmpConfigDedParamsHdr.getLine());
		 * configDedParamsHdr.setInstructionType(tmpConfigDedParamsHdr.
		 * getInstructionType()); }
		 */

		modelMap.addAttribute("configDedParamsHdr", configDedParamsHdr);
		modelMap.addAttribute("firstLoad", "N");

		return "FetchScreen";
	}


	@RequestMapping(value = "/searchContrScoringParameterResult", method = { RequestMethod.POST, RequestMethod.GET })
	public String searchContrScoringParameterResult(
			@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr,

			ModelMap modelMap) throws CloneNotSupportedException {

		ConfigDedParamsHdr tmpConfigDedParamsHdr = null;
		if (configDedParamsHdr != null && configDedParamsHdr.getLine() != null) {
			tmpConfigDedParamsHdr = (ConfigDedParamsHdr) configDedParamsHdr;
			try {
				List<ConfigDedParamsHdr> findByAllBySearchCriteria = dedScoringService
						.findByAllBySearchCriteria(configDedParamsHdr);
				if (configDedParamsHdr.getId() == null) {
					modelMap.put("promisException", "No data Found");
				}
				modelMap.addAttribute("configDedParamsHdrList", findByAllBySearchCriteria);
			} catch (Exception e) {

				modelMap.put("promisException", "Error");

				return "FetchScreen";
			}

		}

		if (configDedParamsHdr.getLine() == null) {
			configDedParamsHdr.setLine(tmpConfigDedParamsHdr.getLine());
			configDedParamsHdr.setInstructionType(tmpConfigDedParamsHdr.getInstructionType());
		}

		modelMap.addAttribute("configDedParamsHdr", configDedParamsHdr);
		modelMap.addAttribute("firstLoad", "N");

		return "FetchScreen";
	}

	@RequestMapping("/createContrScoringParameter")
	public String submitContrScoringParameter(
			@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr, ModelMap modelMap)
			throws CloneNotSupportedException {
		if (configDedParamsHdr.getInstructionType() == null) {
			configDedParamsHdr.setInstructionType("0100,0101,0102,0103,0104");
		}
		if (configDedParamsHdr.getLine() != null) {
			String checkIfInstructionTypeExist = this.dedScoringService.checkIfInstructionTypeExist1(configDedParamsHdr,
					configDedParamsHdr.getLine().getLineName());
			if (checkIfInstructionTypeExist != null) {
				modelMap.addAttribute("promisException",
						"Details Already Exists In The selected InstructionType  : " + checkIfInstructionTypeExist);
				modelMap.addAttribute("configDedParamsHdr", configDedParamsHdr);
				return "DED";
			}
		}
		ConfigDedParamsHdr createConfigDedParamsHdr = dedScoringService
				.createOrUpdateConfigDedParamsHdr(configDedParamsHdr);
		String[] split = configDedParamsHdr.getInstructionType().split(",");
		StringBuilder stringBuilder = new StringBuilder();
		Map<String, String> map = new HashMap<>();
		map.put("0100", "DPA CONVENIENCE");
		map.put("0101", "MT RELEASE ONLY");
		map.put("0102", "OFFHIRE DELIVERY");
		map.put("0103", "SALES DELIVERY");
		map.put("0104", "MT OUT EXP IN FOR SCRAP");
		for (String str : split) {
			if (stringBuilder.length() > 0)
				stringBuilder.append(",");
			stringBuilder.append(map.get(str));

		}

		createConfigDedParamsHdr.setInstructionType(stringBuilder.toString());
		if (createConfigDedParamsHdr != null) {
			modelMap.put("success", "Successfull");
		}
		modelMap.addAttribute("configDedParamsHdr", configDedParamsHdr);
		return "SuccessFull";
	}

	@GetMapping("/fetchLineNames")
	@ResponseBody
	public List<String> fetchLineNames(@RequestParam("term") String term) {
		List<String> lineNames = codesService.fetchLineNamesByTerm(term);
		return lineNames; // Corrected the variable name here }
	}

	/*
	 * @GetMapping("/fetchLineNames")
	 * 
	 * @ResponseBody public List<String> fetchLineNames(@RequestParam("term") String
	 * term,
	 * 
	 * @ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr,
	 * ModelMap modelMap) { List<String> lineNames =
	 * codesService.fetchLineNamesByTerm(term); if (configDedParamsHdr != null &&
	 * configDedParamsHdr.getLine() != null &&
	 * configDedParamsHdr.getLine().getLineName() == null) {
	 * modelMap.put("lineException", "No line is found"); }
	 * 
	 * return lineNames; }
	 */

	private boolean checkDuplicateParameterCode(List<ConfigDedParamsDtls> configDedParamsDtlsList) {

		for (ConfigDedParamsDtls configDedParamsDetails : configDedParamsDtlsList) {
			int countParamCode = 0;
			if (configDedParamsDetails.getParameterCode() != null) {
				String parameterCode = configDedParamsDetails.getParameterCode();
				for (ConfigDedParamsDtls configDedParamsDetail : configDedParamsDtlsList) {
					if (parameterCode.equalsIgnoreCase(configDedParamsDetail.getParameterCode())) {
						countParamCode++;
					}
					if (countParamCode >= 2) {
						return true;
					}
				}
			}
		}
		return false;
	}

	private List<ECodes> getParameterCode(List<ConfigDedParamsDtls> configDedParamsDtlList,
			List<ECodes> parametersList) {
		List<ECodes> parametersListNew = new ArrayList<>();
		parametersListNew.addAll(parametersList);
		if (parametersList != null) {
			for (ECodes parameters : parametersList) {
				for (ConfigDedParamsDtls configDedParamsDetail : configDedParamsDtlList) {

					if (configDedParamsDetail.getParameterCode() != null
							&& configDedParamsDetail.getParameterCode().contains(parameters.getShortCode())
							&& configDedParamsDetail.getReadonly()) {
						parametersListNew.remove(parameters);
					}
				}

			}
		}
		return parametersListNew;
	}

	@RequestMapping("/searchAmend")
	public String searchContrScoringParameterAmend(
			@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr, ModelMap modelMap)
			throws CloneNotSupportedException {

		List<ConfigDedParamsDtls> configDedParamsDetails = new ArrayList<>();
		ConfigDedParamsHdr tmpConfigDedParamsHdr = (ConfigDedParamsHdr) configDedParamsHdr;

		for (ECodes code : codesService.findAll()) {
			ConfigDedParamsDtls configDedParamsDtls = new ConfigDedParamsDtls();
			configDedParamsDtls.setParameterValue(code.getNumericVal().longValue());
			configDedParamsDtls.setParameterCode(code.getShortCode());
			configDedParamsDtls.setRemarks(code.getRemarks());
			configDedParamsDtls.setUnitsDescription(code.getLongDescription());

			configDedParamsDetails.add(configDedParamsDtls);
		}

		configDedParamsHdr.setConfigDedParamsDtlsList(configDedParamsDetails);
		modelMap.addAttribute("configDedParamsHdr", configDedParamsHdr);
		return "amend";
	}

	@RequestMapping("/searchScoringParameterAmend")
	public String searchContrScoringParameterAmend(
			@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr, @RequestParam("id") Long id,
			ModelMap modelMap) throws CloneNotSupportedException {
		ConfigDedParamsHdr createConfigDedParamsHdr = dedScoringService.findById(id);
		createConfigDedParamsHdr.setLineIdEnq(configDedParamsHdr.getLineIdEnq());
		createConfigDedParamsHdr.setInstructionTypeEnq(configDedParamsHdr.getInstructionTypeEnq());
		modelMap.addAttribute("configDedParamsHdr", createConfigDedParamsHdr);
		return "amend";
	}

	@RequestMapping("/updateContrScoringParameter")
	public String updateContrScoringParameter(
			@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr, ModelMap modelMap)
			throws CloneNotSupportedException {
		if (configDedParamsHdr.getInstructionType() == null) {
			configDedParamsHdr.setInstructionType("0100,0101,0102,0103,0104");
		}
		if (configDedParamsHdr.getLine() != null) {
			String checkIfInstructionTypeExist = this.dedScoringService.checkIfInstructionTypeExist1(configDedParamsHdr,
					configDedParamsHdr.getLine().getLineName());
			if (checkIfInstructionTypeExist != null) {
				modelMap.addAttribute("promisException",
						"Details Already Exists In The selected InstructionType  : " + checkIfInstructionTypeExist);
				modelMap.addAttribute("configDedParamsHdr", configDedParamsHdr);
				return "DED";
			}
		}
		ConfigDedParamsHdr createConfigDedParamsHdr = dedScoringService.UpdateConfigDedParamsHdr(configDedParamsHdr);
		String[] split = configDedParamsHdr.getInstructionType().split(",");
		StringBuilder stringBuilder = new StringBuilder();
		Map<String, String> map = new HashMap<>();
		map.put("0100", "DPA CONVENIENCE");
		map.put("0101", "MT RELEASE ONLY");
		map.put("0102", "OFFHIRE DELIVERY");
		map.put("0103", "SALES DELIVERY");
		map.put("0104", "MT OUT EXP IN FOR SCRAP");
		for (String str : split) {
			if (stringBuilder.length() > 0)
				stringBuilder.append(",");
			stringBuilder.append(map.get(str));

		}

		createConfigDedParamsHdr.setInstructionType(stringBuilder.toString());
		if (createConfigDedParamsHdr != null) {
			modelMap.put("success", "Successfull");
		}
		modelMap.addAttribute("configDedParamsHdr", configDedParamsHdr);
		return "Update";
	}

	@RequestMapping("/updatesContrScoringParameter")
	public String updatesContrScoringParameter(
			@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr, ModelMap modelMap)
			throws CloneNotSupportedException {

		ConfigDedParamsDtls configDedParamsDtls = new ConfigDedParamsDtls();
		List<ConfigDedParamsDtls> configDedParamsDetails = configDedParamsHdr.getConfigDedParamsDtlsList();
		ConfigDedParamsHdr tmpConfigDedParamsHdr = (ConfigDedParamsHdr) configDedParamsHdr;

		if (configDedParamsHdr.isAddRow()) {
			if (!configDedParamsHdr.getConfigDedParamsDtlsList().isEmpty()) {
				configDedParamsDetails = configDedParamsHdr.getConfigDedParamsDtlsList();
				List<ECodes> parametersList = codesService.findAll();

				List<ECodes> parameterCode = getParameterCode(configDedParamsDetails, parametersList);
				if (configDedParamsDetails.size() == parametersList.size()) {
					modelMap.put("promisException", "No more parameter to be added");
				} else {

					configDedParamsDetails.add(configDedParamsDtls);
					modelMap.put("parameterList", parameterCode);
				}
			}
			configDedParamsHdr.setAddRow(false);
			configDedParamsDtls.setReadonly(false);
		}
		if (configDedParamsHdr.getLine() != null) {
			String checkIfInstructionTypeExist = this.dedScoringService.checkIfInstructionTypeExist1(configDedParamsHdr,
					configDedParamsHdr.getLine().getLineName());
			if (checkIfInstructionTypeExist != null) {
				modelMap.addAttribute("promisException",
						"Details Already Exists In The Selected InstructionType  : " + checkIfInstructionTypeExist);
			}
			modelMap.addAttribute("configDedParamsHdr", configDedParamsHdr);
		}
		return "amend";
	}

	@GetMapping("/readAmend")
	public String screen5(@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr,
			ModelMap modelMap) throws CloneNotSupportedException {
		return "ReadAmend";
	}

	@RequestMapping(value = "/readAmendView", method = { RequestMethod.GET, RequestMethod.POST })
	public String View(@ModelAttribute("configDedParamsHdr") ConfigDedParamsHdr configDedParamsHdr,
			@RequestParam("id") Long id, @RequestParam("lineName") String lineName,
			@RequestParam("instructionType") String instructionType, ModelMap modelMap)
			throws CloneNotSupportedException {
		ConfigDedParamsHdr hdr = dedScoringService.findById(id);
		if (StringUtils.isNotEmpty(lineName)) {
			Line findByLineName = this.dedScoringService.findByLineName(lineName);

			if (findByLineName != null)
				hdr.setLineIdEnq(findByLineName.getLineId());
		}
		hdr.setInstructionTypeEnq(instructionType);
		modelMap.addAttribute("configDedParamsHdr", hdr);
		return "ReadAmend";

	}

}
