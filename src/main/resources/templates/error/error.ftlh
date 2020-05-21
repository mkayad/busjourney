<div class="content">
    <div class="row js-appear-enabled animated fadeIn" data-toggle="appear" style="width: 100%;">
        <div class="col-md-12">
            <h3 class="content-heading text-muted" style="color: firebrick">Error</h3>
            <div class="block">
                <div class="block-content">
                    <p><span style="color: firebrick">An error occurred while processing your request, </br> please check your input! </span></p>
                    <#if message?? >
                        ${message}
                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>
