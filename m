Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876EDC83F25
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UufkEjWJcclPYDaltsDNVjMmhjsp0hEEc3FxoC4kWbg=;
  b=Lr8sVW6ksTcF1hzCkKXrwZMYoy972e+VRBa2LAejIKwYVKNvbqKTxv2E
   hgt+8MF2VErP5t1ELlccUpdA2aE6A65wPA9GgDgw/370ZFOGSfMMfgYXl
   b3UQyErDda61fUZVmi36krsfD5VbCQ6q0I5OkAR9COAVv00k5x0lfwP6/
   8=;
X-CSE-ConnectionGUID: ZM/vxs55R+y2nW1Q4zTyAA==
X-CSE-MsgGUID: SNXgFQS1RwenpcJ/D3YQDQ==
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
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232451452"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 13:21:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9920AE0CD5; Mon, 21 Jul 2025 13:21:19 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D5FCBE0171
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 13:21:15 +0200 (CEST)
X-CSE-ConnectionGUID: N3L/YW6OQX+gVI8uzEWnew==
X-CSE-MsgGUID: kMHALmYiTga/oGj2XhiZsQ==
IronPort-SDR: 687e229f_ZLf94PUq5+p5zFY1SFeRcXm4fHhGchvwM1fkYHa1clp/92c
 HTXZtt3xQDjEtqCAk2rDecErQK+i1VC14scPfcw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GMBgA/In5og07ASNlaHgEBCxIMQIFVgkKBBlQzBAtJh?=
 =?us-ascii?q?FWPUIIkhDuHPIdUiHiDUgIPAQMBDU4BAgQBAQMEhQACjBMCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEhGQcOO4V7DUkBE?=
 =?us-ascii?q?AGCBwGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJWB?=
 =?us-ascii?q?gEUAQGCfoIiAQYQAQMOJAevUIEygQGCDAEBBtpeHywiWYFkCYEbLoVtgmQBh?=
 =?us-ascii?q?ieEPCcPgVVEgTyDAz6EQ4NbgmmCJoEWg2WNBod8UngcA1ksAVUTFwsHBYEgQ?=
 =?us-ascii?q?wMqNDEjSwUtHYEnfYMNgQ6EKCtPgiJ1gXlBGT+DUx4GbQ8GgRgaSgICAgUCQ?=
 =?us-ascii?q?0V3QAIBC209NwkLGwY9kmKGJTgHxnQ0B4I4gWeBZAyfawYTL4Nxk2AOBpMEm?=
 =?us-ascii?q?QYiqR2BfyOBXDMaJIM2TwMZD44hGYQawFxBNTwCBwEKAQEDCYVGAQGFFoRmg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 /Pp6bb/MJhVKYDxnUBvOAESoQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZNKzeq13RJ2VqL7NwEscJQqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A//3+umg5yenIaPOL6sc05tPXcjJuVCb5i0bvfWi?=
 =?us-ascii?q?BOSVmdpzFVE29x6VpjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AGAYuGA1teXdHsRIUw0NeS2C+mTUj4IGOIWQIoJQ?=
 =?us-ascii?q?6tMDDMgNyYQedjQase9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="121840383"
X-MGA-submission: =?us-ascii?q?MDEs3FLhYDC1o+IE9EFNJy3TyWN9KKcFnGPKwO?=
 =?us-ascii?q?iWNKDMsNRNfKag637sJUpSkuGx9yByaOHiCWbsmtjGSu2CiIdpkXlV41?=
 =?us-ascii?q?4IAu1YraNGMUn5qs05Dg0Z3hITwNUragIASXUxpn3lDjdZzrm48HbBGV?=
 =?us-ascii?q?8hExxSJj2Us8ZMLu2dmOPqgQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:21:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753096863; x=1753701663; i=markus.elfring@web.de;
	bh=UufkEjWJcclPYDaltsDNVjMmhjsp0hEEc3FxoC4kWbg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RQIsZa1hx7OY6lnP8ARd+rgjNVusbjWX7FDUhwUpDiE0Dgw7A4ZpuhsjpkVr/a/o
	 A8IJaWG3bXSHeLNgMMCYbXcVJtXNP7aAA+xiUR0J4pR0S6WRE6OGvQPB+2P1GfwjY
	 xG8yOxsimVpJIr/EohYdouMVvV4k484pz1hC23EHNF2d4gnsFHwjkdumCW9DTzFpZ
	 NnQJ89WL4JWALmAUkmPojsQpyrWIHdWOBKrHGbWVMzJRwLFfHQIuCHr3K1MYqF5ZZ
	 h3vxXVFLfVO+9EIGP/JI6ydnzOdXC8/b2nlwB+donH4tURy5P8F4BvGEoabhNhRZF
	 dexJQmMuy2VBUE3eFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZM3-1uBXIF31hJ-00KIwq; Mon, 21
 Jul 2025 13:21:02 +0200
Message-ID: <457ef653-08a3-48db-89ba-6f0e9153e563@web.de>
Date: Mon, 21 Jul 2025 13:21:01 +0200
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
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2914d20-68da-a23d-6345-fd48f0b9bed8@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/29w6eyJ+mcoK5gW7oHAPzjXPqVBDox++0NlfGmd8JiBQw9oTvl
 Z0/l91o608oWxXUBDFQ2lCeaSQraPpn871NEPxAeaZ8FUExKFbz6qmBg9jRcLbLzMWZ9p2H
 pPEh0kgTwI/7aZy+Sw/+wBtUzlyiUS6oDphtmtrLruy9NCHCjwJWcGFsOOZPTbOrJap0UFZ
 8V9qgr8mebkcSUPG5iWTg==
UI-OutboundReport: notjunk:1;M01:P0:kqwAxpnG8XI=;bMqu1P7JL7SsFNtcoDayq1uZXny
 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
 /j6GyOhbMjw==
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2894
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/457ef653-08a3-48db-89ba-6f0e9153e563%40web.de>

>> Can you recognise development concerns better from another SmPL code va=
riant?
>>
>>
>> @adjustment@
>> expression e;
>> statement s;
>> @@
>> -if
>> +my_result =3D
>>     (e)
>> +&& true;
>> -   s
> And what is the problem?

I would expect that further checks are needed for the determination
if remaining parentheses can be redundant.
I find the knowledge that is encapsulated by the metavariable type =E2=80=
=9Cexpression=E2=80=9D
incomplete so far.


> If you don't want the parentheses around e, then remove them.

How would you determine if extra parentheses are actually required
for a part of a recombined expression?

Regards,
Markus
