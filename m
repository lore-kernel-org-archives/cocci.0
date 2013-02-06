From: mstefani@redhat.com (Michael Stefaniuc)
Date: Wed, 06 Feb 2013 15:37:59 +0100
Subject: [Cocci] Prepending '*' to an expression (Was: [PATCH V2]
 scripts/coccinelle/misc/memcpy-assign.cocci: Replace memcpy with struct
 assignment)
In-Reply-To: <5108415F.1020603@redhat.com>
References: <1358978790-2990-1-git-send-email-peter.senna@gmail.com>
 <510173B3.9090002@redhat.com>
 <CA+MoWDq-Ne6GYUHe-OtrF1MvUv1ou+xPZZfid+TvndLgbpF5Dg@mail.gmail.com>
 <51059238.1090009@redhat.com> <alpine.DEB.2.02.1301282303220.2060@hadrien>
 <5108415F.1020603@redhat.com>
Message-ID: <51126AC7.70605@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 01/29/2013 10:38 PM, Michael Stefaniuc wrote:
> On 01/28/2013 11:04 PM, Julia Lawall wrote:
>> On Sun, 27 Jan 2013, Michael Stefaniuc wrote:
>>> On 01/26/2013 02:28 AM, Peter Senna Tschudin wrote:
>>>> Thank you for testing.
>>>>
>>>> I made changes on the semantic patch. I believe it fixed the problem.
>>>> Can you test it?
>>> while it does fix the issue it makes the cocci script less readable and
>>> works only in that particular case. Not sure it is worth the effort as
>>> the bad generated patch can be trivially detected and easily fixed
>>> manually. My email was more of a bug report / feature request for
>>> coccinelle than an improvement request to the script.
>>>
>>> Though I've noticed an other issue with the script: Any reason you use
>>> "Options: --no-includes"? While it does speed up things it misses quite
>>> a few cases as a lot of types are defined in the headers.
>>
>> I think it should be --all-includes or even --recursive-includes
> no clue what the policy in the Kernel is but --recursive-includes is
> quite heavy handed as a default. I have one --recursive-includes still
> running for Wine and it accumulated until now over 1126 CPU minutes
The --recursive-includes run finally finished after accumulating 4240
minutes of CPU time. There was no visible slowdown nor memory leak
during the run which is pretty cool.

> (Intel i5 mobile CPU with 2.4 GHz). It found 5 more cases while
> --no-includes found 11 and --local-includes additional 32. The
> --local-includes finished in less than 30 minutes (didn't time it exactly).

bye
	michael
