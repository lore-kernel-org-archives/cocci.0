From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Sat, 14 Jul 2018 00:11:06 +0530
Subject: [Cocci] Coccinelle: Development challenges around software
	profiling
In-Reply-To: <d6fac368-bb43-f53c-0f58-b25a81156a4e@users.sourceforge.net>
References: <20180713091412.GA11250@himanshu-Vostro-3559>
 <5e93dba5-1a57-ee59-e714-17a80b3fb031@users.sourceforge.net>
 <20180713164213.GA2747@himanshu-Vostro-3559>
 <d6fac368-bb43-f53c-0f58-b25a81156a4e@users.sourceforge.net>
Message-ID: <20180713184105.GA6945@himanshu-Vostro-3559>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

[ removing Dominique Martinet as I don't want to spoil his weekend ;) ]
On Fri, Jul 13, 2018 at 07:11:33PM +0200, SF Markus Elfring wrote:
> > Btw, Markus, I am curious to know how do you benchmark Coccinelle rules?
> 
> Such software profiling functionality belongs to the current
> standard functionality (to some degree).
> I suggest to take another look at information sources like
> the following.
> 
> * Increase precision for display of SmPL script execution durations
>   https://systeme.lip6.fr/pipermail/cocci/2018-May/005102.html

Agreed! Though we have --profile option.

I couldn't see your patch in the above link to do what you requested.
Did I miss something ?

> * Selection of benchmarks
>   https://github.com/coccinelle/coccinelle/issues/133

Hmm. 

97 issues authored by you. Seems like you put a lot of time exploring
Coccinelle. But I don't see your "patches" in the cocci mailing-list !?

> > I wish to see Coccinelle handling headers in source file in future.
> 
> Data processing is also supported for header files to some degree
> if you pass corresponding command line parameters.
> 
> * Are you looking for any special source code there?

Suppose for eg I wish to replace:

- #include <linux/module>
+ #include <linux/iio.h>

as iio.h to already includes(assume) module.h

Or another eg. would be to replace all <asm/...> with <linux/...>
https://lkml.org/lkml/2017/10/5/106


> * Do you find run time characteristics for data parsing acceptable?

For the zalloc-simple.cocci, I would like to have some profiling
facilities to determine the best approach for framing the rule.
Isn't it ?

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
