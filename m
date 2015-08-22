From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 22 Aug 2015 17:58:05 +0200
Subject: [Cocci] Checking data structure modification with SmPL
In-Reply-To: <alpine.DEB.2.10.1508220716010.2531@hadrien>
References: <55D31848.1060900@users.sourceforge.net>
 <alpine.DEB.2.10.1508220716010.2531@hadrien>
Message-ID: <55D89C0D.80307@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Now I would like to support more possibilities for the determination
>> of affected members from the shown variable.
>>
>>
>> @show_modification_before_memory_release@
>> expression element, value;
>> identifier var;
>> @@
>>  <+...
>> *var->element = value;
> 
> Element is not an expression.  An expression is something that has a value.
> A field name has no value.  It just enables selecting a field.

Thanks for your clarification.


> Probably what you want is <+...var->element...+>, ie something that has
> var->element as a subexpression.

* Do I need to restrict the amount of source code which can appear between
  data structure access and the shown value assignment that should be checked
  by such a SmPL construct?

* Do I need to fiddle with another SmPL disjunction to express
  the possibility that "var" could be more than a simple identifier?

* How should the support for longer arrow chains be specified?


> To avoid parsing ambiguities, you will need to put () around this,
> but it will not affect the results.

Thanks for this hint.


>>  ...+>
>>  free(var);


Regards,
Markus
