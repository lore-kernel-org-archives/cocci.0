Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2977CCFA13
	for <cocci@archiver.kernel.org>; Sat,  8 Nov 2025 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CJkMZIwty2g8m+ngsdLAXnvGPo/Sv/bqgaElcsGH/Wg=;
  b=cIaOWnOuuUQDro3GzJLr69MAnheA8yQrNti9BFbrfFjhlQMk581XdN/o
   F8+WQspWRJnOKFDcrDH4vh/1ICNnHcF2OnOpU8lbIm8eB9zW93arq6Zww
   MxRkBskdz0GYfTBF6eSeoDXa+YJK7WoZAYvhoX3VqvYrb8Ta4a6hPKScb
   I=;
X-CSE-ConnectionGUID: 3XTd2oqNTTKw5CwSFfhCZw==
X-CSE-MsgGUID: rv4Zp7KDRWGO8LLCpAMulg==
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
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="248309542"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2025 15:47:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 436E9E0264; Sat,  8 Nov 2025 15:47:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 58DA0E0171
	for <cocci@sympa.inria.fr>; Sat,  8 Nov 2025 15:47:42 +0100 (CET)
X-CSE-ConnectionGUID: FnKprP1ZQoaQPcRSiyEAXA==
X-CSE-MsgGUID: Z40KkwRGQoaFlbBPvPDw9Q==
IronPort-SDR: 690f580d_CxkufS9B+bTAEoIrV0j2ey1fLYnJCCQkFqdXTvoruwam3YB
 4ssb1tPPknCugVjfetoqf4ael+9b8+3p4ow12fg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HyBQBQVw9pgAMP49RagQmBUIJAZR0GWDMEC0mEVY9Tg?=
 =?us-ascii?q?iSEO48OA4pOgX0CDwEDAQ09EQECBAEBAwSEeAgCjFoCHgcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAg06RAEBAQIBIx0BAREmAQ8JAhoCJgICVgYVAQGCf?=
 =?us-ascii?q?gGCIgEGEAEDDycHDQaSQJxGgTKBAYIMAQEG2l8fLCJZgWQDBoEcLoVugmUBi?=
 =?us-ascii?q?Wx6Jw+BVUSBPIJSMT6CYQOBX4NbgmmCJoEOiRWQQVJ4HANZLAFVExcLBwWBI?=
 =?us-ascii?q?EMDgQsjSwUtHYEkIh8YEWA9F0CDSRwGaA8GgRIZSQICAgUCQDqBaAYcBhwSA?=
 =?us-ascii?q?gMBAgI6Vw2BdwICBIIZfoIKD4QSgQWEb0ACAQttPTcJCxsGPZUGLIJJgT8Ce?=
 =?us-ascii?q?4ECxn00B4I4gWeBZAyKLpU+BhMvg3EBk2AOBpMFmQaOCJs5gWg6gVwzGiSDN?=
 =?us-ascii?q?k8DGQ+SITO8BkI1PAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5S0Rbqvwu1ovEDt2e5pe7TLp7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:wYwbGG8cAQ/2ycGOVfOVv2ASOdg/SiTv9XDZGnezM11oWZC8eXbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AlaXwpwzYy1VURc+edRWiWGC43SqaqJbyUGMOjq8?=
 =?us-ascii?q?pgs6NGyh6EQ+DtBioE7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="130341737"
X-MGA-submission: =?us-ascii?q?MDGusLUEG8iTg0qou63qX0vn9uDvdxBWUsOt8u?=
 =?us-ascii?q?9o623zkJzOXrw9zp48ieJxGWWvIDd/kA3BenE9iCmUC7lB8CHbTaifW4?=
 =?us-ascii?q?PPSYd3J9nfvbTcHh+P1UsH90331/Cf5MngVjWFcDso/jIbibMj4hjxz9?=
 =?us-ascii?q?GYDK+FVzzG/CcB75ExS9OYgQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 15:47:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762613260; x=1763218060; i=markus.elfring@web.de;
	bh=CJkMZIwty2g8m+ngsdLAXnvGPo/Sv/bqgaElcsGH/Wg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I1dNhIP1vsS1t5fU1iwRo4bE5A+raGh4MKN7O5uJaWH+6Lk4hO+wTsVstKir92zU
	 b2bxN0XOwEualFm2oyNaHed0w6Osh0aI8REw8MryFddxe8BsmEe6Iu3ozr4NUG8oh
	 5nv6zs6aFte6tPm0aFlsC5bKldmWawjPQyEwsa41z7EbMlWVRkTR1EmBmPOsx33z1
	 4K4mwwcvwbRfNEYCz3vDDARBQvKarzM9Ad8Nvv8ZzfzL8mBZmN1XRy9z/F2Q2Q6Zl
	 /2ocTZtVk56UwZGgTTWatHFjB3lkW5UX1KMWVpveM5PNJVNs4XGvO2MpSUG0nKesL
	 YGA9P5bll5aL+DjMTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4bO-1vNp2c0iAE-0046fd; Sat, 08
 Nov 2025 15:47:40 +0100
Message-ID: <71e805cb-29bf-4fcb-bd90-9d012f977c4f@web.de>
Date: Sat, 8 Nov 2025 15:47:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
References: <7e3a6e91-b89c-4fb6-91e3-cf43313b9e20@web.de>
 <BCA1262B-159B-480D-9FFD-CA6318D3BDDB@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <BCA1262B-159B-480D-9FFD-CA6318D3BDDB@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z0hT33Gzz6dNzuc2r1znYJyzWfWCh+BWgcWJNBN9I1kiCJJphnP
 8ogFxxZnPq13tUxaDo4eXWYmVVT40Nr1q/RlspcZ6popU3vzQDdhIBE3NtDXWydpzbTsBlG
 hDDVM1UhP8izd2lD0DPCFLseSHv51MEYQWiB20/sRlqOeUUfO+W2ohPmBEoGY/HElq4/GUc
 vC5aLEh78ckJG5Iy749Gw==
UI-OutboundReport: notjunk:1;M01:P0:EAONT0Ul/Dk=;DNc9pl0dfQTihlQQyFnRBb0qHWp
 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
 TcqeQ==
Subject: Re: [cocci] Searching for switch statements with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3145
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/71e805cb-29bf-4fcb-bd90-9d012f977c4f%40web.de>

>> Which SmPL script variant would you find more reasonable for the mentio=
ned
>> use case?
>=20
> Just remove the <+=E2=80=A6 =E2=80=A6+>

May switch statements contain multiple cases?
https://cppreference.com/w/c/language/switch.html

Regards,
Markus
