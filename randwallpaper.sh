file1=`find ~/images -name '*.*' | sort -R  | head -1`
file2=`find ~/images -name '*.*' -not -name '$file1' | sort -R  | head -1`
DISPLAY=:0 feh --bg-fill $file1 $file2
