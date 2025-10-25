Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D727CCF9E3
	for <cocci@archiver.kernel.org>; Sat, 25 Oct 2025 08:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ubQg1Um9eE+wYqHD2VT/p2GjdAWsD+UtgUK5u9h2B/g=;
  b=QLq6115ElkObueiIKYOKRGl+zT/Ma3ihHpqfxZBsqt+7Cv9EkfZ6nUZB
   OJjp7WeSRLdQNVohjmrUYxm+Ldaj1irq2egTkWOWC+PE5ESZJggpIsktV
   ybRikW+stQbCgzW/YQS0SDu88nzeJzEdYp+BAvPM1Z1IOVu8kwRnZcro7
   Q=;
X-CSE-ConnectionGUID: +JKpD+UvRQGO0WXRs4VROw==
X-CSE-MsgGUID: 9leUBg4sTYy45TF/KlmK8w==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.19,254,1754949600"; 
   d="scan'208";a="246125637"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2025 10:06:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E8C4E0264; Sat, 25 Oct 2025 10:06:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BAD23E0171
	for <cocci@sympa.inria.fr>; Sat, 25 Oct 2025 10:05:55 +0200 (CEST)
X-CSE-ConnectionGUID: v4c4HCxpQx20vsFKMMbmWg==
X-CSE-MsgGUID: 7/NxLazQRP6aglCQSpBTlA==
IronPort-SDR: 68fc84e3_eDa25r5odMhhfzfyqyY9jm6V2/mpJzrwFlL8fYqQskfcsYJ
 U5HcCaE2UvRtsbcqi/G6IGBvqUVCIZan6Vpl+JQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HHCAAAhPxogAQP49RagQmBUIJAZR0GWDMEC0mEVY9Sg?=
 =?us-ascii?q?w2DUo8RiHmBVYF9Ag8BAwENRAoBAgQBAQMEggyCaoxaAh4HAQQyBw4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CW4Esg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAg06bR0BAREnNAImAnMBAYJ+AYIiAQYQAQM2Bw0Gs?=
 =?us-ascii?q?AiBMoEBggwBAQaCadd2HywiWYFkAwaBHC6FbYJKGgEFbooYD4FVRIE8glKDO?=
 =?us-ascii?q?RcDAYIrgw6CaYImgQ6GJ5IggUocA1ksAVUTFwsHBYFjA4ELMjwyHYEnPxhzP?=
 =?us-ascii?q?VeDSSFoDwaBEoNTiTIYD4RNgQWCRgIBC209NwkLGwY9lA0shAoCgjGTSLMBN?=
 =?us-ascii?q?AeCOIFnBYFfDIkIgSaVPgYTL5dSDgaTBZkGjgiVYIVZgW8HLIFcMxokgzZPA?=
 =?us-ascii?q?xkPkiEzxAtBNTwCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 HsmT7hGSBoqG/lcBkk3RLQ/
IronPort-Data: A9a23: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
 PzwgLMeNBjA
IronPort-HdrOrdr: A9a23:UZ0CNKhnxBCniQgGHCiZYNlheXBQXvgji2hC6mlwRA09TyXqrb
 HMoB19726StN9xYgBFpTnkAsK9qBznmqKdjbNhX4tKPzOJhILLFu1fBOLZqlWMJ8SUzJ856U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ds2g00NcelwAZsQiTuR5zzra3Gfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:5B19w20qvC3OasypwwOA77xfBJwuLl323G/pMxXgF31Ha5iwQ1qv9/Yx
X-Talos-MUID: 9a23:XsEQ3QivCijsN9MXTjPCOsMpa4BO84CnGnk3qcsPtM2vDBdoEQuZpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,254,1754949600"; 
   d="scan'208";a="246125636"
X-MGA-submission: =?us-ascii?q?MDHlVYv7HGwHl3sSkFVlj6WCZed4gOd8pKR+qq?=
 =?us-ascii?q?u/1464E2UORz659dtaxNEBaZ/Ld8KOduLpOjciWT3o0m5Kf7bo9Nq2LK?=
 =?us-ascii?q?GFUYmD5jHxezdgy3cvKHILGRYac3p3QNEM5xN+Pi94xLQIwQsT+iTwmQ?=
 =?us-ascii?q?Yl/Q4dCpdozN9Fw0AG83nKQQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 10:05:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761379554; x=1761984354; i=markus.elfring@web.de;
	bh=ubQg1Um9eE+wYqHD2VT/p2GjdAWsD+UtgUK5u9h2B/g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TyNeTHuIgFVvgptoCHLBiskEkWbFkTbijnj/XAGi5cbzN+AjfgQo7rM+cEzbcrQa
	 Z06+JO8haKa7v5OYlHGq2AxwrI1QREDPCLZ7cm9uxIndXSZkdXyOJR4nJvYLh9q3Z
	 qyeortJev3YeZzEzUKSXQwk9NyDVya6F0Czovwvx1/BHwRKFAtPq5AHA5N3TPfvrI
	 jm9vQuJ4w6V0x2R7tTco/VE/Iq5ksJF1bencVzUuj/k/rmQ3Ws7Vll/eOLGSDwWOx
	 uGQ1MKZmTza0afVd+CCdYRCFito+M6z1hysMmGqIjbEENYspJM1uqzznHJBEth6x8
	 325mvFp2Gex84OVBOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYclj-1uiiaf0nB5-00Im5s for
 <cocci@inria.fr>; Sat, 25 Oct 2025 10:05:54 +0200
Message-ID: <67c4f12a-5b58-459f-b02d-cfa5e6275693@web.de>
Date: Sat, 25 Oct 2025 10:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:owfnxCpFlo+IBsJZlszTcmYeTF8Zho/EA9pSiV/CG+oGKndsy2q
 jKGlPGVqXPdW/Zgi8075YIL7LxGbK1Gwk23CQV0px9JRyCrCEplb171tSe8upvGbRx833ee
 pLG4cBpfOP+Y7pKbpciyNQUj5Jz4BjEABdo9O1x/Xz+FRBZA+iuOTBkp88la1PYmDgPfDHh
 t+7mDSCDN+AiCQTvMe9lg==
UI-OutboundReport: notjunk:1;M01:P0:Zsov/7RrHZY=;lolgWXHaDklnj8y6QPr01n+pDtg
 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
Subject: [cocci] Searching for selected function declarations with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3097
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/67c4f12a-5b58-459f-b02d-cfa5e6275693%40web.de>

Hello,

I would appreciate if another source code analysis can be achieved
also by the means of the semantic patch language.
Thus I tried the following SmPL script variant out.

@display@
identifier i;
@@
 my_type
*i(...)
 ;


Unfortunately, I am wondering about the following information.

Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_selected_function_declarations.cocci
=E2=80=A6
(
my_type *(*...*) *i;
|
my_type *(*...*) *i =3D ...;
)
=E2=80=A6


It seems that isomorphism rules converted the SmPL code into something dif=
ferent.
I would interpret the generated data representation as variable declaratio=
n variants.

The intended source code search pattern might be ambiguous.

* C: function declaration
  https://cppreference.com/w/c/language/function_declaration.html

* C++: variable definition
  https://cppreference.com/w/cpp/language/declarations.html#Simple_declara=
tion


Under which circumstances will such data processing become better supporte=
d?

Regards,
Markus
