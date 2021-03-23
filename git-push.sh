git config user.email "eric.xiangfu.lee@gmail.com"
git config user.name "tinkericlee"
BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
if [ $BRANCH_NAME != 'source' ]; then
    echo 'Failed: please change your branch to source branch'
    exit -1
fi
git add *
if [ -z "$1" ]; then
    git commit -m "[automatic-push] pushed time: $(date)"
else
    git commit -m "$(echo "[automatic-push] $@")"
fi
git push --set-upstream origin source