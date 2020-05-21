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
        <h2 class="content-heading">Buses Expected at Great Portland Street Station -  Bus Stop G and H </h2>
        <div class="block">
            <div class="block-content">
                <table class="display table table-responsive-sm able-striped" id="tableData" border="0" cellpadding="0"
                       cellspacing="0"
                       style="width:100%">
                    <thead class="thead-dark">
                    <tr>
                        <th>Line Name</th>
                        <th>Destination</th>
                        <th>Platform</th>
                        <th>Due</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#assign arrivalTime = 0>
                    <#list times as time>
                        <tr>
                            <#assign arrivalTime = time.timeToStation/60>
                            <td>${time.lineName}</td>
                            <td>${time.destinationName}</td>
                            <td>${time.platformName}</td>
                            <#if arrivalTime?round lt 1>
                                <td>due</td>
                            <#else>
                                <td>${arrivalTime?round} mins</td>
                            </#if>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


</body>
</html>
