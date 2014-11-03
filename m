From: derek@knosof.co.uk (Derek M Jones)
Date: Mon, 03 Nov 2014 17:05:11 +0000
Subject: [Cocci] s390/net: Deletion of unnecessary checks before two
 function calls
In-Reply-To: <20141103162528.GT6890@mwanda>
References: <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <5453C98C.90105@users.sourceforge.net>
 <20141103095059.GL6879@mwanda> <5457A560.2020304@users.sourceforge.net>
 <20141103162528.GT6890@mwanda>
Message-ID: <5457B5C7.7020406@knosof.co.uk>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dan

> The truth is I think that all these patches are bad and they make the
> code harder to read.

I disagree, I think the code requires less effort to read without the
if test.

A developer reading the code will wonder why kfree does not handle the
case when its argument is NULL.  This takes effort.

Now there might be a reason while kfree (or any other function) does
not handle NULL, in which case the test is necessary for that reason.
Or perhaps calling kfree has other consequences and this means it is
good to minimise the number of calls, fair enough.

> The if statements are there for *human* readers to understand and you are
> making it harder for humans to understand the code.

The reverse is true.

But if there are other reasons, then leave the test in.

-- 
Derek M. Jones                  tel: +44 (0) 1252 520 667
Knowledge Software Ltd          blog:shape-of-code.coding-guidelines.com
Software analysis               http://www.knosof.co.uk
