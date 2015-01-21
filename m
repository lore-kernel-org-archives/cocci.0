From: eliseomarmol@gmail.com (=?windows-1252?Q?Eliseo_Mart=EDnez?=)
Date: Wed, 21 Jan 2015 18:28:38 +0100
Subject: [Cocci] Matching functions with attributes
In-Reply-To: <54BFD099.8030002@users.sourceforge.net>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
Message-ID: <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> Then, would there be any way to match functions having the
>> literal ?FUNC_ATTR_NONNULL_RET? in their declaration/definition?
> 
> Would you like to try it out how many source code places can be found
> with your macro name?

This approach
``` 
@nonnullfuncs@ identifier func; @@

* func
  (...)
  ... FUNC_ATTR_NONNULL_RET ...
  {...}
```
matches nothing.

>> @@ identifier func =~ "^(transstr|list_alloc|listitem_alloc| [...] |concat_str)$"; [...] @@
>> 
>>  var = func(...);
>>  ... when != var = E
>> (
>> * if (var == NULL) S;
>> |
>> * if (var != NULL) S;
>> )
> 
> Does this kind of SmPL disjunction make sense?

I don?t see why not. AFAIK, Disjunctions can contain a full term (identifier/expression/statement).
Regarding meaning, well, I?m looking for places where var is checked for nullness/non-nullnes.
That?s the most obvious way I?ve found to express that?

>> As you see, I have to replicate the list.
>> 
> I would also appreciate if such repetition could be avoided for
> SmPL constraints.

I?ve tried with rule inheritance, but don?t know what to put in a first rule that just ?selects? the functions. This is:

```
@r@ identifier func =~ ??list of names? ? @@

  ? What here???

@@ identifier r.func @@

(
* if (func(?) == NULL) S;
|
* if (func(?) != NULL) S;
)
```

>> Is there any better way to achieve the same effect?
> 
> How do you think about to construct the desired regular expression
> by other programming scripts automatically?
> 
> Would you like to store involved function names into specific
> data structures (like databases)?

The purpose of my question is to see if there?s a way to do this within coccinelle.
If there?s no such a way, then, well, I?ll definitely consider constructing that regexp through some external script.

Thanks.
