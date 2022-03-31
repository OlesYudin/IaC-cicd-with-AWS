locals {
    # Github credentials that stored in Parameter Store
    github_credential = ""
    # Owner of github account
    github_owner = "OlesYudin"
    # Default github url repository
    github_url = "https://github.com/OlesYudin/final_demo"
    # Default path to buildspec.yml
    buildspec = "terraform/env/prod/buildspec.yml"
    # Default branch where will aplly some commit 
    github_source_brance = "main"
    # Default branch for commiting
    github_branch = "^refs/heads/main$"
    # Default if someone pull request to main
    github_pattern = "PUSH"
    # Default path where will be do changes
    github_trigger_path = "app/"
}   