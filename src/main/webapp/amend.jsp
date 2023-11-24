<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.13/css/bootstrap-multiselect.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.13/js/bootstrap-multiselect.min.js"></script>

<c:url var="autoCompleteBasic" value="/" />
<c:url var="backUrl" value="/searchContrScoringParameterBack"
	scope="request" />
<c:url var="updateContrScoringParameter"
	value="/updateContrScoringParameter" />
<c:url var="updatesContrScoringParameter"
	value="/updatesContrScoringParameter" scope="request" />
<c:url var="instructionTypeActionAdd"
	value="/contrScoringParameter/checkInstructionTypeForaddContrScoringParameter"
	scope="request" />

<title>DED Container Scoring Parameter</title>

<div class="container"
	style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; margin-top: 30px; padding-top: 15px; padding-bottom: 15px; border-radius: 15px;">
	<div>
		<div>
			<div>


				<div class="panel-heading page-header-heading"
					style="padding-left: 9px;">

					<h3 class="text-danger">
						<button class="btn btn-primary dropdown-toggle" id="menuButton"
							title="Audit" type="button"
							style="width: 40px; height: 32px; margin-top: 5px; padding-left: 8px; margin-left: 4px;">
							<span class="glyphicon glyphicon-book"></span>
						</button>

						<b>Amend DED Container Scoring Parameter Configuration</b>
					</h3>
				</div>


				<c:if test="${not empty promisException}">
					<div id="errorDiv" class="alert alert-danger has-error"
						role="alert">
						<span class="glyphicon glyphicon-exclamation-sign"
							aria-hidden="true"></span> ${promisException}
					</div>
				</c:if>
				<div class="alert alert-danger has-error" id="alertError"
					role="alert" style="display: none;">
					<span class="glyphicon glyphicon-exclamation-sign"
						aria-hidden="true"></span><span id="alertErrorMsg"></span>
				</div>



				<!-- createContrScoringParameter  -->
				<div class="panel-body panel-body-with-border"
					style="padding-top: 4px;">
					<form>
						<input type="hidden" name="configDedParamsHdr.id">
					</form>
					<form:form id="contrScoringParameterForm"
						modelAttribute="configDedParamsHdr"
						action="${updateContrScoringParameter}" method="post">
						<form:hidden path="addRow" id="addRow" />

						<fieldset style="background-color: white !important;">
							<legend> Parameter Details </legend>
							<div class="row">
								<form:hidden name="configDedParamsHdrId" path="id" />
								<form:hidden name="lineIdEnq" path="lineIdEnq" />
								<form:hidden name="instructionTypeEnq" path="instructionTypeEnq" />
								<div class="form-group col-xs-3">
									<label for="lineName" class="control-label small required">Line</label>
									<form:input path="line.lineName"
										class="form-control alphaNumeric" id="lineName"
										readonly="true" />
								</div>

								<!-- <script>
									document
											.addEventListener(
													"DOMContentLoaded",
													function() {
														var lineInput = document
																.getElementById("line");

														lineInput
																.addEventListener(
																		"input",
																		function() {
																			var inputValue = lineInput.value;
																			var sanitizedValue = sanitizeInput(inputValue);
																			lineInput.value = sanitizedValue;
																		});
														function sanitizeInput(
																input) {
															var sanitized = input
																	.replace(
																			/[^a-zA-Z0-9]/g,
																			'');
															return sanitized;
														}
													});
								</script> -->



								<div id="instructionTypeDiv" class="form-group col-xs-3">
									<label for="instructionTypeLb" class="control-label">Instruction
										Type </label> <br>
									<form:select multiple="true" path="instructionType"
										id="instructionType" class="select instructionTypeCol"
										style="font-size:13px;"
										data-content="Instruction type is mandatory">
										<form:option value="0100">DPA CONVENIENCE</form:option>
										<form:option value="0101">MT RELEASE ONLY</form:option>
										<form:option value="0102">OFFHIRE DELIVERY</form:option>
										<form:option value="0103">SALES DELIVERY</form:option>
										<form:option value="0104">MT OUT EXP IN FOR SCRAP</form:option>
									</form:select>
								</div>

								<%-- 	<div id="bufferdaysDiv"
									class="form-group col-xs-3 mandatoryFiled">
									<label for="bufferdaysL" class="control-label"><span
										style="color: red;">*</span> BufferDays</label>

									<form:input type="text" path="bufferDays"
										class="form-control positive-numeric" id="bufferDays"
										style="padding-bottom:0px;" maxlength="5"
										placeholder="Enter Age of the container" readonly="true" />
								</div> --%>

								<div id="bufferdaysDiv"
									class="form-group col-xs-3 mandatoryFiled">
									<label for="bufferdaysL" class="control-label"> Buffer
										Days</label>
									<form:input type="text" path="bufferDays"
										class="form-control positive-numeric" id="bufferDays"
										style="padding-bottom:0px; font-size:13px;" maxlength="5"
										placeholder="Enter Age of the container" readonly="true" />
								</div>

								<script>
									$(document)
											.ready(
													function() {
														$('#bufferDays')
																.on(
																		'input',
																		function() {
																			this.value = this.value
																					.replace(
																							/[^0-9]/g,
																							'');
																			if (this.value < 0) {
																				this.value = '';
																			}
																		});
													});
								</script>


								<div id="excludeDiv" class="form-group col-xs-3">
									<label for="exclude" class="control-label">Exclude </label>

									<form:select path="exclude" id="excludeDropDown"
										style="font-size:13px;" class="form-control"
										data-content="Exclude is mandatory">
										<form:option value="" label="--Please Select--" />
										<form:option value="100">Off-Hire</form:option>
										<form:option value="101">Mt Release</form:option>
										<form:option value="102">Sale</form:option>
									</form:select>
								</div>
							</div>

							<div class="row">
								<div id="remarks" class="form-group col-xs-3 ">
									<label for="remarks" class="control-label">Remarks</label>
									<form:textarea path="remarks" maxlength="100"
										class="form-control" id="remarks" value=""
										style="padding-bottom:0px; font-size:13px;"
										placeholder="Enter Remarks" oninput="validateInput(this)" />
								</div>

								<div id="validFrom" class="form-group col-xs-3 ">
									<label for="validFrom" class="control-label mandatoryFiled"><span
										style="color: red;">* </span>Valid
										From</label> <input type="text" id="validFrom"
										name="validFrom" class="form-control" value="${configDedParamsHdr.validFrom}"
										style="padding-bottom: 0px; font-size: 13px;" >
									
								</div>
								
								<div id="validTo" class="form-group col-xs-3 mandatoryFiled">
									<label for="validTo" class="control-label"><span
										style="color: red;">* </span>Valid
										To</label> <input type="text" id="validTo"
										name="validTo" class="form-control" value="${configDedParamsHdr.validTo}"
										style="padding-bottom: 0px; font-size: 13px;" >
									
								</div>

								<div class="form-group col-sm-3">
									<label for="Active" style="padding-bottom: 2%;"
										class="control-label">Is Active</label>
									<form:checkbox path="valid" value="${configDedParamsHdr.valid}"
										class="form-control"
										cssStyle="width: 15px;height:15px;margin: 0px;" />
								</div>

							</div>
						</fieldset>

						<!-- start of configDedParamsDtls -->

						<fieldset style="background-color: white !important;">

							<legend> Details </legend>
						</fieldset>
						<div>
							<label for="rowsPerPageSelect">Show</label> <select
								id="rowsPerPageSelect">
								<option value="5">5</option>
								<option value="10">10</option>
								<option value="20">20</option>
							</select> <label>entries</label>


						</div>
						<br>
						<div id="configDedParamsDtls">
							<div class="form-group">
								<div class="row col-xs-3">
									<form:button class="btn btn-secondary add"
										style="padding-left:5px;background-color:black;color:white;"
										type="button" id="add">
										<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
								Add
									</form:button>
									<form:button class="btn btn-secondary btnDel-remove"
										type="button" id="removeBulk"
										style="background-color:black;color:white;">
										<span class="glyphicon glyphicon-minus-sign"
											aria-hidden="true"></span>
										Remove
									</form:button>
								</div>

								<br> <br> <br>

								<div class="scrollable-table">
									<table class="table table-striped table-hover"
										id="configDedParamDetailsTable">
										<thead style="background-color: grey; color: white;">
											<tr>
												<th class="text-center"></th>
												<th class="col-xs-2 text-center"><span
													class="mandatory" style="color: red;">*</span> Parameter
													Code</th>
												<th class="col-xs-2 text-center"><span
													class="mandatory" id="description" style="color: red;">*</span>
													Description</th>
												<th class="col-xs-1 text-center" style="text-align: center;"><span
													class="mandatory" id="value" style="color: red;">*</span>
													Value</th>
												<th class="col-xs-5 text-center" style="text-align: center;"><span
													class="mandatory" style="color: red;">*</span> Remarks</th>
												<th class="text-center">IsActive</th>
											</tr>
										</thead>
										<tbody>

											<div class="control-group" id="fields">
												<c:forEach
													items="${configDedParamsHdr.configDedParamsDtlsList}"
													var="ItemsList" varStatus="counter">
													<c:set var="bgColor" scope="request" value="" />
													<c:if test="${ItemsList.readonly}">
														<c:set var="bgColor" scope="request" value="#cccccc" />
													</c:if>
													<tr id=row${counter.count-1}
														style="height: 10px\9;  ${detail.deleteFlag ? 'display:none' : ''}"
														class="${detail.duplicate ? 'dupErrorRow': ''} ">
														<td><form:checkbox
																style="pointer-events: ${ItemsList.readonly}; background-color: ${bgColor}"
																path="configDedParamsDtlsList[${counter.count-1}].deleteFlag"
																id="delFlagId_${counter.count-1}" value="false"
																class="delFlag" disabled="${ItemsList.readonly}" /> <c:if
																test="${ItemsList.duplicate}">
																<br />
															</c:if></td>
														<td><c:choose>
																<c:when test="${ItemsList.readonly}">
																	<div id="parameterCodeDiv${counter.count-1}"
																		class="mandatoryFiled parameterCodeFromDB required">
																		<form:input
																			style=" pointer-events: ${ItemsList.readonly}; background-color: ${bgColor} font-size:13px;"
																			path="configDedParamsDtlsList[${counter.count-1}].parameterCode"
																			id="parameterCode_${counter.count-1}"
																			class="form-control parameterCode"
																			data-content="ParameterCode is mandatory"
																			readonly="${ItemsList.readonly}" />
																	</div>
																</c:when>
																<c:otherwise>
																	<div id="parameterCodeDiv${counter.count-1}"
																		class="mandatoryFiled required">
																		<form:input
																			style=" pointer-events: ${ItemsList.readonly}; background-color: ${bgColor} font-size:13px;"
																			path="configDedParamsDtlsList[${counter.count-1}].parameterCode"
																			id="parameterCode_${counter.count-1}"
																			class="form-control parameterCode"
																			data-content="ParameterCode is mandatory" />
																	</div>
																</c:otherwise>
															</c:choose></td>
														<td>
															<div id="unitsDescriptionDiv${counter.count-1}"
																class=" mandatoryFiled required">
																<form:input
																	path="configDedParamsDtlsList[${counter.count-1}].unitsDescription"
																	id="unitsDescription_${counter.count-1}"
																	style="font-size:13px;"
																	class="form-control unitsDescription description"
																	maxlength="50"
																	data-content="unitsDescription is mandatory" />

															</div>
														</td>
														<td>
															<div id="parameterValueDiv${counter.count-1}"
																class="mandatoryFiled required ">
																<form:input
																	path="configDedParamsDtlsList[${counter.count-1}].parameterValue"
																	id="parameterValue_${counter.count-1}"
																	style="font-size:13px;"
																	class="form-control numeric parameterValue"
																	maxlength="5"
																	data-content="ParameterValue is mandatory" />

															</div> <script>
																$(document)
																		.ready(
																				function() {
																					$(
																							'#parameterValue_${counter.count-1}')
																							.on(
																									'input',
																									function() {
																										this.value = this.value
																												.replace(
																														/[^\d-]/g,
																														'');

																										if (this.value
																												.match(/^[-]\d*/)) {
																											this.value = this.value
																													.match(/^[-]\d{0,5}/)[0];
																										} else {
																											this.value = this.value
																													.match(/^\d{0,5}/)[0];
																										}
																									});
																				});
															</script>
														</td>
														<td>
															<div id="remarksDiv${counter.count-1}"
																class="mandatoryFiled required">
																<form:textarea
																	path="configDedParamsDtlsList[${counter.count-1}].remarks"
																	id="remarks_${counter.count-1}" style="font-size:13px;"
																	class="form-control remarks"
																	data-content="Remarks is mandatory" maxlength="100"
																	oninput="validateInput(this)" />
															</div> <!-- <script>
																function validateInput(
																		textarea) {
																	// Get the current value of the textarea
																	let inputValue = textarea.value;

																	// Use a regular expression to match only alphanumeric characters
																	let alphanumericRegex = /^[a-zA-Z0-9]+$/;

																	if (!alphanumericRegex
																			.test(inputValue)) {
																		// If the input doesn't match the regex, remove the invalid characters
																		textarea.value = inputValue
																				.replace(
																						/[^a-zA-Z0-9]/g,
																						'');
																	}
																}
															</script> -->

														</td>

														<td class="text-center"><form:checkbox
																path="configDedParamsDtlsList[${counter.count-1}].valid"
																id="valid_${counter.count-1}" value="false"
																class="isActive" /></td>

														<form:hidden id="id${counter.count-1}"
															path="configDedParamsDtlsList[${counter.count-1}].id" />
														<form:hidden id="duplicate${counter.count-1}"
															path="configDedParamsDtlsList[${counter.count-1}].duplicate" />
														<form:hidden id="readonly_${counter.count-1}"
															path="configDedParamsDtlsList[${counter.count-1}].readonly" />

													</tr>
												</c:forEach>

											</div>
										</tbody>
									</table>
								</div>
								<ul class="pagination" style="margin-left: 950px;">
									<li><a href="#" id="prev"
										style="background-color: black; color: white;">Previous</a></li>
									<li><a href="#" id="next"
										style="background-color: black; color: white;">Next</a></li>
								</ul>
							</div>

						</div>
						<!-- end of boxconfigDedParamsDtls -->


						<br>
						<div class="pull-right">
							<form:button type="button"
								style="width:135px;background-color:black;color:white;"
								class="btn btn-secondary" id="saveDedParams">
								Save
							</form:button>
							<form:button type="button"
								style="width:135px;background-color:black;color:white;"
								onclick="back()" class="btn btn-yn">
                             Back
                            </form:button>

							<script type="text/javascript">
								function back() {
									console.log("checlk");
									$('#contrScoringParameterForm').attr(
											'action', '${backUrl}');
									$('#contrScoringParameterForm').submit();
								}
							</script>

							<script>
								$(document)
										.ready(
												function() {
													// Initially, check if the error div is present and disable the button accordingly
													if ($("#errorDiv").length > 0) {
														$("#saveDedParams")
																.prop(
																		"disabled",
																		true);
														console.log("DISABLED");
													}

													// Add an event listener to enable/disable the button when the error div changes
													// This assumes that the error div is being added/removed dynamically
													$("#errorDiv")
															.bind(
																	'DOMNodeInserted DOMNodeRemoved',
																	function(
																			event) {
																		if ($("#errorDiv").length > 0) {
																			$(
																					"#saveDedParams")
																					.prop(
																							"disabled",
																							true);
																		} else {
																			$(
																					"#saveDedParams")
																					.prop(
																							"disabled",
																							false);
																		}
																	});
												});
							</script>


						</div>

					</form:form>
				</div>
			</div>
		</div>
	</div>
	<div id="confirmPopup" class="modal fade" tabindex="-1" role="dialog"
		data-keyboard="false" data-backdrop="static"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header gradient" style="height: 50px;">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 id="formTitleConfirmBox" class="modal-title">
						<b>Confirmation</b>
					</h4>
				</div>
				<div class="modal-body" style="background-color: white;">
					Do you want to submit the configuration ?<br /> <span
						style="font-size: 12px; color: red;"></span>
				</div>
				<div class="modal-footer">
					<div class="row pull-right">
						<button type="button" onclick="updateStatusAndSubmitForm('N')"
							class="btn btn-yn"
							style="width: 80px; background-color: black; color: white;"
							data-dismiss="modal">Yes</button>
						<!-- 	&nbsp;&nbsp; for the extra space -->
						<button type="button" onclick="updateStatusAndSubmitForm('W')"
							class="btn btn-yn"
							style="width: 80px; background-color: black; color: white; padding-bottom: 08px; margin-right: 20px"
							data-dismiss="modal">No</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- modal for terminal message -->
	<div id="dpmessageAdd" class="modal fade" role="dialog"
		data-keyboard="false" data-backdrop="static" aria-hidden="true">
		<div class="modal-dialog" style="width: 200pxpx;">
			<div class="modal-content">
				<div class="modal-header gradient" style="height: 50px;">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 id="formTitleConfirmBox" class="modal-title">
						<b>Add</b>
					</h4>
				</div>
				<div id="formContent" class="modal-body"
					style="background-color: white;">
					<h4 style="margin-left: 20px;">No more parameter to be added</h4>
				</div>

				<div class="modal-footer">
					<div class="row pull-right">
						<button type="button" class="btn btn-yn"
							style="width: 80px; background-color: black; color: white; margin-right: 20px"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="dpmessage" class="modal fade" role="dialog"
		data-keyboard="false" data-backdrop="static" aria-hidden="true">
		<div class="modal-dialog" style="width: 200pxpx;">
			<div class="modal-content">
				<div class="modal-header gradient" style="height: 50px;">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 id="formTitleConfirmBox" class="modal-title">
						<b>Remove</b>
					</h4>
				</div>
				<div id="formContent" class="modal-body"
					style="background-color: white;">
					<h4 style="margin-left: 20px;">No row selected</h4>
				</div>

				<div class="modal-footer">
					<div class="row pull-right">
						<button type="button" class="btn btn-yn"
							style="width: 80px; background-color: black; color: white; margin-right: 20px"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="backBtnConfirmPopup" class="modal fade" tabindex="-1"
		role="dialog" data-keyboard="false" data-backdrop="static"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header gradient" style="height: 50px;">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 id="formTitleConfirmBox" class="modal-title">Alert</h4>
				</div>
				<div id="formContent" class="modal-body popUp-model"
					style="background-color: white;"></div>
				<div class="modal-footer">
					<div class="row pull-right">
						<button type="button" id="backBtnConfirm" class="btn btn-yn"
							data-dismiss="modal">Yes</button>
						&nbsp;&nbsp;
						<button type="button" id="backBtnClose" class="btn btn-yn"
							data-dismiss="modal">No</button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div id="backBtnConfirmPopup" class="modal fade" tabindex="-1"
		role="dialog" data-keyboard="false" data-backdrop="static"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header gradient" style="height: 50px;">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 id="formTitleConfirmBox" class="modal-title">Alert</h4>
				</div>
				<div id="formContent" class="modal-body"
					style="background-color: white;">Data has been lost</div>
				<div class="modal-footer">
					<div class="row pull-right">
						<button type="button" id="backBtnConfirm" class="btn btn-yn"
							data-dismiss="modal">Yes</button>
						&nbsp;&nbsp;
						<button type="button" id="backBtnClose" class="btn btn-yn"
							data-dismiss="modal">No</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
	$(document)
			.ready(
					function() {
						$("#line")
								.on(
										"input",
										function() {
											var input = $(this).val();
											if (input.length >= 1) { // Adjust the minimum length as needed
												$
														.ajax({
															type : "GET",
															url : "/fetchLineNames",
															data : {
																"term" : input
															},
															success : function(
																	data) {
																var suggestions = $("#suggestions ul");
																suggestions
																		.empty();
																data
																		.forEach(function(
																				lineName) {
																			suggestions
																					.append("<li role='presentation'><a role='menuitem' tabindex='-1' href='#'>"
																							+ lineName
																							+ "</a></li>");
																		});
																$(
																		"#suggestions")
																		.css(
																				"display",
																				"block");
															}
														});
											} else {
												$("#suggestions").css(
														"display", "none");
											}
										});

						// Handle click on suggestions
						$("#suggestions").on("click", "li", function() {
							var selectedLineName = $(this).text();
							$("#line").val(selectedLineName);
							$("#suggestions").css("display", "none");
						});
					});
</script>



<script type="text/javascript">
	/* 	$('#add').click(
	 function() {

	 var id = $(this).attr('id');
	 console.log(id);
	 $('.delFlag').each(function() {
	 if ($(this).parent().is(":hidden") == false) {
	 $(this).prop('checked', false);
	 }

	 });
	 $('#addRow').val(true);

	 $("#contrScoringParameterForm").attr("action",
	 '${updatesContrScoringParameter}');
	 $("#contrScoringParameterForm").submit();
	 }); */

	$('#removeBulk').click(function() {
		var counter = 0;
		$('.delFlag').each(function() {
			console.log("Working")
			if ($(this).prop('checked') == true) {
				$(this).remove();
				if ($(this).parent().is(":hidden") == false) {
					counter++;
				}
				var id = $(this).attr('id').split('_');
				$('#row' + id[1]).hide();
				$('#parameterCode_' + id[1]).val("");
				$('#bufferDays').val("");
			}

		});
		if (counter == 0) {
			$('#dpmessage').modal('show');
			$("#formContent").html('No row selected.');
		}
		checkIsActive();
		$('.mandatoryFiled').toggleClass('has-error', false);
		$('.mandatoryFiled').toggleClass('has-duplicate', false);
	});

	$('#add').click(function() {
		var counter = 0;
		$('.delFlag').each(function() {
			console.log("Workingsss")
			if ($(this).prop('checked') == true) {
				$(this).remove();
				if ($(this).parent().is(":hidden") == false) {
					counter++;
				}
				var id = $(this).attr('id').split('_');
				$('#row' + id[1]).hide();
				$('#parameterCode_' + id[1]).val("");
				$('#bufferDays').val("");
			}

		});

		if (counter == 0) {
			$('#dpmessageAdd').modal('show');
			$("#formContent").html('No more parameter to be added.');
		}
		checkIsActive();
		$('.mandatoryFiled').toggleClass('has-error', false);
		$('.mandatoryFiled').toggleClass('has-duplicate', false);
	});

	showInstructionTypeValue();
	function showInstructionTypeValue() {
		var instructionType = "${configDedParamsHdr.instructionType}";
		var instructionTypeArr = instructionType.split(",");
		for (var i = 0; i < instructionTypeArr.length; i++) {
			$("#instructionType option[value='" + instructionTypeArr[i] + "']")
					.attr("selected", "selected");
		}
	}
	$('.instructionTypeCol')
			.multiselect(
					{
						includeSelectAllOption : true,
						nonSelectedText : '--Please Select--',
						allSelectedText : "DPA CONVENIENCE,OFFHIRE DELIVERY,MT RELEASE ONLY,SALE DELIVERY,MT OUT EXP IN FOR SCRAP",
						numberDisplayed : 4,
						templates : {
							button : '<button id="multiSelectCheckboxId"  type="button" class="multiselect dropdown-toggle" data-toggle="dropdown" style="text-align: start; padding-left:20px; padding-bottom:10px; width:260px; overflow:auto;"><span class="multiselect-selected-text"  style="font-size: 12px;"></span> <b class="caret" style="margin-top:5px;margin-right:3px; float:right !important;"></b></button>',
							ul : '<ul class="multiselect-container dropdown-menu uppercase" style="margin-left:37px;margin-top:2px;width:255px;font-size: 09px; "></ul>',
							filter : '<li class="multiselect-item filter"><div class="input-group"><span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span><input class="form-control multiselect-search" type="text"></div></li>',
							filterClearBtn : '<span class="input-group-btn"><button class="btn btn-default multiselect-clear-filter" type="button"><i class="glyphicon glyphicon-remove-circle"></i></button></span>',
							li : '<li><a tabindex="0"><label class="checkbox11"></label></a></li>',
							divider : '<li class="multiselect-item divider"></li>',
							liGroup : '<li class="multiselect-item multiselect-group"><label></label></li>'
						},
						buttonText : function(options, select) {
							if (this.disabledText.length > 0
									&& (this.disableIfEmpty || select
											.prop('disabled'))
									&& options.length == 0) {

								return this.disabledText;
							} else if (options.length === 0) {
							} else if (this.allSelectedText
									&& options.length === $('option', $(select)).length
									&& $('option', $(select)).length !== 1
									&& this.multiple) {

								if (this.selectAllNumber) {
									return this.allSelectedText + ' ('
											+ options.length + ')';
								} else {
									return this.allSelectedText;
								}
							} else {
								var selected = '';
								options
										.each(function() {
											var label = ($(this).attr('label') !== undefined) ? $(
													this).attr('label')
													: $(this).text();
											selected = label.concat(",",
													selected);
										});

								return selected.slice(",", -1);
							}
						}
					});

	$('.checkbox11').parent().find('input[type="checkbox"]').addClass(
			'checkbox12');

	$('.checkbox12').change(
			function() {
				console.log("hbchchbcbrhnjb");
				if ($('#line').val() != "") {
					$("#contrScoringParameterForm").attr("action",
							'${updatesContrScoringParameter}');
					$("#contrScoringParameterForm").submit();
				}
			});
	$('.parameterCode').change(function() {
		var id = $(this).attr('id').split("_");
		console.log(id[1]);
		var paramval = $('#parameteralspan_' + id[1]).html();
		console.log($('#parameteralspan_' + id[1]).html());
		$('#parameterValue_' + id[1]).val(paramval);
		var remarks = $('#remarksSpan_' + id[1]).html();
		$('#remarks_' + id[1]).val(remarks);

	});

	$(document)
			.ready(
					function() {
						checkIsActive();

						function populatedata(code) {
							console.log(code);
							var jsonobject = {
								codes : code
							};
							console.log(code);
						}

						function parameterCodes() {
							var parameterCodeArray = [];
							$(".parameterCode").each(function() {
								parameterCodeArray.push($(this).val().trim());
							});
							return parameterCodeArray;
						}
						function checkIsActive() {
							var count = 0;
							var visibility = false;
							$(".isActive")
									.each(
											function() {
												var id = $(this).attr('id')
														.split('_');
												var readOnly = JSON.parse($(
														'#readonly_' + id[1])
														.val());
												if ($(this).prop('checked') == true) {
													$(
															'#parameterValue_'
																	+ id[1])
															.attr('readonly',
																	false);
													$('#remarks_' + id[1])
															.attr('readonly',
																	false);
													$(
															'#unitsDescription_'
																	+ id[1])
															.attr('readonly',
																	false);
													if ($(
															'#parameterCode_'
																	+ id[1])
															.val().trim() == 'VACAT_STACK') {
														setVisibility(visibility);
														count++;
														if (!readOnly)
															setVisibilityOfDTLS(
																	visibility,
																	id);
													} else {
														if (!readOnly)
															setVisibilityOfDTLS(
																	visibility,
																	id);
													}
												} else {
													$(
															'#unitsDescription_'
																	+ id[1])
															.attr('readonly',
																	false);
													var paramterValue = $(
															'#parameterValue_'
																	+ id[1])
															.val();
													var parameterCode = $(
															'#parameterCode_'
																	+ id[1])
															.val();
													var remarksOfDTLS = $(
															'#remarks_' + id[1])
															.val();
													var unitDescription = $(
															'#unitsDescription_'
																	+ id[1])
															.val();
													if (paramterValue != ""
															&& $(
																	'#readonly_'
																			+ id[1])
																	.val() == 'true'
															&& remarksOfDTLS != ""
															&& unitDescription != "") {
														$(
																'#parameterValue_'
																		+ id[1])
																.attr(
																		'readonly',
																		true);
														$('#remarks_' + id[1])
																.attr(
																		'readonly',
																		true);
														$(
																'#unitsDescription_'
																		+ id[1])
																.attr(
																		'readonly',
																		true);
													} else {
														if (checkDuplicateParameterCode(parameterCodes())
																&& paramterValue != ""
																&& parameterCode != ""
																&& remarksOfDTLS != ""
																&& unitDescription != "") {
															setVisibilityOfDTLS(
																	!visibility,
																	id);
														} else {
															$(
																	'#parameterValue_'
																			+ id[1])
																	.parent()
																	.toggleClass(
																			'has-error',
																			paramterValue == "");
															$(
																	'#unitsDescription_'
																			+ id[1])
																	.parent()
																	.toggleClass(
																			'has-error',
																			unitDescription == "");
															$(
																	'#parameterCode_'
																			+ id[1])
																	.parent()
																	.toggleClass(
																			'has-error',
																			parameterCode == "");
															$(
																	'#remarks_'
																			+ id[1])
																	.parent()
																	.toggleClass(
																			'has-error',
																			remarksOfDTLS == "");
															$('#valid_' + id[1])
																	.prop(
																			'checked',
																			true);
															if ($(
																	'#parameterCode_'
																			+ id[1])
																	.val()
																	.trim() == 'VACAT_STACK') {
																setVisibility(visibility);
																count++;
															}
														}
													}
												}
											});
							if (count == 0) {
								visibility = true;
								setVisibility(visibility);
								$('#bufferDays').parent().toggleClass(
										'has-error', false);
							}
						}
						function setVisibilityOfDTLS(readonly, id) {
							$('#parameterValue_' + id[1]).attr('readonly',
									readonly);
							if (readonly) {
								$('#parameterCode_' + id[1])
										.attr('style',
												'pointer-events: none;background-color: #cccccc5c;');
							} else {
								$('#parameterCode_' + id[1])
										.attr('style',
												'pointer-events: auto;background-color: white');
							}
							$('#remarks_' + id[1]).attr('readonly', readonly);
							$('#unitsDescription_' + id[1]).attr();
						}
						function setVisibility(readOnly) {
							$('#bufferDays').attr('readonly', readOnly);
							$('#bufferDays').toggleClass('bufferReadonly',
									!readOnly);
							$('#bufferDays').parent().toggleClass('required',
									!readOnly);

						}
						$(".isActive").change(function() {
							checkIsActive();
						});

						$(".parameterValue").keypress(function() {
							var paramterval = parseInt($(this).val());
							if (paramterval < 0) {
								$(this).attr('maxlength', "6");
							} else {
								$(this).attr('maxlength', "5");

							}
						});
						$(".parameterCode").change(function() {
							checkIsActive();
							var id = $(this).attr('id').split('_');
							var data = $(this).val();
							setDefaultDescription(data, id);
						});
						function setDefaultDescription(data, id) {
							if (data == 'VACAT_STACK') {
								$('#unitsDescription_' + id[1])
										.val(
												'${ParameterCodesList.get("VACAT_STACK")}');
							} else if (data == 'CONTR_INSP_STATUS') {
								$('#unitsDescription_' + id[1])
										.val(
												'${ParameterCodesList.get("CONTR_INSP_STATUS")}');
							} else if (data == 'CONTR_AGE') {
								$('#unitsDescription_' + id[1])
										.val(
												'${ParameterCodesList.get("CONTR_AGE")}');
							} else if (data == 'DED_YARD_OPTMZ') {
								$('#unitsDescription_' + id[1])
										.val(
												'${ParameterCodesList.get("DED_YARD_OPTMZ")}');
							} else if (data == 'VALID_CONTR') {
								$('#unitsDescription_' + id[1])
										.val(
												'${ParameterCodesList.get("VALID_CONTR")}');
							} else if (data == 'STRIP_YARD_CONTR') {
								$('#unitsDescription_' + id[1])
										.val(
												'${ParameterCodesList.get("STRIP_YARD_CONTR")}');
							} else if (data == 'STACK_POSITION') {
								$('#unitsDescription_' + id[1])
										.val(
												'${ParameterCodesList.get("STACK_POSITION")}');
							} else if (data == 'EQUIP_AVAILABLE') {
								$('#unitsDescription_' + id[1])
										.val(
												'${ParameterCodesList.get("EQUIP_AVAILABLE")}');
							} else if (data == 'MECRC_CONTR') {
								$('#unitsDescription_' + id[1])
										.val(
												'${ParameterCodesList.get("MECRC_CONTR")}');
							} else if (data == 'DISABLE_LOC') {
								$('#unitsDescription_' + id[1])
										.val(
												'${ParameterCodesList.get("DISABLE_LOC")}');
							} else if (data == "") {
								$('#unitsDescription_' + id[1]).val("");
							} else {
								$('#unitsDescription_' + id[1]).val("");
							}
						}
						function checkDuplicateParameterCode(parameterCodeArr) {
							var count = 0;
							for (var i = 0; i < parameterCodeArr.length - 1; i++) {
								for (var j = i + 1; j < parameterCodeArr.length; j++) {
									if (parameterCodeArr[i] == parameterCodeArr[j]
											&& parameterCodeArr[i] != ""
											&& parameterCodeArr[j] != "") {
										$('#parameterCode_' + j).parent()
												.toggleClass('has-duplicate',
														true);
										count++;
									}
								}
							}
							if (count > 0) {
								console.log("data is duplicate ");
								return false;
							}
							return true;
						}

						$('.checkbox12')
								.change(
										function() {
											if ($('#line').val() != "") {
												$("#contrScoringParameterForm")
														.attr("action",
																'${updatesContrScoringParameter}');
												$("#contrScoringParameterForm")
														.submit();
											}
										});
						$('.tt-dropdown-menu').click(
								function() {
									$('#addRow').val(false);
									$("#contrScoringParameterForm").attr(
											"action",
											'${updatesContrScoringParameter}');
									$("#contrScoringParameterForm").submit();
								});

						$('#backBtnContr').click(function() {
							$('#confirmBackPopup').show();
						});

						$('#searchDedParams').click(
								function() {
									var id = $(this).attr('id');
									$("#contrScoringParameterForm").attr(
											"action",
											'${updatesContrScoringParameter}');
									$("#contrScoringParameterForm").submit();
								});

						$(".mandatoryFiled").popover({
							placement : 'top',
							container : 'body',
							html : true,
							trigger : 'hover',
							container : 'body',
							content : function() {
								var current_id = $(this).attr('id');
								if ($(this).is('.has-error')) {
									return 'This field is mandatory.';
								} else if ($(this).is('.has-duplicate')) {
									return 'Duplicate ParameterCode.';
								}
							}
						});

						$(".mandatoryFiled").on('click', function() {
							$(this).toggleClass('has-error', false);
							$(this).toggleClass('has-duplicate', false);
							$(this).popover('hide');
						});

						$('#saveDedParams')
								.click(
										function() {
											var contrScoringParameterForm = $('#contrScoringParameterForm');
											var parameterCodeArr = [];
											$('.mandatoryFiled').toggleClass(
													'has-error', false);
											$('.mandatoryFiled').toggleClass(
													'has-duplicate', false);

											if ($('#line').val() === "") {
												$('#line').parent()
														.toggleClass(
																'has-error',
																true);
											} else {
												$('#line').parent()
														.toggleClass(
																'has-error',
																false);
											}

											if ($('.bufferReadonly').parent()
													.is(":hidden") == false) {
												var missing = $(
														'.bufferReadonly')
														.val() == "";
												$('.bufferReadonly').parent()
														.toggleClass(
																'has-error',
																missing);
											} else {
												$('.bufferReadonly').parent()
														.toggleClass(
																'has-error',
																false);
											}

											contrScoringParameterForm
													.find(".parameterValue")
													.each(
															function() {
																if ($(this)
																		.parent()
																		.is(
																				":hidden") == false) {
																	var missing = ($(
																			this)
																			.val() === "");
																	console
																			.log(
																					"missing in if",
																					missing);
																	$(this)
																			.parent()
																			.toggleClass(
																					'has-error',
																					missing);

																} else {
																}
															});
											contrScoringParameterForm
													.find(".description")
													.each(
															function() {
																if ($(this)
																		.parent()
																		.is(
																				":hidden") == false) {
																	var missing = ($(
																			this)
																			.val() === "");
																	console
																			.log(
																					"missing in if",
																					missing);
																	$(this)
																			.parent()
																			.toggleClass(
																					'has-error',
																					missing);

																} else {
																}
															});

											contrScoringParameterForm
													.find(".remarks")
													.each(
															function() {
																if ($(this)
																		.parent()
																		.is(
																				":hidden") == false) {
																	var missing = $(
																			this)
																			.val() === "";
																	$(this)
																			.parent()
																			.toggleClass(
																					'has-error',
																					missing);
																} else {
																}
															});
											contrScoringParameterForm
													.find(".parameterCode")
													.each(
															function() {
																parameterCodeArr
																		.push($(
																				this)
																				.val()
																				.trim());
																if ($(this)
																		.parent()
																		.is(
																				":hidden") == false) {
																	var missing = $(
																			this)
																			.val() === "";
																	$(this)
																			.parent()
																			.toggleClass(
																					'has-error',
																					missing);
																} else {
																}
															});
											checkDuplicateParameterCode(parameterCodeArr);
											if (contrScoringParameterForm
													.find(".has-error").length == 0
													&& checkDuplicateParameterCode(parameterCodeArr)) {
												if ($("#configDedParamDetailsTable> tbody > tr:visible").length == 0) {
													$('#alertErrorMsg')
															.text(
																	"Configuration must contain atleast one details associated with it, bottom table should contain atleast one row with details.");
													$('#alertError').show();
													return false;
												} else {
													$('#confirmPopup').modal(
															'show');
												}
											} else {
												return false;
											}
										});

					});

	function backBtnClick() {
		$('#backBtnConfirmPopup').modal('show');
	}

	$('#backBtnConfirm').click(function() {
		$('#backBtnConfirmPopup').modal('hide');
		var backUrl = "${backUrl}";
		$("#contrScoringParameterForm").attr("action", backUrl);
		$("#contrScoringParameterForm").submit();
	});
	$('#backBtnClose').click(function() {
		$('#backBtnConfirmPopup').modal('hide');
	});
	function updateStatusAndSubmitForm(status) {
		if (status == 'N') {
			$('#confirmPopup').modal('hide');

			$('.delFlag').each(function() {
				if ($(this).parent().is(":hidden") == false) {
					$(this).prop('checked', false);
				}

			});

			$("#contrScoringParameterForm").submit();
			/* window.location.href='success' */
		} else {
		}
	}

	function backStatusAndSubmitForm(status) {
		if (status == 'N') {
			$('#confirmBackPopup').modal('hide');

			$('.delFlag').each(function() {
				if ($(this).parent().is(":hidden") == false) {
					$(this).prop('checked', false);
				}

			});

			$("#contrScoringParameterForm").attr("action", '${backUrl}');
		} else {
		}
	}

	if (window.history.replaceState) {
		window.history.replaceState(null, null, window.location.href);
	}
</script>

<script>
	function redirectToDED() {
		window.location.href = 'searchScoringParameter';
	}
</script>

<script>
	function searchTable() {
		var input, filter, table, tr, td, i, j, txtValue;
		input = document.getElementById("searchInput");
		filter = input.value.toUpperCase();
		table = document.getElementById("configDedParamDetailsTable");
		tr = table.getElementsByTagName("tr");

		for (i = 0; i < tr.length; i++) {
			// Exclude the header row (assuming it's the first row).
			if (i === 0) {
				continue;
			}

			td = tr[i].getElementsByTagName("td");
			var rowVisible = false;

			for (j = 0; j < td.length; j++) {
				txtValue = td[j].textContent || td[j].innerText;

				if (txtValue.toUpperCase().indexOf(filter) > -1) {
					rowVisible = true;
					break;
				}
			}

			if (rowVisible) {
				tr[i].style.display = "";
			} else {
				tr[i].style.display = "none";
			}
		}
	}

	/* document.getElementById("searchInput").addEventListener("input",
			searchTable); */
</script>

<script>
	// Constants
	var table = document.getElementById('configDedParamDetailsTable');
	var rowsPerPageSelect = document.getElementById('rowsPerPageSelect');
	var currentPage = 0; // Current page index (0-based)
	var prevButton = document.getElementById('prev');
	var nextButton = document.getElementById('next');

	// Function to display the table rows for the current page
	function displayRows() {
		var rows = table.rows;
		var rowsPerPage = parseInt(rowsPerPageSelect.value);
		var totalPages = Math.ceil((rows.length - 1) / rowsPerPage);

		for (var i = 1; i < rows.length; i++) {
			rows[i].style.display = (i >= (currentPage * rowsPerPage + 1) && i <= (currentPage + 1)
					* rowsPerPage) ? '' : 'none';
		}

		// Disable or enable Previous and Next buttons as needed
		prevButton.classList.toggle('disabled', currentPage === 0);
		nextButton.classList.toggle('disabled', currentPage >= totalPages - 1);
	}

	// Event handler for row selection dropdown
	rowsPerPageSelect.addEventListener('change', function() {
		currentPage = 0;
		displayRows();
	});

	// Event handler for Previous button
	prevButton.addEventListener('click', function(e) {
		e.preventDefault(); // Prevent the link from navigating
		if (currentPage > 0) {
			currentPage--;
			displayRows();
		}
	});

	// Event handler for Next button
	nextButton.addEventListener('click', function(e) {
		e.preventDefault(); // Prevent the link from navigating
		var rowsPerPage = parseInt(rowsPerPageSelect.value);
		var totalPages = Math.ceil((table.rows.length - 1) / rowsPerPage);
		if (currentPage < totalPages - 1) {
			currentPage++;
			displayRows();
		}
	});

	// Initial display
	displayRows();
</script>

<style type="text/css">
table.table.table-striped>tbody>tr.dupErrorRow {
	background-color: #da0000;
}

.tt-dropdown-menu {
	margin-top: 0px;
}

.panel-body {
	padding: 0px;
}

.pagination li a.disabled {
	cursor: not-allowed;
}

.has-valid-RangeFrom .form-control {
	background-image: url(../images/invalid_line.gif) !important;
	background-attachment: scroll;
	background-position: 50% 100%;
	background-repeat: repeat-x;
	border-color: #a94442;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
}

.has-duplicate .form-control {
	background-image: url(../images/invalid_line.gif) !important;
	background-attachment: scroll;
	background-position: 50% 100%;
	background-repeat: repeat-x;
	border-color: #a94442;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
}

.has-rangeFrom .form-control {
	background-image: url(../images/invalid_line.gif) !important;
	background-attachment: scroll;
	background-position: 50% 100%;
	background-repeat: repeat-x;
	border-color: #a94442;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
}

.has-rangeTo .form-control {
	background-image: url(../images/invalid_line.gif) !important;
	background-attachment: scroll;
	background-position: 50% 100%;
	background-repeat: repeat-x;
	border-color: #a94442;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
}

.has-rangeEqual .form-control {
	background-image: url(../images/invalid_line.gif) !important;
	background-attachment: scroll;
	background-position: 50% 100%;
	background-repeat: repeat-x;
	border-color: #a94442;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
}

.has-valid-containerPrefix .form-control {
	background-image: url(../images/invalid_line.gif) !important;
	background-attachment: scroll;
	background-position: 50% 100%;
	background-repeat: repeat-x;
	border-color: #a94442;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
}

.switch, .dow, td.day.old, td.day {
	display: table-cell !important;
}

.required label:before {
	color: #e32;
	content: '*';
	display: inline;
}

.required.control-label:before {
	content: "*";
	color: red;
}
</style>
<style>
.scrollable-table {
	max-height: 400px;
	/* Set the desired maximum height for the scrollable area */
	overflow-y: scroll;
}

/* Make the table header sticky */
#configDedParamDetailsTable thead {
	position: -webkit-sticky; /* For Safari */
	position: sticky;
	top: 0;
	background-color: grey;
	color: white;
}
</style>
