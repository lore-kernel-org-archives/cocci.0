Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B3CC4167B
	for <cocci@archiver.kernel.org>; Mon, 26 Dec 2022 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pltLGCoJOL/V9JJyb9mf48+iOIxqPtHRcS4/S39H6CI=;
  b=WwpDJK8A9BEPGnAPR+Hm7e5py5jRMOsVdxzRKUCEdeeRTeLkUxQOd745
   M0wsSE5mfJ7fhhh83+tojawIykwK1FhsX7GRk8zAu9n9WBQYXLdZ4ZM5e
   Og8rEJPGrYRwfvsqdlJ6Jq2e9rcCp+638Iwit1GS9vqgpuKwbl7c27QQw
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="85074332"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2022 11:30:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8928DE0138; Mon, 26 Dec 2022 11:30:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8AC5DE0128
	for <cocci@sympa.inria.fr>; Mon, 26 Dec 2022 11:30:25 +0100 (CET)
IronPort-SDR: 63a977c1_mkDcUuKB5VW5PBlhV087e1G5n8l5M1zYJp/qI/WKOqpS0JX
 75kSXL/qjKaG2mdXRhvFZV/JNXSbknE6+dLLbOg==
X-IPAS-Result: =?us-ascii?q?A0EnAwBFd6ljhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLYFdLgQLRYRPjnqGU4clhzGEYIQCgxY+DwEDAQ1BAQIEAQEDBIR+AoUQA?=
 =?us-ascii?q?h0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARoJF?=
 =?us-ascii?q?wcOEAUihWgNgjgpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR1M9A?=
 =?us-ascii?q?wMjHQEBESYBDwsaAiYCAlcGAQwIAQGCeoJuAQMxB69wgTKBAYIIAQEGnAgfL?=
 =?us-ascii?q?CJTgV4JgRQsjHKEMScQgVVEgTwMgnc+hESDV4JnjmeKNAqBPX2BJw5kJQQOA?=
 =?us-ascii?q?xkrHUACAQs7MgpBNQkCDEsrGhsHgQoqKBUDBAQDAgYTAyICDSgxFAQpEw0nJ?=
 =?us-ascii?q?msJAgMiYQUDAwQoLQkhHwcVESQ8B1Y3AQQDAg8fNwYDCQMCH09wAi4RFQUDC?=
 =?us-ascii?q?xUqRwQINgUGGzYSAggPEg8GJkQOQjc2EwZcASoLDhMDUIFPBC9efwoGKSidD?=
 =?us-ascii?q?MZdNAeCIoFPgVAMnm8GEy6DZgGTDw4GkhothyKPdyCiWYUFgXkjgVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIBkeg26KLEA0OwIHAQoBAQMJhUcBAYZaAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kh2yEKCPN4deGiflHel455DYdb4zR+YMi2TDGXoBLiC9Afbo8v
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO0s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="85074330"
X-MGA-submission: =?us-ascii?q?MDEx7g6zowdfFBRZNaqZ+kcZFKTrwBCP1Su3zM?=
 =?us-ascii?q?tMydZ5LijskUfkQ/wlDcU0gMIZg60QWQ3EnmavN1Gz7ibzQ90zNMoMh8?=
 =?us-ascii?q?1fvE6ZONS+8dMSlTJLRN3SeN3mhfJoXbG6lfa6yqbfr/RySBagigY/fM?=
 =?us-ascii?q?ig9T1yl94pNmAR86hQLODX6Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 11:30:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1672050617; bh=pltLGCoJOL/V9JJyb9mf48+iOIxqPtHRcS4/S39H6CI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=inHJq3ZxTmyOHGZ8ww4u1rA4i3GoW7WMo6Tnd4eapYf0reEJl93K5mBbc6mdOIqks
	 AQ8lBM8ClMD1NOXeZaOy3ioHWfsI2Lbl49CWAPLJFUk00J7WI9ivmq67nGHHfILwwP
	 6SHlV5tvKimanNYrsKOp9SRtRHDR4ZTwe9rbITslKGRuC7jDPNf8usoqjF+1fGWlRW
	 AnRJIw8dyOET5tU7Zp1D7H2xvyESKX8+nAiE+8dCaVfEPVXeTWQ1P50bEe8TiwzDVz
	 rF3rRlSS5QiZTw9WslQj8HhOFZig3alzwe04KLWVs9mZT3XUenZ/5icm0PAHZHclCq
	 0TcBz+QOuh+8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYtx4-1pMpdh2V4C-00VDog; Mon, 26
 Dec 2022 11:30:17 +0100
Message-ID: <a31e9df0-1d15-9727-0a98-6c0cb2acdf84@web.de>
Date: Mon, 26 Dec 2022 11:30:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Deepak R Varma <drv@mailo.com>, cocci@inria.fr
References: <Y6hnpcLiHmJaQbeE@qemulion>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Saurabh Singh Sengar <ssengar@microsoft.com>,
 Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <Y6hnpcLiHmJaQbeE@qemulion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oM2JkkvT/a5lO0y+bP2870FDU1b/gVw8MDNAV1vMi7WdMmT/gxf
 MitEYpckLo7QmneQh/Rlk0RoQYchlKhYzwjUiWinxjRJNU9FGg1lbuf/Lk2d1jCJi2rNm0m
 +vQYB3ccsQhjS4l6iDtG7fTz/oMt0xKO74yadOpptOfkLAZQVf1W5xRCLhUjlr6EA0JK1zP
 qWwDKsoPSJWfHZbCG68jw==
UI-OutboundReport: notjunk:1;M01:P0:fAlxIxB/d9U=;ZxWxowoDWXhgJZRrHwQSXxKMW3n
 rQfz1rH0PwIoCSt9kx7paiUsSvLYzvq8GdxMLQPb90RK3tYz4fYgrh7lwOJhsCu/ls9hyX4Us
 y/jxFS9ugHG7t7jPvkEFtJRBtkRnhv/eM1LpKN4yFu9eBVCAiqIk8bN7BfUQCeB9b8UNm3IeK
 mzY1emrLyI7S0F83uEj8EO52r1uBpjUgGgfAASGjrmu2RGxv0SDi7ss4TS4Gopofascwb0zS3
 nJcSqgAIUCpixZsECqX65nLpRTgqcgC3HZcqCeKhmJUbax8F0CwN51Lc66iKbhYusTLKzTtsU
 SuSGR26o7tGMSOr3mpL/qpY1HMpcbjx1EQ/n/r51pJyHoys7ICP5KCnxFxm9C2/w7mZjnu61d
 kNKGwMUGveruWJZ9bq0tyik+l4I5oNTL1YbjdPAzW7toQgz6PTx/dfJQkvkXZKWvpNuYbzenL
 Vz88Kjsu1hwUG2f+P/rAOUw2FEiKvARKPRPg/8g4hACIu6jpbw4NO5MnjX8XF8D514Ys93D/N
 mp+1UuikBpmkOKbmZNdMN/XCy34fZooIekquVP2UWpnfLWaTGITU9MPYUlqzSAbftRrPGmROD
 g1lo1lad97MWJL/SNIdGw15yEho9VU/PDVesqGSGkn2JAlWXej9wfXuPwxMp59h9MC+H4VfNq
 ET+qgxkU50MJyN1Ugzr7lvoZiCFtOcJ75L1UgZDXtqDGA0ROT/JHmC5/3iQI5wkEtCowXRbbK
 RBjrQgny2Bsa+pL3AdwzVsExOjHYvAfP+kA2PYSKmR4lrtFY7zBnpK0Rlu6zQMiHe30AjFcco
 cV2GhmliadmrdhHmcUERYPw8tnnC92XW7afjNnS6o/5bZBINtud46aOTA9E7Xv5PIvhOoS9dt
 +atC6E8I09RCE41KbDlXm6WdoQ2AlAessMhQ48DrpVLvzFCokDptSODzMKOe60KXolju1nUmU
 13MfLA==
Subject: Re: [cocci] [PATCH] coccinelle: api/atomic_as_refcounter: include
 message type in output
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 788
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/a31e9df0-1d15-9727-0a98-6c0cb2acdf84%40web.de>


> =E2=80=A6 So, include the test "WARNING: " in the report output =E2=80=
=A6


How do you think about to use the word =E2=80=9Ctext=E2=80=9D instead of =
=E2=80=9Ctest=E2=80=9D in
the change description?

Regards,
Markus

