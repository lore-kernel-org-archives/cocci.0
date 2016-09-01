From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Sep 2016 10:32:14 +0200
Subject: [Cocci] Querying Git commits with Prequel
In-Reply-To: <alpine.DEB.2.10.1609010857120.3086@hadrien>
References: <alpine.DEB.2.10.1608291736460.2984@hadrien>
 <2ab7c81b-852a-b090-6ea6-54906d7bab30@users.sourceforge.net>
 <alpine.DEB.2.10.1609010857120.3086@hadrien>
Message-ID: <41926033-b326-ea09-8d02-39ff7f898cad@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>    * How much will the data format flexibility evolve together with the handling
>>      of a key word like "flexible" for metavariables?
> 
> No idea what this means (data format flexibility).

Is this key word the only one which was added to "PQL" (while it is processed by
"SmPL" in other ways)?


>> 3. I get concerns from the section "5.2 Idealized syntax".
>>    How would you categorise it according to the Chomsky-Sch?tzenberger hierarchy?
> 
> No idea.  It seems like a straightforward BNF.

Does the mentioned syntax belong to the category "context-free"?


> The commit range is just X..Y.  X ad Y could be commit ids or tags (v4.0,
> for example).

Can this range be controlled or adjusted from within Prequel scripts anyhow?


>> 5. Can the combination of words like "token" and "regular expression"
>>    be occasionally confusing?
> 
> Does the word regular expression occur in the paper?

Yes, of course.   ;-)

Is the section "6.1 Commit selection" worth for a few more clarifications?


>> 6. How interesting will discussions become around the used hardware
>>    that is mentioned in the chapter "7 Evaluation" and the corresponding
>>    software performance?
> 
> Not sure what there is to discuss.

Examples:
* Number of processor cores

* Run time distribution for the involved scripts


>> 7. How is the status for function and class libraries for this application domain?
> 
> No idea what this means.

Would you like to share any more information around the evolving code design structure?
Which class libraries will eventually combine software modules?


How do you think about to use another public repository interface
which would be similar to the one for Coccinelle?

Regards,
Markus
