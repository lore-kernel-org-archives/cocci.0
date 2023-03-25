Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5152EC6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=G9pfiYCFnZZ6i79pfNzxEMWFp3Oa98X2buzk8+kObpY=;
  b=gA+3Cibujk3+2+sVk03DBFAhYbZcr0pNTAiPL7yZ/qmQ3uoQCt1k/Z9C
   7JXxobYP9eAhVXCBbVsfb4S0mjsrfrWcANVbmIUmbj0M/r98L651BzkJg
   csEZ120NxiYduPU2z4GVByq4aMUBiMY17nAwumdJo0arOUg/KFplPaejR
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99060990"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 13:50:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 53F62E0D41; Sat, 25 Mar 2023 13:50:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1B6CCE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 13:50:44 +0100 (CET)
IronPort-SDR: 641eee25_HmxhNEBRiOR6mAezCweVxRNPmV4Zk1qQakGeiJu6Qb20sRI
 HJH9R30TbPMQNn4sKzIweuHBAyysKewmUnAfuUA==
X-IPAS-Result: =?us-ascii?q?A0HKAABf7R5khwsR49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YItdVYvBAtGhFORAS4DaYNGl0+DFj4PAQMBDT0EAQIEAQEDAwGEfgKFOgIdB?=
 =?us-ascii?q?wEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXB?=
 =?us-ascii?q?w4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAg06GDs9AQICASMEGQEBESYBDwkCGgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJ6AYInAQMOIwcMBpUcnBd/M4EBgggBAQaBQAEDAgwCQ5lzHywiU4FeAwaBF?=
 =?us-ascii?q?C0BjQSDNnonD4FVRIEVJwyCdz6CSxcDARiBRoNYgmeCKIdWhCiLLAqBNHWBI?=
 =?us-ascii?q?A6BPYEEAgkCEWuBEghrgX1AAg1kCw5vgUoCZEyBHiUEDgMZKx1AAgELOzo/N?=
 =?us-ascii?q?QYDCyAGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SDwYmRA5CNzQTBlwBKQsOE?=
 =?us-ascii?q?QNQgUcEL1uBAQYBJiSacgOCZ4E3AkaBbJJTHQqDGY8dihaTeDQHgiiBVYFZD?=
 =?us-ascii?q?IoMlQAGEy6XCA4GkiMulzwgi0OBb5pIgXkkgVwzGiSDNk8DGQ+OIBmEDIELg?=
 =?us-ascii?q?1aKZkA0AgEBNwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 bIRR7UdWFFnTpsn
IronPort-Data: A9a23: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
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:uYTCFK5fIEMOqagudwPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99060987"
X-MGA-submission: =?us-ascii?q?MDFA/+SaXLe/XjsMdFMwNpS3PhByQoC0qcclml?=
 =?us-ascii?q?ilMjSvnHdqshv7xVhFgUCqUi0J4K7SUCZwCxkppK79qsdC7GFcl1WmlO?=
 =?us-ascii?q?begwP+UnNmtGIePQ+B3P3OgZ/zAcagj1IMtgCdRBQ7FIV2ZbSdd+X//M?=
 =?us-ascii?q?6rTEWiYbbf26wiLGaVXb7TlQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 13:50:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679748642; i=markus.elfring@web.de;
	bh=G9pfiYCFnZZ6i79pfNzxEMWFp3Oa98X2buzk8+kObpY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IIKbV8YMCmPy8O9A8IP3TxP/zEkys5xrPyqZ/KlyArbwlGyjtpUBlQHxou+o7scMT
	 KS0fDfABH/vybx65VqrIbw/0WDhUZ/insxh6+UPeyTXM/j2u1KxW6shOnUyzuRf8yA
	 u2MUk08aPt4Aejp01nx4FkvT6+Py0CyJRJ6f8yvVBvsYltR7GAcXQ5aTFbts+Ibi0k
	 gaQLT3rTnb2VoV+wiL5c7jTnUqxfHz1YEQ7Z1WIVr1E9JCfii5zWYwZQT1MzexTK5S
	 fbBBwDVZkm3gEvDDMdaQFipM3JHseREUHrkDp1c+9ZUs1P3JDL1+iY86mZBSguSkGE
	 mJNzeNgLS1h2A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzit-1pxrM3058z-00HlD4; Sat, 25
 Mar 2023 13:50:42 +0100
Message-ID: <5173d68f-7903-fed8-4770-e774a863d426@web.de>
Date: Sat, 25 Mar 2023 13:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Kent Overstreet <kent.overstreet@gmail.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e33f264a-7ee9-4ebc-d58e-bbb7fd567198@web.de>
 <d0381c8e-7302-b0ed-cf69-cbc8c3618106@web.de>
 <157b8db9-82f7-85e7-3bbd-7ef3a1797892@suse.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <157b8db9-82f7-85e7-3bbd-7ef3a1797892@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bmC2KFwp4WhE0v5RDLY0u+UxucFqqZJ1Pnw6+edWNICtiKGXhN3
 PpOl2vVRvhehV2N3kA+oDz9xkBl633mHdscgr+vTiCcrtA9e2bV1+nT9evy1RNg061C3sei
 uex4IM8EX+5N8nNy7ujVQoS6GOOIMlbmSFQ0jWOs2ELYEQzlgiXf17SwaY7WIKkaBVO8RE+
 IdWMnlBjETGse18AMYgsg==
UI-OutboundReport: notjunk:1;M01:P0:8TufPS26cwo=;SrYdnP68kbrzzjyPsoERsrJ6Lnp
 R8pngmGBu2TSRZlHi87jzy51rwB7lJ8/GOqqALJuylz3Dv3pvoayRM0xIQsb2/lK/hP/Gq2cu
 SFDNJWu5vZZ6rA35iomfFU9vO2PxKragMVIVJE9WL7Y19xTV1jm7EHSi9F05rElHhoWmpK2rk
 oFvH8O83GOLI5xVlXcvGqM9GFz//Kau7E1QRPoY867DR3PUSUh5lTvdSgvwgxkqRxuiPPfAlb
 3o47wwSbDybWZBqkXqB0N+0hvizsNAqPJSKN5zemblwN06hLLp7Z5/TPI7qu5zigxzCZJ4LL9
 GjnyqHgqX8MYqMsZxtb+oL+eBD5mx+4ATA8PHofIfExv2YEtRNjyGNSHrj+Vp/RdIG06sCD79
 hoEUYDSYrYI0Nxt1aHfX8Ejy6J/wHLGfbjnHZ9nHQTwLeGmyZ9OmviL6blKfk4/D8B1dzXyRb
 7Od4R2sLPIGHDWVRootET9yCeQFIGwC8hTyigf9plVPPPNH4IhxeMhNyQ0sZVeamdRJhvfyzH
 c/b8bZbgJnwo2IajhswjlWH7aT1s56bkxWTf8sHOfVnc29SYAAQholCELXTngCqPkoKcIiVwu
 JEsZiXXGhDJIUjcXK+du/kLxt4Xr/jNoF2jaLyPUSh7txMfXwsD0bc+MtrCaOOIpTGJ7qz/Df
 BNbF3CO2TsgFt2bJ3PBefhh1bBGBRP4sa+Z8Up9GyvlWSni7lJCxfy9RMZXO8Sc+nYoGTYRHM
 +PGlUTm9wKNt4wvIqo95p/P54cZ+BNphqI59WEAJpHtkvOWupU+30kEt4saARSBGKQcgcTMwY
 8DsROqIClqB/msYasBhjmziRB/rwq4hFMst/8jz1yp5BhB0aB+riTJskYOXkDL0Vg8VY9sTRp
 kjA+51V3vRnfDBRgflZlUn4mobzqIZ+or++kMB4MC7SsPfZ7ACfhOjA3c
Subject: Re: [cocci] [PATCH resent] bcache: Fix exception handling in
 mca_alloc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 942
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/5173d68f-7903-fed8-4770-e774a863d426%40web.de>

>> The label =E2=80=9Cerr=E2=80=9D was used to jump to another pointer che=
ck despite of
>> the detail in the implementation of the function =E2=80=9Cmca_alloc=E2=
=80=9D
>> that it was determined already that a corresponding variable contained
>> a null pointer because of a failed function call =E2=80=9Cmca_bucket_al=
loc=E2=80=9D.
>
> Hmm, I don't get the exact point from the above long sentence.

Would you find another description variant helpful for the understanding
of an applied source code search pattern?

Reconsidering repeated pointer checks with SmPL
https://lore.kernel.org/cocci/f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00017.html


>> * Thus use a more appropriate label instead.
>
> So far I am not convinced the modified label is more appropriate.

Can the usage of specific goto targets become more appealing?


>> * Delete a redundant check.
>
> Where is the location of the redundant check?

I propose to avoid the repetition of a pointer check at this place:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/md/bcache/btree.c?h=3Dv6.3-rc3#n959


>> @@ -955,9 +955,8 @@ static struct btree *mca_alloc(struct cache_set *c,=
 struct btree_op *op,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &b->c->expensive=
_debug_checks);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return b;
>> -err:
>> -=C2=A0=C2=A0=C2=A0 if (b)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rw_unlock(true, b);
>> +unlock:
>> +=C2=A0=C2=A0=C2=A0 rw_unlock(true, b);
>
> If b is NULL, is it a bit fishing to send the NULL pointer into rw_unloc=
k() ?

Thanks for your reminder.

I accordingly sent the next patch version a moment ago.
https://lore.kernel.org/cocci/13b4a57a-5911-16db-2b6e-588e5137c3aa@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00068.html

Regards,
Markus
