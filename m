Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26B6CA1012
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ii8ViAXnJyWQQAV4VcggpIcJACmBpu8uMpsTEXH+V2k=;
  b=qzf3rN9SKxMd8qJmF/DygvIWJRuHIRcMLWf4JJH4hlB/J0ntFpzmmSwg
   OH4zKTdang9TZI/8T9DGyMizvykP+kMXAMKJs2Ch2PxEOCvJcqiYv6ejc
   xEXuZnRVgGNwD6MP51XdeXK1rToAI0JBeZ65j+WWT51IUgPTt/YkGDcpW
   E=;
X-CSE-ConnectionGUID: fCusX5OjQDWX98+WJIoItg==
X-CSE-MsgGUID: TtEsNPSiTk2O1ipIQdHK9w==
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
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="237814110"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 14:30:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D45F5E0172; Sat,  6 Sep 2025 14:30:16 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D0A1E0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 14:30:11 +0200 (CEST)
X-CSE-ConnectionGUID: ViNWU9JOTwKNXHyovEagCQ==
X-CSE-MsgGUID: MryTDBGcTquZrSLw0a3xkg==
IronPort-SDR: 68bc2952_FqNh0o0NYW4JERIzS7AMi4lD+u7J2Q30Rhr7G3jp3UwzntS
 FodeMLovMzCI1kfd7SS4xpyB7Ya72jRO76OnuQg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FSAADjJ7xogAwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYI/gQdUMwQLSYRVj1CCJIQ7hzyHVYh5gVWBfQIPAQMBD?=
 =?us-ascii?q?U4BAgQBAQMEhQACjCkCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEXAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ+giMBBhABAw8mB7FMg?=
 =?us-ascii?q?TKBAYIMAQEG2l8fLCJZgWQJgRsuAYVrgmQBhicJhDMnD4FVRIE8gwM+hEODW?=
 =?us-ascii?q?4JpgiaBFoNYjFiCd4hFUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEneYMHg?=
 =?us-ascii?q?Q2EHStPghxygXQ+GUCDUx4Gaw8GgRUZSQICAgUCQz6BbSIGHxICAwECAjpXE?=
 =?us-ascii?q?IF9AgIES0ACAQttPTcJCxsGPZVzhwgSRpJGsz00B4I4gWeBZAyfbAYTL4Nxk?=
 =?us-ascii?q?2EOBpMFmQYiqR+BbwEygVwzGiSDNk8DGQ+OIYQzuilBNTwCBwsBAQMJhUYBA?=
 =?us-ascii?q?YxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 xRwhgYsOYwQ
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:WEx/rK72lyfMq4f0CwPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3ALygMrGgG2b8es6L25KH4++otMTJuTHz780qBAWi?=
 =?us-ascii?q?EFkVPeJ2ETkG98axPqp87?=
X-Talos-MUID: 9a23:ZN/y2AsQI9QPmswe0M2noStzCOtCzK+SEV0/i64ipJGNbjxzNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="124822392"
X-MGA-submission: =?us-ascii?q?MDGEZEXHS/Gd8gEyqjlhQnhNDwmQQmxj9Y0ChS?=
 =?us-ascii?q?G7c9hixtbAsbwSlV6xkn7D/0hT0KRwgjiDN4hJ9Vc5rGegBmyfk+4qH7?=
 =?us-ascii?q?GsLboIrr1vi7T/sYEnERS0vFDnt8ZexYYEZ1kMO+nKP7BjRnHv5tjcf3?=
 =?us-ascii?q?U2gRxYujJd468UKxQ0PIrqWA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 14:30:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757161809; x=1757766609; i=markus.elfring@web.de;
	bh=ii8ViAXnJyWQQAV4VcggpIcJACmBpu8uMpsTEXH+V2k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y8tWEgsLHfv+coFUNLC+RnGcbOTY5zBGem1zd//5f8DDJXSFQb/u59fhXyjiBSMX
	 UecDjp3QJjAHq0dfHaLIBAe1lHYoz1KAh77d5sbfNvQ2oPmIW3+6BkSEAJgVpOZjP
	 0jwlfFdL00RpBYCnpZS/DoOP7mx9MuG4K9Vq9GlUS3snocT6RUyWNNX/sys4LW0xY
	 CFe43wDT72coRjP6aOx+1MnDBWkagEg19BOQL9Mfbr+xvlJAzu9uy+wZe8ZJ2k43L
	 RuzQvvVTIr/rDMgIqDUQayBrkcKpzUxGvYNGPVVdkjGbu0ybyLIDw0qWfvRe0S/9B
	 eL3mM7U0uDDV52MyHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0ZsE-1uY04z1sbE-00y0Cx; Sat, 06
 Sep 2025 14:30:09 +0200
Message-ID: <360bb5e1-9a03-42dd-a009-818021ade0a3@web.de>
Date: Sat, 6 Sep 2025 14:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
 <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
 <b0221946-43a5-43c0-8573-32c12e149681@web.de>
 <ba87aeca-594d-10b6-960-cd4aa1fcd1e6@inria.fr>
 <d28c6f76-6708-4dba-a446-910170e27572@web.de>
 <b2e58328-97f3-4f1-e588-4647c6ff30d3@inria.fr>
 <13ed7845-6fd9-4a8e-9670-3d2b7e7a0f4e@web.de>
 <ce7a7254-bbb3-4666-8a57-2e6cccaa51fc@web.de>
 <4959806f-e03e-9a59-63eb-f71b6bf6f954@inria.fr>
 <469a978c-5b6f-4cfd-99c6-69671de653ad@web.de>
 <e630c74d-c125-9d12-6bf8-59d1f5bbaafe@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e630c74d-c125-9d12-6bf8-59d1f5bbaafe@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O5eUMVoD8c7Bi4FgYkMI9QmRsRgOB9KBPri0+cdV4NCsrevBNxM
 HK2IRt9cOA45nBBWsAu2YLPJmYn9EQg/2Otg/xkGnmDJtKC6VhrFgjFzyrRTjR7KMFyBxF2
 bR/qMNYRfLrPgeXObqw66+pOmFW4PX86QFatLy7VZ/AXrgsNlmuT7lTPX3PRb8GtYVpN8Ht
 mZ3UiQ5YaRJAGte1DnI2Q==
UI-OutboundReport: notjunk:1;M01:P0:ra1xQzHNQbA=;lyZIU1vEZK3fTH/PPyw7xv42OyQ
 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
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3007
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/360bb5e1-9a03-42dd-a009-818021ade0a3%40web.de>

>>>> @find@
>>>> expression e;
>>>> position place;
>>>> type t;
>>>> t * pointer;
>>>> @@
>>>>  pointer =3D e(...);@place
>>>>
>>>> @display@
>>>> position find.place;
>>>> statement s;
>>>> type find.t;
>>>> t * find.pointer;
>>>> @@
>>>> *;@place
>=20
> This line certainly doesn't work.  It is searching for an empty statemen=
t

I would like to interpret it in the way that there is an end of a known st=
atement.


> at a place where there is an assignment statement.

The first SmPL rule determined that this can not be empty.
Is it possible to avoid duplicated SmPL code here?

Regards,
Markus
