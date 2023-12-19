Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E3DC41535
	for <cocci@archiver.kernel.org>; Tue, 19 Dec 2023 15:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Mrfq1qn//lIf97Lvd38W5b9hy6b7FywROsIYILAsWA8=;
  b=TwXi85+mCEcKk49YDCb5QV88AZZO7mKNgIpw1SOvA2w8FMVy2oryD4uL
   9+5AWfu8NfsmjcXfC+0plwnQhmTWC1aE+lcqDoilCqct86Ze86XVW8slc
   2hpUyby01gYpBAoc+pV45MnbnsQE976sg77Vb2Fgi1Viy6rHy9ajuVq8V
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,288,1695679200"; 
   d="scan'208";a="143155666"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Dec 2023 16:31:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D45C7E0CD1; Tue, 19 Dec 2023 16:31:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AA151E004E
	for <cocci@sympa.inria.fr>; Tue, 19 Dec 2023 16:31:09 +0100 (CET)
IronPort-SDR: 6581b72f_FYrJ3lu4jJk7KHwHFKG3OJ7S6w6eQQwyfaWVkbJzDL3V/Qt
 VBXe3DPCCS4tpb5gMtqmTU9M3E6Jb8qrPBcnlAw==
X-IPAS-Result: =?us-ascii?q?A0GwBQDqtoFl/wsR49RagQmBT4I5B4FLMAQLSIRTj0GBd?=
 =?us-ascii?q?YEFg2aHNYdMhGuEBIFqgSw+DwEDAQ1BAQIEAQEDBDcBhEeHNgIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE4VsDYJcARCBDIEeA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFwJHax0BAREmAS4BBQIRFQJfARICAQGCfIIrA?=
 =?us-ascii?q?QMxB64ogTKBAYIJAQEGr1gfLCJWgWAJgRouiBsBhEWBIYNAgSEPgVVEgTyDQ?=
 =?us-ascii?q?YN8gQaDHIJog2aFNwcyghyDUIooh199BUFwGwMHA38PKwcEMCIGCRQtIwZQB?=
 =?us-ascii?q?CghCRMSQIMyCn4/Dw4Rgj4iAj02GUiCWhUMNARGdRAqBBQXgQ5uGxIeNxEQF?=
 =?us-ascii?q?w0DCHQdAjI8AwUDBDMKEg0LIQVWA0IGSQsDAhoFAwMEgTAFDRwCECwnAwMSS?=
 =?us-ascii?q?QIQFAM7AwMGAwoxAzBVRAxPA2kfMgk8CwQMGwIbHg0nIwIsQgMRBRACFgMkF?=
 =?us-ascii?q?gQ0EQkLKAMsBjgCEwwGBgleJgcPCQQnAwgEAyspAyN2EQMECgMUBwsHSB8GA?=
 =?us-ascii?q?wMDAiEDCwkIAxkrHUACAQttPTUGAwsbBj4Cpw6BDnKCBMR4NAeCNIFggWEMn?=
 =?us-ascii?q?yoGEy+DbgESkyMOBpJRLodQkE0ggjCmDYF5J4FZMxokgzZPAxkPkkuPR0A1O?=
 =?us-ascii?q?wIHCwEBAwmFRgEBg1qBQQEB?=
IronPort-PHdr: A9a23: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
 xZamNsQyKwMO4e910EwMjFH
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:sZSwUqsCf+gf4k6itgC7GzyZ7skDrtV00zEX/kB9WHVpmwKj5q
 KTdYcgpHzJYVEqKRcdcLG7Sc69qBbnnqKdjrN/AV7PZniChILKFu9fBOnZrwEIcheWnoNgPM
 xbAsxD4bPLbWRSsea/xhWkGNA9x9S9/Lmvnvq29QYXcegnUcBdBxwSMHfjLqSafng/OXKzea
 D32vZ6
X-Talos-CUID: =?us-ascii?q?9a23=3Ah5lg32uS9jKnWDpgy8EVRLSe6IsaVS339UaIGXW?=
 =?us-ascii?q?nMl40drK7VUO3u59rxp8=3D?=
X-Talos-MUID: 9a23:6KLhoQpOWL+bISXEV4MezyFsFNpM4quvMhEQs6tcnsWpGAh8ByjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,288,1695679200"; 
   d="scan'208";a="143155486"
X-MGA-submission: =?us-ascii?q?MDEt/QncZ6vn3LVyX/z6gQwfgvJ+quvuCxX2gK?=
 =?us-ascii?q?1iO+cEXDo65PGFwn6kDLqaMUs9V8jfEuQzn/LSqHGtP8mCTsV4ubHxYL?=
 =?us-ascii?q?ReV3tUWA2Pmzx+B4lqDcvb6MG6rLYu3LXUpbkcOcpSJNFebV/DgBgsrV?=
 =?us-ascii?q?dCywq2MYDjvaesOU3nU9HkeA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 16:30:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702999844; x=1703604644; i=markus.elfring@web.de;
	bh=SqIfd9piziXw3rDdw09M/Qh7y3a+TKlJcVDEhj0X7LE=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=G8rGQsvO3ka2I0WSCmF6TMOUJIdC0z1HpW7dfo6cfX3j3H5QFWWXoAN+IiA8Rt0B
	 ZLesoWxR3eaAC5rvZUUXoe1U10oygNn8RCTQWtrkDPjqF1xvS8cmWRSBdipxPAIsE
	 pq8XUAP83s8wqKrIZQWiPBPlG1iru+hsBCD1+X+xRS//QC/YuVu15aCos4wP6x58X
	 9NrmH1fjM6cYhwqeKkiuh4C/EuKWRjaasrbK/73uFzIfbM4kVM4iGwHkINMJbDlZT
	 90Qic0ppevvPCTF3sgiOdxnIQHX9yzTad0z9lAIkPe/1L0xc9IyNe8Fc8Jc2lymke
	 iIAKxo1mA2gOrowN2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXGK4-1roHQg0D1C-00Ynli; Tue, 19
 Dec 2023 16:30:44 +0100
Message-ID: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
Date: Tue, 19 Dec 2023 16:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jzjrw9R8tcsGtcdkiR1zTWKOG/6PCCnBcQo0xtGgnuFaxTVJnwM
 b0hCCtkeaeVYfa0iHrKgIjXE+LmwpwWvv0TlYxGcy34jmoYkgSWhi2VInXh+DWhZM82KraS
 txTHt24MMDToWtq2bImy7ZKfluZtWo8P1G65ykLw3n3X3RsGEv10/qvBroijVkaSqRT4LPe
 YNVd8CaTZUyiNNeiveGtw==
UI-OutboundReport: notjunk:1;M01:P0:xVo22E71VfU=;cSt9rlzBYBXQmohzOXCHz8vONQ+
 ZBYr6njgREwgl1/kqjB0U5HtuINaFkSYGF3++B8IDVPmoOenMQUM9+n3GulYTafevuZOYwGn3
 fJPSjBG0ENNNbtJOVmVjcubmf2J6gCZdlhmevKuW6hcKxd3uksWulwRuYDE0zKQsa1GJndfTW
 PQXHwCDwZ84gzQQHBLZFEiq7Oikpf6Ba1C4o06bpatE+SGpIdE+z4zq+IYBoJB6txv22oMA71
 JE7K4o1zkFOHIMwGIWpDqOukpIQa3uPzlajjGROSIIaLUOn0Iitv6kvAe5exd2Y6+TQym4+Sj
 Z6UyGYBfx9B+Gr9AySBRkfPeOorr66T43uMbyy9bNcOXw6Kufi7HY58sLi8zD+cFbnxAKlV4J
 iyp2e1QgCzB3+A03aWtBYQf1P80fYUiF3WG3dMt/Ohjvqb3duQ8iukBCTxjMAlH9e63TtDiwY
 jG9doKUNid4SJTsS1Vchzz/hwrm3iJ+s3dMGCNIDtMSmNxsLStNJOR2owVtShGZ4jnPWgkFpp
 8RIWYainggBw2LcSPovWDudQeELRsfF0PyfrpbVJUOnzhUTq7cAHHwZY1D0yntDEMI81LK9rv
 LJm7XThHp3P/OVROAAWbfL1N4z8jdmK2urC611LtY3PRBNQDcR9dPI+xC36T/XnKKa3gllMzA
 RZmnu62i9SyCz5LnPxgPe4Fz5g3+vytdEvBz2X+biSSWFsyaY9pLHux9IB0lvc6eB9smsVEdc
 T5G4YcHEv1t5TFSy0EQTwsGwfnkEfK/lVKVdU5yfd/pA+zT4HPv+IxJeIAtIaM5FplNBWZp23
 LStrEd62w460d223tLb+E0J6CWDAxZyub0ttoRzOSX2aupoND+sRhV6k1SnR9F87N8bQ1nncX
 YRNNA6oGNHFuOttMiUAjnIDwXDOSno6QjJjG1x7yiruohcr7pu+5e6GrH3W/V5a93iGL+sV7c
 e4bWyQ+b1N28VmgZj7ET1OemY4Q=
Subject: [cocci] [PATCH 0/3] kobject: Adjustments for kobject_uevent_env()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1348
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/e0543d9d-a02a-4c9c-b341-36771cfb5353%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 19 Dec 2023 16:22:33 +0100

A few update suggestions were taken into account
from source code analysis.

Markus Elfring (3):
  Add a jump label
  Improve a size determination
  Delete an unnecessary variable initialisation

 lib/kobject_uevent.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

=2D-
2.43.0

