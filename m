From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 4 Nov 2016 22:07:44 +0100 (CET)
Subject: [Cocci] Adding argument to a function
In-Reply-To: <796382c5-a53e-f9cb-df4f-40dde7ca2246@linaro.org>
References: <20161102210950.GA1770@mai>
 <alpine.DEB.2.20.1611022237060.2372@hadrien>
 <badecf5a-aa01-7e52-8bd0-1bde70079769@linaro.org>
 <alpine.DEB.2.20.1611030706150.2072@hadrien>
 <796382c5-a53e-f9cb-df4f-40dde7ca2246@linaro.org>
Message-ID: <alpine.DEB.2.20.1611042207000.2019@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 4 Nov 2016, Daniel Lezcano wrote:

>
> Hi Julia,
>
> thanks for the long explanation. With the great help of Viresh, it is
> almost done. However I miss a rule to add a comment description in the
> comment cartridge of the changed function.
>
> /**
>
>
>  * cpuhp_setup_state - Setup hotplug state
>  *
>  * @state:      The state for which the calls
>  * @name:       Name of the callback
>  * @startup:    startup callback function
>  * @teardown:   teardown callback function
> + * @data:       startup/teardown's cookie
>  *
>  * Installs the callback functions and invokes the startup
>  * callback on the present cpus which have already reached
>  * the @state.
>  */
>
> Apparently, coccinelle does not like the '@' symbol.
>
> Is it possible to add such comment ?

How did you get Coccinelle to add a line in the middle of a comment at
all?  It would indeed have trouble with a @.

julia

>
> Thanks !
>
>   -- Daniel
>
> On 03/11/2016 07:17, Julia Lawall wrote:
>
> >
> >
> > On Thu, 3 Nov 2016, Daniel Lezcano wrote:
> >
> >> On 02/11/2016 22:40, Julia Lawall wrote:
> >>>
> >>>
> >>> On Wed, 2 Nov 2016, Daniel Lezcano wrote:
> >>>
> >>>> Hi all,
> >>>>
> >>>> I'm very new to coccinelle, so sorry if the question is irrelevant or was already asked.
> >>>>
> >>>> I'm trying to add a new argument to a function which has a couple of callbacks.
> >>>>
> >>>> The original function is:
> >>>>
> >>>> static inline int cpuhp_setup_state(enum cpuhp_state state,
> >>>> 				    int (*startup)(unsigned int cpu),
> >>>> 				    int (*teardown)(unsigned int cpu));
> >>>>
> >>>> I would like to pass a private pointer when setting the state and then pass
> >>>> this pointer to the 'startup' / 'teardown' callbacks where there signature will be
> >>>> different and all call sites must change their callbacks signature also.
> >>>>
> >>>> I tried to first add the new argument to the function, in order to have:
> >>>>
> >>>> static inline int cpuhp_setup_state(enum cpuhp_state state,
> >>>> 				    int (*startup)(unsigned int cpu),
> >>>> 				    int (*teardown)(unsigned int cpu),
> >>>> 				    void *data);
> >>>>
> >>>> ... with the rule:
> >>>>
> >>>> @rule@
> >>>> identifier cpuhp_setup_state;
> >>>> identifier state, name, startup, teardown, data;
> >>>> @@
> >>>>
> >>>> static inline int cpuhp_setup_state(enum cpuhp_state state,
> >
> > Here you make the name of the function a metavariable.  This will cause it
> > to make the change to any function with any name that has a signature that
> > looks like this.  If you want it to be only this function, you should not
> > declare its name as a metavariable, but just put it directly.  For the
> > parameter names, it will give the warning you have below about cpu if you
> > don't either make them metavariables with identifier, or declare them with
> > symbol, indicating that you know that you really want that name.  But you
> > can also just ignore the warning.
> >
> > The second problem is that this function is defined in a header file.
> > Coccinelle does not automatically include everything that is indicated
> > with #include.  Indeed, it doesn't run the C preprocessor at all.  If you
> > give the option --no-includes then you will get no includes at all.  The
> > default with no options is to include the local files and those with the
> > same name as the .c file, ie foo.h for foo.c.  --all-includes gives all
> > the include files mentioned in the .c file.  --recursive-includes gives
> > all the files they include and so on.  The more include files you have,
> > the more time everthing will take.  In your case, --recursive-includes
> > would be needed to see the definition at the same time as the use, because
> > the function is defined in include/linux/cpuhotplug.h, which is not
> > included explicitly.  But that would probably take a huge amount of time.
> >
> > Actually, all you want to do is process the relevant definition in the
> > relevant include file once, not once for every file that it is included
> > in.  So you want the options --include-headers --no-includes.  Without
> > --include-headers, Coccinelle will only look at the .c files.
> >
> > Since you are working on a specific function with a known name, you can
> > benefit from indexing.  You may want to first rule
> > coccinelle/scripts/idutile_index.sh on your kernel source tree.  Then put
> > --use-idutils at the end of your command line.  You can also run mkid
> > directly in your kernel source tree.  That will give the index a name that
> > is different than what Coccinelle expects, and you will have to give the
> > name of the index as an argument to --use-idutils.  You can also run
> > Coccinelle in parallel with the -j option.
> >
> > julia
> >
> >
> >>>>                                     const char *name,
> >>>>                                     int (*startup)(unsigned int cpu),
> >>>>                                     int (*teardown)(unsigned int cpu),
> >>>> 				    void *data)
> >>>> {
> >>>> 	...
> >>>> }
> >>>>
> >>>> @@
> >>>> identifier rule.cpuhp_setup_state;
> >>>> expression E1, E2, E3, E4;
> >>>> @@
> >>>>
> >>>> cpuhp_setup_state(E1, E2, E3, E4
> >>>> +                 , NULL
> >>>> 		 )
> >>>>
> >>>> But the parsing gives:
> >>>>
> >>>> ...
> >>>>
> >>>> cpuhp_setup_state(E1, E2, E3, E4
> >>>>                     >>> , NULL
> >>>
> >>> This is normal.  The >>> has to do with whether the NULL is to be put
> >>> after what comes before or before what comes after. <<< would mean the
> >>> opposite.  Unfortunately, I don't remember which is which, but it doesn't
> >>> really matter in this case either.
> >>>
> >>>>                   )
> >>>>
> >>>>
> >>>> grep tokens
> >>>> cpuhp_state || cpu
> >>>> No query
> >>>> warning: line 8: should cpu be a metavariable?
> >>>> warning: line 9: should cpu be a metavariable?
> >>>
> >>> I guess you would want an identifier cpu metavriable declaration in the
> >>> first rule.  Otherwise, I don't really see any problems.  Do you have a .c
> >>> file on which you expect to get a result?
> >>
> >> Yes, that is all around the linux kernel code (eg.
> >> ./drivers/clocksource/qcom-timer.c)
> >>
> >> If I change the cocci file to:
> >>
> >> @@
> >> expression E1, E2, E3, E4;
> >> @@
> >>
> >> -cpuhp_setup_state(E1, E2, E3, E4)
> >> +cpuhp_setup_state(E1, E2, E3, E4, NULL)
> >>
> >> It seems to work, except the function signature itself is not changed. I
> >> can do add a manual change in the patch but if coccinelle can handle
> >> both that would be nice.
> >>
> >> --
> >>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
> >>
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
>
