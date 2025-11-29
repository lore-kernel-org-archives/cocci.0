Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362A4CFD2F6
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sWYY/G3jYdjMP01fLPZALAfFC0I9ek1qW2M7Sh78HOM=;
  b=Sa5+ZJPCGJ+VN8WeKTjI9bhdXoN+JSYsELIL6+2HrLrsh1H5WLP0ArsS
   nDmPaNhrWNz9LesZdUfb3xmrV0C+spYBBORcODqXm1W2vdGp9FoHy06rg
   /xYEIX+eVisBlJyXFHfaSkDspfTnm6eMgexxlnITw2OkkjyO9GLt1hZpB
   Y=;
X-CSE-ConnectionGUID: xIURej2DSpOVjJCQlFa1Rw==
X-CSE-MsgGUID: WI0OQRYtQA+seMILJ4DWJA==
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
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251888593"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 14:32:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B1B85E0157; Sat, 29 Nov 2025 14:32:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 777E6E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 14:32:18 +0100 (CET)
X-CSE-ConnectionGUID: kPrYmWAaQkqsCNwo1LPz+A==
X-CSE-MsgGUID: mWJwcHntTkWCH91vMalukQ==
IronPort-SDR: 692af5e2_MwEBnszMyqz6fV+vRoPGo6UNIC6pY39Uh2cwCrLiI5Jjs2T
 CgxFMSoPjnRBbAAGuiwfWI2KkCO2ivfRWejFpqA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FYAAA89Sppg07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0GAQELAYI/gQIGWDMEC0kIhE2PU4IkhDuPEYpOgX0CDwEDAQ1KBAECBAEBA?=
 =?us-ascii?q?wMBgUxAgnQCjGUCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBOgcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHRAEBAQIBIx0BAREmAQQLCxoCJgICV?=
 =?us-ascii?q?gYVAQGCfgGCIgEGEAEDDycHDQaxN4EygQGCDAEBBoFYQdhGHywiWYFkAwaBH?=
 =?us-ascii?q?C4BhW2CZQGKZicPgVVEgTyCUjE+gmEBA4Feg1uCaYImgQ6GJJMyUngcA1ksA?=
 =?us-ascii?q?VUTFwsHBYEgQwOBCyMPPAUtHYEjIR0YEWA9F0CDSR0GZw8GgREZSQICAgUCQ?=
 =?us-ascii?q?DqBZgYcBhwSAgMBAgI6VQyBdwICBIIWfYIKD4gLgQkFLoENAgELbT03CQsbB?=
 =?us-ascii?q?j2VDVCCLmIaP4FFpDqiezQHgjiBZ4FkDIoulT4GEy+EBI0ThjsOBpMFmQaOC?=
 =?us-ascii?q?Js5gWoDNYFcMxokgzZPAxkPjiEZJYN1gQvDXUI1AgkxAgcBCgEBAwmFRgEBj?=
 =?us-ascii?q?FaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:i8jB8KN70q8TOMBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:LTCLqG/n8zpXIuAOgzqVv00sAPEgTVTU9XTJOGSeFmEwbIWHCnbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A6jdasg1TXvqSmZmi01sd0foBuDUj5puMF0stl4k?=
 =?us-ascii?q?6uPavFX0pJRKUiCm0e9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251888592"
X-MGA-submission: =?us-ascii?q?MDEvlJj3IJA4vQWok4nyl5kN2ksY8x6QoOMGTv?=
 =?us-ascii?q?tLDESpdxX8UeRF56rYrmW8OmE0wb1fS1vEk3kgJZmslI+W4SACxdFIDm?=
 =?us-ascii?q?87IqD3x/VgfH+MlzOorsY/sCd+itXibTKh64x0cqX5hyS89oIGnkdBoh?=
 =?us-ascii?q?ZazSaJAusE9QstxkfoYiG32g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 14:32:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764423137; x=1765027937; i=markus.elfring@web.de;
	bh=sWYY/G3jYdjMP01fLPZALAfFC0I9ek1qW2M7Sh78HOM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JInddMeRTNNGpWjaFTG273MjbtIDaepZbKba532TPTZeJXlGF1pHmJOU6Kj+kV4l
	 I09NxbLexDGPt1iY5N7LOHp/aL49vDh19TfJeNgTbepIWOtTXVeJoeHhpBQA8D7Qo
	 3fW2VauDKtfV2LEvNAzq62qPs6xu1QbI5FGjbjCItumQxNQouooMHZBjzba1Y1Z/R
	 1+XNPnMZYQr1cxfhlwQoRMS57nWHfqkQsBxxLcnc/l7rBm9qSeEa9TtvIdr8mJv99
	 k4Q16YUpBViB6H/izCk+nB+7i12BuAl9/75mhCA/xliwGN9aw1CqhEYQAaRa1+Xj/
	 co6X2tp+pPsJKlIyBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovjQ-1vsIt50VgM-00awNp; Sat, 29
 Nov 2025 14:32:17 +0100
Message-ID: <8e9f7398-39cc-4ca9-bca1-c9f7fed60651@web.de>
Date: Sat, 29 Nov 2025 14:32:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2897bda0c438111e967017f6bb3422f0@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wt0Yl94oNsKMhWZhGYTPzxrYvWLoQ9Fy/JA4IS4JExH/QYYsImj
 xO0zFdfqfv5WtEoQdvhWfBGBTFVU+AH9gvNpkM4wzk1xRhRsO0hrqZAGirzUxGu3ehC+7rm
 iHpXfOfbXtQU4g0Ji2aTUsPO5Gn4psHbx33Pwqt7Y975Y0eJeNVxr6zg4EiYRKk1pBdaS9u
 LQ91n9UG8MtHcuW1RdJtw==
UI-OutboundReport: notjunk:1;M01:P0:9HA2KQnMSR0=;6LkXURFeq914H1nYvxovDqs3x3L
 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
 T94Rpj/4=
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3207
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/8e9f7398-39cc-4ca9-bca1-c9f7fed60651%40web.de>

>> The problem is that the code won't parse with the conventional macro
>> name.=C2=A0 Maybe you could change the macro definition in standard.h t=
o put eg
>> __SYSCALL_DEFINE0 in front of the function name?=C2=A0 That would be co=
nsidered
>> to be an attribute and then you could put __SYSCALL_DEFINE0 as an
>> attribute name in your semantic patch.
>=20
> sorry for having to ask again. Your suggestion sounds very reasonable.

Please take also another look at a corresponding information source.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4c9d00ae071800cb447ef=
affd753f3bb2be28800/docs/manual/cocci_syntax.tex#L255-256


> But I couldn't figure out how to match on attributes. I guessed it would=
 be something like this
>=20
> =C2=A0 @r@
> =C2=A0 attribute a;
> =C2=A0 identifier fn;
> =C2=A0 @@
>=20
> =C2=A0 a fn(...) { ... }
>=20
> But that gives a .cocci parse error:

You might point remaining improvement possibilities out for this evolving =
software.

How do you think about to try the metavariable type =E2=80=9Cattribute nam=
e=E2=80=9D out
for the mentioned source code search approach?

Regards,
Markus
