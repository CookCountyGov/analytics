
[cmdletbinding()]
Param
(
    [Parameter(Mandatory=$true)]
    [ValidateSet("dev","staging","production","deploy_staging","deploy_production")] 
    [string] $functionName
)


function dev {
    "Serving the Jekyll Dev environment..."
    bundle exec jekyll serve --watch --config=_config.yml,_development.yml
}

function staging {
    "Building the staging site."
    bundle exec jekyll build --config=_config.yml,_staging.yml
}

function production {
    "Building the production site."
    bundle exec jekyll build
}

function deploy_staging {
    staging

    #make staging && cf push analytics-staging
}
function deploy_production {
    production
    #make production && cf push analytics
}
	
Invoke-Command -ScriptBlock { invoke-expression  $functionName}