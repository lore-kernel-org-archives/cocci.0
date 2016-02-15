From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Mon, 15 Feb 2016 17:54:01 +0000
Subject: [Cocci] --no-loops
Message-ID: <20160215175401.GA24839@osadl.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hi !

 --no-loops is documented as:
<snip>
       --no-loops
              drop all back edges derived from looping constructs - unsafe
<snip>

 the background is that some scanners will simply not make any
 progress (e.g. linux-next/lib/rbtree.c:__rb_insert() is a perfect 
 "hang" without --no-loops for even simple scanners

 what exactly does unsafe here mean ? 

thx!
hofrat
