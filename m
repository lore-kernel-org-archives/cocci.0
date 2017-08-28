From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 28 Aug 2017 17:27:21 +0200
Subject: [Cocci] Addition of support for conjunctions on types
In-Reply-To: <alpine.DEB.2.20.1708281718260.3266@hadrien>
References: <alpine.DEB.2.20.1708281334400.3266@hadrien>
 <a03956ce-b42c-179d-7b87-956f8238bf42@users.sourceforge.net>
 <alpine.DEB.2.20.1708281650580.3266@hadrien>
 <7bea3743-3342-0b7d-0023-935f350c1bae@users.sourceforge.net>
 <alpine.DEB.2.20.1708281708390.3266@hadrien>
 <46e6bd2b-5d17-9636-5631-909ad74f7014@users.sourceforge.net>
 <alpine.DEB.2.20.1708281718260.3266@hadrien>
Message-ID: <6f435253-bccd-b4ef-970f-fca61b9431e1@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I am looking for descriptions about circumstances under which the metavariable combination
>> will be useful by the mentioned SmPL conjunctions.
> 
> I still don't understand the question.

It seems that I have got a few understanding difficulties with the added functionality.


> Another example is
> 
> (
> (
> struct i
> |
> union i
> )
> &
> t
> )
> 
> Now you have one metavariable, t, that stores the whole type,

I find this technical detail unclear.


> whether it is a struct or a union.

But this information sounds promising.

Regards,
Markus
