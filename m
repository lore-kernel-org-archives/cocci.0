Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AFDCCFA13
	for <cocci@archiver.kernel.org>; Sat,  8 Nov 2025 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=vrwfHiYxlCGjGmKw6cm83e5dTYwrBKbQWbGu+loVfHA=;
  b=LVTf7iEZrP3GoHqlyzMebjbD0+Xqte/xaUSvgt6x4tun/Q3LD7xR8LNl
   Q8Qx5OPsbzcIB0d2yvK4wgsxim7aVsyh30V5l4SiZ4NFet0aVPKR+Khly
   Bw7Fd0Y0Z0DCx/NzZXW8LP+njpEHdR/OVVxfvx1uUF71tJQlEVjPs8sqZ
   A=;
X-CSE-ConnectionGUID: utaCVnYyT16ng3jHHcVcHg==
X-CSE-MsgGUID: VaiAiw+2Ry6ucSGqCjSzWg==
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
   d="scan'208";a="248305071"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2025 14:30:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 748F9E0264; Sat,  8 Nov 2025 14:30:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8EECEE0171
	for <cocci@sympa.inria.fr>; Sat,  8 Nov 2025 14:30:29 +0100 (CET)
X-CSE-ConnectionGUID: J/l3zNMsQSuAyqeuVbcKLQ==
X-CSE-MsgGUID: nHR/B2KATkeSC9AP9tRmZA==
IronPort-SDR: 690f45f4_LQ9qfnL2YVHboJU86yDE3qPDT3zOc5qkB13HRfXTUmMHCcR
 qKqvZHR0kZfa/LpGA4vEJ7rKb+viX2RGfhEiiPA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GGCgClRA9pgAMP49RagQmEEGUjWDMEC0mEVY9Thl+HP?=
 =?us-ascii?q?IdViHmDUgIPAQMBDU4BAgQBAQMEggyPUAIeBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGIC8NgluBLIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQJHbR0BAREnNAImAnMBAYJ+giMBBhABAzYHrxuBMoEBggwBAQaCa?=
 =?us-ascii?q?dd2HywiWYFkCYEcLoVugkobAQVuihoPgVVEgTyCUoV/gw6CaYImgQ6GJ4Juk?=
 =?us-ascii?q?EGBShwDWSwBVRMXCwcFgWMDgQtuMh2BJEEYcT1Xg0kiaA8GgRKDUYkeD4QSg?=
 =?us-ascii?q?QWFLwIBC209NwkLGwY9lQaCdYECE5YlswE0B4I4gWcFgV8MiQiWZAYTL5dSD?=
 =?us-ascii?q?gaTBZkGo2iFWYF/I4FcMxokgzZPAxkPjXgBhFu8AUI1PAIHAQoBAQMJhUYBA?=
 =?us-ascii?q?YxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 J7DmfCrQN+t283Z940QCpqNQP8=
IronPort-Data: A9a23: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
 QwhtFcfNBg=
IronPort-HdrOrdr: A9a23:pIhL0qtKJNpx/5huUWOydOAQ7skDVNV00zEX/kB9WHVpm7+j5q
 OTdZMgpHjJYVcqKRUdcLW7U5VoLkmyyXcY2/hyAV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4tgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHRuQ6T9RZQpRoBUdAH0+6VMHfjLqX8KTMtOaYE
X-Talos-CUID: 9a23:Vm9G8G1VOWST6jidsuktOLxfOIchKW/76WzpGFKRGH9kVYOfQny0wfYx
X-Talos-MUID: =?us-ascii?q?9a23=3Ac59ULQ1c/cdKQ0U8yWxcNLUmVzUj5YSUT2pXsrw?=
 =?us-ascii?q?6uMS/Hn1ZA2aBtjGFa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="130338933"
X-MGA-submission: =?us-ascii?q?MDHCGSSfpFcw5FVOsg+cYICPf1Ep7qrlbuJHI+?=
 =?us-ascii?q?YZ1YMPSCbLgD5/i1uAqBMriLcIZvnHUa5NgXBTvXgQQOWVlPk4FkQCoZ?=
 =?us-ascii?q?E9HV8PjT9jBMrts2Mpzuiw4pQrzEWjHGdXaqaSRovqY5T+RAy0mlZexR?=
 =?us-ascii?q?yWUyGsH6kH+ijhPJa8GHZqew=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 14:30:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762608627; x=1763213427; i=markus.elfring@web.de;
	bh=vrwfHiYxlCGjGmKw6cm83e5dTYwrBKbQWbGu+loVfHA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i1YXWiMfsdic3koWZUnAECEhAEbnbGlL0fup42ItX5lGcfAM0qI4VpLHem8Xz5jq
	 j+388YXCUjMh2wL9NDXYa1DBLrIVfeAtPAp9V3G7E0QnIN0baNqFmQ+0eMOmdin6R
	 XFV4ReEm8cyU1700lJx/HH9Pq9/mWx0UJSmILntPOOB/HxRg012FWj9PDX1iNKljJ
	 iAH6k5GSQt7lnyBxev8weIEnMu6wV6CiuUPwEb+pLriyrIz66lDZ11w6PUrc5ccyn
	 OWYg0LS1HfOU5+yXir5ndyuddRcOUXsw8x0FOJMP4eqpEwYr9qHccc7PDnUq36ApO
	 vZqUg9LT76N3NMvnjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Meler-1vpgCE3I1N-00iND4 for
 <cocci@inria.fr>; Sat, 08 Nov 2025 14:30:27 +0100
Message-ID: <d0ebb438-c60e-407a-8cfd-77fe0862223a@web.de>
Date: Sat, 8 Nov 2025 14:30:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7LySQklXhUavRxULu4Gl9EtzbCtY5uaOnpc9zzSs2UR0bNPXg7G
 8HFJt9CJxppOf5wOCQZXhzlmIH7vpPV1kKrRpOEeYdR+Uwl0F91vu3v4aHythzc29Sv2Cbb
 i0uaN1xgLUmt986ogRH0snyvkrUklQ9kn2oohNwArxqED9kn9hToH4j400wvVmruX6Kk+Y3
 cq9m7/SBf3H3yWdS7MuWw==
UI-OutboundReport: notjunk:1;M01:P0:aoifOVCd6+w=;YI1Ynnm2QhPO2692GN7Ccq6Gu4i
 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
 LE79IfWLSq/FedWH5hY6oBi+K4ExlMrPP1o=
Subject: [cocci] Searching for switch statements with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3141
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/d0ebb438-c60e-407a-8cfd-77fe0862223a%40web.de>

Hello,

I would appreciate if another source code analysis can be achieved
also by the means of the semantic patch language.
Thus I tried the following SmPL script variant out.

@display@
constant c;
expression e;
statement s;
@@
(switch (e)
 {
 <+... case c: ... break; ...+>
 }
|
*switch (...) s
)


Unfortunately, I am wondering about the following information.

Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_switch_without_break2.cocci
=E2=80=A6
minus: parse error:=20
  File "show_switch_without_break2.cocci", line 8, column 1, charpos =3D 6=
8
  around =3D '<+...',
  whole content =3D  <+... case c: ... break; ...+>


Under which circumstances will such data processing become better supporte=
d?

Regards,
Markus
