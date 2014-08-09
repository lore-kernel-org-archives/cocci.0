From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 09 Aug 2014 11:13:58 +0200
Subject: [Cocci] [patch 119/197] scripts/coccinelle/free: Delete NULL
 test before freeing functions?
In-Reply-To: <alpine.DEB.2.02.1408091028520.2016@localhost6.localdomain6>
References: <53e53fd1.zO3IbUqJ421c7VXf%akpm@linux-foundation.org>
 <53E5DA60.90902@users.sourceforge.net>
 <alpine.DEB.2.02.1408091028520.2016@localhost6.localdomain6>
Message-ID: <53E5E656.1000606@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I still don't think this should be done for any random function that 
> performs a null test on its argument.  The corrections involved here are 
> not as trivial as they would seem.

I would prefer to make the list of corresponding function names more complete.


> Often it is not the case that the null test at the call site should be
> just deleted, instead the code should be reorganized.

Which source code places do you know where a different approach might look better?


> (Personally, I don't like the whole null test removal idea. [...]

Would you like to clarify involved software concerns a bit more?

Regards,
Markus
