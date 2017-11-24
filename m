From: devel.fx.lebail@orange.fr (Francois-Xavier Le Bail)
Date: Fri, 24 Nov 2017 12:33:29 +0100
Subject: [Cocci] Why some changes are not done ?
In-Reply-To: <alpine.DEB.2.20.1711241159010.3316@hadrien>
References: <764056da-dd1d-ee19-e6fb-d70b5447ca59@orange.fr>
 <alpine.DEB.2.20.1711241122300.3316@hadrien>
 <8c4c920c-8828-082f-005c-695748e95397@orange.fr>
 <alpine.DEB.2.20.1711241159010.3316@hadrien>
Message-ID: <d674d520-3787-4833-c477-d67aa529684b@orange.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 24/11/2017 12:00, Julia Lawall wrote:
> 
> 
> On Fri, 24 Nov 2017, Francois-Xavier Le Bail wrote:
> 
>> On 24/11/2017 11:23, Julia Lawall wrote:
>>> On Fri, 24 Nov 2017, Francois-Xavier Le Bail wrote:
>>>> I use the following Coccinelle script to rename some macros:
>>>> @@
>>>> expression E;
>>>> @@
>>>> (
>>>> -EXTRACT_16BITS(E)
>>>> +EXTRACT_BE_16BITS(E)
>>>> |
>>>> -EXTRACT_32BITS(E)
>>>> +EXTRACT_BE_32BITS(E)
>>>> )
>>>> [...]>> It seems that the problem is link to macro USES_APPLE_DEPRECATED_API on line 835.
>>>> If I comment this macro, the changes are done.
>>>> On Apple systems:
>>>> #define USES_APPLE_DEPRECATED_API DIAG_OFF(deprecated-declarations)
>>>> On other systems (like the one I use):
>>>> #define USES_APPLE_DEPRECATED_API
>>>
>>> Just make a file macros.h and put in it
>>>
>>>  #define USES_APPLE_DEPRECATED_API
>>>
>>> Then run spatch with --macro-file macros.h (or if that doesn't work then
>>> --macro-file-builtins macros.h).  Then it will ignore this code.
>>
>> It works with '--macro-file macros.h', Thanks you !
>>
>> Is there a way to have changes done also in macro definitions?
>> (like
>> #define KTOHSP(kp, cp) (IS_LENDIAN(kp) ? EXTRACT_LE_16BITS(cp) : EXTRACT_16BITS(cp)))
> 
> Normally changes should happen in macro definitions as well, but there may
> be a problem in parsing it due to some confusion about the parsing of a
> preceding macro.  You can run spatch --parse-c file.c to see where there
> are parsing issues.

The reason for this source is that the macro is defined in a function body.
Why not applying change in that case?

-- 
Francois-Xavier
