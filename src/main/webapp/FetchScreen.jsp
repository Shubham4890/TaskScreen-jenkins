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
<c:url var="backUrl"
	value="/contrScoringParameter/searchContrScoringParameter"
	scope="request" />
<c:url var="createContrScoringParameter"
	value="/contrScoringParameter/createContrScoringParameter" />
<c:url var="addContrScoringParameter"
	value="/contrScoringParameter/addContrScoringParameter" scope="request" />
<c:url var="instructionTypeActionAdd"
	value="/contrScoringParameter/checkInstructionTypeForAddContrScoringParameter"
	scope="request" />

<title>DED Container Scoring Parameter</title>

<div class="container"
	style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; margin-top: 30px; padding-top: 15px; padding-bottom: 15px; border-radius: 15px;">
	<div>
		<div>
			<div>
				<div class="panel-heading page-header-heading">

					<h2 class="text-danger">
						<b>DED Container Scoring Parameter</b>
					<b>Testing</b>
						
					</h2>
					<div class="text-right" style="margin-top: 30px;">
						<button id="searchButton" class="btn" type="button"
							onclick="redirectToDED()"
							style="color: white; margin-left: 1000px; background-color: black">Add</button>
					</div>
				</div>

				<!-- createContrScoringParameter  -->
				<div class="panel-body panel-body-with-border"
					style="padding-top: 4px;">
					<form:form id="contrScoringParameterEnqForm"
						modelAttribute="configDedParamsHdr"
						action="searchContrScoringParameterResult" method="post">
						<fieldset style="background-color: white !important;">
							<legend> Search By </legend>
							<div class="row">

								<div id="lineName"
									class="form-group col-xs-3 mandatoryFiled required ${requestScope['org.springframework.validation.BindingResult.configDedParamsHdr'].hasFieldErrors('line') ? 'has-error' : ''}">
									<label for="lineId" class="control-label"><span
										style="color: red;">*</span> Line</label>
									<form:input type="text" path="line.lineName"
										class="form-control positive-numeric" id="line"
										value="${configDedParamsHdr.line.lineName}"
										style="padding-bottom:0px;"
										placeholder="Enter Line of the container" readonly="false" />
									<div id="suggestions" class="dropdown"
										style="position: absolute; display: none;">
										<ul class="dropdown-menu" role="menu"
											aria-labelledby="dropdownMenu"
											style="display: block; width: 260px;">
										</ul>
									</div>
								</div>


								<script>
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
								</script>



								<div id="instructionTypeDiv" class="form-group col-xs-3">
									<label for="instructionTypeLb" class="control-label">InstructionType
									</label> <br>
									<form:select multiple="true" path="instructionType"
										id="instructionType" class="select instructionTypeCol"
										data-content="Instruction type is mandatory">
										<form:option value="0100">DPA CONVENIENCE</form:option>
										<form:option value="0101">MT RELEASE ONLY</form:option>
										<form:option value="0102">OFF-HIRE DELIVERY</form:option>
										<form:option value="0103">SALES DELIVERY</form:option>
										<form:option value="0104">MT OUT EXP IN FOR SCRAP</form:option>
									</form:select>
								</div>
							</div>
						</fieldset>
						<br>

						<div class="pull-right" id="SearchButton">
							<form:button
								style="width:135px;background-color:black;color:white;"
								class="btn btn-secondary" id="search">
									Search
								</form:button>
							<a style="width: 135px; background-color: black; color: white;"
								class="btn btn-secondary" href="fetch"> Reset </a>

						</div>
					</form:form>
				</div>
				<div class="row" id="tableDiv"
					style="padding-top: 5px; /* width: 61%; */ margin-left: 0px; margin-right: 0px;">
					<c:if test="${firstLoad == 'N'}">
						<div class="row" style="padding-top: 5px; padding-left: 20px;">
							<fieldset>
								<legend> Details </legend>
								<div class="col-lg-12">

									<div >
										<label for="rowsPerPageSelect">Show</label> <select
											id="rowsPerPageSelect">
											<option value="5">5</option>
											<option value="10">10</option>
											<option value="20">20</option>
										</select> <label>entries</label> <input id="searchInput"
											oninput="searchTable()" placeholder="Search"
											style="width: 200px; margin-left: 750px;">


									</div>

									<br>
									<div class="scrollable-table">

										<table id="configDedParamDetailsTable"
											class="table table-striped table-responsive table-hover">
											<thead style="background-color: grey; color: white;">
												<tr>
													<th class="col-xs-2 "><span class="mandatory"></span>
														Line</th>
													<th class="col-xs-2 " style="width: 450px;">Instruction
														Type</th>

													<th class="text-center">IsActive</th>
													<th class="text-center" style="width: 50px;">Action</th>
												</tr>
											</thead>
											<tbody>

												<c:choose>
													<c:when test="${empty configDedParamsHdrList}">
														<tr>
															<td colspan="5" class="text-center">No data
																available</td>
														</tr>
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>

												<c:forEach items="${configDedParamsHdrList}" var="ItemsList"
													varStatus="counter">
													<tr>
														<td>${ItemsList.line.lineName}</td>
														<td>${ItemsList.instructionTypeDtls}</td>
														<c:choose>
															<c:when test="${ItemsList.valid}">
																<td class="text-center" style="margin-left: 250px;">Yes</td>
															</c:when>
															<c:otherwise>
																<td class="text-center">No</td>
															</c:otherwise>
														</c:choose>

														<td><a id="searchButton"
															href="/readAmendView?id=${ItemsList.id}&lineName=${configDedParamsHdr.line.lineName}&instructionType=${configDedParamsHdr.instructionType}"
															class="btn" type="button"
															style="color: white; background-color: black">Details</a>
														</td>
													</tr>
													<tr>
													</tr>
												</c:forEach>
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
							</fieldset>
						</div>
					</c:if>
				</div>

			</div>
		</div>
	</div>
</div>


<script>
$(document).ready(function() {
    var $searchButton = $('#search');
    var listSize = "${configDedParamsHdr.id}";
    if (listSize == '' || listSize.trim() =='') {
        $('#amendBtn').hide();
    } else {
        $('#amendBtn').show();
    }

    $('#amendBtn').click(function(){
        var id='${configDedParamsHdr.id}';
        $('#contrScoringParameterEnqForm').attr('action',"searchScoringParameterAmend?id="+id);
        $('#contrScoringParameterEnqForm').submit();
    });
    
    $('#line').on("input", function() {
        if (window.location.href.includes("searchContrScoringParameterBack")) 
            window.location.href = "http://localhost:8080/fetch"; 
             $("#configDedParamDetailsTable").hide();
              $("#configDedParamDetailsTable tbody").empty();
            var input = $(this).val();
            if (input.length >= 1) {
                $.ajax({
                    type: "GET",
                    url: "/fetchLineNames",
                    data: {
                        "term": input
                    },
                    success: function(data) {
                        var suggestions = $("#suggestions ul");
                        suggestions.empty();

                        if (data.length === 0) {
                            $('#line').parent().toggleClass('has-duplicate',true);
                            $("#suggestions").css("display", "none");
                        } else {
                            data.forEach(function(lineName) {
                                suggestions.append("<li role='presentation'><a role='menuitem' tabindex='-1' href='#'>" + lineName + "</a></li>");
                            });
                            $("#suggestions").css("display", "block");
                        }
                    }
                });
            } else {
                // If input length is less than 1, hide the suggestion list
                $("#suggestions").css("display", "none");
            }
        });

   /*  $('#line').on("input", function() {
        var input = $(this).val();
        if (input.length >= 1) {
            $.ajax({
                type: "GET",
                url: "/fetchLineNames",
                data: {
                    "term": input
                },
                success: function(data) {
                    var suggestions = $("#suggestions ul");
                    suggestions.empty();

                    if (data.length === 0) {
                        $('#line').parent().toggleClass('has-duplicate',true);
                        $("#suggestions").css("display", "none");
                    } else {
                        data.forEach(function(lineName) {
                            suggestions.append("<li role='presentation'><a role='menuitem' tabindex='-1' href='#'>" + lineName + "</a></li>");
                        });
                        $("#suggestions").css("display", "block");
                    }
                }
            });
        } else {
            // If input length is less than 1, hide the suggestion list
            $("#suggestions").css("display", "none");
        }
    });
 */
    $("#suggestions").on("click", "li", function() {
        var selectedLineName = $(this).text();
        $("#line").val(selectedLineName);
        $("#suggestions").css("display", "none");
    });
});
</script>

<script type="text/javascript">
$('#search')
.click(
		function() {
			var contrScoringParameterForm = $('#contrScoringParameterEnqForm');
			var parameterCodeArr = [];
			$('.mandatoryFiled').toggleClass(
					'has-error', false);
			

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

			
		
			
			if (contrScoringParameterForm
					.find(".has-error").length == 0 && contrScoringParameterForm
					.find(".has-duplicate").length == 0
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
</script>


<script type="text/javascript">
	var UnselectAll;
	var rows = [];
	var deleteAgentRefNo;
	var pushAgentRefNo;
	var table;
	var tableLength;
	var currentViewId = "${currentId}";
	var listSize = "${configDedParamsHdr.id}";
	$('.validChecked').prop('checked',${configDedParamsHdr.valid});
	if (currentViewId.trim() == '' || listSize.trim() =='') {
		$('.menuButton').hide();
	}
	else {
		$('.menuButton').show();
		}
	showInstructionTypeValue();
    function showInstructionTypeValue(){
	           var instructionType="${configDedParamsHdr.instructionType}";
	           var instructionTypeArr=instructionType.split(",");
	           for(var i=0;i<instructionTypeArr.length;i++){
	    	   $("#instructionType option[value='"+instructionTypeArr[i]+"']").attr("selected","selected");
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
					button : '<button id="multiSelectCheckboxId" onmouseover="checkMultiSelectError()" type="button" class="multiselect dropdown-toggle" data-toggle="dropdown" style="text-align: start; padding-left:20px; padding-bottom:10px;  width:260px;overflow:auto; height: fit-content;"><span class="multiselect-selected-text"  style="font-size: 12.5px;"></span> <b class="caret" style="margin-top:8px;margin-right:3px; float:right !important;"></b></button>',
					ul : '<ul class="multiselect-container dropdown-menu uppercase" style="margin-left:37px;margin-top:2px;width:255px;font-size: 12px; "></ul>',
					filter : '<li class="multiselect-item filter"><div class="input-group"><span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span><input class="form-control multiselect-search" type="text"></div></li>',
					filterClearBtn : '<span class="input-group-btn"><button class="btn btn-default multiselect-clear-filter" type="button"><i class="glyphicon glyphicon-remove-circle"></i></button></span>',
					li : '<li><a tabindex="0" onclick="checkMultiSelectError()"><label></label></a></li>',
					divider : '<li class="multiselect-item divider"></li>',
					liGroup : '<li class="multiselect-item multiselect-group"><label></label></li>'
				},
				 buttonText: function(options, select) {
		            if (this.disabledText.length > 0 &&
		                (this.disableIfEmpty || select.prop('disabled')) &&
		                options.length == 0) {

		                return this.disabledText;
		            } else if (options.length === 0) {
		                return this.nonSelectedText;
		            } else if (this.allSelectedText &&
		                options.length === $('option', $(select)).length &&
		                $('option', $(select)).length !== 1 &&
		                this.multiple) {

		                if (this.selectAllNumber) {
		                    return this.allSelectedText + ' (' + options.length + ')';
		                } else {
		                    return this.allSelectedText;
		                }
		            }  else {
		            	var selected = '';
		                options.each(function() {
		                    var label = ($(this).attr('label') !== undefined) ? $(this).attr('label') : $(this).text();
		                    selected = label.concat(",",selected);
		                });
		                
		                return selected.slice(",",-1);
		            }
		        } 
			});
    $('.checkbox11').parent().find('input[type="checkbox"]').addClass('checkbox12');
	$(document)
			.ready(
					function() {
						$('.checkbox12').change(function(){
							if (listSize.trim() !='') {
							$("#contrScoringParameterEnqForm").attr("action",'${resetURL}');
							$("#contrScoringParameterEnqForm").submit();
							}
							});	
						$('.dropdown-menu').click(
								function() {
									if (listSize.trim() !='') {
									$('#addRow').val(false);
									$("#contrScoringParameterEnqForm").attr("action",'${resetURL}');
									$("#contrScoringParameterEnqForm").submit();
									}
								});
						$(".mandatoryFiled").popover({
							placement : 'top',
							container : 'body',
							html : true,
							trigger : 'hover',
							container : 'body',
							content : function() {
								if ($(this).is('.has-error')) {
									return 'This field is mandatory.';
								}else if ($(this).is('.has-duplicate')) {
									return 'enter valid line';
								}
							}
						});

						$(".mandatoryFiled").on('click', function() {
							$(this).toggleClass('has-error', false);
							$(this).toggleClass('has-duplicate', false);
							$(this).popover('hide');
						});			
					});
	function amendContrScoringParameterClick() {
		var visitDetailUrl = '${amendUrl}' + '?amendId=' + currentViewId;
		$("#contrScoringParameterEnqForm").attr("action", visitDetailUrl);
		$("#contrScoringParameterEnqForm").submit();
	}
</script>
<script>
function redirectToDED() {
    window.location.href = 'searchScoringParameter';
}
</script>
<script>
function redirectToamend() {
    window.location.href = 'searchAmend';
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

    document.getElementById("searchInput").addEventListener("input", searchTable);
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
            rows[i].style.display = (i >= (currentPage * rowsPerPage + 1) && i <= (currentPage + 1) * rowsPerPage) ? '' : 'none';
        }

        // Disable or enable Previous and Next buttons as needed
        prevButton.classList.toggle('disabled', currentPage === 0);
        nextButton.classList.toggle('disabled', currentPage >= totalPages - 1);
    }

 // Event handler for row selection dropdown
 rowsPerPageSelect.addEventListener('change', function () {
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
    $(document).ready(function() {
        var $tableContainer = $('#tableDiv');
        var tableHidden = true;

        $('#instructionType').on('change', function() {
            var instructionType = $('#instructionType').val();
            if (instructionType !== '') {
                $tableContainer.hide();
                tableHidden = true;
            }
        });
        
         $('#line').on('input', function() {
            var line = $(this).val();
            if (line !== '') {
                $tableContainer.hide();
                tableHidden = true;
            }
            console.log('Line value:', line);
        });
 

        
        $('#search').on('click', function() {
            if (tableHidden) {
                $tableContainer.show();
                tableHidden = false;
            }
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

.required.control-label:before {
	content: "*";
	color: red;
}
</style>
<style>
.scrollable-table {
	max-height: 400px;
	overflow-y: scroll;
}

#configDedParamDetailsTable thead {
	position: -webkit-sticky; /* For Safari */
	position: sticky;
	top: 0;
	background-color: grey;
	color: white;
}
</style>