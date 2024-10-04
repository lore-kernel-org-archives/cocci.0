Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5476BCFA74C
	for <cocci@archiver.kernel.org>; Fri,  4 Oct 2024 07:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=I+g3k1LDrBFuIHfv//C/9Lzybu9R4yvEHlNDT3V4Kig=;
  b=L95YsMYMyms9BBpF9Y1yrKLDO5/vh+a5HF0V3v3Zbukw7BQQnCbHPORS
   8MpLuIQ5v90KWWg4NAo8ENk7aIlpq586vgDFY8KbPciuTs5oJPoVJNw2V
   8Ucny/dEDeWKXrhzW45cSnqPWIGLRcS+75SUkPtwk3BKXirdxXpzMA9Au
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.11,177,1725314400"; 
   d="scan'208";a="186921362"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Oct 2024 09:24:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E9C9DE0145; Fri,  4 Oct 2024 09:24:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DE2F4E0141
	for <cocci@sympa.inria.fr>; Fri,  4 Oct 2024 09:24:09 +0200 (CEST)
IronPort-SDR: 66ff9819_ESf1MU9sncrT7lRkJfqXnk58Z6BRk5JnD+ZCj/W0zeyL312
 0+0b4vTlSuEsMMyVRHn834JhoeKy42eP1IP5OHg==
X-IPAS-Result: =?us-ascii?q?A0E6AAATl/9m/wsR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE9AwEBAQELAYJDB1sbWjMEC0iEVo9NgXUtA4Q7k32ECIFWF?=
 =?us-ascii?q?IEsPg8BAwENOQgBAgQBAQMEOIFUgWCBFAKKGAIeBwEEMgcOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQgBAQUBAQECAQECBAYBAoEKCAuFNUYNgmMBEIEUgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEXAg06RAEBAQIBIx0BAREbCwEECwkCGgIfBwICVgYBEgIBA?=
 =?us-ascii?q?YJ9AYIvAQMOIwcNlGWcQ4EygQGCDAEBBtpbHywiV4FjAwaBGi4BiEoBhWc7g?=
 =?us-ascii?q?0J6Jw+BVUSBPAuCRzE+gmEBA4EpARIBIYNbgmmHb4QqhG1pBAQBFYQkVw+CW?=
 =?us-ascii?q?IQMJYEjEIcpcJIPUnscA1khEwFVExcLCQWJOAqBeX0FIQQlgUUmgSCCdQiBK?=
 =?us-ascii?q?xOBBgKCV4FnCWGEO4I8cGKBDYE+gVkBRYEXgVwvGyQLXoFDfx0WBhUEgSUFO?=
 =?us-ascii?q?Ao/glFrTjkCDQI3gigkaoJagScEBYNrgXodQAIBC209NQYDCxsGPax4gVsBR?=
 =?us-ascii?q?4INgS4aPgEvcSUSDh0wNpMJsj80B4I3gWSBYwyKJ5UrBhMvhAWTOg4GizaHQ?=
 =?us-ascii?q?S6HY5BlIoI0iyWVb4UzgW4JLQ1ccDMaJE+CZ1ILDg+OITiDdYRhiioBsShBN?=
 =?us-ascii?q?QI5AgcBCgEBAwmFRgEBhmmBSwEB?=
IronPort-PHdr: A9a23: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
 0BpZm+seg==
IronPort-Data: A9a23:Rhw/9KOiJnABHwrvrR2ylsFynXyQoLVcMsEvi/4bfWQNrUp03mMOm
 2EfDGGAOvqDMDT3fNEgb4i19BhQusSAzIUwQHM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQbNNwJcaDpOt/vb8E835ZwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXaaSrh4ttzN30xMNdEyslNGmpSr
 /4xfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8mcBfyTjTNb9G9YasRmOP/EZ
 NcCLxdrYg7BZRJnJVodTp4z9AutriCvLWwC8QnO/8Lb5UDPixF76oDMc+Dnf42qG5RttEmHu
 lz/qjGR7hYycYb3JSC+2nmrjeTOtTjqXZobUry+7P9jxlOJrlH/EzUTUkan5+a0gAiyVrqzN
 nApx8bnloBqnGTDczU3d0TQTNOs53bwh/I4/ywGBACxJm785gGEGi4bQzQHZNFOWArag9A1/
 gfhoj8rLWUHXH6ppba16bqe6z+/UcTQBXFXfjcKFGPp/PG6yLzeTXvzohJLD6O/yNH4cd01L
 /ZmswBm74guYQU3O2lXMLwJb/9AZnQEc+Lt2jjqYw==
IronPort-HdrOrdr: A9a23:XcbAZKF20CZi8UiUpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AXkHlHmt6FPjO8jzTmC5nQhr36Is5aCzQ7VnNGHO?=
 =?us-ascii?q?/BDw1eJKvUlSMoqFNxp8=3D?=
X-Talos-MUID: 9a23:hz1GiQlz5CkqpuwfgUwjdnp+c9pi2ZyPS3o/lMQm5Zi8HyNvJwmk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,177,1725314400"; 
   d="scan'208";a="186921332"
X-MGA-submission: =?us-ascii?q?MDFFkdrViuWDfg2mDFTUas3zYrzUd4sJXKjn5y?=
 =?us-ascii?q?5PSGlEYkLOe46P4rolPdDf5D9brvesD+TbzzY4A5JiCnhqmEk/6o7meJ?=
 =?us-ascii?q?zgDTUjY9DXVvhMZthc4BdkrGH5/dVubPZQ+UyFzr42QtGpow7AJy4ef4?=
 =?us-ascii?q?r0/l6XOBWTEFg6G2PjntgRSQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 09:24:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728026634; x=1728631434; i=markus.elfring@web.de;
	bh=I+g3k1LDrBFuIHfv//C/9Lzybu9R4yvEHlNDT3V4Kig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MdHuP54lv3a+OhlbtVKyguI622KLMrLcXACTk3I5ImxNCgpn7C/+ClWWa4lXLCfm
	 DS+ixFnFvgC6VkWYDJNLfdnlcIHZQY7aLSe+1Zx7M2Mvk1x0D0yJSpzOfommg2fk5
	 Xv5fuaKn1nkndHVhrYw8Y5ZJGK4Y9ao6eOWmM3hptIZSgdfu94Mtu7NcKNAW2cgCD
	 f7DMm51IbkBYh8KhohJ9ge9O1U68qa31Ud8HQp1FHTASnMm6wbc6Qgcs5MjPZtEY+
	 LGwF1e0zhc8dNpoM/vMUDXR0iZe1rRviNZrqhdacNDX1vgh0fXnmZeTf6YUWpOsHT
	 kAGgnpxzHB6e2EueYg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBRn-1sHV9w3j41-00hh4H; Fri, 04
 Oct 2024 09:23:53 +0200
Message-ID: <6d4240ab-b432-4753-bb6e-de0697f8db69@web.de>
Date: Fri, 4 Oct 2024 09:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de> <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de> <87v8iz75ck.fsf@linux.ibm.com>
 <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de> <87pm9377qt.fsf@linux.ibm.com>
 <afb528f2-5960-d107-c3ba-42a3356ffc65@web.de>
 <d4bcde15-b4f1-0e98-9072-3153d1bd21bc@web.de>
 <8949eefb-30d3-3c51-4f03-4a3c6f1b15dc@web.de>
 <434320e1-2a30-4362-9212-ca17cdde8b31@web.de>
 <9dfb5d24-f05c-4a67-b86c-7f157f633fb9@csgroup.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9dfb5d24-f05c-4a67-b86c-7f157f633fb9@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cOf4DD9kuzKnBYdmw6NcXUSvbOP9sAzC9p5qTgB+bGyU7sJcs63
 QiMSjOujc9hiccxuIXqHaRZLnUJsdU6ykSuv5ytZ74uWVnAwPLBYyOJj343c2VT8S9Y0Boy
 XMoKO/CvstmKZrD+uYN54Gmjsaz8CDNnDLudkSsQM48q6FB0olfOotKL0kJ4ATs/IEkIw2o
 VX191Yqz9Pq2ESV7BohcA==
UI-OutboundReport: notjunk:1;M01:P0:xq5kUmhz/C0=;EHOq5dN2pU7VW7prVUe4HmKd3Cq
 WLbiil794B2VtL6Mj2+aYkkps5TLz5oe9JuvauRVC7zo6qYK1hV9ewjbsWOG5b/71DpyvyEQZ
 mxBuM3EVRmETUQA0s5kbw0ZQDAiuc9UsFZDdeuhgBrXvvsqHEGd+bp4kfYFo9NUFbDSomgmxY
 iRrzj0NtmeK/RDAt5RTzbjluRTs9p07JbKDlZnNIDSxF3iOoWQBtf9pE5CA8plRhd/7hArg8T
 z1j/i7tAxmG7bphOpkGUNNBKdpN2L+7J20HqKyWViEA2gBmFE4CgfiLck9oXGiHKpTnzBNVd4
 T84cR/1xcTKFSre4h2XsGc7Ydlrff2HGkHP0BYF5FlkzBbpa66o1lz8RYL9gxeESqrydxu/zn
 l+UJOLSsh5p4CwV6SE4oaGKvDu1bBmqEiavyk9SFhyTmSdbQOLkOOMHCvLPLeA+Mz49SHVIHH
 WLSJwZiq/5yUTkWGRGGVF7XTqRY8E6jy5/w2kp9OEgml6qocLQrSfzQFddhvw0FRNZOFU2rA3
 kbUwf1B7V/+eUOWUz7Hi6gDtJ5NDSYWPCIuX8K+See+yELI6IgIXfsuZhI6i/W4VWkUejq9VO
 ZA3uB0yZcoY6lrKl7IbAk5XU/mCFgxoLp7HchSXaYP01Tpjsz0zoAYCLSrQr4IjNWLfVlnUfa
 SUk7aMQP80QMm9PsMe4WekAVGp7K/KhEbiprpwK1kUAdMJyq8igQZYtf+y1KVpHXCdKvCtjCw
 nvR7ys0XpEkE+BcJzhi3pe9+Hw24QUK3l+JMU90GNbPgOt/OjnUbDRrZcfrL3VJXktIIyTKIH
 5XUwx5vxocfmzbbHfssHf65g==
Subject: Re: [cocci] [v2 1/2] powerpc/pseries: Do not pass an error pointer
 to of_node_put() in pSeries_reconfig_add_node()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1908
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/6d4240ab-b432-4753-bb6e-de0697f8db69%40web.de>

>> I was notified also about the following adjustment.
>>
>> =E2=80=A6
>> =C2=A0 * linuxppc-dev: [resent,v2,1/2] powerpc/pseries: Do not pass an =
error pointer to of_node_put() in pSeries_reconfig_add_node()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - https://eur01.safelinks.protection.out=
look.com/?url=3Dhttp%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Flinuxppc-dev=
%2Fpatch%2Ff5ac19db-c7d5-9a94-aa37-9bb448fe665f%40web.de%2F&data=3D05%7C02=
%7Cchristophe.leroy%40csgroup.eu%7Cab19d1c85de343f5474908dce3cd8c02%7C8b87=
af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638635719164841772%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C0%7C%7C%7C&sdata=3D8b7APXbglDf13PvZ4nVh5Z92bEft2RBqU3LfKsUETOI%3D&reser=
ved=3D0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - for: Linux PPC development
>> =C2=A0=C2=A0=C2=A0=C2=A0 was: New
>> =C2=A0=C2=A0=C2=A0=C2=A0 now: Changes Requested
>> =E2=80=A6
>>
>> It seems that I can not see so far why this status update happened
>> for any reasons.
>> Will further clarifications become helpful here?
>
> Sorry I forgot to send the email. It is the same kind of problem as the =
other series: Message IDs and/or In-Reply-To headers are messed up

Three mailing list archive interfaces can present a mostly consistent view=
 for
the involved message threads, can't they?


> and b4 ends up applying an unrelated patch instead of applying the serie=
s as you can see below:
>
> $ b4 shazam f5ac19db-c7d5-9a94-aa37-9bb448fe665f@web.de
=E2=80=A6

This development tool is also still evolving.
Are you looking for corresponding software extensions?
https://b4.docs.kernel.org/en/latest/#getting-help

How do you think about to start with the desired cover letter from the pro=
vided patch series
for another integration attempt?

Regards,
Markus
