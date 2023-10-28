Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24553C0032E
	for <cocci@archiver.kernel.org>; Sat, 28 Oct 2023 08:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=HqeMf4HlGlJ4F2yDqjaI3kGlMRjlMT6EA410UwqwW9A=;
  b=HI9qlbewbqObIhAa9yRXFNs5jtxsGtu+FawBNBOoQjsVJHYdD7lXp4k1
   aqEvxcC8IFJtfZ3Ai4wl2l++wyfG5Kf41V5cp+wZB7sYjZGLa3T77EzTM
   I77suqa5u/Ngen1PBayGK1gDFP8xjintXCXKdQlLQ9QTK1s4UYjhPIaS6
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.03,258,1694728800"; 
   d="scan'208";a="133676388"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Oct 2023 10:15:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 78BCCE00BA; Sat, 28 Oct 2023 10:15:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D73E7E00B7
	for <cocci@sympa.inria.fr>; Sat, 28 Oct 2023 10:15:35 +0200 (CEST)
IronPort-SDR: 653cc327_RfWjnulfMbiD2ox/mnV1FAAUCLv4s/Gn66ivikcUFFPDwZM
 we4F/Zv2VwEbXC0GLfXEwtv8AdowexeElbPOc9w==
X-IPAS-Result: =?us-ascii?q?A0H2FwDVwTxl/wMP49RaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VGBTwJmB3NWDyEEC0iEU488hmCOfohvgxY+DwEDAQ0UAQEfDAECBAEBAwSCC?=
 =?us-ascii?q?4oRAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFa?=
 =?us-ascii?q?A2CNyQZgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCDTprHQEBEScYHAImAnQBA?=
 =?us-ascii?q?YJ6AYIpAQMxB4wWnDKBMoEBggkBAQaCZqxuHywiVYFfAwaBGiwCAQGHbhoBB?=
 =?us-ascii?q?WOJRQ+BVUSBPIJSg1ACgi2DDoJog3eNHosQgQIFQnAbAwcDgQMQKwcEMCIGC?=
 =?us-ascii?q?RYtJQZRBC0kCRMSPgQNgysKgQY/Dw4RgkMrNjYZS4JbCRUMNU12ECoEFBeBE?=
 =?us-ascii?q?m4fFR43ERIFEg0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNHBkoLAwIaBQMDBIE2B?=
 =?us-ascii?q?Q0eAhAtJwMDGU0CEBQDOwMDBgMLMQMwV0cMWQNvHzYJPAsEDB8CGx4NKywCO?=
 =?us-ascii?q?wQOAxkrHUACAQttPTUJCxsGPgKeIQNthC2CPZMWsVA0B4IxgV4FgVoMiHOBI?=
 =?us-ascii?q?5UNBhMvg26TLw4GkkkemCCKQkeCXJUkhUiBeiaBWTMaJIM2TwMZD45Yg0Azj?=
 =?us-ascii?q?0g/NTsCBwEKAQEDCYVGAQGDWoIpAQE?=
IronPort-PHdr: A9a23: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
 CaA9rZT
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:b0ilv6Da7xY4pgDlHemO55DYdb4zR+YMi2TDpHoBKiC9Ffbo8P
 xG/c5rsSMc7Qx7ZJhOo7+90cW7MBHhHP1Oj7X5X43PYOCOggLBQb2KhrGSpgEIdRefysdg9e
 NHb7V0DsH2AGN3lMDg/WCDYq4dKZW8kZxBno3lvhFQpOxRGthdB4wVMGymLnE=
X-Talos-CUID: 9a23:uigeQGwtDTkVhouROxNKBgUpO5oKQnP0407ZCHflUmQySqebYF65rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AYNPfzQ5RtDR3Bg3iBudnkAfZxoxp4Z+nVXJdvaw?=
 =?us-ascii?q?mpo6BDQZcPhGhoSuOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,258,1694728800"; 
   d="scan'208";a="133676384"
X-MGA-submission: =?us-ascii?q?MDE4YoO0eKx6PonsxG4iFPax0iVTuBya6HiaKy?=
 =?us-ascii?q?lmBEctU6a60NF+WfCVfg0nd7LoIzbpY1AejmaUQnU3aG43GW6NBbTBMY?=
 =?us-ascii?q?UnYLENQEELKfTHQhODQpk/Kba437SUs+er8Y/DsB0POoVGosA16dZfWG?=
 =?us-ascii?q?odBDLJKxoMxtWYyDw+YJcpIQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 10:15:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698480926; x=1699085726; i=markus.elfring@web.de;
	bh=HqeMf4HlGlJ4F2yDqjaI3kGlMRjlMT6EA410UwqwW9A=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=Iz/ofzRoD236wOXgDNJx029m7HxFHo69oZ4r228GXTHFrgWgkWDY/iSdExf+tmH+
	 mcXT7wUTzrcK30i8zcIm4wKDCbbuAC/I239FtZbY0YdDLxORQepadejto/pt/d8vl
	 py3+7VdTPplxlwaH5Q/shI8M11PJqLinziZt3RK9o9iYTXEi2Io0ruXb3OBipjvr5
	 ig1gWLvzCJyLoIV4sVtZJwj9Ga37dbJH0qk8k3GvUZ3xvgVWIV7eKCOvggrB2hL1B
	 KVtfl5iSlvyLeO6Y5Stkn8J6JkYLHg5g4OYTJMqjDKB9CSWOdpZY8LDJ4gjmX8rap
	 oGZIVb4csrcuDn5PHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjMO-1qkbGE2x9Y-00C9oP for
 <cocci@inria.fr>; Sat, 28 Oct 2023 10:15:26 +0200
Message-ID: <7f3e9676-0d1a-4fc2-83cb-8b77f6dd0a56@web.de>
Date: Sat, 28 Oct 2023 10:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KaDhHCe/cvFpOptYP2GZ6S++ul1txVm3H6KDzDPS7IDx0Kucnrr
 in41kgUEybIcJSqnz30gKRIbEuO8eP9F5y6dqWzZzbucBaw96i1qEPW8oQ4IODSZiAfdLOc
 IsyO2weVRXCo5bow7VbXuRM74jHvQ8gufBFOY/se5uUKdtEllTD4VSNYUuQNabJrUy8X54n
 dN1WcnEOrITwitbrFITYA==
UI-OutboundReport: notjunk:1;M01:P0:d/XNJDwLFZs=;6jdjNEFkx2hH8oILb7txgpcrPzS
 9A95jYfO4dxUq2PCV3CcFOWFR4NoOZ7FmfYsCdWQKyvouKOuTbHPIGewWlIuX8/LahIqim7aU
 PRsVT77epRQ/eeaaOLKmsfMoZCaKfCpSw4bBs23yap2oWWK+VNNRPhSzo8Wd3ADCHmTaA5xNP
 6R1ow902EJyMhIh6QzsaMdCpQihCRxk6+U3bAWKy/68DaLc/Ij2P0vMklnLQdQDUYadC804Mm
 VmrwS8tQZG6f4C2j07hg+X13+wNZC+vokHurIbPK6V7y2EafyKOKLfxFHk6uWFWLERed/UwJK
 Lc4nqCcWwKp+pJPI6gOfwvufAkDIoEpOxw8yqwz3e5kBf++Dt1xNu9w/u2Rzo+65IQhyQtwFf
 ornMtgocB/Qc1aIHb0L8Z873fnAkJnoSCvH8tlqr+8rD/IQ2/HKJOW+yZonbZAHQIbt7BISrZ
 XLpcjjEo264LBIewwN541mfVjm04OAQ6Vs8X/hSMNWJuaW2L4amLCNMQD+JzrL1ryNWrS7G12
 DEuVnqe9RvftN1D/ZwuE8+PoixQ/40eY0eiMXCGkLysgAY3jI95bmM+M4VbiSdS0TkZ3UWjUi
 qdX1KICBmJYoeveUPCUSTcKEPfO0uyYLPrz4NFJr9jYPJ32XVgaipZctXD/55/V1P+/H1u5xt
 vrNa//xjyzIyge+WzplU0bqD8pgkthkVqACAuVF0lS5XghUUBm0S/7AhaPFeKi6zuM7I4rMyK
 2RcTQZ+B06sAiucP5+JYPefI6pXkfqeceWWDPPzFhbDT+BGl0k7RjdHGCcaIYjQO8TinerhJi
 /bcLCoo5Y6VzzsyxrvG28kQSgy0O2JzK//aYFZLsHpSvmBhOX0BoxVj9/8Ra6Ox7IBY4CsBSX
 gpeAAQlNE9NTlEcbD5igAO7ZOtk9c4agaJ73SW5uN6sKN0FnvCpvohPWOzq3VtlDwjRGf2YR4
 E+VnMg==
Subject: [cocci] Improving support for Coccinelle data formats with parse
 expression grammars (or Packrat)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1283
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/7f3e9676-0d1a-4fc2-83cb-8b77f6dd0a56%40web.de>

Hello,

The Coccinelle software provides customised data formats for its applicati=
on domain.
Data conversions are needed accordingly.

The following information is published.
https://github.com/berke/aurochs
=E2=80=9C
Aurochs is a parser generator that uses the parse expression grammar (PEG)=
 or "packrat" approach.
=E2=80=A6=E2=80=9D


Would you like to benefit more from it
(instead of using tools like ocamlyacc and Menhir)?

Regards,
Markus
