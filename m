Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F81CCF9EA
	for <cocci@archiver.kernel.org>; Mon, 27 Oct 2025 12:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cCX5z4kvrLPuPLxBlQEdQuBQjR1yH3Poo4jWnPyQ5Kw=;
  b=hYkFgX63oTj7b0S8D9mE2SWRDZoBAlZ+V0fjI/nJ42On/UoAf/RQa6CJ
   8qMwjnG9iZY+83f6Gk+4Qqt2gjviiXbmkIX7hqSUNKGm4nf+lPp4jTl3s
   4DqkFXgavxaXtM6LGEHZirYTN4zoDI/Rqsfc+7SVcYx5pCkx9I3+/sHCd
   o=;
X-CSE-ConnectionGUID: J/INit+tRMqCOPz+9IQeJg==
X-CSE-MsgGUID: iyBIDrk/SF2ulN34neYpIA==
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
X-IronPort-AV: E=Sophos;i="6.19,258,1754949600"; 
   d="scan'208";a="246308281"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2025 13:28:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 52021E0C55; Mon, 27 Oct 2025 13:28:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AD81DE0171
	for <cocci@sympa.inria.fr>; Mon, 27 Oct 2025 13:28:13 +0100 (CET)
X-CSE-ConnectionGUID: oVGgi9ibRJ+qDUxTc0hMqQ==
X-CSE-MsgGUID: oNmWLP5dRQ2jEiTz0o+0RA==
IronPort-SDR: 68ff655d_oVjlkwLTR4eOUYPaZzqoEEAAZJ0Vj5Q8axrLqdGUbrnjyCj
 iAocnXVuigm93EudxAcjLkbRokxlAJ9TP2tGveQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HqAAB1ZP9ogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8EAQELAYI/ZSNYMwQLSYRVj1KCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IIMgnQCjE4CHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBEScECwsaAiYCAlYGARQBAYJ+giMBBhABAw8nB7I2gTKBAYIMAQEG2l8fL?=
 =?us-ascii?q?CJZgWQJgRwuAYVsgmQBhieEPScPgVVEgTyCUjE+hEODW4JpgiaBDoYpkW1Se?=
 =?us-ascii?q?BwDWSwBVRMXCwcFgSBDAyo0LSMPPAUtHYEnIh8YE2A9F0CDSRsGaA8GgRIZS?=
 =?us-ascii?q?QICAgUCQjqBaCIGHxICAwECAjpXDYF3AgIEgh5+ggcYD4RCgQWCPwIBC209N?=
 =?us-ascii?q?wkLGwY9k36CB4JcgS9TRsYDNAeCOIFngWQMn2wGEy+XUg4GkwWZBiKpH4F+J?=
 =?us-ascii?q?IFcMxokgzZPAxkPjiGEM8cWQjU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 lgphwE4bel/rF/R
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3aZhzqi1eWqQLwrpEO26YvXRjHBQXgQji2hC6mlwRA09TyXqrb
 HKoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: 9a23:d4U61m63nxVLBu/vcdss83A7FcF0c3fn7jTJD3KoNW0xSJiMcArF
X-Talos-MUID: 9a23:TMfBdQW8VJDdykfq/DjKgQ5GDJpk2Z30Cm0MrYdevIrcDwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,258,1754949600"; 
   d="scan'208";a="246308272"
X-MGA-submission: =?us-ascii?q?MDGmNU/bFk2sS5GERlj6hZ7CDSmwYlM3DqcdqH?=
 =?us-ascii?q?+XTjznJV9f+XnGlCTf/P/ET1Ds0zNmZH99KyVt/jeo1cpUVK3ObPHUOm?=
 =?us-ascii?q?qdorZwTuz3b52jypCO0lOvLPeAtCMBp5CBLhY6Q4BJHyx0NjyezJudGg?=
 =?us-ascii?q?bGAPyqTPQyYw2s8MiHkRKGog=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:28:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761568093; x=1762172893; i=markus.elfring@web.de;
	bh=cCX5z4kvrLPuPLxBlQEdQuBQjR1yH3Poo4jWnPyQ5Kw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bSlw2mNTwBl2x7gxzxOGjlaTBaMvhfq2xnQVbTsGcVXPjuhZy4by1DTpdmPR6bZJ
	 Q3akeQrfb5+vGzPHVlfdslQPFit1vrYo/yNb+Op+owPVxzps7/obX2n0tDhgq167q
	 eZe456D9xV6PKRSzwvrZoVI+MjuW07aHL4gm2+fZTrT3N5CaEqKNAfBQDVBCWM4lg
	 /YxB3gojVI2SBSjxW0M/NdKoaqv7zSqrqgVmftZseCBPSQOBIcdKXfZHKLO86Eb1g
	 soNn3WFhnX1hj9faxlyG8r1bYouXibTmnwxO5B+aJGPijxovArKZP7Xv6Or4hoRnh
	 2T4IO3aoxK6q2mB1EQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCol0-1v4Wdw3hpo-002E8O; Mon, 27
 Oct 2025 13:28:12 +0100
Message-ID: <e71332b3-7eea-4d96-b9fd-21c9797a643d@web.de>
Date: Mon, 27 Oct 2025 13:28:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <67c4f12a-5b58-459f-b02d-cfa5e6275693@web.de>
 <ade38bd-6997-b95-cce1-74944218af1e@inria.fr>
 <d0112ed2-0cb9-4fb2-a8e6-0f94e8424d0e@web.de>
 <577d971e-60c7-d790-ea26-fd9862745a68@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <577d971e-60c7-d790-ea26-fd9862745a68@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Le02Ie4y6bz7lGWQaJSoexcnZnNFx9FRs+0nI6rSoJS9EkyPKAi
 PWXHS6oHlM+FW30ZXfDtUn2OqbioEMmOWn/xDfR+sduIvjmjaQad+SpaY3Et3dcz3zqhnGo
 LZkUIZTEDQWxmcTzk5bzpOczugVLzoW+WLDtO4WnKoChGFEH66tWPtQ0iUaurptHSn7A9Gf
 akEe/S1dHO4flAZYNYnBA==
UI-OutboundReport: notjunk:1;M01:P0:YLVVJ4CjT6o=;Ijx2k6cxae63DAaerinSo0d3ldw
 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
 eWon+oRdswEHaNuIp3CRMxQea8=
Subject: Re: [cocci] Searching for selected function declarations with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3103
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/e71332b3-7eea-4d96-b9fd-21c9797a643d%40web.de>

>>>> @display@
>>>> identifier i;
>>>> @@
>>>>  my_type
>>>> *i(...)
>>>>  ;
>>> It would work properly if my_type were declared as a typedef.
>>
>> Can such a source code search pattern become supported also with an ind=
icated fixed information
>> (without moving it to a constraint for an extra metavariable)?
>=20
> I don't understand the question.

You pointed the possibility out to use an additional metavariable
with the type (or kind) =E2=80=9Ctypedef=E2=80=9D.

* The selection approach would become =E2=80=9Cvariable=E2=80=9D then for =
the function return type.

* I might like to restrict the relevant return types further.


> Currently, the code is being parsed as a variable declaration, not as a
> function prototype, but I am not completely sure to understand why.

My understanding for the Coccinelle software is also evolving accordingly.

Regards,
Markus
