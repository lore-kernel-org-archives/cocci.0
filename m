From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Sat, 14 Jul 2018 01:56:50 +0530
Subject: [Cocci] Coccinelle: Development challenges around software
	profiling
In-Reply-To: <536adc42-1680-e4be-bfee-7d01c37a239d@users.sourceforge.net>
References: <20180713091412.GA11250@himanshu-Vostro-3559>
 <5e93dba5-1a57-ee59-e714-17a80b3fb031@users.sourceforge.net>
 <20180713164213.GA2747@himanshu-Vostro-3559>
 <d6fac368-bb43-f53c-0f58-b25a81156a4e@users.sourceforge.net>
 <20180713184105.GA6945@himanshu-Vostro-3559>
 <536adc42-1680-e4be-bfee-7d01c37a239d@users.sourceforge.net>
Message-ID: <20180713202650.GA11690@himanshu-Vostro-3559>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jul 13, 2018 at 09:45:06PM +0200, SF Markus Elfring wrote:
> >> * Increase precision for display of SmPL script execution durations
> >>   https://systeme.lip6.fr/pipermail/cocci/2018-May/005102.html
> > 
> > Agreed! Though we have --profile option.
> > 
> > I couldn't see your patch in the above link to do what you requested.
> > Did I miss something ?
> 
> Do you find Julia's feedback more interesting for one of my
> update suggestions around related topics?
> https://systeme.lip6.fr/pipermail/cocci/2018-May/005104.html
> 
> 
> Examples for further development considerations:
> https://systeme.lip6.fr/pipermail/cocci/2018-June/005105.html
> https://systeme.lip6.fr/pipermail/cocci/2018-June/005106.html
> 
> 
> > 97 issues authored by you.
> 
> I suggest to recheck this information.
> https://github.com/coccinelle/coccinelle/issues?author%3Aelfring
> 
> I am trained to report various items.   ;-)

Yeah, I can figure that out.
But...

	"Talk is cheap. Show me the code."

That what I have saw in my nearly one year experience ;)

> > Seems like you put a lot of time exploring Coccinelle.
> 
> This is an usual ?side effect? from my work also with this software
> for years.

Ow.

> > But I don't see your "patches" in the cocci mailing-list !?
> 
> * The main developers omitted attribution for some changes
>   which were influenced (or even triggered) by my direct feedback.
> 
> * Would you like to inspect any pull requests once more?
>   https://github.com/coccinelle/coccinelle/pulls

I will check them out, later.

> 
> > Suppose for eg I wish to replace:
> > 
> > - #include <linux/module>
> > + #include <linux/iio.h>
> 
> The replacement of paths for include statements is another software
> development challenge.
> Did you ever look at the following feature request?
> 
> Support data processing for include statements together with
> the use of metavariables
> https://github.com/coccinelle/coccinelle/issues/138

I don't know Ocaml or else would've tried adding such feature.
Did you try to send a patch instead ?

Nobody is looking for ideas, you need to work it out yourself IMHO. And
Coccinelle mailing-list queries/suggestions/rants is handled by Julia
only, not sure if Michael or any past cocci reviewers are still present.
So, its difficult.

> 
> >> * Do you find run time characteristics for data parsing acceptable?
> > 
> > For the zalloc-simple.cocci, I would like to have some profiling
> > facilities to determine the best approach for framing the rule.
> 
> Which further development ideas did you get for this SmPL script
> in the meantime (since previous clarification attempts got bumpy)?

I didn't get time to look after the rule got merged, and I started
working on IIO and am still working
https://summerofcode.withgoogle.com/projects/#6691473790074880

Few months back I worked on a rule with help of Julia:
https://lkml.org/lkml/2018/3/7/1009

But somehow there was no development in that direction :(

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
