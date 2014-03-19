From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Wed, 19 Mar 2014 14:39:49 +0100
Subject: [Cocci] [PATCH] Coccicheck: Remove memcpy to struct assignment
	test
In-Reply-To: <1395230578.12633.21.camel@thorin>
References: <1395177092-3023-1-git-send-email-peter.senna@gmail.com>
 <1395230578.12633.21.camel@thorin>
Message-ID: <CA+MoWDoSYu-aSp39vBe7DmayH2iqagHNYP9BC7LefajMXk+FnQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Mar 19, 2014 at 1:02 PM, Bernd Petrovitsch
<bernd@petrovitsch.priv.at> wrote:
> On Die, 2014-03-18 at 22:11 +0100, Peter Senna Tschudin wrote:
>> The Coccinelle script scripts/coccinelle/misc/memcpy-assign.cocci look
>> for opportunities to replace a call to memcpy by a struct assignment.
>> This patch removes memcpy-assign.cocci as it is not clear that this
>> convention has an impact on the generated code.
>
> Using struct assignment keeps the type check and is just for this reason
> always preferable over memcpy().
What about the assignment hiding that a potentially large memcpy is
happening instead of just a pointer assignment?

>
> Kind regards,
>         Bernd
> --
> Bernd Petrovitsch                  Email : bernd at petrovitsch.priv.at
>                      LUGA : http://www.luga.at
>



-- 
Peter
