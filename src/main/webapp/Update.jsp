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


<title>Success Add</title>

<div class="container"
	style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; margin-top: 30px; padding-top: 15px; padding-bottom: 15px; border-radius: 15px;">
	<div>
		<div>
			<div>
				<div class="panel-heading page-header-heading">
					<h2 class="alert alert-success">
						<span class="glyphicon glyphicon-ok" aria-hidden="true"></span><b>
							Container scoring parameter has been updated successfully.</b>
					</h2>
				</div>

				<!-- createContrScoringParameter  -->

				<form:form id="contrScoringParameterForm"
					modelAttribute="configDedParamsHdr"
					action="${createContrScoringParameter}" method="post">
					<div class="row" style="margin-left: 20px; margin-right: 20px;">
						<form:hidden name="configDedParamsHdrId" path="id" />
						<form:hidden path="lineIdEnq" />
								<form:hidden path="instructionTypeEnq" />
								<form:hidden path="line" />
						<div class="gradient-border" style="text-align: left;">
							<h3>
								<b>Line : </b>
								<c:if test="${configDedParamsHdr.line.lineName != null}">
									<span></span>
								</c:if>${configDedParamsHdr.line.lineName}
							</h3>

							<h3>
								<b> Instruction Type : </b>
								<c:if test="${configDedParamsHdr.instructionType != null}">
									<span></span>
								</c:if>${configDedParamsHdr.instructionType}</h3>
						</div>
					</div>

					<br>


					

						<div class="pull-right">
						<form:button type="button"
								style="width:135px;background-color:black;color:white;"
								onclick="back()" class="btn btn-yn">
                             Back
                            </form:button>
                            
					</div>
				</form:form>
			</div>
		</div>
	</div>
</div>

<script>
                         function back(){
                        	 console.log("checlk");
                        	$('#contrScoringParameterForm').attr('action','searchContrScoringParameterBack');
                        			$('#contrScoringParameterForm').submit(); 
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


