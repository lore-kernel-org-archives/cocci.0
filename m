From: nicstange@gmail.com (Nicolai Stange)
Date: Sun, 06 Mar 2016 13:54:40 +0100
Subject: [Cocci] [PATCH v4 0/8] fix debugfs file removal races
In-Reply-To: <20160305212613.GA29738@kroah.com> (Greg Kroah-Hartman's message
 of "Sat, 5 Mar 2016 13:26:13 -0800")
References: <8737sjo7qa.fsf@gmail.com> <20160305212613.GA29738@kroah.com>
Message-ID: <87egbn3gxb.fsf@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Feb 23, 2016 at 02:51:25PM +0100, Nicolai Stange wrote:
>> The changes from v3 to v4 are style changes regarding the Coccinelle
>> part only -- it has been split off from former [3/7] into its own
>> patch [4/8].
>> 
>> The big step has been from v2 to v3 and these changes haven't got any
>> review yet.
>
> Well, given that they look sane to me, I've applied them to my tree,
> let's see what breaks in linux-next now :)

Great, thank you!

Unfortunately, the kbuild test robot detected two minor issues and I've
sent v5 in order to correct this.

In case that it isn't possible to simply replace v4 by v5, please let me
know and I'll send two fixup patches instead.

Best,

Nicolai
