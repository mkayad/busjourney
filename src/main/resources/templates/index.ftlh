<!DOCTYPE html>
<html>
<head>
    <!-- CSS only -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

    <!-- JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
            integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
            integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
            crossorigin="anonymous"></script>
    <title>Great Portland Street Station - Live update</title>
</head>
<body>
<div class="container">
    <!-- Content here -->
    <div class="col-md-12">
        <h2 class="content-heading">Buses Expected at Great Portland Street Station</h2>
        <div class="row">
            <div class="col-md-6">
                <h3>Stop G</h3>
                <table class="display table table-responsive-sm table-striped" id="tableData" border="1" cellpadding="0"
                       cellspacing="0"
                       style="width:100%">
                    <thead class="thead-dark">
                    <tr>
                        <th>Line Name</th>
                        <th>Destination</th>
                        <#--<th>Platform</th>-->
                        <th>Time</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#assign timeToStation = 0>
                    <#list gStopTimes as arrivalTime>
                        <tr>
                            <#assign timeToStation = arrivalTime.timeToStation/60>
                            <td>${arrivalTime.lineName}</td>
                            <td>${arrivalTime.destinationName}</td>
                            <#--<td>${arrivalTime.platformName}</td>-->
                            <#if timeToStation?round lt 1>
                                <td>due</td>
                            <#else>
                                <td>${timeToStation?round} mins</td>
                            </#if>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
            <div class="col-md-6">
                <h3>Stop H</h3>
                <table class="display table table-responsive-sm table-striped" id="tableData" border="1" cellpadding="0"
                       cellspacing="0"
                       style="width:100%">
                    <thead class="thead-dark">
                    <tr>
                        <th>Line Name</th>
                        <th>Destination</th>
                        <#--<th>Platform</th>-->
                        <th>Time</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#assign timeToStation = 0>
                    <#list hStopTimes as arrivalTime>
                        <tr>
                            <#assign timeToStation = arrivalTime.timeToStation/60>
                            <td>${arrivalTime.lineName}</td>
                            <td>${arrivalTime.destinationName}</td>
                            <#--<td>${arrivalTime.platformName}</td>-->
                            <#if timeToStation?round lt 1>
                                <td>due</td>
                            <#else>
                                <td>${timeToStation?round} mins</td>
                            </#if>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    setInterval(function(){location.reload();}, 3000)



</script>
</body>
</html>
