Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBB8C02183
	for <cocci@archiver.kernel.org>; Fri, 17 Jan 2025 07:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=KnugLl4aSVuSuglLhTQBJIgcnbLFjEU3EWov5b+sT7o=;
  b=BAtXlVjIutHbKzpWY1Ah15DR/Jf8UsfhN9nVzH6uFrVOcQq0SBPd2NGD
   QweIUM/bu6u1LoPexspUth+a4JORM/6f7YSLki/Olb9h/4MLuwv7YO5St
   yUC+dVkHf3wP5tCrYa7z0kr4dim/xzCHxDmH8dKNKhq+2TQmLnJVJ/5Bn
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
X-IronPort-AV: E=Sophos;i="6.13,211,1732575600"; 
   d="scan'208";a="203611640"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jan 2025 08:55:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 84F11E007A; Fri, 17 Jan 2025 08:55:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1E896E0077
	for <cocci@sympa.inria.fr>; Fri, 17 Jan 2025 08:55:33 +0100 (CET)
IronPort-SDR: 678a0cf4_Dzo8Ym3ekKXWjrCnuhLz/Eq2hoUPOlr6x0X6C6AmcH9VhUo
 AYrg2MMsLvnMp9VJm8JWby0mGy+mkDvj7T13aiQ==
X-IPAS-Result: =?us-ascii?q?A0F1AgB0C4png07ASNlagQmBU4JEfVozBAtICIROj06Bd?=
 =?us-ascii?q?C2EPo8RikwUgWoPAQMBDTsGAQIEAQEDAwGFAIp2Ah4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAToHDjuFew2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpGJx0BA?=
 =?us-ascii?q?REmATQCJgJeFQEBgn0Bgi8BAzEHDQazfYEygQGCDAEBBoJo13MfLCJXgWQDB?=
 =?us-ascii?q?oEaLoVrgmMBiWiBIQ+BVUSBPIJTAYF8gVICAoEkhBWCaYI2hExnnzKBTRwDW?=
 =?us-ascii?q?SwBVRMXCwcFgXEDgRSBSnuCRmlJNwINAjWCHnyCK2sEBYNohEWEUYVigTpag?=
 =?us-ascii?q?hSCN4IbHUACAQttPTcJCxsGPZxIPYMAbAaBO4EAjwK4UTQHgjiBZgWBXgyKK?=
 =?us-ascii?q?Y4thwYGEy+XRA4GknuYfI4EmymBZzqBXDMaJIM2TwMZD446g2EzgQu8CkI1A?=
 =?us-ascii?q?gkxAgcBCgEBAwmFRgEBik1qYQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 lTZiYyJrI9XhKIx/Qtdl6ZpJSwk
IronPort-HdrOrdr: A9a23:CYhHmqkRBXzOCjWTq1ymwyeB1znpDfL03DAbv31ZSRFFG/FwWf
 re/sjzpiWE6wr5P0tQ/+xoWZPwJk80kKQf3WB/B9iftWXdyQ6VxeJZg7cKoQeNJ8SWzIc0uJ
 uIGJIObOEYY2Ibse/HwE2fD8sqxsWB/ZulnOHE0h5WPHpXgu1bjjuQEWygYzRLreR9dOIE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3ALsk9mGtl0/h2TFwcU7ejrl6e6IsEfCPd/FnyIHS?=
 =?us-ascii?q?/GGVWUrepFEe3p5trxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AplbLJQ1htrdNDKagp1DZYgOH+jUj7KeQNVssipU?=
 =?us-ascii?q?86sCjLxFeZA6l0R+bXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,211,1732575600"; 
   d="scan'208";a="203611635"
X-MGA-submission: =?us-ascii?q?MDHdLOGIT1xU0WgSP7B/Qq1dv0PQGRNIbOGt+b?=
 =?us-ascii?q?9icy44vODmM5Xo/G0Guvvpj277W1PBw3GMATCvh82IC84Mv3t04HcvjH?=
 =?us-ascii?q?0O3jnb88S0B0Sq+IsSrvLobIAanJoS/fMyJ2IsJ3VRzjKkrXsvuWmO2Q?=
 =?us-ascii?q?dtjssme43a3LdEQQkZgZjEbQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 08:55:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737100532; x=1737705332; i=markus.elfring@web.de;
	bh=KnugLl4aSVuSuglLhTQBJIgcnbLFjEU3EWov5b+sT7o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WUpUwJ88ZqzyIq25k33b4/ybpwAZfKFFdZA1238bT6VhSHp/N38llq4Q/I23eFZx
	 oVf85JRGzyCis2pFjwf/DiQg5mQaXzrgOgFyBVvh3AHSpPPZRBIWJ3yLN/db1cmGR
	 t2u7Oux6UwWUPhq5qH6U9L9oY7m/Ry9ZM/Je6MOEg/XtilJYHpsgRe5YuclmDcC1N
	 y11DLoIk4PLosyOCcWyHDyzq6moXqCoqqIjpaU+9XgJ2/buud8Q9WnU0maxu/wjAL
	 XX2oHDaFHLwCXLKMOV9Bzqh0+sa8MPT/hNhKZa2niX6UjTs6Jh8ECUkFmNrWCq0TK
	 Lasenmqm+T1+G9Ei/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.42]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqPT-1tDA4w4ANN-00kmf6; Fri, 17
 Jan 2025 08:55:32 +0100
Message-ID: <8522e546-13b5-435c-835a-13602c139616@web.de>
Date: Fri, 17 Jan 2025 08:55:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W5k93AFkxCpCOTRf4MavLeO+gLvjUKJ//CiX5mHlz1TSX2ekQVJ
 jm4I8gX/2MLLBrZwhFxjUO4OpGiKbHjmXA8eV4kt+2ZtjO6GanG+WgUj1CPaijBZdP3n7Ha
 F3cseEyLH35yG9NJMHVz74GBtL1NRxP/PyyQtE0jJGk/OnPIYFEkVJIn1pb5UUCXc572grc
 Ni+LHY8+R7jlZ8GpM31SQ==
UI-OutboundReport: notjunk:1;M01:P0:8HHTmhyOsNY=;p9KIjln974zYSin3Zpzyg9TXatd
 Z6Cf7uXbxKM/2BtmcGnrAGPszUiMc/DFSi9O5lY4heJZpoK7Y2Q0gu2ei2hBQn169khSstD/y
 HcyZmiijpqmCVDLKEXCdzT0ng+Nvk1LsCGNvrRMKE7u5/YcXVCYzuXF/eeVzQ2UQXu1by0vU3
 w7XbWCOP+KyVbsp3ulF1UEDUJWDyzWGbhDRV0g7xb3ioZaclSt+ZShc4bO6DvGaYNhT9L55RE
 tF3Ialz0I/4vu6v8ozWZranPy4rEVIJPABb1TcU+9eW7UIL6lZqugU27YgTcGk7VRHO2iPO7Y
 GFKudb9ZPYvHbQu3k5x4ux/hbKNrsCGNUMbBwLM4HRjCTq1dnKJ+h4BRexryxEzxCaBga3C7v
 VmEsj3ylFpjqxkfjMByawAeCbE4LArSIwm2Cx1rL36yzdzPB50JLRu8BEiJ93tJZjHdKecihb
 P7Lp7dPB1Fded7qnBJmi8bMyZTOjiksMFvLfteAr3UoYN8jYIdGZJqfcqmof0WrLXF3I20B8z
 SRXMHfd4FK7PCMQlsq4Gnt3xUZqvkBSvbG7qrobnU7TtfM2Zezl1WeUmQCJF6xuF9H3RkfueC
 F+G9E8ATN9VDC3RUmQAAdBTkwUE1nhW8cg6lWwcZlvpX8bJl8eRfKnKYvC2SVAsgdfUCo4YRc
 KEc087ZVxBhMl6fi0NkI5DSUM8+ImcXVkZ8EU8Convt5p22G2vRHjBnLLFJ36BoE0nk1ygUnx
 Nik/IbrsHktNnQHIqY9455edZIZUFWfed/mAxzalfYz2Yy3LvG5alIkRYZKqnBqoWys3BVhGF
 1X0z3prYjruT6oBXfDDNV1Lth6kQyxUAYUQwWMRA5ct+t+vkG7Y+AmX1bG/LmqQ2n9Z3MAJXT
 DpHt5F7BjciyMWe75VdlhWd5alT+anuiwI1Q5PWpxKVIXDctdChkQUeKEo2hrbUjZaLfLe+53
 s374dVS2Kj5N/DZCB68QitmK8mNowrUiW8XAQpUnUwQJ9t2jp6ltbsNfG6LJ887gWzLcO8dOp
 fMJX/821w55OLAGasff6l4ocyMCCHYI0k5RuOYUE23mmMFxDdFxnV0DVZ/i4P6HSoJODC0bz3
 QfdJTh6cG+6utAJA+7m+ABzZR+EEgiMHsNQ9Ljo2jHbrtg4kK9ddlLLIvbmcmSzo/nKprmWmK
 Aq1mawunSA69sTHU0hitpeVkk9W96lkb3+ou8qI8PWWlqZizyuGb88jSqjqxIQsUd+hnCwJBM
 iAaVD8GCrBs3
Subject: [cocci] Improving test case constructions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2210
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/8522e546-13b5-435c-835a-13602c139616%40web.de>

Dear Victor,

I noticed also the commit =E2=80=9Cadd test case for crash fixed in cca222=
17=E2=80=9D (from 2025-01-14).
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/3a8852684a48a6cd04f=
72a853c0ad22e4fb3e5dd

I find such a test case construction improvable.


> +++ tests/define_unmatched.c
> +// https://github.com/bminor/binutils-gdb/blob/gdb-15.2-release/sim/com=
mon/cgen-mem.h#L171-L173

The referenced source code indicates that conditional compilation would be=
 relevant here.



> +#define DECLARE_SETMEM_EXTERN(mode, size) \
> +#define DECLARE_SETMEM(mode, size) DECLARE_SETMEM_EXTERN (mode, size
> +DECLARE_SETMEM (SF, 4)

It seems that more code is provided than needed.
Will reduced test cases become more helpful here?


> +++ tests/define_unmatched.cocci
=E2=80=A6
> +// we do not expect a change, we are just checking coccinelle does not =
crash
=E2=80=A6

I suggest to reconsider this test goal once more.

A change attempt is actually expressed.
I would prefer to use SmPL asterisk functionality here.


> +++ tests/define_unmatched.res

I find the shown test result questionable.
I would expect corresponding modifications here.
Will any bugs get additional development attention?

Regards,
Markus
