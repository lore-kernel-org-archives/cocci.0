Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18EAD1D892
	for <cocci@archiver.kernel.org>; Thu,  4 Dec 2025 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xvrYoqFXG0twqo5yWA2bkbH1mOhB2oKR64AHPQPgU1I=;
  b=E3f7Tj0pQNIcV/no2YYhyImVraQpLLA1ZxYmy5LZGBih6TgtF5Tny1/e
   rRZgOLXw7ytGrtmSi8c2HwLf05wP7sCW5zX1t6Rjqe0wNU190RpemRMsx
   4O7K8v+/qVBPZAzhbKdBPNkhRSLSqZdKVvqEcVlQiY2BSMwRv9hXR4+hb
   g=;
X-CSE-ConnectionGUID: QGmXfOr0QGiDCF0644FKXQ==
X-CSE-MsgGUID: 19DvfcUYQFagqHVRTmfvoQ==
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@posteo.de
X-IronPort-AV: E=Sophos;i="6.20,248,1758578400"; 
   d="scan'208";a="252690574"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2025 09:56:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BE66DE0AF6; Thu,  4 Dec 2025 09:56:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8138EE00A5
	for <cocci@sympa.inria.fr>; Thu,  4 Dec 2025 09:56:19 +0100 (CET)
X-CSE-ConnectionGUID: wik1mLZ9TDe4u/cf2gobPw==
X-CSE-MsgGUID: wIqPOxmUR2CiRl7gY9P8LQ==
IronPort-SDR: 69314cb2_niNCInQ1mBh3K4cbBSC8EbRHepY+BWAXehE8Ft9wzxHTiiC
 nU5cLtIKBVPYUQn8WInCQVsK24qso0vA1kBIDrA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EwJQDVSzFpg0IkQ7laHgE8DAILFYFPA4I+gQJfMwcIS?=
 =?us-ascii?q?QiETYh7iHkDEVidMoF+DwEDAQ1ECwIEAQEDBIFMgzQCjGcCHwYBBDYEDQECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBATkHDjuGTw2CW?=
 =?us-ascii?q?4EsgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg0fPwEfAQEBAgEjFQgBATgECwsaA?=
 =?us-ascii?q?iYCAlYhE4JnAYIiAignBwEMBrFsgTKBAYIMAQEG3CeBZAMGgR0vhW2CZQGKZ?=
 =?us-ascii?q?icPgVVEhA4xPoJKFwEBAgMQgUsVOIMOgmmCJoEOhh+CUi6ITodsLCZ4HANZL?=
 =?us-ascii?q?AEPRhMXCwcFgSBDA4ELI0sFLR2BIyEdFxNgPRdAg0kYBmcPBoERGUkCAgIFA?=
 =?us-ascii?q?kA6gWYiBhwSAgMBAgI6VQyBdwICBIIVfYIKD4gCgQgFLnsnAwsHZj03FBsGA?=
 =?us-ascii?q?gE6e5QYT4JIG3kQgWhJLRmTJ49hons0B4I4gWeBXgYMii6VQRIcF4QEjROGS?=
 =?us-ascii?q?ZMLmQaOCJs4ggIKFi6BLk0kT4JnEzwDGQ+OOoNnM7t8QzU8AgcBCgEBAwmFa?=
 =?us-ascii?q?ROLbiwIgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:YCxY7KNUr4fqocBcTvSjsMiBIKoaSvp037By7TEVdfUnSL39qy
 nOpoVi6faaslcssR0b8+xofZPwI080lqQFmrX5X43DYOCOggLBR72Kr7GSoAEIcBeTygcp78
 ldmt9FZ+EYY2IWsS+w2njeLz9p+qjgzEmHv5am80tQ
X-Talos-CUID: =?us-ascii?q?9a23=3AfFQawWi6UtJDvRyAQeHyruOtoTJubXzelXL0ER6?=
 =?us-ascii?q?EJWs1VfqeRwWf/6lcjJ87?=
X-Talos-MUID: 9a23:KjKo5ArndsVYDe5CuPsezy5DLf9P86GTMhomkK8C5Ma1ZBQgHw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,248,1758578400"; 
   d="scan'208";a="132734985"
X-MGA-submission: =?us-ascii?q?MDGHZHbGJUxvaboxKHq/293JnZ/OJ6tKHKt0qo?=
 =?us-ascii?q?qiNgmiuNwE1lRRPuMKZmYfMtYNKhUr+q+KGTyfdLFQoxIHzkVTuZMtSQ?=
 =?us-ascii?q?GX03c9RB0K2INri8w9TOBVT+gVVirchqnqRDT15sQAwb9FcO1mNhf5wc?=
 =?us-ascii?q?/mxmwewPRrZeBdUw9NSXjJgw=3D=3D?=
Received: from mout02.posteo.de ([185.67.36.66])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:56:19 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 9BAD6240101
	for <cocci@inria.fr>; Thu,  4 Dec 2025 09:56:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764838577; bh=xvrYoqFXG0twqo5yWA2bkbH1mOhB2oKR64AHPQPgU1I=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=oXD3PgzTyapkTehBEjff7jOMw+1kGD1Ao3vqsbS9tm2AqAsM2TYBOjxvg2P9IojNA
	 fZUwMaCHPlBXNxbCwH4TfR+niBgWbBvrYE8UwLLxDe+yd11T/M1nKW5VR4an1j2LpQ
	 NqfDoDd8iYDJ6X/UxU6PlpGLfh5PtO088bJ+tfWAz0gFNR540qGsch9Fn9gZ6HuV5f
	 bRnkFAFZbAHZwQl9QcxwFidawd23b+9AMQZsEHOHShDf5BgnDN6UagaAv1APKcweKt
	 dMCTtxqKOxTlJpVMkQA72Gi3RHlKsbveap0ioLPzmYfyU2Tdy04UdIGkL+9Xhn7TOa
	 Z5jBrtXO7keCg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dMSzN72qrz6tsb
	for <cocci@inria.fr>; Thu,  4 Dec 2025 09:56:16 +0100 (CET)
MIME-Version: 1.0
Date: Thu, 04 Dec 2025 08:56:17 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
In-Reply-To: <1534c930-426e-4939-8fcb-ad4a32c3e23c@web.de>
References: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
 <9ab63cb6ee4a0354c053f22fb0934317@posteo.de>
 <1534c930-426e-4939-8fcb-ad4a32c3e23c@web.de>
Message-ID: <b5b21fa8f7d361142b60027d84edd34c@posteo.de>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Search for the concatenation of meta variable + fixed
 string
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3241
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/b5b21fa8f7d361142b60027d84edd34c%40posteo.de>

Hi,

(copy for list, sorry for again messing up To:)

Am 04.12.2025 08:54 schrieb Markus Elfring:
>> Found a workaround using fresh identifier to add an intermediate=20
>> helper construct:
>=20
> Please reconsider your solution approach once more.
>=20
>=20
>> @device_attr_ro@
>> declarer name DEVICE_ATTR_RO;
>> typedef __DEVICE_ATTR_RO_T;
>> identifier attr_name;
>> fresh identifier show_fn_name =3D attr_name ## "_show";
>> @@
>> =C2=A0 DEVICE_ATTR_RO(attr_name);
>> + __DEVICE_ATTR_RO_T attr_name =3D show_fn_name;
>=20
> Would you really like to modify source code here?

No. It's a temporary modification as workaround. I'm using=20
--no-show-diff, and don't replace inline.

> Are you more interested in an =E2=80=9Cordinary=E2=80=9D source code sear=
ch?

Correct, it's only about searching. But not "ordinary". If there's=20
another OSS tool that could do semantic code search, can deal with C=20
macros and supports "hops" like first search marro, then search=20
definition of function referenced by macro please tell me. Coccinelle is=20
the only tool capable enough I currently know.

>> Seems to work good enough. If there are cleaner ways, let me know.
>=20
> I suggest to take another look

I took reasonable amount of looks and found no better way than this [1].=20
That's why I'm posting here and hope to receive SmPL snippets that=20
demonstrate a more idiomatic less complex way.

> at algorithmic properties.

The linux tree was searched in 44 s locally, which is fine for me.

> Would you need to extract identifiers from selected macro calls?

Yes, I print functions names and positions in python scripts. The=20
result, verified with samples, looks complete [2].

Tobias

[1] https://github.com/haxtibal/linux/blob/tdmg/cocci/cocci/sysfs.cocci
[2]=20
https://github.com/haxtibal/linux/actions/runs/19922697880/job/57114762347#=
step:4:512
