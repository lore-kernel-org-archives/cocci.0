From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 16 Jun 2014 11:10:11 +0200
Subject: [Cocci] Matching partial expressions in macro arguments
In-Reply-To: <alpine.DEB.2.02.1406141755470.1962@localhost6.localdomain6>
References: <20140613091128.GJ5821@phenom.ffwll.local>
 <alpine.DEB.2.02.1406141755470.1962@localhost6.localdomain6>
Message-ID: <CAKMK7uFkcL-Co2CSmarewBsgXuzLeB1+h9caZQDHjmbJx8k00g@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Jun 14, 2014 at 6:00 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Fri, 13 Jun 2014, Daniel Vetter wrote:
>> In our testsuite[1] we have a macro to compare 2 integers with a given
>> comparison operator, print them on assert failure to stderr for
>> diagnotistics and then abort our testcase.
>>
>> Usage is e.g.
>>
>>       igt_assert_cmpint(obj_count, ==, 0);
>>
>> Now I want to add a simple igt_assert_eq(a, b) macro, so the above example
>> should look like
>>
>>       igt_assert_eq(obj_count, 0);
>>
>> I tried to use cocci for the refactoring, but failed. I tried
>>
>> @@
>> expression E1, E2;
>> @@
>> -igt_assert_cmpint(E1, ==, E2);
>> +igt_assert_eq(E1, E2);
>>
>> which failed to parse as a spatch and
>>
>> @@
>> expression E1, E2, E;
>> @@
>> -igt_assert_cmpint(E1, E E2);
>> +igt_assert_eq(E1, E2);
>>
>> which didn't match anything. I didn't find any examples for creative macro
>> abuse and using iterator metavariables which helped last time around I've
>> stumbled over macros didn't work out either.
>>
>> Any ideas and suggestions highly welcome, or is this simply not possible
>> with cocci?
>
> I don't think it is going to be possible.  == is not considered to be a
> valid argument by the C parser.  You can make a macro definition for this,
> but then the C parser will just skip over the whole igt_assert_cmpint
> call.  No matches will be possible on that part of the code.

Ah, I suspected as much. Thanks a lot for your confirmation anyway.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
