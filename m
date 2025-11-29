Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39573D116EA
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=A2J/xijYkFV/tCRaI6eq7H5z6jsawX/8C+PvwwIsk/Q=;
  b=ttqah7o6gxvAkGShU9OhRSILTjs0E/UWZXV4xMnkBACQdwiTC9Tb+y3+
   zsHWXvjs+Dabdp9ci4VrgUKQWxuNUfhQ3yZMLCjOa6jzKfRUM6Mupm66t
   B6tAAqMkC+p3ji7v5euz0uz6Ms/kcvbLTyw8cx92hVr7erRlO0Rpe5a9W
   I=;
X-CSE-ConnectionGUID: QAmbNa1YRDazfrKbkb2dUQ==
X-CSE-MsgGUID: pCbsXR8aQkqfXHiH+NlbkA==
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
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="251902200"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 19:29:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5568EE01A8; Sat, 29 Nov 2025 19:29:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8CEE4E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 19:28:58 +0100 (CET)
X-CSE-ConnectionGUID: Qb2knCUOQZ+mFjs9BsO0Xg==
X-CSE-MsgGUID: Zvo1piFdRDiBjhuRBWf42w==
IronPort-SDR: 692b3b6a_oEibENwizTGLkmxz7CnhIuehBGlEtU7Jtrx5aiI0IxUJGZ6
 6jwygI3pLCl91Rte7OmMFX8hq1SBVEjLEuL/cwA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EcAADIOitpg07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYI/ZSNYMwQLSYRViByHN4IkhDuHPIdViHmBVYF9Ag8BAwENTgECB?=
 =?us-ascii?q?AEBAwSBTIMqCgKMZQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABAQE6Bw47hk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBA?=
 =?us-ascii?q?QECASMdAQERJgEECwsaAiYCAlYGARQBAYJ+giMBBhABAw8nB7IAgTKBAYIMA?=
 =?us-ascii?q?QEG2l8fLCJZgWQJgRwuAYVtgmUBhimEPScPgVVEgTyCSwcxPogegmmCJoEOm?=
 =?us-ascii?q?VZSeBwDWSwBVRMXCwcFgSBDAyo0LSMPPAUtHYEjIR0YEWA9F0CDSR0GZw8Gg?=
 =?us-ascii?q?REZSQICAgUCQDqBZgYcBhwSAgMBAgI6VQyBdwICBIIWfYIKD4gLgQkFLoENA?=
 =?us-ascii?q?gELbT03CQsbBj2VDVCpaKJ7NAeCOIFngWQMn2wGEy+DcQGTYA4GkwWZBiKpH?=
 =?us-ascii?q?4FoOoFcMxokgzZPAxkPjiEZJYN1xHpCNTwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 xRwhgYsOYwQ
IronPort-Data: A9a23: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
 Qwhp1fOxckwsfqovPk8DBnest+jO9Ez
IronPort-HdrOrdr: A9a23:tw3i4KPmabKjfMBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:T4b13GMJPn4hge5DYSM990g/J+ccQD7Y4nXLcmWjLj5ZR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3ACOBmqgwZ3PMwImvrGR3d34dPSgyaqJawDxkVkLs?=
 =?us-ascii?q?KgeWFHy5wJg23szrrGJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="251902192"
X-MGA-submission: =?us-ascii?q?MDGHoUEVdRwnvnJCJ4lXkV5XL/ea6EdSU3eH4I?=
 =?us-ascii?q?Wt6XFyQDlgOfynEvfULK0QhgJ10Wl9S0WIj2Ay8Lr3itvjhyqGcuGZlM?=
 =?us-ascii?q?pzloRLIC3nnyY0RE8EitfZHZmw3a0UPdETi8CQH5wiCsKMdsmMsWT1Vi?=
 =?us-ascii?q?KC8tZM7ODAkt5kMUGSYsxuqg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 19:28:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764440931; x=1765045731; i=markus.elfring@web.de;
	bh=A2J/xijYkFV/tCRaI6eq7H5z6jsawX/8C+PvwwIsk/Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hqKz18V4TV44d8CKfQjLIZKRwSKydzprcI4p8+lbU4adHjqKczFSUfyx7cz13P74
	 8Xti+Tu/c1RM1mYQzvXtgNApjMz0KNgRKs1nnpguxTDzx84p89I6SQj4G5pOCH0iu
	 lyhiT8uVnYmdwMiWfIW47VAN0NbIjbu7swoQUqbaSVGjXo9/M+FiG4KTf7JwLXfBV
	 E8+rQ0DFgy2gKvjMU64Gg9FMhFRQkmVK4DhwHmkbgYB/2DuAhi+3yKmnovgR12nLY
	 h91HRrz7KLAgUjaQz3H1ZaxAK2WTCcAZ5wSohjnSUmdUb//dFIqD/W9pYeh3fnTqD
	 3FHRonaQY0yJsIyfHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrLN-1vkdRA3ITT-00Ug89; Sat, 29
 Nov 2025 19:28:51 +0100
Message-ID: <61b6fc28-4bfe-4bd3-ae84-0565d30e8203@web.de>
Date: Sat, 29 Nov 2025 19:28:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
 <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de>
 <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr>
 <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
 <29c204aa0f1f08074279425b7de42dd7@posteo.de>
 <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
Content-Language: en-GB, de-DE
Cc: Tobias Deiminger <tobias.deiminger@posteo.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:61lzlw3422Kjj2u4SAwisjq9hcO3F2LlKfQhFCgiwI5bUDYigZw
 u+KHIMHxZ8QBMNeYPrDYJvhd2X06XQkTX+suLWICGVtAHeBZrh18xdN4FUTztQVoRi6Erg5
 8Wg8ozgBt701Lp87RAWkcoGPo0hI8bfyrPReFwTbHFPAoJTjwYBm7lPeaJwFvBe6O3RE7ME
 Otnz/SMCbKA0JkpW952zg==
UI-OutboundReport: notjunk:1;M01:P0:VObnTNwg78E=;0NanJr5eKEo/5uvIdYDjr9u80M2
 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
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3218
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/61b6fc28-4bfe-4bd3-ae84-0565d30e8203%40web.de>

> .cocci
>=20
> @r@
> symbol SYSCALL_DEFINE1;
> identifier fn;
> type t;

Is this metavariable unused in the SmPL code?


> .c
>=20
> SYSCALL_DEFINE1(foo,int,x) { return 0; }

How can a macro call be matched here?


> Using * was a bad idea.  You can't transform macro expanded code.

Would any more background information become relevant here?

Regards,
Markus
