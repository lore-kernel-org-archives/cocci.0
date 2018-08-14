From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Tue, 14 Aug 2018 03:29:31 +0000
Subject: [Cocci] 2 basic question
Message-ID: <20180814032931.GA28344@osadl.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hi !

 Trying to do some verification of the coccinelle tool
 it self and one of the tasks was to estimate false
 negatives (so reliability not accuracy). To be able
 to do that the first task was to determin if a semantic
 patch specification would actually be looking at all
 instances. The following trivial cocci spec was used:

<snip>
virtual report

@found@
position p;
@@

   kmalloc at p(...)

@script:python depends on report@
p << found.p;
@@
msg = "kmalloc called" 
coccilib.report.print_report(p[0],msg)
<snip>

With this I run coccicheck on 4.18-rc8 (linux-stable)

  make coccicheck COCCI=kmalloc1.cocci | tee kmalloc.log

which gives me a line count of (wc -l kmalloc.log after
removing the header) 4722 instances

But cscope reports 4746 kmalloc cases - so I??m wondering
if coccinelle is actually checking all cases or where
this difference would come from ?
Is the assumption that the above specification sould actually
report every usage of kmalloc correct ?

The second issue is that to simplify completness verification
I wanted to add simple counters like so:


<snip>
virtual report
@initialize:python@
@@
import sys

count=0

def show():
   print("Total %d" % count)

@found@
position p;
@@

   kmalloc at p(...)

@script:python depends on report@
p << found.p;
@@

count = count + 1
msg = "kmalloc called" 
coccilib.report.print_report(p[0],msg)

@finalize:python depends on report@
@@
show()
<snip>
this works when run with spach version (spatch --version):
spatch version 1.0.1 with Python support and with PCRE support

And will give me the same as wc -l 
Total 4722

but not with a current git version (spatch --version):
 spatch version 1.0.7-00500-g97695d0 compiled with OCaml version 4.01.0
 Flags passed to the configure script: [none]
 OCaml scripting support: yes
 Python scripting support: yes
 Syntax of regular expresssions: PCRE

where Total 0 is reported

did the python interface change and my usage is obsolete
or is this a regression ?

thx!
hofrat
