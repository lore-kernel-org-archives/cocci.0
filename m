Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407FCCFC518
	for <cocci@archiver.kernel.org>; Sun, 23 Nov 2025 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3ZAKsDFKf4qkhNNQJc2ReLxbmL0TeQ/6jWxxL9iNIxc=;
  b=uZkREZ7xnrIWKR3erJ9q0ZK294xi5FKvl2orCgj6R6X/PP/VuFNZ8Wew
   cXvCd6pVKkCAfW+ucaDXxUw4b7wA10Vi5HNX4IGtNTCJTVomWFoPnfLyF
   Ll12EJSATDxkxh5+Phjfgy4ZP4oy44uJB3h9aHF+kD5llBzyUIUY9t1LR
   g=;
X-CSE-ConnectionGUID: cieAcLKzQSOQPTcInZdWrA==
X-CSE-MsgGUID: hV1+VO0BSw6Ee59UMBdudw==
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
X-IronPort-AV: E=Sophos;i="6.20,220,1758578400"; 
   d="scan'208";a="250688968"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2025 11:00:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DF64EE0172; Sun, 23 Nov 2025 11:00:58 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D5966E0171
	for <cocci@sympa.inria.fr>; Sun, 23 Nov 2025 11:00:55 +0100 (CET)
X-CSE-ConnectionGUID: 6SMnCqX1R0m25gPYZleyyQ==
X-CSE-MsgGUID: BLBsCicNRV2d5FkxqK2/fQ==
IronPort-SDR: 6922db46_SbozNAlscjs5BU6kwa1cN5xmH4VGKjXLITLNAVwl95cOwlb
 ArK4rPiRfucwynlEHDpyEVRJT+VazUIUBM2O+ZA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H6AAD92iJpgwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8EAQELAYI/ZR1eMwQLSQiETY9TgiSEO48RiHmDUgIPAQMBDUoEAQIEAQEDA?=
 =?us-ascii?q?wGFAAKMYAIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQE6Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQJHRAEBAQIBIx0BAREnBAsLGgImAgJWBgEUA?=
 =?us-ascii?q?QGCfgGCIgEGEAEDDycHDQawSYEygQGBBIEIAQEGgVhB2EYfLCJZgWQDBoEcL?=
 =?us-ascii?q?gGFbYJlAYYphD0nD4FVRIE8glIxPoJhAQOFOYJpgiaBDplXUngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEgQwMqNC0jSwUtHYEkIR0YE2A9F0CDSR0GaA8GgRIZSQICAgUCQDqBZ?=
 =?us-ascii?q?iIGHBICAwECAjpVDIF3AgIEghl9ggoPiDmBCQUuXgIBC209NwkLGwY9lRBRg?=
 =?us-ascii?q?w9ZpzWhRTQHgjiBZ4FkDIoulT4GEy+DcQGTYA4GkwWYIGYijWabOYF+JIFcM?=
 =?us-ascii?q?xokgzZPAxkPjiEZhBqBC8YnQjUCCTECBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3DaUIKHJBUVloX4FpLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:EOjXoGGs5fwgd1D3qmI5z2sSMdkVK0eFyS2NLHeJO2JkWaysHAo=
X-Talos-MUID: 9a23:aZ9YpgYrO4PwCOBTnRvGnxpjP+FS3f6iVW4OgYwl4Y6KDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,220,1758578400"; 
   d="scan'208";a="131653163"
X-MGA-submission: =?us-ascii?q?MDFpiDayc29rauHw3QGKvtizqbhH2ded9+X0Gg?=
 =?us-ascii?q?vWqHXLW3r7K7dtVcGSd8YEwtPiO6A3BZkfzGWaijxFGkkRR2utEuK4kQ?=
 =?us-ascii?q?a/k4Ym8mO4GLuCCuYGPDkKVoJXj54YMnmAGVm8aimNEYCNo5q2BsGGHZ?=
 =?us-ascii?q?GKi4K48Lo7A2NtoLVzkHU7nQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 11:00:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763892037; x=1764496837; i=markus.elfring@web.de;
	bh=3ZAKsDFKf4qkhNNQJc2ReLxbmL0TeQ/6jWxxL9iNIxc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QTvld4ipcE+Km0kVlTv/+qHYP6kpFzijTxxJnvne4mvSznqrrUfovHU4meVSA743
	 mox5/RvyusMc+Mk/Svnc9q62HmgTDR62YZNAAhVUWNTyzRUGTS+fAHbgd5ZWhtnWL
	 mfVMG9GMDJNGpM/i19Zg2jBQP8bqglSwTer/Z5dWmikeDzliIj7k3P73UqMAI7tGe
	 7wnG8oEE82dXtFjzJN2ChYG8jscGFVWv+knvPiCBUDYQlso/zuUABmMEW3XEEp1qW
	 XWdGPqSIuzru6p4N2XUxtLAnCxGgzLtjvwrRj7+wBVSzmhbJTzZwGTDIxfsCSPUTi
	 adyFkSf5dd8goKor5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.252]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjMM-1vHdn72H40-00GL6T; Sun, 23
 Nov 2025 11:00:37 +0100
Message-ID: <4243db25-4d9a-4d60-adba-b1feb9ba6996@web.de>
Date: Sun, 23 Nov 2025 11:00:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <228c50a2-bb15-4abe-bef9-b0f9b95f6992@web.de>
 <7cea8a1d-31ad-4475-be80-ef1cb1e3b2d1@web.de>
 <188e41fa-91c5-b09c-51d1-8f69f5d8cea@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <188e41fa-91c5-b09c-51d1-8f69f5d8cea@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Vxe+sU4ossmYm7qdMFznKqb18UAALi7VcKA9wxsUqRQVXsSPbrx
 itIgrplQXwvJIr1jnTd0OJNQvXmxXJl1m0QhSEIP1Qrfn1weS+gNUfl8JNOAid8Xh23fEi0
 0YycJqpAps86qnZ1jCtIILQbDnK9MxmP1bupG3JXfB6WmLZ5PyKeXETe7nQdotprwrhMds+
 pJal96UkfV/IQETGdBN5Q==
UI-OutboundReport: notjunk:1;M01:P0:qqGC+PB2NU4=;sqSPUCqfOVILX3AQalX+W0Gi1uj
 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
 vnkjkuyk=
Subject: Re: [cocci] Avoiding duplicate elements in SmPL disjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3193
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/4243db25-4d9a-4d60-adba-b1feb9ba6996%40web.de>

> iso_pattern.ml

Do test results indicate that data processing for isomorphisms is still so erroneous
that this functionality should be deactivated until the implementation quality
will really be acceptable?

How can it be switched off?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/2d5df416a939c5c7b9d958559be3b63e0b1414fe/docs/manual/spatch_options.tex#L93-112

Regards,
Markus
