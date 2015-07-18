From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 18 Jul 2015 14:32:47 +0200
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
Message-ID: <55AA476F.7020907@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> @show_unstored_return_values
>> depends on !find_calls_for_initialisations
>>         && !find_calls_for_designated_initialisations
>>         && !find_calls_for_assignments@
>> identifier allocation =~ "^(?x)
>> (?:
>>    ippNewRequest
>> |
>>    sigaction
>> )$";
> 
> Do you really need to use a regular expression here?

No, not at the moment with this SmPL stub.


> Why not use a disjunction in the pattern?

The corresponding function name list will grow to some degree in the future.
Our debate around the use of SmPL disjunctions or constraints will continue
for this purpose.


> What does x represent?

Should this parameter turn the free-spacing mode on for the regular expression?
http://www.regular-expressions.info/freespacing.html


>> position pos;
>> @@
>>  void receiver(...)
> 
> What is received?

This specific function name does not really matter at the beginning.


> Why is the void type important?

It is unimportant for a start.

My SmPL approach is evolving so that the following specification might be better.


 return_type work(...)


>>  {
>>   <+...
>> * allocation at pos(...)
> 
> How is it useful to match just thf function call.

Do you care also for unused return values at such source code place occasionally?


> This doesn't show anything about whether or not the return value is stored.

I am trying to express this constraint by a detailed SmPL dependency specification
somehow in the rule declaration.
I am also unsure on the right way to establish a safe relationship between the position
variable "pos" there and function calls at other source code places.

Regards,
Markus
