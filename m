Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1B5C77B7A
	for <cocci@archiver.kernel.org>; Wed, 24 May 2023 06:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=26mhuhBEF0zACiZf3Ol0PJ2bycW1/C/tKLS2bMtRf1s=;
  b=Xx8pQbqF9P+g6WqAhDcp4TDHAtY9Gfo7jmGuVyLGtxxdw4GEZndBaQ2B
   BiRILeZQDLQX1Mx7N+d3vvthKOPQX2OkCRYQaq5eofF9zILs0LWtnMuJC
   8pCbzTj7TKj7PqYqghz5stDS22F2i0EIAW2rrX2xzpDdOAwygA/fsGo7f
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.00,188,1681164000"; 
   d="scan'208";a="109362718"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 May 2023 08:56:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0B981E2697; Wed, 24 May 2023 08:56:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 030EFE0082
	for <cocci@sympa.inria.fr>; Wed, 24 May 2023 08:56:22 +0200 (CEST)
IronPort-SDR: 646db513_GFN+C4fT4FvmN4xfSx9Lhwwp19ld6FYT7RiO+WbqHXDMAb8
 gpMTeDFeJ7RD6SqEw69hNl0FyXepFgmy6DOE72Q==
X-IPAS-Result: =?us-ascii?q?A0ESAAA3tG1kgAMP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYIueFMwBAtGhFKIHYZ2gXaBD4NVhzCHRIRnhAOBVoFAP?=
 =?us-ascii?q?g8BAwENQQECBAEBAwQ3AYRHhV0CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQFAQIQAQEkFwcODimFaA0Igi8pARFkgQgBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARICR2gEGQEBESYBLgEFAiYCXwEMBgIBAYJ6gigBAzEHr?=
 =?us-ascii?q?W1/M4EBgggBAQacDh8sIlWBXgmBFS0BjSyEWA+BVUSBPAyBCYItiB+CZ4Ieh?=
 =?us-ascii?q?zOFXIMriXSBMHKBI4EogQICCQIRZ4EOCGaBc0ACDWQLC2yBO1pDgWkCAhFCD?=
 =?us-ascii?q?BUFWAKBBBABEwMHBAKBDhAxBwQ3CyEGCR01LQZdBy8kCRMVUweEKwMKCjMlB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PTUGAwsfBiYfAoIDBIEJewckJKA+gQ6CdpJdkl2ePTUHg?=
 =?us-ascii?q?i6BWoFdDJ8YBhMvlxEOBpIqAS6HNJApIKgSgWM6gVwzGiSDNk8DGQ+OIIQmj?=
 =?us-ascii?q?wkBPj80OwIHAQoBAQMJhUYBAYUgXgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RwjFqXMAyWM
IronPort-HdrOrdr: A9a23:HqZqPaCwyiMyIzLlHel055DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rsyMc6QxhP03I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gduVbKvlrkuEVmtRGthdBupCe36m+sYafmN7OaY=
X-Talos-CUID: 9a23:t9qTr2+WqlXCqywhjdqVv2IlRuMKb2GH9UuTEUmmD1s2Sr3WQ0DFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AbJmZUg76x0idvw5XljDg6b4WxowvyI/2EFJVkKw?=
 =?us-ascii?q?+quucFnJiMTK6siuOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,188,1681164000"; 
   d="scan'208";a="109362707"
X-MGA-submission: =?us-ascii?q?MDGyjZa3xW6ogH+UWaa6iEWKQYN52dFkrJCR0Q?=
 =?us-ascii?q?hquKiARoFPKOP2XqTXBqS/KjdEYnIB4bykXaFzF/lFcgTNvKnMRc9neg?=
 =?us-ascii?q?NurYmtnnld59hfNrEuVlIXQnaTJqIb2AqBBG3eY9FFpNeqz6j5OP5ZI5?=
 =?us-ascii?q?m1XvW7YBkKws6WkShe/PB4CA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 08:56:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684911380; i=markus.elfring@web.de;
	bh=53f7PWpqkJYiXaUj+QCeUlPyp+bGB9LeMD1SU2E82nk=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=H4hRAM9YEyJRzGhxbGI3Xg8INByz02yvq533NQRf393vjoCPsE1qNOJuIV+wp0Mr6
	 UTH4FhcMfQrdOWs24FRCv9o4JocVsDufA1MBdqXqGFsz0y1T0YCjtXiw+XdTBhh2rB
	 EgOWfXf/KD9g75rZzpd5ew5fD1pVuIgmpnLEl6wQ0lyBs5nafS8TIqmrY7ywxs4/T6
	 pvVo/13EuVzsXLsaVdCH5movsl7dEZqU9ZkBMgZzlBQSlW0pHaFOoMo1gPReHF5PUS
	 H85Oyf4CR9+iLDe3+X4DnuFCQA7LGV4kBd4HquZBzouPlHiI01JDEMVcoUefiXYfMO
	 0cyfI8xwv3fqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlsKF-1qSDcF12VX-00ihgF; Wed, 24
 May 2023 08:56:20 +0200
Message-ID: <9f036fbd-5aa1-6336-fdf4-50952e882eaa@web.de>
Date: Wed, 24 May 2023 08:56:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Andy Walls <awalls@md.metrocast.net>, Hans Verkuil <hverkuil@xs4all.nl>,
 Helge Deller <deller@gmx.de>, "John P. Harvey"
 <john.p.harvey@btinternet.com>, Kevin Thayer <nufan_wfk@yahoo.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b9vD6fpjlA3riPjBMTM6MuwUe61HjLUHOgXTy7bY/zP/LtEKF+j
 sIE9N32tChy/wfOiXCuz0WfBBUsm0pMdjf/ZTWGC8pffKv/9qk/yjp37nX6Mksn7cFE/hda
 3+AAl/vXAR3lTcw+jqcXJUWUsu6RnAfjaD4VGDbFqLqR2Dvmon7BWfViy3WUwWTBt3ex620
 YAQcym35SfBRO7zA2Z6yg==
UI-OutboundReport: notjunk:1;M01:P0:b5mtaVUMt1g=;vRp2R7xZBAiQ3wzVJtsbaa8j7X/
 zoMFugIjSaHU5qFHfd6sKL++IUt7rOA9JhnheQtY8qYbfYuwTH2NQCBbDhpF6uhP9UqnJnN5N
 1mqLneC5KYgOdnC+5i+fNM3Q+v2CpOUsuy10X0kNHufY9czxpj/OT6b8wGd4KO9v2j4/862Ga
 8yEp80dxX1PEYtXJ3xjVKrJW4ykGtBiCHqAIuEd3E+Q6bg0qOo6bR935XwXq4c9Sl5gOZAjpd
 poBbNopP58T+3tme8yd8vE/cm/FBfP6l7Rvak9T+792XBJUlZiCQtmFybUNh/bqRJEFI+lNK4
 HgP0Uxd0UcTEAc5fUSJm+T2Z+vAq66xG9BCQPkKuxbRwCQCeaWDaepRYpZ6Y6gQ5jqxqj8rZV
 0NgOheiiFU31x1JBtI/696H3BSbFRyX8z+OTsqbhLrXj6HB38OyOs3GL7jsRe9gdXRQNiCG+n
 ef+s4pBC5vw1lRVxau1MqHM5Ui+izwfRG/5g1hMttrFcPgtOL7IssFpnw2NIbucZWqu+OlN0R
 nQFaAM5t4Nlr8GD9zponf5WIdfDszdrCSovgv2FR68rlAgVQ5NdrQfytnLYoKOz2z37MxBONR
 CQhqxg7po8VJhhvcS+5tZCazZ185yWGe0eo9L1IeIr1/xBsc4qb8SFknc0hmu6M3hxIu3P9pF
 Hk2RUy46CIKmyimcqwrBI6+58z78Wz7y7jHtd63mpyse1zf120/0cYMgk+Ddb4eiXkT3OgsIV
 TIL8xITJIEkcLvzMbTi2tF22kv1iCGQwFlLVVe4+VagAFBCuVoJQb0zKetvWwWrFrt3CIXKwI
 WJ9X4yy1EA+ifA1/KyQ6wq0QT3T1KGysMezVbKqOCmAmyOOwM1EMoZeZk85OVTj+79Uj0Npo4
 WyeBaztvwvR9WsyJD9ybcKWqoOZIKmDzsjbbAH9lTNmN6ClgdiNifVDFwWExM1YMvAjKiu3vd
 IPTyYA==
Subject: [cocci] [PATCH] media: ivtv: Fix exception handling in
 ivtvfb_init_vidmode()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1155
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/9f036fbd-5aa1-6336-fdf4-50952e882eaa%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 May 2023 08:30:10 +0200

The exception handling was incomplete.

Call also the function =E2=80=9Cfb_dealloc_cmap=E2=80=9D after a call of
the function =E2=80=9Ckmalloc_array=E2=80=9D failed here.

Fixes: 32db77545281 ("V4L/DVB (5902): Add ivtv-fb framebuffer driver.")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/pci/ivtv/ivtvfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtv=
fb.c
index 0aeb9daaee4c..7d6a8065220c 100644
=2D-- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -1073,6 +1073,7 @@ static int ivtvfb_init_vidmode(struct ivtv *itv)

 	if (!oi->ivtvfb_info.pseudo_palette) {
 		IVTVFB_ERR("abort, unable to alloc pseudo palette\n");
+		fb_dealloc_cmap(&oi->ivtvfb_info.cmap);
 		return -ENOMEM;
 	}

=2D-
2.40.1

