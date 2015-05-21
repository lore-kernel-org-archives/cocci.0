From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Thu, 21 May 2015 15:21:12 +0300
Subject: [Cocci] Matching from upper level struct
In-Reply-To: <alpine.DEB.2.10.1505202254470.2642@hadrien>
References: <555CF004.5010400@mentor.com>
 <alpine.DEB.2.10.1505202254470.2642@hadrien>
Message-ID: <555DCDB8.3050600@mentor.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Julia,

thank you for helpful and fast response.

On 20.05.2015 23:58, Julia Lawall wrote:
> 
> 
> On Wed, 20 May 2015, Vladimir Zapolskiy wrote:
> 
>> Hello Julia,
>>
>> please excuse me for a newbie question, I'm trying to find a way how to
>> match an assignment done from embracing struct or union.
>>
>> If you consider this C code sample:
>>
>> ----8<----
>> static void a(void) {};
>>
>> struct x {
>> 	void (*u)(void);
>> };
>>
>> struct y {
>> 	struct x v;
>> };
>>
>> struct x k = {
>> 	.u = a,
>> };
>>
>> struct y l = {
>> 	.v = {
>> 		.u = a,
>> 	},
>> };
>> ----8<----
>>
>> where "struct x" type is known and "struct y" may be arbitrary/unknown,
>> and I would like to match both assignments.
>>
>> My na?ve rule finds only k.u assignment:
>>
>> ----8<----
>> @@
>> struct x X;
>> identifier value;
>> @@
>>
>> * X.u = value;
>> ----8<----
>>
>> I believe it should not be a problem for me to get access to ".u", if I
>> get ".v" identifier firstly, but here I encounter a problem, probably
>> because "{ .u = a, }" above is not considered as a valid expression to
>> be matched in a rule like ".f = E,".
>>
>> Any help is appreciated, thank you in advance.
> 
> Could you live with the following?
> 
> @@
> struct x X;
> identifier value;
> @@
> 
> * X.u = value;
> 
> @parent@
> identifier y,v;
> @@
> 
> struct y {
>         ...
>         struct x v;
>         ...
> };
> 
> @@
> identifier l,parent.y,parent.v;
> struct y X;

Just to share my level of comprehension, I don't quite understand what
the line above is needed for.

> identifier value;
> @@
> 
> struct y l = {
>         .v = {
> *                .u = value,
>         },
> };
> 
> -----------------------------------
> 
> This will work for the case of a struct field inside a struct field, but
> not more levels of nesting. 

Much better than nothing and I got the idea, thank you so much. It might
be a good improvement to coccinelle, if any level of nesting can be
technically supported (if it is not).

I ported the code to my actual project, and it works well, though spatch
1.0.0-rc24 produces a warning even on toy example above:

  (ONCE) warning: struct/union with a metavariable name detected.
  (ONCE) For type checking assuming the name of the metavariable is the
name of the type

> Do you expect the assignments to all be in structures, or sometimes
> in ordinary assignments?  If you expect always structures, perhaps
> rewrite the first rule to mention structures.  If there can be
> ordinary assignments, you can leave it as is.

Yes, my intention is to cover both cases, actually ordinary assignments
is the main case, but then I found that the discussed case is not
covered by my rule.

> But you may want to make a second copy without the ; if there is the
> possibility that such an assignment could be part of another
> expression, and thus without the ;.  The ; though is necessary
> to get the isomorphism with structure field assignments.
> 

In my particular situation it is unlikely, but I tested it and works as
expected.

Thank you for the great tool!

--
With best wishes,
Vladimir
