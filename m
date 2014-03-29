From: mmarek@suse.cz (Michal Marek)
Date: Sat, 29 Mar 2014 21:37:23 +0100
Subject: [Cocci] [PATCH] Coccicheck: Remove memcpy to struct assignment
	test
In-Reply-To: <20140319164855.GB27142@kroah.com>
References: <1395177092-3023-1-git-send-email-peter.senna@gmail.com>
 <1395230578.12633.21.camel@thorin>
 <CA+MoWDoSYu-aSp39vBe7DmayH2iqagHNYP9BC7LefajMXk+FnQ@mail.gmail.com>
 <1395237927.12633.29.camel@thorin> <20140319164855.GB27142@kroah.com>
Message-ID: <53372F03.9010803@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 19.3.2014 17:48, Greg Kroah-Hartman napsal(a):
>>>> On Die, 2014-03-18 at 22:11 +0100, Peter Senna Tschudin wrote:
>>>>> The Coccinelle script scripts/coccinelle/misc/memcpy-assign.cocci look
>>>>> for opportunities to replace a call to memcpy by a struct assignment.
>>>>> This patch removes memcpy-assign.cocci as it is not clear that this
>>>>> convention has an impact on the generated code.
[...]
> Can someone please just remove the check from the kernel as I'm getting
> tired of rejecting patches that do this...

I just applied Peter's revert to kbuild.git#misc.

Michal
