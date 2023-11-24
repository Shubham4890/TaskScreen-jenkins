<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.13/css/bootstrap-multiselect.css">
<title>Success Add</title>

<div class="container"
	style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; margin-top: 30px; padding-top: 15px; padding-bottom: 15px; border-radius: 15px;">
	<div>
		<div>
			<div>
				<div class="panel-heading page-header-heading">
					<h2 class="alert alert-success">
						<span class="glyphicon glyphicon-ok" aria-hidden="true"></span><b>
							Container scoring parameter has been submitted successfully.</b>
					</h2>
				</div>

				<!-- createContrScoringParameter  -->

				<form:form id="contrScoringParameterForm"
					modelAttribute="configDedParamsHdr"
					action="${createContrScoringParameter}" method="post">
					<div class="row" style="margin-left: 20px; margin-right: 20px;">
						<form:hidden name="configDedParamsHdrId" path="id" />
						<div class="gradient-border" style="text-align: left;">

							<h3>
								<b>Line :</b>
								<c:if test="${configDedParamsHdr.line.lineName != null}">
									<span></span>
								</c:if>${configDedParamsHdr.line.lineName}
							</h3>

							<h3>
								<b>Instruction type : </b>
								<c:if test="${configDedParamsHdr.instructionType != null}">
									<span></span>
								</c:if>${configDedParamsHdr.instructionType}
							</h3>


						</div>
					</div>
					<div class="pull-right">
						<form:button type="button"
							style="width:100px;background-color:black;color:white;"
							onclick="window.location.href = '/fetch';" class="btn btn-yn">
            Back
        </form:button>
					</div>
				</form:form>
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
	$('#add').click(
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
						'${addContrScoringParameter}');
				$("#contrScoringParameterForm").submit();
			});

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

	showInstructionTypeValue();
	function showInstructionTypeValue() {
		var instructionType = "${configDedParamsHdr.instructionType}";
		var instructionTypeArr = instructionType.split(",");
		for (var i = 0; i < instructionTypeArr.length; i++) {
			//   $("#instructionType option[value='"+instructionTypeArr[i]+"']").attr("selected","selected");
		}
	}

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
													if (paramterValue != ""
															&& $(
																	'#readonly_'
																			+ id[1])
																	.val() == 'true'
															&& remarksOfDTLS != "") {
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
													} else {
														if (checkDuplicateParameterCode(parameterCodes())
																&& paramterValue != ""
																&& parameterCode != ""
																&& remarksOfDTLS != "") {
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

						$('.checkbox12').change(
								function() {
									if ($('#line').val() != "") {
										$("#contrScoringParameterForm").attr(
												"action",
												'${addContrScoringParameter}');
										$("#contrScoringParameterForm")
												.submit();
									}
								});
						$('.tt-dropdown-menu').click(
								function() {
									$('#addRow').val(false);
									$("#contrScoringParameterForm").attr(
											"action",
											'${addContrScoringParameter}');
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
											'${addContrScoringParameter}');
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

.required.control-label:before {
	content: "*";
	color: red;
}

.gradient-border {
	position: relative;
	padding: 20px;
}

.gradient-border::before {
	content: '';
	position: absolute;
	top: 0;
	right: -10;
	bottom: 0;
	left: -100;
	z-index: -1;
	margin-left: 100px;
	background: linear-gradient(to right, #f1f8e9, #fffde7);
	border-radius: inherit;
}
</style>


