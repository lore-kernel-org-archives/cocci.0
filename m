Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B760C83F27
	for <cocci@archiver.kernel.org>; Tue, 22 Jul 2025 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xiLoI4hTzs0mT7n/2BNZEq8zLnwctktUvQwnqD9VapA=;
  b=Md9IWyQz06Xnj2CTy42l4bGSNteyoOj7lFIfctiEvbdzZlQrICI/yB3u
   kqMjvwy4ff5XSkT4XhnEmNpEabz2ytEL9PmxjAeHUe80eMIIxfNlDb6TC
   RS3oF4E2orGFiJV6z7FzK76KrU0bIUNT0rL/+mQF37Wu+98/lGrR71zML
   0=;
X-CSE-ConnectionGUID: sH1o67sCQlKN0LBokeu3Fw==
X-CSE-MsgGUID: RotokYuCRJi0GzfhjYV8fg==
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
X-IronPort-AV: E=Sophos;i="6.16,331,1744063200"; 
   d="scan'208";a="232615538"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jul 2025 13:10:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 88BA7E0CD5; Tue, 22 Jul 2025 13:10:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0A01EE0171
	for <cocci@sympa.inria.fr>; Tue, 22 Jul 2025 13:10:22 +0200 (CEST)
X-CSE-ConnectionGUID: BK0aW9zjTpaqTnXmXDBITw==
X-CSE-MsgGUID: wSLjminKT6aeCoH/S7aWow==
IronPort-SDR: 687f719d_m1tpLbS4mD2XxL/bec7+/aWGu8pRmTJhMGKqS8QNNUvOA44
 8qcBF6osDjSIirzE+JdITQ2JavdvJ0KoLyD6XLA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HwAQA+cH9ogAMP49RaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?QGCQoEGVDMEC0mEVYgchzSCJIQ7hzyQTIFVFIFpAg8BAwENTgECBAEBAwSCD?=
 =?us-ascii?q?IJ0AowTAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBOwcOCjGFew1JARABggcBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECA?=
 =?us-ascii?q?SMEGQEBEScECwsaAiYCAlYGARQBAYJ+giIBBhABAw4kB7ByfzOBAYIMAQEG2?=
 =?us-ascii?q?l4fLCJZgWQJgRsuAYVsgmQBhieEPCcPgVVEgTyDAz6EBT6DW4JpgiaBFoNkj?=
 =?us-ascii?q?QaIClJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ32DCoEOhCgrT4IidYF5Q?=
 =?us-ascii?q?Rk/g1MeBm0PBoEYGkoCAgIFAkNFgRlAAgELbT03CQsbBj2Sc4IqhH6SdbIxg?=
 =?us-ascii?q?Qo0B4I4gWeBZAyfawYTL5dRDgaTBJkGIqkdgWg6gVwzGiSDNk8DGQ+OIYQzw?=
 =?us-ascii?q?ChBNTwCBwEKAQEDCYVGAQGFKIRygUsBAQ?=
IronPort-PHdr: A9a23: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
 UNgKVbQMokZcIH2iRQKVw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hYCveqAB97J7HevlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:o7OkhGGhnrzT7f8JqmJN1xYdJZE3cEHFxW7sJX+9OUpDaYGKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3As/5beQ6V2be3f3QTfO0ZPQmcxox32ICsDUELsql?=
 =?us-ascii?q?YssSvMgw3AGiUszOoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,331,1744063200"; 
   d="scan'208";a="121933235"
X-MGA-submission: =?us-ascii?q?MDG9RhHzuLKh7ZRO/pcYhKEj3WemItkZ9G7ahL?=
 =?us-ascii?q?POTkwvZJfkHe9RVxw9M7W/pCjinraeOfThbYQgngO+FLQ76gi39p43Vh?=
 =?us-ascii?q?eI6Y3+g9UfEwANu+vZuvQk5WKyXNn0SMZJKDDp9dUR4UmK6PKBnbSjJn?=
 =?us-ascii?q?XZ4K+HkBDVGHTpiEyjtLpp3g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:10:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753182619; x=1753787419; i=markus.elfring@web.de;
	bh=xiLoI4hTzs0mT7n/2BNZEq8zLnwctktUvQwnqD9VapA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WNOAe20uH+TgEdHfAcKtpUSSog1UB8dobmEQ6YP6Ql98EZ2OhzQVMquOjsVd7F/E
	 bkTRbrGd7btNSs/BAbNFvy+9E8RWLkeWNTsJErUTH3dvRFUBbpsBzpoWRx/wA50/c
	 gXdxPXgEaCkI7ZpP1rnRzsuuDBJbUi8gwxz5lkFFNdTUn07C6JZiIJExJ41TUtndF
	 inD4MPn5ecPhQMp69s3urygtWHOZSI76JHxpWMDpV5FcPJAHyC2zqDWCvcWiISTRk
	 1bOakG0iRQSX6/sTh6YD48mHlZ08s55Y5eMt5bcB9p0ukd6Ia7ziTVYizzDGGZpFf
	 GPHRyJS915n1JkcyBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWQud-1u6F1s2PwR-00Jv7u; Tue, 22
 Jul 2025 13:10:19 +0200
Message-ID: <9083bc25-b9ab-40ef-903c-f26d9670c112@web.de>
Date: Tue, 22 Jul 2025 13:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
 <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
 <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
 <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
 <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien>
 <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de>
 <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr>
 <52ce78f5-8141-46dc-9ad0-5cbfedfd92a1@web.de>
 <cd40be57-cdef-7834-5c8d-eda49eb3a8b@inria.fr>
 <9083cb34-5f8a-43d9-b908-43a9fe2a4281@web.de>
 <4752963-ce2-3e23-fe61-9cbd1acbbdc1@inria.fr>
 <9154fc36-842b-4797-9b55-397cfdcba283@web.de>
 <2914d20-68da-a23d-6345-fd48f0b9bed8@inria.fr>
 <8c949c3e-cb28-42f4-9db6-e4e81231236e@web.de>
 <479a2492-62de-2b9d-4899-4d4f35f653e9@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <479a2492-62de-2b9d-4899-4d4f35f653e9@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4j7jFMKOjX/1ceGewEFjhCyz2b+GvUfNVeZhTgjo47n0rfLoV0C
 kWuQ9knbQFQi2EQCV3thma+BjY2kckGuvb15Sw1mKi3sMMWSGaPV0LX4s2szyFud5O0KYl+
 iNB/U2amz4KI6mCdVfTMnnWxgWj7iinzjB734UA8j0TAMuFc+/wslJM08/z4L7u/jR2fqYF
 YXtVgu2FKsnH+XsR8zHMQ==
UI-OutboundReport: notjunk:1;M01:P0:NbDX+5sfPjs=;m6f+BZFozgVWWHAT6/Wf4WyUbeR
 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
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2899
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/9083bc25-b9ab-40ef-903c-f26d9670c112%40web.de>

>> There is a desire to avoid extra parentheses in the generated diff outp=
ut.
>> If such difference displays should be accepted as patches for known cod=
e bases,
>> it would probably be more helpful if they could adhere better to coding
>> style preferences.
> You have sent like 20 messages about this.

Some communication is obviously needed to achieve a better common understa=
nding
for the presented topic.


>                                             How about one single concret=
e
> example where the output is not what you hoped for???

Another SmPL script example:
@replacement@
expression condition, context, x, y;
identifier action;
@@
-if (condition)
-   { action(context, x); }
-else
-   { action(context, y); }
+action(context, (condition) ? (x) : (y));


Questionable test result (by the software combination =E2=80=9CCoccinelle =
1.3.0=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20250722 && time /usr/bin/spatch =E2=80=A6/Projekte/Coccinelle/Probe/=
use_selected_call_with_ternary_operator-20250722.cocci fs/xfs/scrub/findpa=
rent.c
=E2=80=A6
@@ -229,11 +229,8 @@ xrep_findparent_live_update(
=E2=80=A6
+               xrep_findparent_scan_found(pscan,
+                                          (p->delta > 0) ? (p->dp->i_ino)=
 : (NULLFSINO));
=E2=80=A6
@@ -269,10 +266,8 @@ __xrep_findparent_scan_start(
=E2=80=A6
+       xfs_dir_hook_setup(&pscan->dhook,
+                          (custom_fn) ? (custom_fn) : (xrep_findparent_li=
ve_update));
=E2=80=A6

real    0m0,322s
user    0m0,138s
sys     0m0,022s



> On the other hand, Coccinelle cannot guess what are your coding style pr=
eferences.

It would be nice if the pattern recognition could be improved another bit.
But we tend to concentrate mostly on Linux source code variations so far.

Regards,
Markus
