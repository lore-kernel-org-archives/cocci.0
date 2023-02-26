Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81385C64ED6
	for <cocci@archiver.kernel.org>; Sun, 26 Feb 2023 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/crFn99iNFrk33n1npMGW81pMHBjB7zpmM/dt9Uwkpo=;
  b=A6UUAQK297f+G4J73EXMwPP3ssdFMuKS0KyEsPpiLFiZPa0LGQWUvIqG
   68Jlx+pBycmVwYyBQ8Asj8dXr6+0fp4roPzVpqPfr0I9W6MFY1XXwAxqr
   4GyvkivTa4AoSlM1sua4BbmacAEwKFZ9OmDcOQewYoek2zg4jqKJ6UKLd
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@mailo.com
X-IronPort-AV: E=Sophos;i="5.97,330,1669071600"; 
   d="scan'208";a="94405400"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2023 21:33:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2AB5EE0151; Sun, 26 Feb 2023 21:33:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2611DE00A1
	for <cocci@sympa.inria.fr>; Sun, 26 Feb 2023 21:22:55 +0100 (CET)
IronPort-SDR: 63fbbfa0_RSDXN6bGVfDzZJlKXOX8BT0yiPplzyAzF6bi8Sl6xLQB4Xx
 ooHZcNAxy5PtZyUvWfe4xGZxQn9/ibFC9aWQi+A==
X-IPAS-Result: =?us-ascii?q?A0EJAABlvvtjhw82ttVaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYIsgV4vBAtGjHKGXIIlA5EPgQqLLoF+DwEDAQ1EBAEBA?=
 =?us-ascii?q?wSEfgKFLwIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBA?=
 =?us-ascii?q?QIQAQEBARkJFwcQDgUihWgNgjcpAXWBCAEBAQEBAQEBAQEBAQEBAQEBAQEWA?=
 =?us-ascii?q?n45AQEdAQEBAQIBJxMGAQE3AQ8LGC4QRwYLCIJ+gwAjB6tbeIEBM4EBgggBA?=
 =?us-ascii?q?QadSYFeCYFAAYxlgmRpeicVBoINgRWBPIFuPoQLhniWLwqBNHSBIw6BQoEJA?=
 =?us-ascii?q?gkCEXGBFQhsggNHAg9GNwNEHUADCzs6PzUUIV6BHCQFAwsVKkcECDYFBhw0E?=
 =?us-ascii?q?QIIDxIPBiZEDkI3NBMGXAEpCw4RA0+BRwQvgWAGASgmmSVDexMUghyTAoNBj?=
 =?us-ascii?q?WOfW4QDoSkEqTQthyiQBKJpDRmFCIFiOoFcTSMVgyJPAxkPjiAZHoM7kAE8M?=
 =?us-ascii?q?TsCBwsBAQMJiHCCWQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:LL1udqsf0hbqwU2JGzQzhkZveufnVERaMUV32f8akzHdYApBsoF/q
 tZmKWjVM/rbYmf0KNxybdu2/BkP6sXTn4c3TVE5/CE3Fi0agMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCY0idfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbyRFtMpvlDs15K6p4GlC4ARkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJBxsYYsX4PpvOjxL1
 tAcAgoHQFOljtvjldpXSsE07igiBMzwM8ZD/HRpzDXeS/0hRPgvQY2QvIQehWdqwJ0SW6+DD
 yYaQWIHgBDobwdRElIeCZY52uyvgxETdhUJ9A7N+PJuvQA/yiRX9OH3D9DPQOCKasdewGKju
 m7f8XXmV0Ry2Nu3kmbbryLw2YcjhxjTXIsNHbm83uxrhVeJzyoSDgcXXB21u5GRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVYvGjiHufsVtAHd9ZEuk9rgqKz8I4/jp1GEBZFGJHZ8Y6rPRrQB8G0
 nWzlf2qIzVW5ej9pW2myp+Yqja7OC4wJGAEZDMZQQZt3+QPsL3fnTqTHoY4SvTdYsndQ22on
 G3iQD0W3u17sCId60ms1X79695GjqDAVA8ujuk8dj34tlokDGJJTydO7VWe4fsFApyQSFKM1
 EXoduCb9+9LUdeInS2JR6MGG7TBCxe53N/03w8H83oJrW3FF5ufkWZ4u20WyKBBbp9sRNMRS
 BWP0T69HbcKVJdQUYd5YpiqF+MhxrX6GNLuW5j8N4QRPcQqKlXbons3OSZ8OlwBdmBwzsnT3
 r/GKq6R4YoyV8yLMRLrF7xDgdfHOAhgnDm7qW/HI+SPiubAOS7JFt/pwXODZfo48K6A6B7c6
 Ms3Cid540g3bQEKWQGOqdR7BQlScxATXMmmw+QKKLLrClc4SQkJVaSLqZt/INMNokigvryVl
 p1LchQEkwWXaLyuAVniV02Pn5u1B8gg8CxrbHx8VbtqslB6CbuSAG4kX8NfVdEaGCZLlJaYl
 tFVJZ/SMecFUTnd5TUWYL/0qYEoJlzhhhuDM2DhKHIzdoJpDV6BsNL1XBrdxA9XBAqOtOw6v
 +KB0CHfSsE9XAhMNpvdR8+u6FKThkIjvtxOcXHGGfRpQ3W0wrNWc3TwqtQVP/AzLQ7yw2rG9
 gSOXjYdi+r/g64019jrmZG7q5yjArZ8FBACHk3wz7W/BQ/F9EWNnK5CV+epe2jGdWXWoa+NW
 8Rc/8veAtYmwmlYktNbPe5w7KQc49DPmedr/j58Fi+WU2XxW6JSHHaW+OJu6ItP/+Z9kimrU
 But/tJ6B+24CPn9GgRMGDt/P/Wx7tBKqDz89v9vHV7b4hVw97+5UUl/GRmApSheDbltOrMe3
 uYTl58K2jO7lyYVHI6KvgJM+0SIC04wYaEtm5UZIY3s0wQQ2g5jZ77YAXTI+52hUYhHHXQrB
 T62v5D8oYpg6HDMSFcNMETc/PF8gM0OsS9azVVZKFWunMHEt8AN3xZQ0GoWS11H/AQfi8Z2Y
 2hiCF1rAaCo4T1TpdNiWlq0EFprHyyp+U3WynoImlbGTkKuaHf/EW0lNcuJ/2Eb62h5fAUHz
 IqHyW3gbynmTPvx0gQ2R0Rhjf7pFv51ySHvh+GlGJ6jM6QhQD+4nJKrW3UEmyHnDew1mkfDg
 +tgp8R0SK/jMB8vs78JMJab2ZsQWSK7CjR7G985x5wwHEbYZD2W8hqNIRroespyetr7wXXhA
 Mlqfs9yRxCy0RiVlQ8iBIkOHe5QvOUo7988aL/UNTY4k7+AnAFI7rPU1AbD3VEOffs/v/o5G
 I3rcxC6LlexnlpRwm/Ek9lFMDG3YP4CfwzN49q2++QoSbMG6eFlTlEs9r6SoX+uERBG+iiMt
 1jpfJ7mzO1FyKVtkbDzE65FOR6GFNPrWMmM8yGxq95rb+6TAfzRtggQlEbrDz5WMZQVRd5zs
 7aH6/zz42/oo5c0VDr/t6SaNqwU+/i3YvVbAvj3IFZegyGGfs3muDkH2mKgLK12gMFv3damS
 yS4efmPW4YsAfkF/0Jsag9aDxo5IIb0ZP25pSqC8tK9OiJE2gnDdN6a5XvlaF9ATRAxOrr8N
 F7Ei677rJQQ5oFBHwQNCPxaEod1ag2rE7cvc9rq8yKUFC+0i1eFoaHvjgck9SqNMHSfDcLm+
 tjQc3ASrvhpVH3gl7m1crCevyH7yF54muZ1IgQY8t9yjHaxC2tuwSHx93kZIsk8r8Aw/MiQi
 PLxgK8KDCz8WTMCehL5iDgmdhnKHfQAY78VORRwl355qE6K6EeoBbJg8iAm6HBzEtcmICdLN
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:J+8LDa4JcZdwUd1hMQPXwPTXdLJyesId70hD6qm+c31om+ij5q
 eTdZUgpHvJYVMqM03I9urtBEDtexzhHNtOkO8s1NSZLWzbUQmTXeJfBOLZqlWLJ8S9zJ8+6U
 4KSchD4bPLY2RSvILXyE2RD8sgqePrzJyV
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,330,1669071600"; 
   d="scan'208";a="94405016"
X-MGA-submission: =?us-ascii?q?MDGNkSlrYEcXYT3sDKsPvpy/2zKSpAN7h76bgQ?=
 =?us-ascii?q?wCR/TyCosK2Lpp1qC5aXrMYTzeAZdCJVWzp8bMy1/NYT6nSx+XVkXU2c?=
 =?us-ascii?q?A6RBWsN9owLJbXrd+cEw2mfw3MenhI3FKAlzwGigBWbmT1/0hfgKh1Cj?=
 =?us-ascii?q?viTwlzt4Lf1Rxm1OEhE61kIw=3D=3D?=
Received: from msg-4.mailo.com ([213.182.54.15])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 21:22:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
	t=1677442974; bh=FRkGvJDmaEz0swKnwZzPE0L9HyhTVuotpdyes0dJpOM=;
	h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To;
	b=jqw+0L6varzZLT18Aylj+/ynQKFNmxTlAHp8XSG3in1t/wYA6y2GZhz83ApBFdnPg
	 DKA6Z8JCYhcPNoEY5VHhbz7ESqbGEFIJyM6fY7w914G/GmXeAfhk/xJZ/q25BYcPlL
	 kNIIsmZiISvER+/bs9FZcWng56EeqcG3XMnavuLo=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
	via ip-206.mailobj.net [213.182.55.206]
	Sun, 26 Feb 2023 21:22:54 +0100 (CET)
X-EA-Auth: TAIhNcv5bfuO/MsWc1+6zY1h5Un2D9etJ70zxWicPeOZiIPqBBoL5iUIxv+so2EeDpR4HrVZUDaPoN3Gbbke0SdwJA6tU8Fz
Date: Mon, 27 Feb 2023 01:52:49 +0530
From: Deepak R Varma <drv@mailo.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: nicolas palix <nicolas.palix@imag.fr>, cocci <cocci@inria.fr>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Praveen Kumar <kumarpraveen@linux.microsoft.com>,
	Deepak R Varma <drv@mailo.com>
Message-ID: <Y/u/mV6GUC5+l3m6@ubun2204.myguest.virtualbox.org>
References: <Y+/DQ6l0pDcxC2c3@ubun2204.myguest.virtualbox.org>
 <597798313.18813704.1677352621708.JavaMail.zimbra@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597798313.18813704.1677352621708.JavaMail.zimbra@inria.fr>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: put_device: Include of_node_put to
 avoid false positives
Reply-To: Deepak R Varma <drv@mailo.com>
X-Loop: cocci@inria.fr
X-Sequence: 866
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-02/Y%2Fu%2FmV6GUC5%2Bl3m6%40ubun2204.myguest.virtualbox.org>

On Sat, Feb 25, 2023 at 08:17:01PM +0100, Julia Lawall wrote:
> > The node reference increased by of_find_device_by_node() can also be
> > released by using a call to of_node_put(). Hence when this exists, the
> > script should not trigger a warning, which otherwise will be a false
> > positive.
> 
> Could you explain more about why of_node_put is sufficient?

You are right. In fact, I think calling of_node_put() for a prior
of_find_device_by_node() is buggy as a call to of_find_device_by_node()
increments the kref for the device embedding the node and not the kref of the
node. Hence a call to put_device() is required to decrement the device kref.
Calling the of_node_put() attempts to decrement the kref of the node, which I
think is not correct.

May I request any comment on my understanding?

Thank you,
deepak.

> 
> thanks,
> julia
> 
> > Also, improve the warning message to include of_node_put too is missing.
> > 
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> > scripts/coccinelle/free/put_device.cocci | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/coccinelle/free/put_device.cocci
> > b/scripts/coccinelle/free/put_device.cocci
> > index f09f1e79bfa6..259195b501aa 100644
> > --- a/scripts/coccinelle/free/put_device.cocci
> > +++ b/scripts/coccinelle/free/put_device.cocci
> > @@ -18,8 +18,10 @@ type T,T1,T2,T3;
> > 
> > id = of_find_device_by_node@p1(x)
> > ... when != e = id
> > +    when != of_node_put(x)
> > if (id == NULL || ...) { ... return ...; }
> > ... when != put_device(&id->dev)
> > +    when != of_node_put(x)
> >     when != platform_device_put(id)
> >     when != if (id) { ... put_device(&id->dev) ... }
> >     when != e1 = (T)id
> > @@ -42,7 +44,7 @@ p2 << search.p2;
> > @@
> > 
> > coccilib.report.print_report(p2[0],
> > -                             "ERROR: missing put_device; call
> > of_find_device_by_node on line "
> > +                             "ERROR: missing put_device or of_node_put; call
> > of_find_device_by_node on line "
> >                              + p1[0].line
> >                              + ", but without a corresponding object release within this function.")
> > 
> > --
> > 2.34.1


