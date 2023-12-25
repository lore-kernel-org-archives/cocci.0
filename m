Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2892C3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=cYke8mBw2JrxwLQ1pXHU2Yy42jPm5yFyIAL3euQ6Nsg=;
  b=WJmBIAwbGX/kmPtWgyTEpaBH3bOxsWrB9QnHQiK+4Rx6fKFvNTQcyXtF
   e3U+lJPScsGXTZbHZa53G2QRgr/Yxcm71AT1A/11sSo3jEoU/AAnL8tzq
   AxjNUveIzmJRdw7K/8jQ2KqqPG1JKt0yiZdTsySzvmXKUsDbQWNZD9v5V
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
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="143989732"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 18:32:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CE54CE0CCA; Mon, 25 Dec 2023 18:32:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3EE36E004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 18:32:45 +0100 (CET)
IronPort-SDR: 6589bcbd_0HJqNlaWVppeswUpilXdCaN/eLFULjhqBSs7DbSZw+5EZdE
 IKoe80gNyoSXuDHeQ5reUBK0cWoEHXWCqxAnSnA==
X-IPAS-Result: =?us-ascii?q?A0ElCACou4ll/wwR49RaHQEBAQEJARIBBQUBQIFPgjkHg?=
 =?us-ascii?q?UsyBAtIhFOPQYF1hGuHNYdMiG+BaoEsPg8BAwENQQECBAEBAwQ3AYRHhzgCH?=
 =?us-ascii?q?gcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE4VsDYJcA?=
 =?us-ascii?q?RCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHax0BAREmAS4BBQIRFQJeARICA?=
 =?us-ascii?q?QGCfIIrAQMxB68ggTKBAYIKAQEGr1gfLCJWgWAJgRouiBsBhWeEYg+BVUSBF?=
 =?us-ascii?q?ScLgzaDfIEGgxyCaIkcBzKCHINPiiSHNX0FQXAbAwcDfw8rBwQwIgYJFC0jB?=
 =?us-ascii?q?lAEKCEJExJAgzAKfj8PDhGCPiICPTYZSIJbFQw0BEZ1ECoEFBeBDm4bEh43E?=
 =?us-ascii?q?RAXDQMIdB0CESM8AwUDBDMKHQshBVYDQgZJCwMCGgUDAwSBMAUNGgIQLCcDA?=
 =?us-ascii?q?xJJAhAUAzsDAwYDCjEDMFVEDFADbB8yCTwLBAwaAhseDScjAixCAwkKBRACF?=
 =?us-ascii?q?gMkFgQ2EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHU?=
 =?us-ascii?q?gMZKx1AAgELbT01BgMLGwY+AqZLexOCdpMDsX40B4I0gWCBYQyfKwYTL4QBk?=
 =?us-ascii?q?yUOBpJUmE0ggjGmFYF6JoFZMxokgzZPAxkPjiCEK48JAT1ANTsCBwEKAQEDC?=
 =?us-ascii?q?YVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 EYiODqWHtq5apN/eGothAKO4fNy
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:apeT+a0AA+bnLncayZFn7QqjBGokLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskd2ZJhAo6HmBEDkexjhHPFOjrX5UY3SPjUO21HHEGgB1+ffKlTbckWSygc379
 YET0ERMr3NJGRbyeDn/QK/D9Es+9Wf9ru07N2utEuFATsKV0l6hT0Jczpz/3cGPDWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3ARIELLmtgNYAwWXm0W+CpCHWh6Is+VGL5j2zTKnT?=
 =?us-ascii?q?mDFhkdu2SbxiL4757xp8=3D?=
X-Talos-MUID: 9a23:IF18twQwrJCfhFdvRXTDnQ5TDflu5p31N3I/m5kdi/WdEAhJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="143989731"
X-MGA-submission: =?us-ascii?q?MDHJaJre+cFH3BnyNxKByeuT+U2dQE/VkDVxYx?=
 =?us-ascii?q?wYcp+NlBCOsIHXXs9/DWomdMin4Kw0GMCwhI4ZWYRIyDydsIplbrI0q3?=
 =?us-ascii?q?EQ5fgzfBDF4t5b6jdPOSkRaoaw04HHmT/2qrgoIGdWOLCdhzLZMUVGCA?=
 =?us-ascii?q?zaY3XzuR7RpQVA0XH1E3H7eg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:32:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703525537; x=1704130337; i=markus.elfring@web.de;
	bh=Hqsf/W1zTujyJBR8uJaWWv0uhOGXacuRBqoB7Qd6iuY=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=bS6K7tcabbL26CgtnaDpAfS3aG1sywSUJKLX7j0VmMugEsBiJ27VFpZRQu2px3us
	 iujud0mhvAJgCF3ThYWrDiK/ecr65b7t5iccSdnd5NF/ofCT515zKQsCVZv43HTf3
	 A8K6Tz23iZrAB4+YkRXf6cgsSLRAbilk8e+ajmVRD7e/VS6sMUoOchNN1nMEpvuCn
	 J05KCuWNe7tM28lPlru0rXffZQpS784CmmVeARuZ9zQdfG4pi+etJ+U0/EA9pjaat
	 OlyHTdTWvZ3iZlwQ59MuZaDK+j9NfCNhmC/DAnr3Vj5ue9ZirthZXa+0g45iu71ex
	 UOHk9h9BpZYP6HWmpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYtx4-1rmdMm4BxQ-00Uy7T; Mon, 25
 Dec 2023 18:32:17 +0100
Message-ID: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
Date: Mon, 25 Dec 2023 18:32:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Muralidhara M K <muralidhara.mk@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R/3pPPgsW0Ytss/g9XC6guLy3I5essvBwpZaVoyDkq1UxEW0nYZ
 Vo65W7Z92aWXWfLmG5FmImwYQFDVFxnh37MxQ/pKsrLvyomKJmS6wDznIl2v99C6jg76GB3
 5NZ2Zta0Blhm759eNXJGUpgh2M3/sjiKZmIbu2/06UjlKZKCjRvoMXU5eZKH6+/dcWNclMk
 lLnDhtsj3sd8+zoPGZcoA==
UI-OutboundReport: notjunk:1;M01:P0:du6Y8wJZnYE=;qMoTsZM+U1eao0pQGstHy7uI27M
 Xciq9KrBPc/417A2OjPguJ12q5XIOXcbqDeFJjBZJSoVxg8izKB3tJH8e0J36rzQ75z4Py0lL
 4cekn23R0mQp/jgvY+cUTTpgeF0YCyzAZOE/nzOzdG26ZLGvSshtTmZus3U0E4V3qPscDNdtX
 YTx8ozQ3JRT5PpIGuKLKcrr/nUqHz+aEJmQR6iG+3iitd9WRa7sGWuBDZQrm86ueVuxuBeI/y
 znlGjC6QJXLQ/XQFyf2+Sv4GKyx7NULKtNyhoG6MRzY4wxjuoc+11IY/Ds/mWokxBFwYCI1Y8
 piA26RcEOjbH3HlxvjwxMeUTEOGX99/aGeDmKtRRxRE/aBWeIhPt1xtgGv5NGlCsLcXBkUL2A
 095UPOK3u8HW30Z8i95tNIJY3+G2IS3RDTz3gMA6WyyINUSD1BGbk7bCGv4SnfsXb46iUCCJ7
 GM9u7EzbN4tBDMSsmFoy5mGYLy/PbREB2KMeJIiK13egwHcbb73m+gpswBD2C981j3F8etDjJ
 lpjivtfRlRXLIP4XHlCg/GdHLqrGWHhXwDJdfkdMz/IHEfWKpIazjzcrjmak8fsz9gwZBudBh
 BEJW9pHcx1G6Yer2yWmWuSOYVV0Jb6C2EIgICirCOGsPstvfxLYx88gzlnw/0ZqhtWunAsfAb
 isPaHn8I7oYm6b4cGCq/0QHc6/GbnSRJXbLbZf+uURW5gXvTkfdS6I80hv33VzvKcwsmDHdLK
 vXipTuGQd9JZtYmpbVXmFRgdn2T8Ptt3NZkQCZ4NOyPHEKdmKMZ54z86VLNvrioGhxTyeQJ/N
 qJ6QeCiTlYrxVby2r3sKOWJDTVR+mnqTT4G6AArwNMnuCKYsGl8nV8ads51lsxEyzLH557Lyw
 qsMiUasBGkKPABi+nDwQvXMnIOC9atm3RBdRlfiakh2mLaOn1BDM6cdeuOubqPkesOuF7oXz9
 tfTgIA==
Subject: [cocci] [PATCH 0/7] EDAC/amd64: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1384
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/8c9e2c01-9ed0-4392-af40-4e8eb393cb67%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 18:19:45 +0100

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (7):
  Improve error handling in amd64_edac_init()
  Delete an unnecessary variable initialisation in amd64_edac_init()
  Merge two if statements into one in amd64_edac_init()
  Adjust error handling in probe_one_instance()
  Improve two size determinations in probe_one_instance()
  Delete an unnecessary variable initialisation in probe_one_instance()
  Move an assignment for the variable =E2=80=9CF3=E2=80=9D in probe_one_in=
stance()

 drivers/edac/amd64_edac.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

=2D-
2.43.0

