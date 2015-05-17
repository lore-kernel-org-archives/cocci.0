From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Sun, 17 May 2015 08:18:03 +0200
Subject: [Cocci] Fatal error: exception Failure("not supported")
Message-ID: <20150517061803.GA32427@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hi !

 Writing some simple checks for user-space sample code to check that a 
 read loop has some error checking in it - the read loop should look 
 something like this:

        do {
                len = read(fd, buff + off, BUFFSIZE);
                if (len < 0 && len != -EAGAIN) {
                        perror("read failed");
                        exit(-1);
                }
                off += len;
        } while (len > 0);

to check this the following cocci spatch was intended 

<snip>
virtual report
virtual org

@check_open@
identifier f,retval;
idexpression int fd;
idexpression int l;
idexpression int o;
idexpression char * b;
position p;
@@

f(...) {
<+...
 do {
 ...
 l = read@p(fd,b+o,...);
 if (l < 0 && l != -EAGAIN) {
? perror(...);
(
  exit(...);
|
  return ...;
)
}
 l = l + o;                                                                                               
} while ( l > 0);
return retval;
...+>
}


@script: python@
p<<check_open.p;
fn<<check_open.f;
@@
print "OK: read loop in %s:%s line %s checking errors" % (p[0].file,fn, p[0].line)
<snip>

 spatch --parse-cocci gives no errors and the output looks fine (just the iso
 expansions basically) - but when run with:
  spatch --sp-file check_read_loop.cocci open_read_ok.c
 its giving me:
  init_defs_builtins: /usr/local/share/coccinelle/standard.h
  Fatal error: exception Failure("not supported")

how can I figure out what is "not supported" here ?

thx!
hofrat
