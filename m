From: tipecaml@gmail.com (Cyril Roelandt)
Date: Wed, 05 Jun 2013 02:37:31 +0200
Subject: [Cocci] Converting old-style function definitions.
In-Reply-To: <alpine.DEB.2.02.1305291835300.2246@hadrien>
References: <20130529162209.GA30955@domone.kolej.mff.cuni.cz>
 <alpine.DEB.2.02.1305291835300.2246@hadrien>
Message-ID: <51AE884B.3080308@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 05/29/2013 06:37 PM, Julia Lawall wrote:
> On Wed, 29 May 2013, Ond?ej B?lka wrote:
>
>>
>> Hi,
>>
>> I am interested in common cleanup to convert K&R function
>> definitions to ISO ones (As gcc warning in -Wold-style-definition).
>>
>> Probably someone already wrote spatch so I ask here who?
>
> Unfortunately, it is not supported.  The Coccinelle C parser makes at
> least an attempt to parse K&R function definitions, but the SmPL parser,
> ie the parser of the transformation specification language, doesn't accept
> them.
>

Wouldn't it be possible to use a Python/OCaml rule to do this 
transformation ? I did not manage to do it, but I think the attached 
Coccinelle script might still be useful, since it can probably be used 
to "fix" prototypes without having to write a complete C parser first. 
The attached Coccinelle script does 3 things:

1) Find all function definitions (the "find" rule);
2) Parse their prototypes in a python rule and compute the "correct" 
prototype (the "fix" rule);
3) Write the "correct" prototype in the code.

This does not work well, as it just turns:

void
k_r_function(foo, bar)
         int foo; int bar;
{
}

into

void
k_r_function(foo, bar)
         int foo; int bar;
{
}
+k_r_function(int foo, int bar);


Even if the third step cannot be fixed, it's probably quite easy to fix 
the code in the second step, and to write the whole source file in a new 
file.

WDYT ?

Cyril.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: kr.cocci
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130605/d2328d37/attachment.ksh>
