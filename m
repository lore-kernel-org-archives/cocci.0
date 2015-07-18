From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 18 Jul 2015 13:40:15 +0200
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <alpine.DEB.2.10.1507150629540.2670@hadrien>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
Message-ID: <55AA3B1F.5020807@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I can find some function calls with the help of the semantic patch
>> language easily.
>> But I see further software development challenges in the following use cases.
>>
>> 1. The return value was not used for the initialisation of a variable.
>>
>> 2. The return value was not assigned to another variable.
>>
>>
>> Do I need to fiddle with SmPL position variables to determine if an assignment
>> is not performed together with a call within a function implementation?
>>
>> I would appreciate your advices for such a source code analysis.
> 
> No idea what you are trying to do.  Write something, and then if the
> result is not satisfactory, ask afterwards.

Now I try again with a different wording.

If I would start with top-down approach, I imagine that I will need a SmPL rule
like the following.


@show_unstored_return_values
depends on !find_calls_for_initialisations
        && !find_calls_for_designated_initialisations
        && !find_calls_for_assignments@
identifier allocation =~ "^(?x)
(?:
   ippNewRequest
|
   sigaction
)$";
position pos;
@@
 void receiver(...)
 {
  <+...
* allocation@pos(...)
  ...+>
 }


But I find that the shown dependencies will be insufficient so far.
I imagine that I should also specify additional constrains for the function
calls I am looking for.
Can extensions be better discussed with such a SmPL stub?

Regards,
Markus
