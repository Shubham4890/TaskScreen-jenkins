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
						<button class="btn btn-primary dropdown-toggle" id="amendBtn"
							title="Audit" type="button"
							style="width: 40px; height: 32px; margin-top: 5px; padding-left: 8px; margin-left: 4px;">
							<span class="glyphicon glyphicon-book"></span>
						</button>

						<b> DED Container Scoring Parameter Details Configuration</b>
					</h3>
				</div>

				<!-- createContrScoringParameter  -->
				<div class="panel-body panel-body-with-border"
					style="padding-top: 4px;">
					<form>
						<input type="hidden" name="configDedParamsHdr.id">
					</form>
					<form:form id="contrScoringParameterForm"
						modelAttribute="configDedParamsHdr"
						action="${updateContrScoringParameter}" method="get">
						<form:hidden path="addRow" id="addRow" />
						<form:hidden path="lineIdEnq" />
						<form:hidden path="instructionTypeEnq" />
						<fieldset style="background-color: white !important;">
							<legend> Parameter Details </legend>
							<div class="row">
								<form:hidden name="configDedParamsHdrId" path="id" />
								<div class="form-group col-xs-3">
									<label for="lineName" class="control-label small required">Line</label>
									<form:input path="line.lineName"
										class="form-control alphaNumeric" id="lineName"
										disabled="true" />
								</div>

								<div id="instructionTypeDiv" class="form-group col-xs-3">
									<label for="instructionTypeLb" class="control-label">Instruction
										Type </label> <br>
									<form:input path="instructionTypeDtls"
										class="form-control alphaNumeric" id="instructionTypeDtls"
										disabled="true" />

								</div>


								<div id="bufferdaysDiv"
									class="form-group col-xs-3 mandatoryFiled">
									<label for="bufferdaysL" class="control-label"> Buffer
										Days</label>
									<form:input type="text" path="bufferDays"
										class="form-control positive-numeric" id="bufferDays"
										style="padding-bottom:0px; font-size:13px;" maxlength="5"
										placeholder="Enter Age of the container" disabled="true" />
								</div>



								<div id="excludeDiv" class="form-group col-xs-3">
									<label for="exclude" class="control-label">Exclude </label>

									<form:input path="excludeDtls"
										value="${configDedParamsHdr.excludeDtls}"
										class="form-control alphaNumeric" id="exclude" disabled="true" />

								</div>
							</div>

							<div class="row">
								<div id="remarks" class="form-group col-xs-3 ">
									<label for="remarks" class="control-label">Remarks</label>
									<form:textarea path="remarks" maxlength="100"
										class="form-control" id="remarks" value=""
										style="padding-bottom:0px; font-size:13px;"
										placeholder="Enter Remarks" disabled="true" />
								</div>


								<div id="validFrom" class="form-group col-xs-3 ">
									<label for="validFrom" class="control-label"><span
										style="color: red;">* </span>Valid
										From</label> <input type="text" id="validFrom"
										name="validFrom" class="form-control" value="${configDedParamsHdr.validFrom}"
										style="padding-bottom: 0px; font-size: 13px;" disabled >
									
								</div>
								
								<div id="validTo" class="form-group col-xs-3 ">
									<label for="validTo" class="control-label"><span
										style="color: red;">* </span>Valid
										To</label> <input type="text" id="validTo"
										name="validTo" class="form-control" value="${configDedParamsHdr.validTo}"
										style="padding-bottom: 0px; font-size: 13px;" disabled>
									
								</div>

								<div class="form-group col-sm-3">
									<label for="Active" style="padding-bottom: 2%;"
										class="control-label">Is Active</label>
									<form:checkbox path="valid" value="${configDedParamsHdr.valid}"
										class="form-control"
										cssStyle="width: 15px;height:15px;margin: 0px;"
										disabled="true" />
								</div>

							</div>
						</fieldset>

						<!-- start of configDedParamsDtls -->

						<div class="pull-right">
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

						</div>

						<br>
						<br>
						<br>
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
										type="button" id="add" disabled="true">
										<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
								Add
									</form:button>
									<form:button class="btn btn-secondary btnDel-remove"
										type="button" id="removeBulk" disabled="true"
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
																	data-content="unitsDescription is mandatory"
																	disabled="true" />

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
																	data-content="ParameterValue is mandatory"
																	disabled="true" />

															</div>
														</td>
														<td>
															<div id="remarksDiv${counter.count-1}"
																class="mandatoryFiled required">
																<form:textarea
																	path="configDedParamsDtlsList[${counter.count-1}].remarks"
																	id="remarks_${counter.count-1}" style="font-size:13px;"
																	class="form-control remarks"
																	data-content="Remarks is mandatory" maxlength="100"
																	oninput="validateInput(this)" disabled="true" />
															</div>

														</td>

														<td class="text-center"><form:checkbox
																path="configDedParamsDtlsList[${counter.count-1}].valid"
																id="valid_${counter.count-1}" value="false"
																class="isActive" disabled="true" /></td>

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


					</form:form>
				</div>
			</div>
		</div>
	</div>
	<script>
		function goToPickupVendor() {
			// Assuming pickupvendor.html is the target screen
			window.location.href = 'fetch';
		}
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
			nextButton.classList.toggle('disabled',
					currentPage >= totalPages - 1);
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


	<script>
		$(document).ready(
				function() {
					var $searchButton = $('#search');
					var listSize = "${configDedParamsHdr.id}";
					if (listSize == '' || listSize.trim() == '') {
						$('#amendBtn').show;
					}/*  else {
										$('#amendBtn').show();
									} */

					$('#amendBtn')
							.click(
									function() {
										var id = '${configDedParamsHdr.id}';
										$('#contrScoringParameterForm').attr(
												'action',
												"searchScoringParameterAmend?id="
														+ id);
										$('#contrScoringParameterForm')
												.submit();
									});
				});
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