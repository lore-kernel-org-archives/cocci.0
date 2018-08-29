From: Felix.Blyakher@Quantum.Com (Felix Blyakher)
Date: Wed, 29 Aug 2018 16:25:54 +0000
Subject: [Cocci] coccinelle to rescue for "C++11 requires a space
 between literal and string macro"
In-Reply-To: <alpine.DEB.2.21.1808281514290.2555@hadrien>
References: <DM3PR14MB0766042ACA4CECA31C33FF29800A0@DM3PR14MB0766.namprd14.prod.outlook.com>,
 <alpine.DEB.2.21.1808281514290.2555@hadrien>
Message-ID: <CY1PR14MB0762DAD8C953D15476B8881380090@CY1PR14MB0762.namprd14.prod.outlook.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 28 Aug 2018, Julia Lawall  wrote:

>On Tue, 28 Aug 2018, Felix Blyakher wrote:
>
>> Hello coccinelle experts,
>>
>> I'm working with the legacy code and with newish gcc 7.3 hit the following warning:
>>
>> warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]
>>  #define PADARG64 "0x%016"QUAD"x"
>>                   ^
>>
>> where QUAD is a platform dependent string, thus the macro.
>>
>> The string concatenation works in C OK for this code, though, gcc rightfully complains
>> about required space and wants it to be:
>>
>>  #define PADARG64 "0x%016" QUAD "x"
>>
>> The code like this is sprinkled across huge code base, mostly in printf-like statements,
>> and some in defines like above to be used in printf-like statements.
>>
>> I'd like to use coccinelle to change the code globally.
>> I was trying something like (I know it may have false positive, just need to get something for starter):
>>
>>
>> @@
>> Identifier I;
>> @@
>>
>> -"I"
>> +" I "
>
>Coccinelle doesn't interpret things inside strings, except format
>directives.  Also, identifier shouldn't be capitalized.
>
>What you want is:
>
>@@
>constant char[] c;
>@@
>
>- c
>+ c

which means "add a space to every string".
Works perfect for the example I gave in my original email.
Simplicity is genius.

However, "every string" is too aggressive in a wider conetxt. For example it
picked up the following, which I wouldn't like to change:

-               YY_FATAL_ERROR( "out of dynamic memory in cfg_yy_scan_bytes()" );
+               YY_FATAL_ERROR("out of dynamic memory in cfg_yy_scan_bytes()" );

>
>When Coccinelle adds the string back, it will pretty print it properly.

While generally it's a good thing, it doesn't always makes the code better,
e.g.

-      printf("--- Stored file link statistics are:\n"
-             "---  Virtual transmitted = %llu (bytes)\n"
-             "---  Virtual received    = %llu (bytes)\n"
-             "---  Actual transmitted  = %llu (bytes)\n"
-             "---  Actual received     = %llu (bytes)\n",
+      printf("--- Stored file link statistics are:\n" "---  Virtual transmitted = %llu (bytes)\n" "---  Virtual received    = %llu (bytes)\n" "---  Actual transmitted  = %llu (bytes)\n" "---  Actual received     = %llu (bytes)\n",

It concatenated strings (with the space in between), where they meant to
be split on separate lines for readability.
Can this feature be disabled (with some command line option)?

>If you want to see a diff in the output, put --force-diff on the command
>line.  Normally Coccinelle doesn't print a diff when there are only
>whitespace changes.
>
>This will work on every string in your code.  If you don't want this, then
>you can put:
>
>constant char[] c : script:python { check c };
>
>where check is some python code you write under
>
>@initialize:python@
>@@
>
>def check ...
>
>to check whether it is a string with multiple pieces.  Note that the c
>that check received will have the spaces already, so it won't be possible
>to tell if the string is actually missing spaces.  But you can distinguish
>strings in multiple pieces from string that are atomic.

Yes, this is what I'm planning to work on, as "every string" is too
aggressive.
(While this script is fun to work on, I've been interrupted by other
urgent work related tasks.)

Thanks a lot,
Felix

>
>Let me know if anything is not clear.
>
>julia

________________________________________
From: Julia Lawall <julia.lawall@lip6.fr>
Sent: Tuesday, August 28, 2018 5:19:08 PM
To: Felix Blyakher
Cc: cocci at systeme.lip6.fr
Subject: Re: [Cocci] coccinelle to rescue for "C++11 requires a space between literal and string macro"



On Tue, 28 Aug 2018, Felix Blyakher wrote:

> Hello coccinelle experts,
>
> I'm working with the legacy code and with newish gcc 7.3 hit the following warning:
>
> warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]
>  #define PADARG64 "0x%016"QUAD"x"
>                   ^
>
> where QUAD is a platform dependent string, thus the macro.
>
> The string concatenation works in C OK for this code, though, gcc rightfully complains
> about required space and wants it to be:
>
>  #define PADARG64 "0x%016" QUAD "x"
>
> The code like this is sprinkled across huge code base, mostly in printf-like statements,
> and some in defines like above to be used in printf-like statements.
>
> I'd like to use coccinelle to change the code globally.
> I was trying something like (I know it may have false positive, just need to get something for starter):
>
>
> @@
> Identifier I;
> @@
>
> -"I"
> +" I "

Coccinelle doesn't interpret things inside strings, except format
directives.  Also, identifier shouldn't be capitalized.

What you want is:

@@
constant char[] c;
@@

- c
+ c

When Coccinelle adds the string back, it will pretty print it properly.
If you want to see a diff in the output, put --force-diff on the command
line.  Normally Coccinelle doesn't print a diff when there are only
whitespace changes.

This will work on every string in your code.  If you don't want this, then
you can put:

constant char[] c : script:python { check c };

where check is some python code you write under

@initialize:python@
@@

def check ...

to check whether it is a string with multiple pieces.  Note that the c
that check received will have the spaces already, so it won't be possible
to tell if the string is actually missing spaces.  But you can distinguish
strings in multiple pieces from string that are atomic.

Let me know if anything is not clear.

julia
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through security software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
