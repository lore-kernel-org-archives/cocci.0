Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A62EC3DA49
	for <cocci@archiver.kernel.org>; Fri, 26 Jul 2024 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OCIbmF0FgK4qQRBVzulYxfDUri+xFETP5n3P8FmYpC0=;
  b=L1M4+CUq1gIRhhxnniOSP9j3834765Pnkj7xuZ0pEvwemmmeikYno/6Q
   UUHoq8d5w/+cqPuK2lW4WWFjhnT8BTs0DutsJU3g29mDFgPZJxbfa4fks
   DqgJIrdgyOHQVLzPqeiQeLCRDYJ57TtrmBpOW0wVwqNnfg+Ui9oDlfPOw
   U=;
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
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="177124779"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2024 17:05:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 92A81E0035; Fri, 26 Jul 2024 17:05:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6FB2BE0035
	for <cocci@sympa.inria.fr>; Fri, 26 Jul 2024 17:05:35 +0200 (CEST)
IronPort-SDR: 66a3bb3f_/SMvNr2Kl7Jgw+Zk9vYM/j7z1vYjG/2paHETXHX9NXZHjVw
 21Bf/kgPPs/SA8nYkDPw2pOo6kYXsMfJkD3Cc6w==
X-IPAS-Result: =?us-ascii?q?A0GMAADWuaNmh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYiBUMwQLSIRWiB2HLoIlhDuHOodRiHWBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwSEfwKJOgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQE6Bw47hXUNgmcBEIESgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdEA?=
 =?us-ascii?q?QEBAgEjHQEBESYBBAsLGgImAgJWBgEUAQGCfIIwAQMOIwetR4EyE26CDAEBB?=
 =?us-ascii?q?tpZHywiV4FjCYEaLgGIPAGGDINNeicPgVVEgTwLgkcxPoRDg1uCaZJEiCwDg?=
 =?us-ascii?q?00mjU5UexwDWSETAVUTFwsJAgUQiWAKgyUpgUkmhBsIgS0Vg2SBawxhh3Zig?=
 =?us-ascii?q?Q+BPoFfAUmCd0uDaByBZWwdQAIBC209NQkLGwY9pSqBCYEDgkBbxB2BCjQHg?=
 =?us-ascii?q?jaBYoFjDJ9PBhMvlzwOBpJuHphPIqhvgWc6gVwzGiSDNk8DGQ+OIRmEFMwTQ?=
 =?us-ascii?q?TU7AgcBCgEBAwmFRgEBg1qBSgEB?=
IronPort-PHdr: A9a23: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
 jnnkaXuNHFd/tiS8cZOX6A8x+qYPXBnPRe7QVbp
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Am4GraB/7Qd8y7/lHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AGDLiI2mtWM7Zs8D9aI8vSyqgIjfXOW/5y1vxLBa?=
 =?us-ascii?q?yMEdsR63ScF6I+I5jnPM7zg=3D=3D?=
X-Talos-MUID: 9a23:ToJnxQqFPv/XSNgbJWkezx1+Bdoy3IeqNEsyg4QfpfDabSFIGB7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="177124776"
X-MGA-submission: =?us-ascii?q?MDFZULmxCCEVyRkqzrmQMJLSxbyBA2WhMeBQhv?=
 =?us-ascii?q?ErCsu1hPtWZSh31nxq4qX6dHrAlkvlM1h2WEd7RsvhDL7qHpzw1x5p54?=
 =?us-ascii?q?tBvEeNO5vSHJzia+SN6oxDSpbyYBvCxFAVIsVk20nr8FWw4Wqdcr7wSN?=
 =?us-ascii?q?NsjLPGX7sJ+tumrDLBgJ8nJw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 17:05:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722006326; x=1722611126; i=markus.elfring@web.de;
	bh=OCIbmF0FgK4qQRBVzulYxfDUri+xFETP5n3P8FmYpC0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TDG/i/qfbF5oMvAWIQKIMqDfcXmqhQ0Rvd2N2+Cx9nzYjL0+EFmkzt9VhqBu/aPt
	 Omlmw56SvnSKa9gUCcw/uNVhCXa9AehkxxlWNwmKMvzvu6vtd1dzWWphVHHaeW4Ky
	 3aPIj2pum9R8gY76/locbEq9h8aS+U/LTKPpNHcBRF9xUtkGyMojXPa0GX5BODdZO
	 pTXhZa9mm1YBCQd/7F7tWmNQ4PwUETnFu+E/u95yXOBBtjq2XJzKUg65aC2nyg26i
	 3Qx5gmuRPj3kUeihUCGYpyTfZ6BtfgexjAcX5dzPMtjTwXsCl4/BG9wJlXPR0Ln7Q
	 mBZIEKeTDzjZdPTxqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N14tM-1s8V5j3ep8-010qSs; Fri, 26
 Jul 2024 17:05:25 +0200
Message-ID: <c1c3f2b0-4581-41f0-a29e-b6964da045c2@web.de>
Date: Fri, 26 Jul 2024 17:05:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Chen Ni <nichen@iscas.ac.cn>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
 <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
 <d3f11294-5751-442e-b7d4-616c3bd217b9@web.de>
 <bea5cf4d-0e4-d141-1365-4d5f76bcf513@inria.fr>
 <f7cb87e7-3a17-44b7-87a1-8fec22e649ea@web.de>
 <fea78c48-494a-ee18-97ee-fc6930fce7d@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fea78c48-494a-ee18-97ee-fc6930fce7d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5jMWf5dqIJGjv5WaUUUm6QngpoQsJISv+QiiUhmCv+0iUacoaGC
 9rAy2ISH/aRuepxMbzorTZvgmB0QhclSNH2nUYmaPpqsC3JeRettPZpFbbbhmtJNJzjaHjJ
 Ztk548VtD4+gMku197eqqd5wPRGT6jUzYqxnkPL99C9gJSgwmnZk65N7WUn+zqfHyIK9WtJ
 i7uAzLvWeo/i01X/zO+Xg==
UI-OutboundReport: notjunk:1;M01:P0:gi488xBoGUg=;uaEGxsmhl4/OvXmJSxncadxifiu
 uuJB6fglzUk4mJ11iHia53xv+vAroFSwsPvnAtTQk02QoSoTRjLFzjJBBicdRJ3zU5p+CsT8B
 FjDvmKDgYj+/SjK22TKtEbDuqccNhtOQbmVjqilvZtiwxwR2aIpIm/S0jYrGkSckP7u8csTiU
 XIhlaXufqpkNy9rJaHsLC7AIvjPWYaI682PUoZgp1LakqvquOPv0feV3bqEcPbGbCDBmOU/sq
 kFk43LbQWUqmYFS0Bh2b/IrxgzgNINDoFqZ0jDdo6eNLh5OprcbuRm3CQlHWJnHdzM78BIr3B
 pTTzli8AdaTPctoU7TvvuPdJGf3RHLbbtT3nGKKPd5xF4qVQpN2v/k4cNSizZxBdyCIZxIDgD
 venCvBH6rqaH77DMDEpbYfRo0Uzho2QLmy/i4XTGXVOq1cndCX9cWUnSboyWtN51WbDg+rJDf
 hoAVsi6iy4sYySSxC17XXWy0mA579e7U6dxEYPGWWmqtQksFS3ldAgf2isuqAFPT0SUeDFMDN
 SoV5e04OwpfzbDYrUSRq2DuXcguFtzEbpTyCSPPGOGq4smGhLi0yOuvjEhSCqxxkjec2guWaL
 2Pzz9urJv0/vG7R1Yy4Cx8JEEYj+76JOZTWaIbPUkzBprCcSeDeRWBduDqAgi4cVGNN702wY/
 7JAveIw/oicQMJbvxAoJ43Ury1KuIj3MysQ5TKiewJ+rfgupSDjP1mSdqURd7Wmzqs5Ns4Yxs
 M+tS/vNn/x0Q+qzAjPwxsmJjNNIlHLyMMiw/dwEdrCVe9KknjKEcOKD9RZpa7qdPI+ceQ85LE
 A6gZ0gATWgD0/wPjJYJRM7Ew==
Subject: Re: [cocci] Data processing challenges according to the comma
 operator
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1821
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/c1c3f2b0-4581-41f0-a29e-b6964da045c2%40web.de>

>>> The comma operator expression has the form
>>> lhs , rhs
>>>
>>> That doesn't end in a comma.  There is no rhs within the <+... ...+>
>>
>> Can subexpressions be supported by the semantic patch language
>> for such a =E2=80=9Cbinary=E2=80=9D operator?
>
> A subexpression is also an expression.  There is nothing specific about
> this operator.

How do you call the construct of an expression together with an operator
(like a comma for example) on the right side?


>                 The rule in Coccinelle is that when you write <+... ...+=
>,
> the term in the middle has to be a complete expression or statement.

Will additional source code search operators become relevant here?

Do further development resources need to be allocated anyhow?

Regards,
Markus
