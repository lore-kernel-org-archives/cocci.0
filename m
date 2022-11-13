Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE95C433FE
	for <cocci@archiver.kernel.org>; Sun, 13 Nov 2022 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vKa38FagOskgD52c0ZK0T5mT3Xi1BBJ/g0VE5/EslAc=;
  b=lGvDAVXL2PLlodKauQZ2v5WFX9MVrvIiOtdNP0k6TRgt0KgA+a3/jN5B
   K//xAautnPDyDbMSu6c+i0AflPVzaUgfXy9Xm1EOTy2ACezyqsOCITMcy
   UPEOz4zXV3XobqBaFWE3qmIpCJ8K8THU5+rkKY5yeAONfFvMB+R+56J9z
   w=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208";a="77920077"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2022 16:36:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7D4DE0092; Sun, 13 Nov 2022 16:36:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9F22CE0092
	for <cocci@sympa.inria.fr>; Sun, 13 Nov 2022 16:36:24 +0100 (CET)
IronPort-SDR: 63710ef8_MjynhD1pRlcVNDI+J4ofGROhBOENWSG+vLBk2HVPr2kLNFR
 jlDfInvPFGNxlYooQK/YpTm3XAqtgbqUcXivkNQ==
X-IPAS-Result: =?us-ascii?q?A0GqJAA2DXFjhwsR49RaHgE8DAILFYEqASMDgUMCAWWBB?=
 =?us-ascii?q?VMuBAtFhE+QbAgphCmHIIcwijiBfQ8BAwENQQECBAEBAwSCC4JzAoR8Ah0HA?=
 =?us-ascii?q?QQ2BA0BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEZCRcHD?=
 =?us-ascii?q?hAFIoVoDYI1KQF1gQgBAQEBAQEBAQEBAQEBAQEBAQEBFgJHUz0BAgIBIx0BA?=
 =?us-ascii?q?REmAQQLCxoCJgICVwYNCAEBgnmCbgEDDSMHrEOBMoEBgggBAQacBh8sIlOBX?=
 =?us-ascii?q?gmBFCoDAQGQE3onEIFVRIE8DIJHMD6ERINXgmeOd4hqJgQOAxkrHUACAQs7M?=
 =?us-ascii?q?g1KGzEnDgkfHAoEFw0FBhIDIGwFCjcPKC9nKxwbB4EMKigVAwQEAwIGEwMiA?=
 =?us-ascii?q?g0pMRQEKRINKydvCQIDIWUFAwMEKCwDCSEfBxYRJjwHVjoBBAMCECA4BgMJA?=
 =?us-ascii?q?wIiVnECLhEVBQMLFSUIBUoECDkFBlMSAgoRAxIPBiZFDkg+ORYGJ0IBMQ4OF?=
 =?us-ascii?q?ANegWkENWadWIE6gUKSYYMarEM0B4IfgUyBTQyeZgYTLpZuDgaSFJc0p3iBf?=
 =?us-ascii?q?AQcgVwzGiSDNk8DGQ+OOYQMiixANDsCBwEKAQEDCYVHAQGFIAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:1Q10u683srvGD7udnF1uk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208";a="39601701"
X-MGA-submission: =?us-ascii?q?MDHQHSUgzwia3ernVmnZrM6v0Sak+1EPeIXqFe?=
 =?us-ascii?q?mOfCEsbcfoO9afHJzXX2tYfYqcNn5iFo4hy4QVEZhAYhR1t7HmbbHz2y?=
 =?us-ascii?q?8A9YNBHPa1EUrUiqOouvXG7kwa8Bk32BKycW/GcGuV946XF++eKaY8C4?=
 =?us-ascii?q?Pku1FPZNenlC8tTNMk4zAWmQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 16:36:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668353782; bh=P84O9LLC2LvRfoTp7G38gWkeyOoFn5MK+A9DQVsazbg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RLrG4/o8jcOjhaB009nVFDjkK3xcxUGRYKAv+F9M03dv8iEC0u2s8AxbnZFNHYAit
	 1fbN1oMqhpbvqfzPcDHw5/XJxliaz0Zfct/HLGkbJVtQFLoyO4/tVDwLtwYotnpX2r
	 SveShBkojB50n0pSPA86anxBPRssc7xxg9eWzHQ0b2G47pqpWFZJUBtLMm0yYpdqJK
	 jy/AXVBpQF7nSwGTiqflGIYZ1YT64IQt7y41NfYEiNM11jcoJNtOdMlNc2ZDO/x+RW
	 bvuOEY7o4DLsgIvMhe3K1mnHvQ81O8ZB8wKK43lj9I+ypWf8ApnjJAeCQZhF4SEfGY
	 jKQ9gp/rf8Xow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3UY-1pC2ti2Vge-00rBPk; Sun, 13
 Nov 2022 16:36:22 +0100
Message-ID: <4d057f08-bae3-1762-6b4f-b8dea38ac9d9@web.de>
Date: Sun, 13 Nov 2022 16:36:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Elia Pinto <gitter.spiros@gmail.com>
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
 <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
 <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de>
 <0a1acdf8-64be-6e43-6fc1-9160781bc7e0@web.de>
 <b48551e5-3792-e563-469-57f2b17164@inria.fr>
 <2dd76fcc-0f76-e99b-80a1-2ade40e65380@web.de>
 <6cedba8a-8765-fd51-2980-b64a6f86aa7@inria.fr>
 <4ae6751f-fc14-782e-013d-af6be69c1f7d@web.de>
 <3fdf533a-e03d-25e-ba34-5591ed0d393@inria.fr>
 <752a875f-6d92-669f-784d-73f96ed2a0c7@web.de>
 <d6f6d9fb-aa4b-5d17-788-e4b5f3914617@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d6f6d9fb-aa4b-5d17-788-e4b5f3914617@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IvtKNsF1WEyr27YeXZCjAYDkLsFPBVvcKxxSHgagE98fW5oxe9j
 f+bZRHwiMVLh0amP6vHTnhc6LLd+QovA0yy+07BRKj2s4HRgT4mo+HnzP0WmLNmeBTjtuOl
 aJyKVExj9/W1xmwT8ZpnTvWDTO5LFioGRAM5zF8yA/j/+PEKFVBnsp048xTe9Z/xoU0nV53
 Ecu+fzkFbQrZQ03PvOF6Q==
UI-OutboundReport: notjunk:1;M01:P0:Ga2Ced6Gidc=;ga7RraES664olZhgHf89zt19n3b
 Xts59VcT38M9+ewlBNF0l6apHQ+6w5AV5NFwr8dOq05lHZwBE9OReeUFv+YwyZjhNMQtsTYkD
 oe6yBwvZQGdAyghGqqCQbjG4yTXi+brw4tDOZKkSv5qGYWhzex6S7P+jk5+GCkJtzkhrCACmp
 E0H5Bx9NVzUwNYfnsEMm2367Z5C455uQnUACdIgtm2es4bMCk1jfFF8WBMjWJ/W4cY/V0Id8X
 9jKrepIat0YCyLgCVosi9LRYLMDPH2XkdvB6Ektf5Zfw+ODB/iJZ+yx4MY+IkCMN+o9qXdsdN
 dlWt2PrLI/ukY9Xz91xKRjKtetwuK3CCojGpI2VQaRct4MVqN/bxjEId+l54/KuTtLucm+Ltc
 ND6NTe0rIbAZ5GMPJptqlQYA61tniTTuxw4qNVGuYzTdKhMt/Xvoey6AAtBjuW0ctRP17vodO
 scvPUsQ0NcVQvgkH6vn03fBfh8OIT4dpbqJpguClD4Dp2h+i0N01JkukidQYLETFwSAWouVVQ
 ZoneYMOtz7yCvr3MiXs9v4bqw9G5s/dGCwH+RY0WuzyTzDvdwnckT3siee4UWkBDRa4Z9Nc7D
 5EFxRidcn3O29iHD6pATUAbD9rxtr+2BXIPR7pLxiLxWCcKuSIRkBSZkN9OKO6jWLd+gBC1sY
 e3k71fa9Z1X5CF+/ZUcERRiIbR5fTKIZToHS+oT6Nq4mIt3+NLNVyfDIRkF5ZqcqNT9Xp9ARF
 2tyglcsx7jfDE/a1s6h0xhBoHTrbBy5qgqdH7Lxt+oISmgGRiSsvAS2KX5ZP7kt/A64MINEFd
 48VnllMocYG9/rfkZnhj+KO56gcu3DqAlw4Obpb4z4K0/kW4lOV/2xFYNLCZ8OrKTndTA8/o0
 rc4t9E/iksxfGgnGeiK0p2eP9zKjLTEv0rFCmoDRAv437kGQlVU7ZgYOe4CkgqhkPZBVrbdL2
 B2q3vg==
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 747
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/4d057f08-bae3-1762-6b4f-b8dea38ac9d9%40web.de>

>> The error message was not displayed for such a source code variant.
>>
>> I got the impression instead that multiple declarators could be handled
>> to some degree for changeable variable declarations also by the means o=
f
>> the semantic patch language.
> That is correct.  They can be handled to some degree.


Thanks for your acknowledgement.



> That doesn't contradict the message provided.

I interpret the discussed software situation differently.

Should the source code fragment =E2=80=9Cchar **p, *r;=E2=80=9D be treated=
 as an indication for
the declaration of two variables with different (pointer) data types?

Does hinder anything to extend the support for all other data types accord=
ingly?

Regards,
Markus
