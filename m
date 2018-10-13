From: timur@kernel.org (Timur Tabi)
Date: Sat, 13 Oct 2018 10:56:53 -0500
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <e4e5dc37-c364-c53d-26f6-52205cfee304@users.sourceforge.net>
References: <CAOZdJXWzDQay=sRwri7N_Hanzee1Qkwqg-ezLiY3_JToCp9kog@mail.gmail.com>
 <e4e5dc37-c364-c53d-26f6-52205cfee304@users.sourceforge.net>
Message-ID: <bbf8f3f2-baa4-b9a2-4350-ae3d45ec0fd5@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 10/13/18 7:44 AM, SF Markus Elfring wrote:
> I have also taken another look at your evolving SmPL script ?nv_printf.cocci?.
> I suggest to merge the first five SmPL rules into one rule by using
> a SmPL disjunction. Will you get nicer run time characteristics then?

I care more about simplicity and code maintenance than I do about 
runtime.  It already runs in a few seconds, how much faster do I need it 
to be?

I'd rather have help in fixing bugs than making it more efficient.

> How do you think about to continue development discussions around topics
> like ?nested SmPL disjunctions? (and ?Usage of regular expressions in
> SmPL constraints?)?

That's way over my head.
