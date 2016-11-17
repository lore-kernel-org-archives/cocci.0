From: arend.vanspriel@broadcom.com (Arend Van Spriel)
Date: Thu, 17 Nov 2016 21:36:13 +0100
Subject: [Cocci] Fwd: Fwd: Re: min/max mtu field in struct net_device
In-Reply-To: <3a964780-2513-624f-6a2a-ae507398b0a8@broadcom.com>
References: <3a964780-2513-624f-6a2a-ae507398b0a8@broadcom.com>
Message-ID: <2c575398-b566-6529-4f30-10e8e0c8fcba@broadcom.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Not seen a response on the backports mailing list so subscribed to the
cocci mailing list and reposting it.

Attached is a script I want to use to backport drivers. However, the
second (unnamed) rule matches for each occurence of 'struct
net_device_ops'. Is there a way to disable a rule after a desired amount
of matches (in my case once)?

Regards,
Arend

-------- Forwarded Message --------
Subject: Fwd: Re: min/max mtu field in struct net_device
Date: Tue, 15 Nov 2016 09:36:50 +0100
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
CC: backports at vger.kernel.org <backports@vger.kernel.org>

Hi Julia,

Would you have any ideas on how to solve the problem below. The problem
occurs with source files that have more than one struct net_device_ops
defined, which is the case for net/mac80211/iface.c for one. Obviously I
want the callback definition to be added only once.

Regards,
Arend

-------- Forwarded Message --------
Subject: Re: min/max mtu field in struct net_device
Date: Mon, 14 Nov 2016 11:46:01 +0100
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, backports at vger.kernel.org
<backports@vger.kernel.org>

On 14-11-2016 10:30, Johannes Berg wrote:
> On Mon, 2016-11-14 at 09:49 +0100, Arend Van Spriel wrote:
>> Just wondering. Does anyone have any ideas on how to backport the two
>> patches below. The struct net_device now holds mtu range which
>> network subsystem checks. For a number of drivers and mac80211 it
>> means they no longer have .ndo_change_mtu callback. My guess is that
>> we need patches in backport of some sort to tackle this.
> 
> Yeah, I kinda saw this coming. Since in almost all cases using the new
> min/max the ndo_change_mtu was actually removed, perhaps we can come up
> with a way to spatch it back in?

Me too. This is what I got so far, but the callback is generated twice
for net/mac80211/iface.c for obvious reasons (data and monitor ops).
These are my first baby steps with spatch so not sure how to solve it.

Gr. AvS


-------------- next part --------------
@r1@
expression ndev, e1, e2;
identifier func;
@@
func(...) {
	<...
- 	ndev->min_mtu = e1;
- 	ndev->max_mtu = e2;
	...>
}
@@
expression r1.e1, r1.e2;
identifier OPS;
@@
+ static int __change_mtu(struct net_device *ndev, int new_mtu)
+ {
+	if (new_mtu < e1 || new_mtu > e2)
+ 		return -EINVAL;
+	ndev->mtu = new_mtu;
+ }
+
struct net_device_ops OPS = {
+ 	.ndo_change_mtu = __change_mtu,
	...
};
