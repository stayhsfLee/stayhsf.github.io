git config  user.email "yutian.lxf@gmail.com"
git config  user.name "stayhsfLee"
rm -rf docs
hexo generate
git add *
if [ -z "$1" ]; then
    git commit -m "[automatic-push] pushed time: $(date)"
else
    git commit -m "$(echo "[automatic-push] $@")"
fi

