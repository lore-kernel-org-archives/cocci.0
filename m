From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Sun, 14 Jan 2018 16:58:44 +0530
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <8649d987-c6f2-f36d-3a6f-cfda02557362@users.sourceforge.net>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <68dd2f4a-7921-922c-399d-284d3506415d@users.sourceforge.net>
 <alpine.DEB.2.20.1801141003270.7902@hadrien>
 <2fd51b6d-75d8-ee9a-b52f-beab2299d9b0@users.sourceforge.net>
 <alpine.DEB.2.20.1801141056190.7902@hadrien>
 <0ca5933b-6973-8273-2646-3241157058cf@users.sourceforge.net>
 <alpine.DEB.2.20.1801141126290.7902@hadrien>
 <8649d987-c6f2-f36d-3a6f-cfda02557362@users.sourceforge.net>
Message-ID: <20180114112844.GA2649@himanshu-Vostro-3559>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, Jan 14, 2018 at 11:46:34AM +0100, SF Markus Elfring wrote:
> > Look at the script code just under the comment "For context mode" and just
> > under the comment "For patch mode".  Both of them use m.
> 
> I would like to apologise that I overlooked these places somehow.

Rather than apologising, start looking the SmPL grammar documentation
first. For eg. You asked about the 'initialize' code so take your time
and read what actually initialize does rather than writing about each
and very change. If its not mentioned there then ask Julia, that is what
I do. But first search around the documentation.

> 
> > __ are typically used in sparse annotations.

Now, again look for what __attribute__ means and why is it used ? How is
it benefiticial to sparse for static analysis. Even wikipedia explains
that!

> Is this search pattern worth for a corresponding comment in the Python code?
> 
> 
> How do you think about to pass it to the method ?compile? directly (without the variable ?pattern?)?

Would removing that boost performance ?
pattern variable improves readability and I mean people can easily guess
"Ok he searching for a pattern ..."

Whatever you wish to suggest, don't just email directly! Look for
documentation, explore, test the patch with the -next tree and show the
benchmarks to the relevant people. And finally prepare a patch and send
upstream.

Respect the developers, they also have their job.
Don't ask trivial questions to Julia or any other develper before
searching and exploring. She also has her research and other productive
stuff to do and not just sitting idle replying to each and every email.

Also, don't linger on *trivial* stuffs that improve the comment, add a
tabspace etc.

Lastly, you have a habit of saying:
"How about this ... ?' "How about that ...  ?"
"What if ... ?"

You have all the tools, documentations, source code, and you can explore
it yourself too before asking. That is what we call *opensource* :-)

BONUS:
https://www.kernel.org/doc/html/latest/dev-tools/coccinelle.html
http://coccinelle.lip6.fr/docs/index.html
https://en.wikipedia.org/wiki/Sparse#Annotations


-- 
Thanks
Himanshu Jha
