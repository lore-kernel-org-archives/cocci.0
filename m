From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 3 Nov 2016 01:56:30 +0100
Subject: [Cocci] Adding argument to a function
In-Reply-To: <alpine.DEB.2.20.1611022237060.2372@hadrien>
References: <20161102210950.GA1770@mai>
 <alpine.DEB.2.20.1611022237060.2372@hadrien>
Message-ID: <badecf5a-aa01-7e52-8bd0-1bde70079769@linaro.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 02/11/2016 22:40, Julia Lawall wrote:
> 
> 
> On Wed, 2 Nov 2016, Daniel Lezcano wrote:
> 
>> Hi all,
>>
>> I'm very new to coccinelle, so sorry if the question is irrelevant or was already asked.
>>
>> I'm trying to add a new argument to a function which has a couple of callbacks.
>>
>> The original function is:
>>
>> static inline int cpuhp_setup_state(enum cpuhp_state state,
>> 				    int (*startup)(unsigned int cpu),
>> 				    int (*teardown)(unsigned int cpu));
>>
>> I would like to pass a private pointer when setting the state and then pass
>> this pointer to the 'startup' / 'teardown' callbacks where there signature will be
>> different and all call sites must change their callbacks signature also.
>>
>> I tried to first add the new argument to the function, in order to have:
>>
>> static inline int cpuhp_setup_state(enum cpuhp_state state,
>> 				    int (*startup)(unsigned int cpu),
>> 				    int (*teardown)(unsigned int cpu),
>> 				    void *data);
>>
>> ... with the rule:
>>
>> @rule@
>> identifier cpuhp_setup_state;
>> identifier state, name, startup, teardown, data;
>> @@
>>
>> static inline int cpuhp_setup_state(enum cpuhp_state state,
>>                                     const char *name,
>>                                     int (*startup)(unsigned int cpu),
>>                                     int (*teardown)(unsigned int cpu),
>> 				    void *data)
>> {
>> 	...
>> }
>>
>> @@
>> identifier rule.cpuhp_setup_state;
>> expression E1, E2, E3, E4;
>> @@
>>
>> cpuhp_setup_state(E1, E2, E3, E4
>> +                 , NULL
>> 		 )
>>
>> But the parsing gives:
>>
>> ...
>>
>> cpuhp_setup_state(E1, E2, E3, E4
>>                     >>> , NULL
> 
> This is normal.  The >>> has to do with whether the NULL is to be put
> after what comes before or before what comes after. <<< would mean the
> opposite.  Unfortunately, I don't remember which is which, but it doesn't
> really matter in this case either.
> 
>>                   )
>>
>>
>> grep tokens
>> cpuhp_state || cpu
>> No query
>> warning: line 8: should cpu be a metavariable?
>> warning: line 9: should cpu be a metavariable?
> 
> I guess you would want an identifier cpu metavriable declaration in the
> first rule.  Otherwise, I don't really see any problems.  Do you have a .c
> file on which you expect to get a result?

Yes, that is all around the linux kernel code (eg.
./drivers/clocksource/qcom-timer.c)

If I change the cocci file to:

@@
expression E1, E2, E3, E4;
@@

-cpuhp_setup_state(E1, E2, E3, E4)
+cpuhp_setup_state(E1, E2, E3, E4, NULL)

It seems to work, except the function signature itself is not changed. I
can do add a manual change in the patch but if coccinelle can handle
both that would be nice.

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
