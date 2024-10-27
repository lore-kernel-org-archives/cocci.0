Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1E0D1356C
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Sx3uvxqxYQZt2O/9O6S26fB7ltJ2uRXqxkD6n+1OdKs=;
  b=AQNjdVk3bbCnAzZt5a8FQieAvisHsab2OuYBuAQHIDTpWFmLiow1214V
   oO4K8txFDqJpd0z25PDGQDmNHyou/iwM2nMp6aKNVHC7qsVS1AGNIMmLn
   Ca/7K4Apmq3Gq79o9LSWZayN3Eja6vOC0JEqGPsT4Yk2KApl6xPc/CaoI
   A=;
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
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190922259"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 16:15:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E388BE0D1D; Sun, 27 Oct 2024 16:15:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 676B4E00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 16:15:51 +0100 (CET)
IronPort-SDR: 671e5926_h4WqNti7gg58Xk+CAJN3QJRM/iH2q9QFfTDvpPaJE+vxWiA
 +I0hjADK2Mo8t/i31l0Dyd28muSOC01NzzNdqPw==
X-IPAS-Result: =?us-ascii?q?A0H1AQBPWB5ng07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDYnUzBAtIhFaPTYF0gQ+DXIc6h1WIdYNUDwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IUAAoonAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBAToHDjuFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMdAQERJgEPC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn2CMAEDMQevPIEygQGCDAEBBtpbHywiV4FjCYEaLgGFa?=
 =?us-ascii?q?YJiAYYkg0J6Jw+BVUSBPIJSMT6EQ4NbgmmCY4MxhDUliDdqkUFSexwDWTIBV?=
 =?us-ascii?q?RMXCwcFgTAyMAOEdVt/gTuBUwFGgmZKg0gcgUUFOEmCTWpLOgINAjeCJCRZg?=
 =?us-ascii?q?lCBJQQFgzqCOR1AAgELbT01CQsbBj2cLIJGGYFhgTpjxXs0B4I4gWWBYwyfV?=
 =?us-ascii?q?QYTL4Nxk04OBpJ4mHciqH+BfSSBXDMaJIM2TwMZD44hGYQUzA9CNTsCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGKaoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:IEMSRaMqK6gvvMBcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:eSgns2PylDC1LO5DCRJ4y04+KsIZYyPG3CeOe32jMVdPV+jA
X-Talos-MUID: 9a23:+8oi3gh6vWRfuZC8j/YoxsMpDsN55IKULFw3zs8olJSlJAVTAguepWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="100137274"
X-MGA-submission: =?us-ascii?q?MDFKHf1iN1+Fy5r+nHpHIXjFq3dl68R15MqVKf?=
 =?us-ascii?q?TI/tla3OB4IWsfO78uyYviXudr+Pu0Hur/MxBmqh0bA1KVgXxH05nvZ3?=
 =?us-ascii?q?0yLsaFgHhV/M5YaiMsDk6ZSCFn+gL0+P7LQDvjEaLQIqP1KbhZduRbHH?=
 =?us-ascii?q?bUL7B6qBPi/v0JvtBnoARLWg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 16:15:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730042149; x=1730646949; i=markus.elfring@web.de;
	bh=Sx3uvxqxYQZt2O/9O6S26fB7ltJ2uRXqxkD6n+1OdKs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hv94w0IzeyL7DmXL/sfcphMVZm9u2pc8jwYX0nZlBOSpBs1NEZ1UX5JsrzQymma9
	 HAbRZ3ta+z2+Sp4vZqJ/NuQ/DBbUs4IyettiIQdQAkfD7RqPaV1y8d7PSrA/tIkNi
	 PLlpCO32kozKPffF6KutllXISqgSjBBoyTP2bUv2bAfyLB2+aQc5MNsCv/KaId8rL
	 JkaTNPYiOSzcdkgMaHwzAIjwj42HvSjyTvYricyvd6/tuhrM2UHLf26ZjSp0Jo5J2
	 Vm6MOpwH7hDx/hzELadovaM0ES6eNs6UJ5ZB8czkDBS+o3V53Okb8CXVYwYX7rKYP
	 y7kqoXsfQOgsgTJm0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwA1O-1tuqlV1iL6-016FSI; Sun, 27
 Oct 2024 16:15:49 +0100
Message-ID: <186a1d10-709a-48a8-b904-66d86cc04235@web.de>
Date: Sun, 27 Oct 2024 16:15:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: "Derek M. Jones" <derek@knosof.co.uk>,
 Victor Gambier <victor.gambier@inria.fr>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
 <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
 <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jly/fP4P50C16ZtEbOumaJvjwixdYjabPvd4DazQKrwNQJvj0Ee
 4N55Dr9jQUFvxUc+iKuqBp4F8FdqHR29V/Lkz80lTo217Txf8RADCyAtU66s1fxe4J7Q1rL
 dWpMxchmD9oaNMp45U0wg4AzJz+L2ilPsEAxhGblR+3z968rzb2xBt3nqeLHH6RX57mt+DG
 x9YOvNLt9zk+y3z/ZdQHQ==
UI-OutboundReport: notjunk:1;M01:P0:MRZjgXA4wg4=;7cKjdiZd2LE1fruekk7fXpx7uo7
 noyrcUidNVXqvOdi7I3Pm1VsnPWrGx3h7IoNp9BibYEdvXpld7Z0N0AE0CCuCVDOTUDXVIbtH
 jD2z/LKVNG7dF8yk0u+HkYtbu3Ro2ZePbNFHF9IF6lhD+ruGwjytOcSlAfgrDCxnGLkDqYxQ+
 LYUv+zJJxFLKOhNOaQYhOMyK5rO+uDZ9jL/eBkzggHb5QqILEo2v/GCeZE52Cwk/RTokDXIm5
 O+/VBvJviHwK43RlKEDw0qlxmqVorTKvvel8sb8GZtfcyZQWAuoJTRkoGQ36EVPRvHW4D+XWI
 3/i/EionMJmYEHycC5UNYA9Z4hXSjU3/1twXTO2swZMWcwDhWcCB0Euhl0v1bZOQaXtBQuJhQ
 DEXYh9831+i+Ux1z055iPA/QPobb/e9NSV0YYf1M39PLzhUpxezoXOnWPh5cMJN5h6rBI8jZG
 d8hrMkgutmS4upAk+Q9+ZM715E79Aq9WlhWoMUzsZc0OY9ChSPqZdKuAdfNloYdcvXSsTTKlA
 wrJEQ8skL2K/Mnywy+XuOZsrSKJuIoliqNj8aHt8Whlp9Rzyw1R90PPbML6IkaPXQlkqSz8KI
 oGFeyz8N1mVU/HiX7usK7TbALwuxFtV+2v3Y6s4mDbyEFveEz4bl+2WBcC7lZInjJ38OtVlEM
 kSlP4FrFZT1s066OaxTBUgdmleKoOLGzuWHpYzy4ogBIbj47JjMKUd6BWORjbSfCBw+qkksbw
 IIXTyPp0jWbhLUPFRL3JCcmd7hrTpVxW/vtVwCOpuz3/Yk7+gAT2Bql2RLcxA4/z1U+Z2S/zm
 0+/cTcbyeaGatPbfWLSD4wcQ==
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1942
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/186a1d10-709a-48a8-b904-66d86cc04235%40web.de>

=E2=80=A6
>> @searching@
>> identifier f;
>> position p;
>> @@
>>  f(...)
>>  {@p
>>  ... when exists
>>  }
=E2=80=A6
> If you could make a semantic patch that doesn't involve 30-some lines of
> python code and would provide a minimal test case, then I could try to
> understand if you are concerned about the same issue.
Can you get further development ideas from the shown general source code s=
earch approach?

How will the support grow for better handling of mentioned macro code?
(How many of such macros should generate variations for function implement=
ations?)

Regards,
Markus
