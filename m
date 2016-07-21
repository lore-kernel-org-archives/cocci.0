From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 21 Jul 2016 23:00:37 +0200
Subject: [Cocci] Better explanation for the usage of
 expression/parameter lists with SmPL?
In-Reply-To: <alpine.DEB.2.10.1607212246050.3326@hadrien>
References: <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <66bd684a-98f1-0ec4-aa95-1a966d7c4e90@users.sourceforge.net>
 <6a8f4258-188e-36f6-28fa-1626c29cf361@users.sourceforge.net>
 <alpine.DEB.2.10.1607172056220.3177@hadrien> <20160720155333.GE1688@katana>
 <b249584b-47b8-ffd9-432e-986d69260ff1@users.sourceforge.net>
 <20160721062726.GC1664@katana>
 <b221aadb-2af7-8d0f-ce8e-99b1efa31edd@users.sourceforge.net>
 <20160721163714.GB1616@katana>
 <6f2ca140-9384-bc3f-9d20-2433b808d566@users.sourceforge.net>
 <alpine.DEB.2.10.1607212159150.3326@hadrien>
 <95f4ee32-f5dc-6c0e-7ed1-5a62dfcd8648@users.sourceforge.net>
 <alpine.DEB.2.10.1607212246050.3326@hadrien>
Message-ID: <0f3f6122-a67c-fc8d-1384-267308b4c2d0@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> A parameter list is something that comes after the name of a function in
>>> the function header.  Something like int x, int y, in foo (int x, int y) {
>>> ... }.  Probably you want an expression list.
>>
>> * How do you call the list usually that is used for the definition before
>>   the function body?
> 
> parameter list

It seems that we have got the same understanding here.


>> * Did I get inappropriate expectations from a description around a "parameter-list-declarator"?
>>   http://en.cppreference.com/w/c/language/function_definition
> 
> Apparently.

I am surprised by this feedback.


> parameter-list - either the single keyword void or a comma-separated list
> of parameters, which may end with an ellipsis parameter

How does this description fit to the term "expression list" in the
semantic patch language?

Regards,
Markus
