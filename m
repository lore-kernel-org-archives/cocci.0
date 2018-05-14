From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 14 May 2018 17:26:30 +0200
Subject: [Cocci] Moving a function body to an other source code place
 with SmPL
In-Reply-To: <alpine.DEB.2.20.1805141714300.17398@hadrien>
References: <704e29ae-bd49-6b84-eb96-45f6d3ad004e@users.sourceforge.net>
 <alpine.DEB.2.20.1805141632540.17398@hadrien>
 <03b3476d-083f-216b-bfef-03b0b1b25d21@users.sourceforge.net>
 <alpine.DEB.2.20.1805141714300.17398@hadrien>
Message-ID: <b4bed5e0-c747-a470-62c3-a53971ace610@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I have noticed a moment ago that a blank line is not marked by the SmPL
>> asterisk operator (for a small source code example) so far.
>>
>> Can such whitespace characters be also preserved there anyhow?
> 
> No.  Whitespace is never preserved in metavariables.

I guess that this aspect will trigger further software development consequences.

How should a function body be converted into a part of a macro then?


>> How will the software behaviour evolve if I stumble on the message
>> ?Fatal error: exception Coccinelle_modules.Common.Timeout? after passing
>> the parameter ?--timeout 123? for a change attempt with a C++ source file?
>> (Am I too impatient here?)
> 
> No evolution is planned.  I see no reason why matching the body of a
> function should intrinsically cause a timeout.

I am also unsure if the Coccinelle software can cope in an other time frame
with another example file I am experimenting a bit.

Regards,
Markus
