Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E7CC83F27
	for <cocci@archiver.kernel.org>; Tue, 22 Jul 2025 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GZLLDvDO2bWkpO+bnxh3L8BSjBs/re7l3Bt0LiyXox0=;
  b=lQpcZRT8mJgKz1o9/O4d387LP+q6VVzkJAV8KgKwQS5SyOM6a+FgC0iQ
   6vRrNmKHcRiDi6AgFz7sK/vUIpq+isuxErKIEP0tT+u16aeCpjTI2VLbm
   +0NT8Dtj6rZbSEEQBDOjjcFzabsAABZxCOn4sBo/vs3qHdGATcqevswbf
   c=;
X-CSE-ConnectionGUID: fACk5gUZRJSn/0BAIPt/3A==
X-CSE-MsgGUID: w+fdVBTTTIitaZPDvUT3YA==
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
   d="scan'208";a="232617472"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jul 2025 13:26:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 697D5E0264; Tue, 22 Jul 2025 13:26:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 28196E0171
	for <cocci@sympa.inria.fr>; Tue, 22 Jul 2025 13:26:53 +0200 (CEST)
X-CSE-ConnectionGUID: czGxc4WqR9q4QNKKbHRFPQ==
X-CSE-MsgGUID: d9Mj8VupQy2HxKmb0M9vhA==
IronPort-SDR: 687f757c_7RIX9HSQZlhdHDGsdji/CJ+96fBzTsKSHqI6pvKF00qqnI1
 3wYy0yoZdXYprmDQ6ry/EA3+OuboLjbYDXGoKsA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GkEwC9dH9ogAMP49RaHgEBCxIMQIFIC4JEgQZUMwQLS?=
 =?us-ascii?q?YRVj1CCJIQ7hzyHVIh4gVWBfQIPAQMBDU4BAgQBAQMEggyCdAKMEwIeBwEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxh?=
 =?us-ascii?q?XsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMEGQEBEScPCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgn6CIgEGEAEDDiQHsG9/M4EBggwBAQbaXh8sIlmBZAmBGy6FbYJkA?=
 =?us-ascii?q?YYnhDwnD4FVRIE8C4J4PoRDg1uCaYImgRaDZI0GiApSeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SBDAyo0MSNLBS0dgSd9gwqBDoQoK0+CInWBeUEZP4NTHgZtDwaBGBpKAgICB?=
 =?us-ascii?q?QJDRYEZQAIBC209NwkLGwY9knOCKgmCC8gQgQo0B4I4gWeBZAyfawYTL5dRD?=
 =?us-ascii?q?gaTBJkGIqkdgWg6gVwzGiSDNk8DGQ+OIYQzwCVBNTwCBwEKAQEDCYVGAQGKG?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 klQqVsXBZsePMv31h47AmQ=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9EaFxaMBKpw1g8BcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3AMUz/Bmm9tRbc5a1GjUMaTz4PcLvXOXbP42fbf3C?=
 =?us-ascii?q?hMzdwFISzanya2JlKq/M7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A+cOtPwzbbL74QJZQVkL1da6+xKyaqKj/LUJdr4g?=
 =?us-ascii?q?egtjeFTxTPj3FqWWpQqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,331,1744063200"; 
   d="scan'208";a="121934325"
X-MGA-submission: =?us-ascii?q?MDGZgvm1jj1xNycW7Bfr07lbJhhBhLE96UhlF+?=
 =?us-ascii?q?CVPPq8BrGtDLx/CTcZa73MVa7n8qus1RvY1xz1knuK06VnwJA28aFnxD?=
 =?us-ascii?q?mgl0KgGG04Y/BrwW81VUre3dq5ruQv8mmXlR0drVRlTzypEEBiPrWi/c?=
 =?us-ascii?q?XjgNQkqBPVp+BF1yr+ravEPw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:26:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753183612; x=1753788412; i=markus.elfring@web.de;
	bh=GZLLDvDO2bWkpO+bnxh3L8BSjBs/re7l3Bt0LiyXox0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r8yM3Wex6yPUn2FUicLqgDU/LKXq9O7FFp8PkSTgvEfUsa00raCUGvP/pAaLcL/Z
	 U2hNp194veSSjThfXAxXDnfB6c6MHGDX155duKE3/AASCtCMtCVd1ifHhCzeaFaBt
	 WAjLJQf60jMy/dd5qcSH+nCsOPKIw2nO2ocDVbBEVj8TH1Lak9aPb4hmKkLn0x7Ff
	 +NUxVqZpYgBsVsSmeZw4fT7yn41ocJMRbo8YVWx8QmvpWkBuWV+WpqFrplZBOijzL
	 qLWdwjRzsNbOr71wUirDekC1JPF9nV27AorkC9IcMUHNwHoQMOwfOuU61xe1GwIW7
	 6Q+/WIKDmfzw+zTeoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UgI-1ufrAf3GSA-00qvfr; Tue, 22
 Jul 2025 13:26:51 +0200
Message-ID: <da08790e-4668-484d-b074-4f2797688156@web.de>
Date: Tue, 22 Jul 2025 13:26:50 +0200
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
 <9083bc25-b9ab-40ef-903c-f26d9670c112@web.de>
 <8ef830f6-6ab3-e5de-86a3-771315bc90d@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8ef830f6-6ab3-e5de-86a3-771315bc90d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xrDiw06jhI83ZH+0Ij56WsH6wspgrG6SwBne1cj/03QMgXn1rij
 O0N2q58JBFOKWSUxyIoDv6yFoHEeCbWMhzwzX82z0AhcY4PKOQ8xlHZxyDLF4gjzYpmg2Nu
 RFQ6DulFq49p4eE9jkFnvnkpvA4+FBnj67t/sQBC+G2BUx73ldAcai1jv7HPRKPE60ZcIZ5
 Fns0CRkaSbySuuvdM7PVg==
UI-OutboundReport: notjunk:1;M01:P0:jJswKtcrX9Q=;r+9htizrlbKDPpLE1dF/D6ArHBD
 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
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2901
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/da08790e-4668-484d-b074-4f2797688156%40web.de>

>> Another SmPL script example:
>> @replacement@
>> expression condition, context, x, y;
>> identifier action;
>> @@
>> -if (condition)
>> -   { action(context, x); }
>> -else
>> -   { action(context, y); }
>> +action(context, (condition) ? (x) : (y));
>>
>>
>> Questionable test result (by the software combination =E2=80=9CCoccinel=
le 1.3.0=E2=80=9D for example):
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checko=
ut next-20250722 && time /usr/bin/spatch =E2=80=A6/Projekte/Coccinelle/Pro=
be/use_selected_call_with_ternary_operator-20250722.cocci fs/xfs/scrub/fin=
dparent.c
>> =E2=80=A6
>> @@ -229,11 +229,8 @@ xrep_findparent_live_update(
>> =E2=80=A6
>> +               xrep_findparent_scan_found(pscan,
>> +                                          (p->delta > 0) ? (p->dp->i_i=
no) : (NULLFSINO));
>> =E2=80=A6
>> @@ -269,10 +266,8 @@ __xrep_findparent_scan_start(
>> =E2=80=A6
>> +       xfs_dir_hook_setup(&pscan->dhook,
>> +                          (custom_fn) ? (custom_fn) : (xrep_findparent=
_live_update));
>> =E2=80=A6
>=20
> Why is it a surprise to see the () if you put the ()?

Am I forced to specify additional parentheses for the desired source code
transformation pattern because I can not know so far if the found expressi=
ons
would really fit into the recombined expressions?
Should pretty-printing approaches take care of corresponding format adjust=
ments?

Regards,
Markus
