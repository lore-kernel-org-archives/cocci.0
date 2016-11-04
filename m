From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 4 Nov 2016 22:32:54 +0100 (CET)
Subject: [Cocci] Adding argument to a function
In-Reply-To: <447ba46f-8f4e-5da5-67f7-399bc73631a6@linaro.org>
References: <20161102210950.GA1770@mai>
 <alpine.DEB.2.20.1611022237060.2372@hadrien>
 <badecf5a-aa01-7e52-8bd0-1bde70079769@linaro.org>
 <alpine.DEB.2.20.1611030706150.2072@hadrien>
 <796382c5-a53e-f9cb-df4f-40dde7ca2246@linaro.org>
 <alpine.DEB.2.20.1611042207000.2019@hadrien>
 <447ba46f-8f4e-5da5-67f7-399bc73631a6@linaro.org>
Message-ID: <alpine.DEB.2.20.1611042232280.2019@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 4 Nov 2016, Daniel Lezcano wrote:

> On 04/11/2016 22:07, Julia Lawall wrote:
> >
> >
> > On Fri, 4 Nov 2016, Daniel Lezcano wrote:
> >
> >>
> >> Hi Julia,
> >>
> >> thanks for the long explanation. With the great help of Viresh, it is
> >> almost done. However I miss a rule to add a comment description in the
> >> comment cartridge of the changed function.
> >>
> >> /**
> >>
> >>
> >>  * cpuhp_setup_state - Setup hotplug state
> >>  *
> >>  * @state:      The state for which the calls
> >>  * @name:       Name of the callback
> >>  * @startup:    startup callback function
> >>  * @teardown:   teardown callback function
> >> + * @data:       startup/teardown's cookie
> >>  *
> >>  * Installs the callback functions and invokes the startup
> >>  * callback on the present cpus which have already reached
> >>  * the @state.
> >>  */
> >>
> >> Apparently, coccinelle does not like the '@' symbol.
> >>
> >> Is it possible to add such comment ?
> >
> > How did you get Coccinelle to add a line in the middle of a comment at
> > all?  It would indeed have trouble with a @.
>
> Well actually, I didn't. The lines above are to describe what I would
> like to achieve. But if you confirm a @ will put coccinelle in trouble,
> I will manually do the change.

Even without the @ issue, there is no way to add a line in the middle of a
comment.

julia

>
> Thanks for your help.
>
>   -- Daniel
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
>
