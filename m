Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3043C197A0
	for <cocci@archiver.kernel.org>; Thu, 16 Nov 2023 20:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KSYRmD06Nco9jPcae9/OfOPbWTiNcnWlkgJ2jZ3T8lQ=;
  b=PrIT+HPuLGHmFnwBbkdppe+xoCJNiSsRZZiriBJz6LKwsDkw9neSr5C/
   xRx3n+nA5vF79LFGhy/CSKJ7UngIVyddtVP7m4BMtQEHrQJEmECByn6fL
   a3AxSkZFLEN6zqk0D2U0iVlDOmG6gfdyjKCjtD2rAtaUO5+8zU5+bNYqw
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,205,1695679200"; 
   d="scan'208";a="136846719"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2023 21:24:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 930F3E0145; Thu, 16 Nov 2023 21:24:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 79DFDE0133
	for <cocci@sympa.inria.fr>; Thu, 16 Nov 2023 21:24:56 +0100 (CET)
IronPort-SDR: 65567a97_+LjOtmINGmsjdWIGnAP3aMfF0iWbteD0BUqWUdWTQOa9gGh
 h4RxIUMQ8FIKElgOvhiLDDuSDR+dnPHauJUBEPg==
X-IPAS-Result: =?us-ascii?q?A0G4AwBIeVZlhw4P49RaHgEBCxIMQIFEC4I5gVAwBAtIh?=
 =?us-ascii?q?FOPPYIlhDuHNIdKiG+DFj4PAQMBDUEBAgQBAQMEOIFTgnQChykCHgcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDhAnhWgNg?=
 =?us-ascii?q?lwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQICASMEGQEBESYBBAsLG?=
 =?us-ascii?q?gImAgJXBgEUAQGCfIIqAQMOIwesc38zgQGCCQEBBq9VHywiVYFfCYEaLogNA?=
 =?us-ascii?q?YVZgzt6Jw+BVUSBPIEUgTcHMT6EQ4NbgmiDbYU4B4JVg1KOJl0iBUJwGwMHA?=
 =?us-ascii?q?38PKwcEMBsHBgkUGBUjBlEEKCQJExI+BIMuCoECPw8OEYI9IgIHNjYZSIJbF?=
 =?us-ascii?q?Qw0BEZ2ECoEFBeBEwRqGxUeNxESFw0DCHQdAhEjPAMFAwQzChINCyEFVgNFB?=
 =?us-ascii?q?kkLAwIaBQMDBIE2BQ0eAhAaBg0nAwMTTQIQFAM7AwMGAwsxAzBVRAxQA24fN?=
 =?us-ascii?q?gk8DwwfAhseDSclAjJCAxEFEgIWAyQZBDgRCQstAzEGDwQOAxkrHUACAQttP?=
 =?us-ascii?q?TUGAwsbBj4CJ6QEG5VZgyiPZ4oslDY0B4IxgV+BXwyfIwYTL5ciDgaSTy6YE?=
 =?us-ascii?q?iCoNIF5JIFcMxokT4JnTwMZD44gGYQSj0dANTsCBwEKAQEDCYVGAQGDWoFAA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:39p4palYbnJltUQFV/ni2d1bjszpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:hDwcLGEQNR7vMMIEqmI+xGIbF+oKdUH21VeXfAjmVXY5E7uKHAo=
X-Talos-MUID: 9a23:dM1ZzgYTV699g+BT6G7Tjzt4C+xUuuexOnkHmrMrn8+kKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,205,1695679200"; 
   d="scan'208";a="71719712"
X-MGA-submission: =?us-ascii?q?MDGj8uVpOk2Yi9w1hme48vALsLN7VBupRmpPQA?=
 =?us-ascii?q?RlScp5fsz6fsKLa0to0TeXZxciv/nE8iMasKTXvVjGshu2iC3MW1A8gk?=
 =?us-ascii?q?9dLiU6T1VYRYMNZMxt/IgKs+1kJrpFnJiSf4/+BSdDjx6ZnEx1gY67lH?=
 =?us-ascii?q?qO6nwckvpjINJ8Ugiul+Iqlw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 21:24:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700166287; x=1700771087; i=markus.elfring@web.de;
	bh=bMIHg3ng5KpBsFUPYXabL+iRStRao71P9CiqdQ1Rh04=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Tf25lBEF3cfVAGakvgsCXjsaRCNAGPbuTpwCN/7hXT3kDMm3PVKzUjRVkS7IhS8J
	 2nxl2ugHjXXtNB/rsOxhBdoXZ5FNwS0I5hgC/ss2ydSfquWJI5wLZqfHRJULeceH8
	 aOjGcRXQse9opN4SSCDGsgEtsf6i/BQfQcEsmFRjVj4GfEsmhYDPmV5W2ARx8TBou
	 A9KSqWchYUBwi6X0JWDysSs9FsDv/xQbjthCFOWmu+rrwywy9rIHGElcyhpOn6b15
	 xafyG0aVx4tLN43/wxXZv4TUQ1U+1SsHxa4n5JZsN7HD8/y5OpBAkLCf/UcrF06fs
	 2QTrGt+/VPsT00061A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTvvy-1quGkf27cY-00R9fk; Thu, 16
 Nov 2023 21:24:47 +0100
Message-ID: <35a52379-5b97-46d4-be0f-1eca6d780a40@web.de>
Date: Thu, 16 Nov 2023 21:24:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Justin Chen <justin.chen@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Wojciech Drewek
 <wojciech.drewek@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr, Simon Horman <horms@kernel.org>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
 <20231106145806.669875f4@kernel.org>
 <dce77105-47ab-4ec7-8d46-b983c630dad8@web.de>
 <CALSSxFYRgPwEq+QhCOYPqrtae8RvL=jTOcz4mk3vbe+Fc0QwbQ@mail.gmail.com>
 <4053e838-e5cf-4450-8067-21bdec989d1b@broadcom.com>
 <38279cb8-ff60-427e-ae9f-5f973955ffa6@web.de>
 <CALSSxFYBhv==pJTme0FThxP9JBJszsj1v4G2s-HGzkaevbyvBA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CALSSxFYBhv==pJTme0FThxP9JBJszsj1v4G2s-HGzkaevbyvBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OIrOzr2zLfCRBOWIhQDkoUbk+8mTHFjp4JI5w2O+y8lMchJi4zR
 B87iRZrxV12DjNwGuQclyM0vTDc3Zru04L/rLTyiXZbYfVdaHUydVKTqvT5BFtO3DJn+tkU
 nskTWsmgVIbdmu3BSqPbKLWRdklp5cg03fmcQcJ/0YursqXGt3+Xx9ASV0eppbCRIhMGhqQ
 0S+rgQwV75GIT7OBWmTUA==
UI-OutboundReport: notjunk:1;M01:P0:D3poQ9YnxXs=;p0nk9N6WT8E78LvSQ+rgoMR7w7t
 iSzHmeCenjnd935HxWsY4EqFNWT5SGOjfGtTenGc4De/30U+HbKtpBpFE5wrGpAb1RxugEqOM
 9D5utGHxkvXQxZMw6tMcfRxbbJRgOpom7FIbunoYUgpESgyw7fYUud0x/kz4Yr8qtpfilazp6
 QgCygDjMnI+IuxILUJbS7BZahWZsarylf3W7lJOT1NOHcKiymm9xXtJs7WCvh5c0c5hX02ikO
 4oXVKv9jKX90FUsXpJdGJyBYl0vjgjCOUSf20/SttdZYSxeVOgRNONByVBXGKDEqo98VXAP49
 0d+ykKMLsXTVE/0rrAWPOkB2xkpF3xUJ3DrT4EcPFqFxhCvobZ6kQiYHk06y1lvsai5l18kKE
 jNOpFC3cXyLrU6LiBEnt1Dz1hAZCD4hP+ExQDbEmb+vR7CK4P6NwTTSSCtCIEfu9tBuNy9TEN
 N56Y2MKySuk9z1U1o9Mz9S2l2rlI1qAeGyI9O2zhS/8lp3G7aMgSyOOjDM1BaRUticEc3GY3q
 RoS/wjePfhTN7P+dsp3hmYy3GsOmmZnEEwxbJ+xo1obhjs2DFk3oEdJiIjcv8KKiLkAw/mYi5
 wzfoXcZeq5pkqPJTnQiUxTOnOex9iykLov7kYM/fX+uXVUL+nlSJd37Y4t9NJ9dUKofrNtGxd
 snoPnJgDMq6OjpiMEK8MZcTCK7k7gx4xl/xZL9pJhYLcaziSk5AJZ3SxJQ5j6D0u9tN8e5T2Z
 vHiqncujIB2v0ziQryInspjNIKjndVKd/eIGB1XkNyNtR2ubw12ejyyD6vDK15e056MUP3UfI
 l9fFH1mt04V4XupBFXDYrKwpFmAZ7uFr6hcJjMP4ji6SZJicrEtqubHs/4YPs9RrS2G7oLEvQ
 9VQiS04pqjlNr+SsOtdyqOd/Jnu38FJOcgmhGRiSHpIAxLbBJRlA8AtEMPu3U7bXQoMbcFTJE
 8WIOKQ==
Subject: Re: [cocci] [PATCH v2] net: bcmasp: Use common error handling code
 in bcmasp_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1296
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/35a52379-5b97-46d4-be0f-1eca6d780a40%40web.de>

>> Add a jump target so that a bit of exception handling can be better reu=
sed
>> in this function implementation.
=E2=80=A6
>> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
>> @@ -1304,9 +1304,8 @@ static int bcmasp_probe(struct platform_device *p=
dev)
>>                 intf =3D bcmasp_interface_create(priv, intf_node, i);
>>                 if (!intf) {
>>                         dev_err(dev, "Cannot create eth interface %d\n"=
, i);
>> -                       bcmasp_remove_intfs(priv);
>>                         of_node_put(intf_node);
>> -                       goto of_put_exit;
>> +                       goto remove_intfs;
>>                 }
>>                 list_add_tail(&intf->list, &priv->intfs);
>>                 i++;
>> @@ -1331,6 +1330,7 @@ static int bcmasp_probe(struct platform_device *p=
dev)
>>                         netdev_err(intf->ndev,
>>                                    "failed to register net_device: %d\n=
", ret);
>>                         priv->destroy_wol(priv);
>> +remove_intfs:
>>                         bcmasp_remove_intfs(priv);
>>                         goto of_put_exit;
>>                 }
>> --
>> 2.42.1
>>
> nak. Doesn't save any lines of code.

Would you get into the mood to take also another look at consequences for =
executable code?


> Doesn't make things clearer or easier to follow.

Maybe.


> This doesn't seem like an improvement to me.

Can this software implementation benefit from one function call less?

Regards,
Markus
