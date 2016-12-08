From: mstefani@redhat.com (Michael Stefaniuc)
Date: Thu, 8 Dec 2016 15:18:21 +0200
Subject: [Cocci] Negated Positions and Modifications
In-Reply-To: <alpine.DEB.2.20.1611292248140.2016@hadrien>
References: <6772dc00-a196-b6db-097e-f4be53ff7d87@redhat.com>
 <alpine.DEB.2.10.1611221430450.31331@hadrien>
 <93d3068e-44a6-c80a-ecb3-6290d985a559@redhat.com>
 <alpine.DEB.2.20.1611272159200.2019@hadrien>
 <alpine.DEB.2.20.1611292248140.2016@hadrien>
Message-ID: <8338824e-3099-6e7b-f9a1-431f829f3c00@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 11/29/2016 11:49 PM, Julia Lawall wrote:
> 
> 
> On Sun, 27 Nov 2016, Julia Lawall wrote:
> 
>>> @@
>>> {r1.T, r2.T} obj;
>>> @@
>>>
>>> That only matches when both r1.T and r2.T are defined. That kinda feels
>>> odd but probably is easier to implement as all inherited variables need
>>> to be bound. I have quiet a few duplicated rules across multiple scripts
>>> due to that.
>>
>> This problem is fixed by the following patch.  Will appear in github
>> shortly, but not immediately.
> 
> The change is now available in the github version.  It is also now
Thanks Julia, I have tested the change and it seems to work.

> possible, thanks to Thierry, to put negated constraints on type variables,
Is there a way to have the positive constraint variant too?
That doesn't seem that useful for static types like int and char but can
avoid rule duplication when the type is inherited from 2 or more rules
that don't match at the same time. E.g.:
@@
type T = {r1.T, r2.T};
@@
 T *foo =
-          xyz
+          abc
 ;

Now in my specific case I'm getting the error:
meta: semantic error: incompatible inheritance declaration T

> as illustrated by the following semantic patch
> (tests/type_constraints.cocci):
> 
> @@
> type T != { int, char };
> identifier x;
> @@
> -   T x;
> +   T *x;

thanks
bye
	michael
