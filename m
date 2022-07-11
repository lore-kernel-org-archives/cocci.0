Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5E3C433EF
	for <cocci@archiver.kernel.org>; Mon, 11 Jul 2022 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=cBgVQY3uHeKzOdRly8LTuWilRdixKQY7zDFXwFNu9Mk=;
  b=l8Ewcx753ejBBl3/pnclGVS6jVKnK9WEYV14yOX7bdSTmPii+rNQ798p
   rQUI9JfZgpA3WC43zSzFqj+945Z8FDDqMShBTHN9aJQgs0b4cSfPr2SmT
   DzrAHmdU44v4CFjEVHzRa8K206z/nyf9KYSmysGVlpPSd3sGdEfnF7Qqw
   o=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.92,262,1650924000"; 
   d="scan'208";a="45059970"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Jul 2022 09:24:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9A336E035B; Mon, 11 Jul 2022 09:24:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 363B3E015F
	for <cocci@sympa.inria.fr>; Mon, 11 Jul 2022 09:23:59 +0200 (CEST)
IronPort-SDR: TbPsLZz+vvZvA4kcEi9sPIMq+xEZHB/WYVuyM7jSi0efC9ckZBVs8HKGQQFiGp65tFVwXKwnju
 G+qxoubKmZlmQvL0MUHlgjq5zkw459LoBbhtbg+/2LVdDray4paDYZxNPNUXcxn8VCud8Tdby1
 Y8WGSfpDuh/2SCcI1VDw+t+Kfvqwzkinwl76a+O97N2ZO5vd8ih/WN3PpTuhZJl67jitpY5lYF
 E/pfXKUEuRWUkdmUTz7mMppEdu4gEZWeEjJ0jjnW2y39hgv0Axq7J7zU0t65eN8hqYECInSz6v
 av44ZKAyKc+Q3/r+YSASJede
X-IPAS-Result: =?us-ascii?q?A0AcBgBEz8tihwwR49RaHgEBCxIMQIFECwKCIoEBVi4EC?=
 =?us-ascii?q?0WETo5ogXeBBoNPjiqMIwsBAwENNwgBAgQBAYIQgi87AYUWAh0HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDA0JBQgKBw4QBTYGX?=
 =?us-ascii?q?gZkBIFLBIF0CzQNQAEMAYFnIoQVHQEBESc0AiYCYAwIAQGCeQGCZAEDMAcMr?=
 =?us-ascii?q?W+BMYEBgggBAQaBPwGBH4FsHywiUoFcAwaBESwBhh8ZR4JcgQKERRCBVUSBP?=
 =?us-ascii?q?AyCR4NQAoU2gmWadyYEDwMaLS8SgR9sAQgEAwMHCgUwBgIMGBQEAhMSUxYCE?=
 =?us-ascii?q?gUHChkOFBsiFwwPAxIDDwEHAgkQCBIlCAMCAwgDAgMmAgMWCQ4DHQgKGBIQE?=
 =?us-ascii?q?gIEERoLCAMWPwkCBA4DQAgOAxEEAw8YCRIIEAQGAzIMJQsDBQ8NAQYDBgIFB?=
 =?us-ascii?q?QEDIAMUAwUkBwMhDyYNDQQiHQMDBSUDAgIbBwICAwIGFQYCAmw5CAQIBCsjD?=
 =?us-ascii?q?wUCBy8FBC8CHgQFBhEIAhYCBgQFAgQEFgIQCAIIJxcHExgbGQEFMicQCSEcC?=
 =?us-ascii?q?h0QBQYVAyFtBQo7Dyg0NjwsHxsKgRUsKxYDBAQDAgYaAwMiAhApBjEDFQYpF?=
 =?us-ascii?q?RQaEwkqgQEGIhwCnlQilHiuOzQHghWBPAWBPwyIMIEilGEGEAMtg2MBknIOB?=
 =?us-ascii?q?pF7lncgjRKUWYU8gXeBfzMaJIM3TgECAQINAQICAwECAQIJAQECjh0Zg1kzi?=
 =?us-ascii?q?i0/NDsCBgEKAQEDCYVHAQGED4UtAQE?=
IronPort-PHdr: A9a23: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
 nK6kw==
IronPort-Data: A9a23:ZGwJLKmrTqMgHCoUi8OPbjzo5gyDIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xJJXW7SaaneY2qjfth+PdnnoUkH7ZXTydMyHgJtpH89QVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTrSs1hlZHWeIcg944f5Ys7N/09QAbeSRWVvX4
 4ut+pSHYTdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /12rY2uTlcUHZfBo8kkXyt8ITNQPpVJreqvzXiX6aR/zmXDdGbwhepjBgc6MOX0+M4tWDsIr
 6ZHbmlSKEnZ7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzYYJhG1s2ZgedRrYT
 9UWah8yaRv8XxpsJXhJWJwakMj2n1CqJlW0r3rM+PZpujGNpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zD2Y7jSzi+WJkS6TtJ8u+KOQzeZ7nlrD+08pBSY7bFeJhcurpE2GVIcKQ
 6ALwRYGoa83/U2ta9DyWRykvXKJ1iIht8ps//4StVnRk/qMi+qNLjdUHmERADAznJVuHVQXO
 km1c8TBKREHXFe9aX+c8r2Ztyi5OSUUIQfujgdZE1dcubEPTKkJjh/OSNJqFqLwttP8HSOY/
 txnhC05mqlVksMBkam2lbwmv95OjsiYJuLWzlyGNo5A0u+fTND8D2BPwQaDhcus1K7DEjG8U
 IEswqByFtwmA5CXjzCqS+4QBryv7PvtGGSC3AEzQMZxrWnxqyTLkWVsDNdWexcB3iEsJm+BX
 aMvkV8JjHOuFCb2PPEsOepd9exwlfS8SrwJqcw4nvIXP8QvLVbZlM2fTRfehijsllQhi6cyJ
 d+Sfq6R4YUyWcxaIM6Nb75Fi9cDn3hgrUuKHMyT50n5jdK2OSDEIZ9YYQPmRr1ot8us/VSFm
 /4BbZfi40sECoXWPHKImbP/2HhRcBDX87it95cIHgNCSyI6cFwc5wj5m+17JNQ5xPUIzY8lP
 BiVAydl9bY2vlWfQS3iV5ypQOqHsU9XoS1pMCoyE0yv3nR/M4+j4L1BJYQ6d/8r+bU7n/JzS
 vAEfeSGA+hOE2iWpW5CMMOl9IEyJg62gQ+uPja+ZGZtdZBXRzvPpo3ucDzp+XRcFSGwr8Y//
 +at21qDE5oOTghvFujMb/erww/jtHQRgrwgQEbCZNVeIR2+/I9vIi33r/k2P8BVdUSdnGTHj
 V7ODE5B9+fXooIz/N3Yvoy+rt+kQ7lkA05XP2jH9rLoZyPUyWqUx9MSWui/ez2ABnj//7+vZ
 LkOwvzxbK8HkVJNv9YuGrpn1/tntd7ouqMc0QluWnnGNgz5BrRlK3iA/M9OqqwUmu4H41TrA
 BrX94kII6iNNePkDEUVelgvYNOD4vdIyDPc2vI4fRfh7yht8bvbCkhfY0uWhCpGIOcnOY8p2
 7546ssR9hD5lRcgdNqL13gG+2OJJ30GcqMmqpBDXN610FV2kAkabMyOEDLy7bGOd85IbBsgL
 AiUs6ye1b5S8UzPLigoHn/X0OsB3pkDtXimFrPZy4hlRzYEuhM24PGV2TEwUxgT0RhNle5+U
 oSu24uZOo3WlwqERuAaN4xvJ+2FLAKU8Ar9xjPlUUXHGlKwWDWlwHIVYI6wEYNwz46YVidW9
 veUxQ4JlNoskN7ZhkMPZKKulxAvoRGdOOEPdABL0vlpx6UHXAc=
IronPort-HdrOrdr: A9a23:bvhtfK4difGzGKfnZwPXwPrXdLJyesId70hD6qkDc203TiX+rb
 HIoB17726RtN91YhodcL+7V5VoLUmsl6KdgrN+AV7BZmXbUQKTRekO0WKI+UyEJ8SRzI5gPO
 tbEpSXE7fLfD5HZCvBkXCF++9L+qj+zEgi6N2180tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,262,1650924000"; 
   d="scan'208";a="19024708"
X-MGA-submission: =?us-ascii?q?MDG1RiRdcw74OfLKqoEOV3cILo8f63e0MNvwR5?=
 =?us-ascii?q?ZbR60TKvs5wwtnJzdkDHH2vRRZQdHunTIo2Or2B7b43zYzTYaZASrZJY?=
 =?us-ascii?q?sgxSbX8odgK/lxdJ1HlVDcPf/sBSXB1HE5D6+7Bqt30+34wbG0Tk3U3z?=
 =?us-ascii?q?1LIEyaQ4lxHqfUC7nizJRgmg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 09:23:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1657524237;
	bh=cBgVQY3uHeKzOdRly8LTuWilRdixKQY7zDFXwFNu9Mk=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=IXbAwIsEpJR+xDmlVCWdz+eHalIc9ls23HGcg0LfKcGowbyYqiWhtg3Zofe2P6Y50
	 o1DvLscPj9b9tTNqsrb/EmV2o6GjebI8x/77XrMw6NgM2nrKwdbjXPACu0wGCOriFQ
	 kQEMKFWVFiC8go8InsKNeMwAJVMMtTV3czw/u26E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.135.77.98]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLAVc-1nsaQp17kA-00IY0I; Mon, 11
 Jul 2022 09:23:57 +0200
Message-ID: <85246751-c2b9-6533-8507-3246d5d00147@web.de>
Date: Mon, 11 Jul 2022 09:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: cocci@inria.fr, guile-user@gnu.org
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AWiqK+qoXwT2WRConwWOPcDOrOaPsTFR9xEVqT+ftjai+JJ/hFc
 ku28qeON1gTXFdyi5NDCYnVMNZO35Fqey/G7QOisE/ezO/pPfQgaWKcF2xzZrB1NCQrlZtP
 GMiSMJEkUWgeAhPAxqjQwNDD93e3u3bz4lDHMnLxp29kRRYA7vJbrGV/u7w2p37FsFqQMon
 5IdYJ8aB9soxEK6KH5ABw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kz8+Wajvbrg=:A5gnrL5Y5AkHZj6R77ygID
 gxqrbO9TURcKopddPP1IU8y0E4xqi80bShkwfvnV8uBaidfTFQ2Xk6zD0OUZv+6vgmfXtVfco
 xIq7Mc6iKYksgJBNv/SAA47X13uXaCLE4bRShdXY+0XYs7H5z2EgLK8RqwHaOlrkDiwLak1DH
 KUMYsmNAVo0+uwT2PNEXbv89NwjRcIDSG6HmaytoTjHP154A0phJueeEHQAtjY5PVLDIWgtet
 z19HYYiRDA7yChiREbWRHG5VOrwQ52a8J0RdKYA9PYf7ishHnePJcmD1dWYJnaJn7j6vj3F4e
 PZi++vtPABsZ20l1yAjz8qCzHjob6eyjusZ3Qs6HOabW5fPXETmPDoU8tDXUdhPRJnDqKuRPA
 YkJmD1g5MO+zWndrIdEVLYAOqbz+ra8Bxy0wVCQrB9BgQnAp0sA7f9Ck6B4cINaWiyLuOvOWS
 oTaqtSHcOdcRXUN/es2SbVqw1goAmRwHtUFN582pgFtp3wHdbwfmkIxxiRzr46lfeEpG1lSw8
 wBmGjX60flQNbz7Vp5PRYQMWir0uepvEUAkDK4OX1gsUhycOg5Vr36LUAQjGYfV7WTQgyoxDc
 60x615v2YJG8oDV1Qe+XiE2hvklrGWb0I9ORRLjerA9MkiJxjOw5nkfCkppUGcuVf4h0K5+s7
 lzcDvdP4FX4PUe0o8YoKsaOeYPDfbgZ6IGtncjjP1ADJzrZVauFti8HRYKT+9PjaNPhPshEzI
 jM9zH+nfyis47lLEcONlxG7EHvigjXyNAvj6F/UdOtoIsiCG6wLG07Km1xtaKf/Yz1jG9slEU
 6O40wov3mtP1JhyMN+kO8kKgRdHOIo8UINk1TvbZKzGyynUJNPoC8YFEXd+zwbrBSAxZXAQO0
 La5ISsVKePoF6rF4yZkfSpv5ZVOvc0VgS/R1hZOwoXxgLMN0BMJSr88w3R21Z/W/rf9+Gramg
 e2Wi9/rftKhd8W/9h4DEfV56fs+Qtatl76uLatkT43flGnTj7kdmZlp7c7Ljb3VxVfW+T77E7
 NKdn3GDmeGJ8SCNrPCaMSqF/CR5uHjt0FjQ0pfCex4Qgoqr6aXEfFSo5G3RI9ntvxKThLCJwh
 IEar+vFeb5KobJlXvvYqLi8umkcW0lV1/YHC1XtcFDSFMdySeLhJkWPgQ==
Subject: [cocci] Developing reusable libraries for computation tree logic?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 489
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/85246751-c2b9-6533-8507-3246d5d00147%40web.de>

Hello,

It was demonstrated for some years what can be achieved also by the means =
of
the technology =E2=80=9Ccomputation tree logic with variables and witnesse=
s=E2=80=9D.
Will development interests eventually grow for the construction of
reusable libraries according to affected software areas?
https://github.com/coccinelle/coccinelle/issues/251

Regards,
Markus

