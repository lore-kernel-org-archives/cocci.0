Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A0AC10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GtAzOhU+19sfYsHKJLMipDQP4BK4QpjvFAPZ1wFSWrk=;
  b=PicdY0JhALJiubUPtLMsOKtCjpJ9e6hBF5lZtjQvj+YegG9HE0ZIcOaP
   odXs0YRKYWEXzcTHvFQBzrxhYDAXZ6YluqZYbOSe6DgBCpYVljUfQ/M6i
   AceL7W7ak7NMNIpBsneyZ7CtHeV2Us7V3DMtappnwk3SllPcWt0JHMQO4
   g=;
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
X-IronPort-AV: E=Sophos;i="6.08,156,1712613600"; 
   d="scan'208";a="165249818"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 16:52:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E79FDE0CCC; Sun, 12 May 2024 16:52:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D6345E004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 16:52:01 +0200 (CEST)
IronPort-SDR: 6640d791_gCrb4XkFOwb1UX/u6+aSCFJ6XS5iPKn60VIZTlWgsQ4kPrF
 xwf3t1w1KT+IcqCXPjs3YqFcfn3lAU06e5gmSZQ==
X-IPAS-Result: =?us-ascii?q?A0HyAwCu1kBmhwwR49RaHQEBAQEJARIBBQUBQIFPgkSBA?=
 =?us-ascii?q?FQzBAtIhFaRPTCEO4c5h0+IcYMWPg8BAwENQQECBAEBAwSCC4JqCgKIPQIeB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ?=
 =?us-ascii?q?4V0DYJnARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEBAQIBIx0BAREnB?=
 =?us-ascii?q?AsLGgImAgJWBgEUAQGCfIIwAQMOIweyYIEygQGCDAEBBtpZHywiV4FjCYEaL?=
 =?us-ascii?q?oguAYV8hEAnD4FVRIE8glIxPoRDg1uCaY9GilaCH44aVH0cA1kyAVUTFws+C?=
 =?us-ascii?q?RYCFgMbFAQwDwkLJioGNgISDAYGBlkgFgkEIwMIBAMQNAMgcREDBBoECwd1g?=
 =?us-ascii?q?XaBNQQTRAOBOIl1DIMvgXUphB0IQ2wVg3WBdw5hg1iETmaBJx1AAgELbT01C?=
 =?us-ascii?q?QsbBiIBHadjBwx6xy80B4I2gWCBYQyfRAYTL5c4DgaSaJhiIKhngXwjgVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIRmEFMsyQTU7AgcBCgEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:T5CTq6kzv5fTxF6WtCOxU3JjFu3pDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:AEYcdm00ZtR3TegfzNi8cbxfGJEYf2/t5nzrMhH7LzxGdZ2NbWGZ9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AcdRlzQ+PVvGh/pC2E2a2qTWQf85C2KS0CltWqJE?=
 =?us-ascii?q?fseuoDgBaCRTFvTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,156,1712613600"; 
   d="scan'208";a="86806460"
X-MGA-submission: =?us-ascii?q?MDEBM6u8zQ5MJMZXLpEQtgCr7BjoV0RoExbKI7?=
 =?us-ascii?q?dElQnb0rM+5pFjRMvQAYhY4HfuoZGTM2V0COxxNurb762UEwgfX54YTY?=
 =?us-ascii?q?MGVxV4dJlQqw7FGyCY73zfObqt0CSg8FKYAd374ViNhVNnjQbOBGT9dr?=
 =?us-ascii?q?NTlqH9eJifVGrXy01vF/XMYg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 16:52:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715525520; x=1716130320; i=markus.elfring@web.de;
	bh=GtAzOhU+19sfYsHKJLMipDQP4BK4QpjvFAPZ1wFSWrk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VN8+ooRqw6PnHlwuklho7NpA22Oo2q3o1W8H5P2oU0fLpg8SXbu5faoGOzE/l+ni
	 3jBr6fxEK37zWeiZeOZWYtf1VnQp7yLDsuR5vXCRSc1pHd832d/ILq6PRG88UepZI
	 3NEeqCNpqaq9VPnAGQU0VowhITqqDXV4BuP7LheuE99O+lshlcd00ouE8dBSaYeMn
	 fHll9EQ0EpjJhAwK7nmoBbf381ghgj8wwG8vL7l/RmBsgFl8K8vxUlFTgM1Z9Fcz8
	 xGp8Quo1j5YGfyh8eiRfNxkU8QGEkK2UV8ueS0BuM6lQlPp7Yc38pxbkkLNUQK0p6
	 361SokZLNTy+DlwDMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEXi-1sJNyK0V72-001ACv; Sun, 12
 May 2024 16:52:00 +0200
Message-ID: <0f37e7b2-df29-44ac-b4da-69168bf7a85c@web.de>
Date: Sun, 12 May 2024 16:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
 <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
 <alpine.DEB.2.22.394.2405120932360.6747@hadrien>
 <ac4b8c84-abb1-496b-9377-4f47c1f7cbb0@web.de>
 <alpine.DEB.2.22.394.2405121451530.6747@hadrien>
 <ac848508-8b0f-418a-a2b0-45cd68176d7c@web.de>
 <alpine.DEB.2.22.394.2405121513320.6747@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405121513320.6747@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dUkmxag+XVBhXWVOn3PDrUGxR7zht6UkE+u7ynzgV5xAeDD12VA
 FRtDJBEpzS6XgDQC9b7wWBr6HXrtONmnFqBhWbomLN0Ea5HmYILDuxranqgE7MfSj8mN+3S
 FFy/6GTlqFtRI2RJ/nWKtIEHpU5TF2OGhnAEKN7TVVWEXskkceSHBhfyA158wxn5lv99iuQ
 clfpQT53edBogL7N0EQMQ==
UI-OutboundReport: notjunk:1;M01:P0:m0a+K7FQe7s=;nRzeSS/XvIzJw0kV9Jcrfamv89d
 /v0Fgfrd06asOEzhagpNNdm9EE9RxmvzTtCWzW8wiYC7wfFyuNOrX/7Axz2bixrBhJRYU4F0F
 03zkWK12GCSgN9x52Nr/6vyuDgPQ9H+IDl5daamjKEzfwOCGpT7F9IPV2ZHspTJHH5uX2Zd5f
 xRmJ085l7EqlBVJcY4TzKuDHNqxZfH37Za0/GvknIJ+ngO+IdlDZ3Fzw4bgpGbrnEoq40Mo7W
 drqJQvrYHVozVr6231lGe2RNcU/PhJ47NMmLHFerUZeiPQrWxEfhjGP90849kwBk8UzutePox
 y9RLCFJQBdi7kfQw8OjiDFaYlM4PaGeEpHKeWmYoNSkcgkH1mROHTsLiegQyaujokYjfm40BK
 Cxm6cMQ2Wzv0+coIPQ8tOZ2pzQTPL+D1LS1t9+mXAnPF+USrJ+rwySQt/WS7LpmF3WoMa2uqM
 HmjeURGPIGLltg5TVRR9LeV9rYZJlXD7kRqlZh0QFON+AZEAzJlvZRkgw2ezuoH1tazLnOhMu
 zaL2J0AJmvp/drZVH8BoufWZTHkcywD4w5S6AU5iiPVTYALRlgMEuKVTjniL5h9bg62UcL/0P
 7VBXI7gWBFc4jJMQgwp6Yo606Nqej6llmEpB2Cj96qNmnlzfRQCyGea/866uBxaA+RH5TFqIr
 uL6NRtzrCFE2gAk9h2fgi/ZrYxsZ0DPuDHeynp92+aWlCCj9DiaIkA4PNKBPi7yjec0mhwanr
 3PGMGcXcfXDt5GEV7DmGgtcMQ7YPbHfB66vK0YSLYFYUy5ubwGC4pABYH2YMFbUh2liI2qXRo
 u53RjLhgFx8eOxPgYTs30cRbbaiWKztolPIAJEO5dkjbk=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1734
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/0f37e7b2-df29-44ac-b4da-69168bf7a85c%40web.de>

> The language is as it is.  You can express various things by adding more
> or less information.

The previous SmPL script example indicated special SmPL code design possib=
ilities.
Thus I would like to apply such development experiences to another SmPL sc=
ript variant.


// See also:
// qca_read_fw_build_info()
// drivers/bluetooth/btqca.c
@replacement@
identifier exit, result;
statement s;
@@
 ... when !=3D if (...) { ... when any result =3D -EILSEQ; goto exit; }
(if (...)
-{
-   result =3D -EILSEQ;
    goto
-        exit
+        e_ilseq
    ;
-}
|if (...)
 {
 ... when any
-   result =3D -EILSEQ;
    goto
-        exit
+        e_ilseq
    ;
 }
)
 ...
 exit:
 s
 return result;
+
+e_ilseq:
+result =3D -EILSEQ;
+goto exit;


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci use_common_code_for_EILSEQ-4.cocci
=E2=80=A6
minus: parse error:
  File "use_common_code_for_EILSEQ-4.cocci", line 8, column 37, charpos =
=3D 162
  around =3D 'result',
  whole content =3D  ... when !=3D if (...) { ... when any result =3D -EIL=
SEQ; goto exit; }


Unfortunately, it seems that I stumble once more on questionable software =
limitations.

Regards,
Markus
