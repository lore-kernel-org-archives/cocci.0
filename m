Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA788C32771
	for <cocci@archiver.kernel.org>; Sat, 24 Sep 2022 15:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wLrLVm1EJI4hNMFWxi8rVg7HMjQDPVVYAA9QeZni4C8=;
  b=SQXBfL+Zd2LF/3gebrfHYZ9PHXLBxvwg8RfBGc3WnAaMMH1Hug3Wbjyt
   6cu/GDyp9jfFnbDqJIwxZaLXYJiC7rdZQF2Bgah/kd465nXezhXsgvP2v
   LVozBqe6WtSIzLoFNiQa+G1p1jArIFmyV1wLpDpXFbTW8OTec2MXSbyNZ
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,342,1654552800"; 
   d="scan'208";a="54345447"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Sep 2022 17:40:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6D7E0E0130; Sat, 24 Sep 2022 17:40:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1D99AE0090
	for <cocci@sympa.inria.fr>; Sat, 24 Sep 2022 17:40:46 +0200 (CEST)
IronPort-SDR: 632f24fd_v+4FnYjCuN3fjw1pwqVTC3Y8rAFEE9VRIi9UqVvxwecb8ox
 S76Wmxre//NzYrtxAH6Z2KpgGy+c/CbOftME/Hw==
X-IPAS-Result: =?us-ascii?q?A0BbAABYIy9jhwsR49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YIjgVcuBAtFhE6Ob4ZOhxiLf4VVgXwLAQMBDT8BAgQBAYUFAoRsAh0HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBGQkXBw4QBSKFa?=
 =?us-ascii?q?A2CNSkBg2QDAyMEGQEBESYBDwkCGgImAgJXBgEMCAEBgnmCbQEDMAePJJwXf?=
 =?us-ascii?q?zOBAYIIAQEGhE4fLCJSgVwJgREsAYwAgkWBYycQgVVEgTwMgnc+hESDVoJml?=
 =?us-ascii?q?HyEIyYEDgMZKx1BAgELQjUDFQMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCA?=
 =?us-ascii?q?gMCBhMFAgJNNggECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJ?=
 =?us-ascii?q?hcHExgbGQEFMicQCSEcCgQaDQUGEwMgbwUKOg8oMWsrHRsKgQwqKBUDBAQDA?=
 =?us-ascii?q?gYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJjwHWDoBBAMCE?=
 =?us-ascii?q?CI9BgMJAwIkE0d1AjcTFQUDDRkmCAUjFx4ECDwCBQZXEwIKEgMTm3vEQTQHg?=
 =?us-ascii?q?hiBRIFJDJ5NBhMulmcOBpIJLYcKE49BIKdJgWcBM4FbMxokgzZOAxkPhFCJU?=
 =?us-ascii?q?Bkeg26KLT80OwIGAQoBAQMJhUcBAYUbAQE?=
IronPort-PHdr: A9a23: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
 4qX/EoSADJF7s6S4sYWQcTZeprvDQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:TjFWSqs1/d9e919p0qiaJ0aJ7skDUtV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,342,1654552800"; 
   d="scan'208";a="24588440"
X-MGA-submission: =?us-ascii?q?MDGGXV7HC98Q+3AD00sRbPH8WXJ7aPt2Gx2ghe?=
 =?us-ascii?q?Ze+dAPkA/z+Ke1W7Xd46eC4bq+swyvq2R+SJSM48b1s6XnRInKFCWsTr?=
 =?us-ascii?q?VyiJkhiDg9PbxIGAv2W5wy8dqqfhIsgAROY2lyY7e/ppXM+wuk9HJpYP?=
 =?us-ascii?q?Z7x2B//u1MgywN9P4snkDkaw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 17:40:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664034030; bh=lKxcU0eJ9wrQ7EkY1HoHFWi5BiYfuF5y8SZXpMLZKLc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=qCuQ7oE+MCb5q7Qj+PIxQ6OH7JoFX4TK3ulVwJncID+LLRCw3XByMzamjE7fz7fE+
	 YUDyLWJaLz/S9Irsr1vw7Htpjy4BZ4OxnQKhP8xNSxTKIR2VU+Taoldp7Ej5UuxXtg
	 bUS8ZTCaz+TJBktrCNxlwWdA/X3ayd/uVy+ih7Py/oGW878cCfMVyIrEzhRNdwvBxd
	 mTxyMfe0SftJBbSWCnJb8U6HNutjyJj1bpuQnWs8nMaAKTdZd+kjUdjaznOawUvwog
	 q8L/k3T4CKWs51wRutnCOPFK9W6DaD5Bb2tDb7G6NQQcPL7EtszAa6SWiKqzMBZg6K
	 CZLTM40RVuI7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28SB-1oZeQJ0Uhd-002CkC; Sat, 24
 Sep 2022 17:40:30 +0200
Message-ID: <58a33107-51c3-a392-8357-a0793736c66f@web.de>
Date: Sat, 24 Sep 2022 17:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-GB
To: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <20220922115535.44132-1-yuancan@huawei.com>
 <20220922115535.44132-2-yuancan@huawei.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20220922115535.44132-2-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9R9X7vbzU1sFGwx9tR9BL9MLTPPkKn/FIVQHGEqI6KT/qag6U2q
 6Z+yHj2L9criyGLSq/hgal8J8JumewcfHsJEGG57qPdUCUy0c08e1sLhGwzX3heeCue+uCQ
 bCMgPPVx6sxKereeIvpIVkR3DOWvXIMC6N4cf8Qj6lp+RyK0qCaAmovfWCU3gNqsq+uB4pg
 sc8B3jX91XoVHmbmoXEkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w5O5bTt54rY=:j97rtWR+aE/HBeVpzWn17k
 DeFEcQxlZTYBv9FOaJsWPMqHQ+PGDam/T1MjFCEj4U5rcpM+8FRfFOVai9V982tBwksMKtru1
 O5jI9c16xoaI+KzLr4bMgbQ4uK5O6n04Uq9p28Nnfb35sfmggO+EK1jq842MySiybGTd8dOjR
 NmWg7xnJsbXq+xP3h7tcYqFimmfsl2ydCr+3AVJ6eNgpTbi631JulQfRumOnh/nFcnt9SyBw9
 n3lTZpJXTgzCpR8IUCh9al4U4h6fLDTrBrfFi7rxag6QIvKZdYsgMTzApE7qjNJcbmI1cWzEG
 DbJBHjrTtLd3cyax471jM3BiKtHOI91t+uZOC+2s4CsiWDgXHnkslGkL4jJ/L739kRcrL79Uq
 x6Tr4YL0kYwiYkCnNprhLMYDOefUiUAT76V+baAuVLihkPw13ibbzR8fb9WqCNepDbcM5vjIO
 +l4oJkBBJv0e72Xey8QSmCQXvfrzReJas0LAVPfpCSv9CrKvutTCp/U1lw9i0Br/hGDx0ANPh
 R3Q+1i+gGFGYXDS2ZuX5Sg1/YwXpFpWQSx1YA9drGf37rmQ47Z7jWsxs1DGB7ow3GxrHPrRU6
 6yckm+MOd9MnUcgytnvGezsL/1QlfYsGDEoiI236hGZorMONRq61BCnSvN2InXWrrqSoS6bhG
 YoyEak8WMQrQY8W8Wm/DuDmD4F/zaRdoL+rG4olvYJd5H5l0ZqQ6BOrKnYvMRWZBYkE1Q3zOw
 bR0J9aGiNqcUD6/jXjK/qfXdqkwkt0tkncZDBmORjKMoA1DWNnScucOrL3GrfPP8HIofZQ+hT
 JziTJmAJDSz5mc5YPu6qIPKfKfexhu7NkHd5EtY+Q7x5xkteBtM9dBQ5dxax4QWl6VUpwUopA
 HTOZEu9+9NaJpCbMJ32oPX15uHjXW2C3qruleOSJ/3fZqBzPPRbX402DlJpABoUM0SuB9Hj3Y
 d0fL7m62MBoJQg5uJ68kSblTgxNd0Rb/f6lSR9s8cY+FnLp6Ed+KB8dAGZNADSNeStPiN6Kn4
 nGrMIYq88yT3o9Nq9ulg85thMXit4Gnu2GR4frHcbv1M2zXmv/gxydg7A3Kn4wivbY68uoGxf
 qkz3T9hrUCq7TlGyoZsM9N/oJSpmtanY0hHAdoyBstLe50F5OiFnPGFeag0L/PwdMy7Pdyvbr
 5oUgWd5q0f8rZyAlJsvhpLY7h6
Subject: Re: [cocci] [PATCH v3 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 582
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/58a33107-51c3-a392-8357-a0793736c66f%40web.de>

=E2=80=A6
> +++ b/scripts/coccinelle/locks/missing_mutex_init.cocci
=E2=80=A6
> +/// Report mutex used without initialize. False positives can occur
> +/// when the mutex allocation and initialization happens in two
> +/// different files.


How do you think about to use the following wording variant?


+/// Report mutexes which are used without initialization.
+/// False positives can occur when
+/// * the mutex allocation and initialization will be performed in
+///=C2=A0=C2=A0 two different source files.
+/// * inappropriate data types will be found in the source code
+///=C2=A0=C2=A0 because of unsafe scope resolution.


> +///
> +// Confidence: Low


Will this categorisation trigger further development considerations?



=E2=80=A6

> +@r1@
> +identifier s, fld;
> +struct s *mm;
> +@@
> +mutex_init(&(mm->fld))
> +
> +@r2@
> +identifier r1.s, r1.fld;
> +position p;
> +@@
> +
> +struct s {
> +  ...
> +  struct mutex fld@p;
> +  ...
> +};


How =E2=80=9Csafe=E2=80=9D do you find the scope resolution for the search=
ed data types?


Would you like to explain data processing consequences a bit more for
inheriting metavariables after these SmPL rules would occasionally not mat=
ch?


=E2=80=A6

> +@script:python depends on report@
> +p << r5.p;
> +p1 << r4.p;
> +s << r3.s;
> +fld << r3.fld;
> +@@
> +msg =3D "Mutex %s inside the struct %s malloced at line %s is possibly =
used at line %s without init." % (fld, s, p[0].line, p1[0].line);
> +coccilib.report.print_report(p[0], msg)

I suggest to use the following statement variant.

coccilib.report.print_report(p[0],
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "Mutex =E2=80=9C%s=E2=80=9D within the structure =
=E2=80=9C%s=E2=80=9D (which was allocated at line %s) is possibly used at =
line %s without initialization."
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 % (fld, s, p[0].line, p1[0].line))


Regards,
Markus
