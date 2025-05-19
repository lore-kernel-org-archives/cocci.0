Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99431C2D0CD
	for <cocci@archiver.kernel.org>; Mon, 19 May 2025 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Ha3nEhBWyo3fa/atEysT4KDKCpNRZ6eL7oA30qo7oYs=;
  b=s7+zj5++OsAPcZrG/kvjbrDBTDbn2ZVn2T6pDvoVAnP2v+TZkDBCZA8C
   ZSHp8u4d/hWbDzGZUPhDoMdfoAwMvVS5KHxLsDJkZuyN2tkSD/DHBQ0Cf
   LLi18Iafx/n1/K7di23M22VkYKflfQsOorXIOK6JCpIaoSr6tn7XqdJMv
   8=;
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
X-IronPort-AV: E=Sophos;i="6.15,301,1739833200"; 
   d="scan'208";a="222818364"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 May 2025 17:50:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 96C63E0BE9; Mon, 19 May 2025 17:50:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EB79EE0131
	for <cocci@sympa.inria.fr>; Mon, 19 May 2025 17:50:46 +0200 (CEST)
IronPort-SDR: 682b5356_VCw52ghCcUQDiEWWFxOiFty8/0u6Zr0FWOxf02H711H1TCl
 dZPgjghgZ2cdZxd8VEyaj1FOYjcT/KSPll97kBQ==
X-IPAS-Result: =?us-ascii?q?A0GEAQD8UStogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRH5aMwQLSYRVj1CCIQOEO48PjEoPAQMBDT0RAQIEAQEDAwE4gVSCdAKLT?=
 =?us-ascii?q?QIeBwEENBMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOO?=
 =?us-ascii?q?4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQINOkQBAQECASMdAQERJgEECwsaAiYCAlYGEwIBAYJ+AYIhFQEDD?=
 =?us-ascii?q?iQHDQawSoEygQGCDAEBBoFGAgwCQ9hFHywiV4FlAwaBGy6FbYJjAYpjJw+BV?=
 =?us-ascii?q?USBFSeCUjE+gmEDgV+DW4Jpgi+BFo0akX9SexwDWSwBVRMXCwcFgSZDA4EPI?=
 =?us-ascii?q?w88BS0dgg2FGYIPgVwDAxYPAYMTcxyDQ4EjhEorT4MkgX5MGUGCdEACAQttP?=
 =?us-ascii?q?TcJCxsGPZdAgnOBNyNYAoEbNjM5OsVwNAeCOIFmgWQMiiqVOAYTL5dJDgaSf?=
 =?us-ascii?q?5kBjA6BeZswgX8jgVwzGiSDNhM8AxkPjiEMFoQRgQuDVcILQTUCATkCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGLEIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:nRZrdKtrpHKN0cO/fjNPuzxx7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHrJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3ApBYrm2lSCyUAA2Zuu3EjuCTglNzXOVaG6HzzEl2?=
 =?us-ascii?q?+Mj90du3MZFCc4JE9jeM7zg=3D=3D?=
X-Talos-MUID: 9a23:65I6GAZa6MIMeuBTtwfTvS1YBOdSzeeHVl4Al8QZvM/bKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,301,1739833200"; 
   d="scan'208";a="116974051"
X-MGA-submission: =?us-ascii?q?MDEmILNk1lx0SmMHEKA/qs7vvUhePYhrTbfmEu?=
 =?us-ascii?q?80KfW/fFYXXOVN/mhTDYApkUIkVxSBqjkbIliGdRvOJqB5GwrkOLQR94?=
 =?us-ascii?q?E4cxauX6smcHwyFs9v2q3wv+bOLX5GXTSRS3QYR90dDvzCFA+4sn905F?=
 =?us-ascii?q?EK9cA7kAbMlDb+HPhwTx8p+Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:50:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747669845; x=1748274645; i=markus.elfring@web.de;
	bh=Ha3nEhBWyo3fa/atEysT4KDKCpNRZ6eL7oA30qo7oYs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KnKdK2xpoJY/l8NigOkjj+F5v/PQHDEirkfc9FbpTkqnn6lpFacu9uYLPV99bukA
	 owRGFQ1WYGdf5aE+FDG1gyENEPwCOE7qOQv+x6ojfKi0X//w1L+J1GvZUMVQdC8jB
	 U3qzvOO6xfkBgZvUVAUpI/IeeqfvSZuNetP35VEHQT2LpKvKQZxBpmkNhosndvIJX
	 W55VhTtlS7N8G3/ChZp9fMnLuz0Yf8Hiqzpa7T19HlypDBPPb2/vvAB+2PT8gsKT+
	 zQjhSlnjwGBgS1CuodvV4iY81pciAPB0vr24DEgQEYtG2sbFwN8RBqdIaUbYXE0YR
	 oh9Zh1hc2jKCSKI3kA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwjJo-1v9Y3a47ek-00sofx; Mon, 19
 May 2025 17:50:45 +0200
Message-ID: <fdc8e894-1d4c-4d55-bb5d-12cd0fbceac1@web.de>
Date: Mon, 19 May 2025 17:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>
References: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
 <6007e0f7-3d15-4490-a000-b10797c9d579@inria.fr>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr, Olaf Hering <olaf@aepfle.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6007e0f7-3d15-4490-a000-b10797c9d579@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ih+mqJT8johTzKm0J8bvPD1xlm+nmwhqxrsICO+SY5LwOldwTMu
 +XoDInJhf2G43m3scbAxpkdr/pnE5JXbXehwQM+cLHNjJ9YNjHjWO7XOqr1xyabhpjhtzzL
 92ESqC3Si2e0hV/qeauc7bdiJ7+TQfNCxoOxestHGcOf/N6oMTmgSaeYAaWIfsCajZI9G9j
 aCfTKHJ4dVnARWuVPoqKQ==
UI-OutboundReport: notjunk:1;M01:P0:j8nv2liLmC0=;cSmZQ1qJdkujbU/or0yeLhYOLFN
 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
Subject: Re: [cocci] Reconsider software dependencies for PCRE support (with
 SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2741
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/fdc8e894-1d4c-4d55-bb5d-12cd0fbceac1%40web.de>

> It depends on your current setup and what you want to achieve, =E2=80=A6

Did you stumble on undesirable understanding difficulties?


> =E2=80=A6 and the output of `spatch --version`.

I informed you that also this program call variant can not work any more
with my Linux software distribution because the library for PCRE1 became o=
utdated
and the corresponding package vanished therefore.

* I assume that the usage of regular expressions might not be required for=
 some
  command variants.

* The program can eventually be built without PCRE support (for a while).

* Olaf Hering showed how the PCRE2 support could be activated.
  https://lore.kernel.org/cocci/20250319083051.2862-1-olaf@aepfle.de/
  https://sympa.inria.fr/sympa/arc/cocci/2025-03/msg00161.html


Regards,
Markus
