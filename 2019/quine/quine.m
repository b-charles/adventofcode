function q=quine()
  w='q=sprintf(p,c,w,c,c,c,c,c,c,p,c,w);';c='''';p='function q=quine()\n  w=%s%s%s;c=%s%s%s%s;p=%s%s%s;%s\n';q=sprintf(p,c,w,c,c,c,c,c,c,p,c,w);
end

