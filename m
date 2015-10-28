From: mmarek@suse.com (Michal Marek)
Date: Wed, 28 Oct 2015 11:04:56 +0100
Subject: [Cocci] [PATCH] coccinelle: misc: remove "complex return code"
	warnings
In-Reply-To: <20151028095414.GD28572@localhost>
References: <1443652647-23097-1-git-send-email-johan@kernel.org>
 <alpine.DEB.2.10.1510031825170.2586@hadrien>
 <20151028095414.GD28572@localhost>
Message-ID: <56309DC8.5030202@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 28.10.2015 v 10:54 Johan Hovold napsal(a):
> On Sat, Oct 03, 2015 at 06:25:39PM +0200, Julia Lawall wrote:
>> Should have acked this message...
>>
>> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>>
>> On Wed, 30 Sep 2015, Johan Hovold wrote:
>>
>>> This effectively reverts 932058a5d5f9 ("coccinelle: misc: semantic patch
>>> to delete overly complex return code processing").
>>>
>>> There can be both symmetry and readability reasons for not wanting to do
>>> the final function call as part of the return statement and to maintain
>>> a clear separation of success and error paths.
>>>
>>> Since this is in no way mandated by the coding standard, let's just
>>> remove this semantic patch to avoid having "clean up" patches being
>>> posted over and over in response to these Coccinelle warnings.
>>>
>>> Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Is anyone planning on picking this patch up?

It is already in kbuild.git as commit 1a617a8475e8, I apparenly forgot
to reply to this thread.

Michal
