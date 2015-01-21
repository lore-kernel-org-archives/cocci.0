From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 21 Jan 2015 17:15:21 +0100
Subject: [Cocci] Matching functions with attributes
In-Reply-To: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
Message-ID: <54BFD099.8030002@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Then, would there be any way to match functions having the
> literal ?FUNC_ATTR_NONNULL_RET? in their declaration/definition?

A preprocessor symbol like "NULL" or "ZERO_OR_NULL_PTR" can be found
at least.   ;-)

Would you like to try it out how many source code places can be found
with your macro name?


> @@ identifier func =~ "^(transstr|list_alloc|listitem_alloc| [...] |concat_str)$"; [...] @@
> 
>   var = func(...);
>   ... when != var = E
> (
> * if (var == NULL) S;
> |
> * if (var != NULL) S;
> )

Does this kind of SmPL disjunction make sense?


> ```
> 
> As you see, I have to replicate the list.

I would also appreciate if such repetition could be avoided for
SmPL constraints.


> Is there any better way to achieve the same effect?

How do you think about to construct the desired regular expression
by other programming scripts automatically?

Would you like to store involved function names into specific
data structures (like databases)?

Regards,
Markus
