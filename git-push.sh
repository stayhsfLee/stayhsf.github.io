git config user.email "eric.xiangfu.lee@gmail.com"
git config user.name "tinkericlee"
git add *
if [ -z "$1" ]; then
    git commit -m "[automatic-push] pushed time: $(date)"
else
    git commit -m "$(echo "[automatic-push] $@")"
fi
git push

