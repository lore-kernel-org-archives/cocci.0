Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC25C6FA82
	for <cocci@archiver.kernel.org>; Tue, 20 Sep 2022 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MOd3//wqmghp2sUH/JRzYjePq0/NZ6BvYYEL6bEJtQU=;
  b=BJ92Z64EYjolw5l8ApWHPoLqPdj681WIOHI8tnTfyC+AaS7gEcTK+Ope
   mDRQX+4B0jg5+2hvqlslhyjA25rIZPlHDROq2C18QAK4B4JRbRQ4wkOsQ
   z27Dgy8xPbPB2yZyrlvae40dGp9X02MTj20cs8w3ijtfLT2v3+oOiqzCj
   c=;
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
X-IronPort-AV: E=Sophos;i="5.93,331,1654552800"; 
   d="scan'208";a="53729954"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Sep 2022 21:22:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B76EEE019E; Tue, 20 Sep 2022 21:22:19 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B5FBCE0157
	for <cocci@sympa.inria.fr>; Tue, 20 Sep 2022 21:22:12 +0200 (CEST)
IronPort-SDR: 632a12e0_FK0/0zQDeZXJMYG8EthEqMqzdXGsGuFRy9S3HT70btIKlyE
 xtFo9Rd3RGogsZza70g0lMoeJnDE3MSGL8Awu0w==
X-IPAS-Result: =?us-ascii?q?A0AQAAAOEipjgAwR49RSCBsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgTwFAQEBCwGCI4EBVi4EC0UChEyOb4F3LgNpgz2TFYVVgXwLAQMBD?=
 =?us-ascii?q?TsEAQIEAQGEQEUChGoCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQEARMBARoJFwcODgcihWgNgjUpAYNkAQICASMEGQEBESYBBAsLGgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJ5AYJsAQMNIwcMrDh/M4EBgggBAQaBQAEDAgwCQ4I3HywiU?=
 =?us-ascii?q?oFcAwaBESwBi36EKCcQgVVEgTwMgnc+gksXAQEBARiBHyeDVoJmlQSEBiYED?=
 =?us-ascii?q?gMZKx1BAgELQjQDFQMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCBhMFA?=
 =?us-ascii?q?gJNOAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHExgbG?=
 =?us-ascii?q?QEFMicQCSEcCgQaDQUGEwMgbwUKOw8oMmsrHRsKgQwqKBUDBAQDAgYTAwMiA?=
 =?us-ascii?q?hAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJjwHWDoBBAMDECI9BgMJA?=
 =?us-ascii?q?wIkE0h3AjcTFQUDDRkmCAUjFx4ECDwCBQaYfINKAoFNDQUloVCgOzQHghaBQ?=
 =?us-ascii?q?4FHDIlklGcGEy6WZw4GkgkthwkTj0EgjRmaLIFjATeBWzMaJIM2TgMZD44gN?=
 =?us-ascii?q?4M7M4ELg1aFTD80AgEBBwQsAgYBCgEBAwmFRwEBhTEBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:26P+9KsIH/lsknjeyFvskc6l7skDUtV00zEX/kB9WHVpmwKj5q
 STdYcgpHrJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BgDVQfexQo+VvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,331,1654552800"; 
   d="scan'208";a="24233932"
X-MGA-submission: =?us-ascii?q?MDECmlnnrN6HfKMBbhZVgFGw5kgLFlTSYh5RY6?=
 =?us-ascii?q?SX1PdQe68a6r+K244IwRlMqYp4J5l3IspFqVKs5UznBpjM2skicE0u5i?=
 =?us-ascii?q?GZjiE+KA3wND8G29Q1/Ta9ZHK31zyYPzMttoitA8NJcLN7j3R342SBDY?=
 =?us-ascii?q?pziRziUfzvVZxwhEm2nSDZGQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 21:22:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1663701715; bh=xDjWQwvF78WLdwp+cr+i7WmzATojx5xD+7srNrLvMAg=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=Y2YqGiGlws7nJhM7jNm5p97sGEefQHdtx296vMDBHREfqOg/tk/lvNJ4jVvl53ACb
	 UtkOHCtuR7zdwf1Afs2Yc570YIPACLNDMuBvAo1jgV05g+XJjIIJuGzbUQQk0KX28l
	 vPsRKFbAP6f8LRYCllY23w5bYMyWmbFyqVsiznxzU5I0ms47JDMGTyTDUFg9GqwPg/
	 2J/xS9TqVP74UytTJBi7S6s0sVXZAPpfy4xUq1WJl+8fkL5DR5qHcGjcFRqYGQ9hhm
	 ukF6WXmlU3ct9CPnlZZ1mkYMKI8OWZ9hKlEvSbJrl45i7gqkY+G3BJH+/LSHJ3BSZ8
	 aQ5Cgkf5wa+Uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9ZeA-1ogCzX1EzU-005npA; Tue, 20
 Sep 2022 21:21:55 +0200
Message-ID: <0896e030-5060-08e7-d0de-c63d77c9ef27@web.de>
Date: Tue, 20 Sep 2022 21:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <20220920025820.105924-1-yuancan@huawei.com>
Content-Language: en-GB
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20220920025820.105924-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q1pwXWVrzGkLWRETmHOQAJZf9nWRkMCG2jKQahg1Zr1L4ZHH1M5
 2r/nImCh2/Gv2etLiDAS+AEIMsYmdy7j1BSym7h7qf+KoGt0LeeVHJ14JsgPVDRHKw0bZBZ
 A1OFqZXcF6rWaLuyna7LqpYFX+x3Cep2aDEuTJsJZ7ObyDu0xKjt25/vOkOMbKfUdoM9EVo
 zoMxS5X7dRtAtxS8snSag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WMllgXGW8/4=:gE3kxihng3ZkkLnOjLP3Oo
 kN17fOBCXldqYHEtVGp1IJxEdOHV939aDMlIzcEpUt5lY6Pk6bExRLjmiStOn1hkgHbUKf8iO
 m+jUFXXfBqOIbVG3Ix81wvIPpVZebMBVdgiSFUE1dtu8rdaQft6/WZy6OTFBxoqZ39hhdiwon
 Pqmr4biY5xF4FUaUYl5zlfGlWJswKBmaA1nOu4YpKI+JSYZliheUyvzJDJIsspgPEyQejILLr
 gF6p6EBLpK7DhmW3yqPa3cnLb02JMwvGsXEz+XWDWjpPALxmjs6K1e3vcKzt6F/6TCIonTpzm
 9PaHuhF7PTHRiLZ6Rs3xeEc4JRNi1LqnepXIp4OEQhlUFbJx90l+6bOwDzh6khV252V6xgtlV
 DwSyx35yTc7KjEv/OErzCg4gYgeKB0sZy3mX+Z8qn6RJBjY94QhkdW9fgV9+CIpwI/4l82LNr
 bfdC7yepEQsQ7Kmy4ollqJAuih7rsg2mm1KW1138dyOAPk90kyleMu4Q7aB1nhL7FW7OXznUM
 IYNJtzo3rF2ou4WWjzASfDBZ1nUH9PGD3KiWNZ+wpVcoxQ3di876Rb/uEyHh8JFR2ZCbwt7yu
 9Vm3ImGjUHj1gi8FxNTSTuafAREAagW+Fr+5i6OGbVb0UMp1MjEpf19Ajiph1rh6cVMfjw/eF
 gLqv7nxEw1IwcbbAZzk+zmOILIkIxxaMA+x/RQS3cbqvHlZ0Y6Pp1Bh4WR/cXoiP/QZb7J6rs
 Gmkc+gf4TtpFs4E/FXOwZDpPF7lhQFlIrLhLT9xb8nNAvn4byTJt83q7mJN4BmGyZeUEhM9B3
 u6GZ9l9RrgaXYCtB39plES+R9cnqoMFNvJ6ccUzaotsjKuV6DbL4deHwvixAmDlWM/h1w0G6+
 Lm4uG5rxVcf6qT2y45D+5Uedw+lk5Cld60cqqrjNViE3McBge2Vo7bz9F74uqSm+h1pAZK7S8
 34clTBl6LpXLW87CrlOi+MHrXLhGCAdMogaeIf7tHvqSMUg/2IiaDfXWOObuWubaAS7EyCoBs
 RNvzDTS0QaXeqVwtT+b6m/VeIwLWi2PFkM7yR9eQ2rA97o5tx4FWtQa9ccI0e33lnBjK5XvRz
 l4bFxenovlqvy+8LeOfm5phYDw7ZB5oeSEn7pvyyPRQbjblOA6Rs/pvsHMFLyDCEw2YyVbhmx
 umy87ILQW5jD1TDgQRORrqnzZN
Subject: Re: [cocci] [PATCH v2 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 561
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/0896e030-5060-08e7-d0de-c63d77c9ef27%40web.de>


> Find mutex inside struct which is possibly used without init,
> provide the name of the struct and of the mutex, the position
> where the struct is malloced and where the mutex get locked.


I find this commit message variant also improvable.

Will terms like =E2=80=9Cdata structure=E2=80=9D and =E2=80=9Cinitialisati=
on=E2=80=9D become relevant?


I would appreciate answers to my previous questions.
https://lore.kernel.org/cocci/fb101290-3ec7-9170-9fec-43e1b5f54c52@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2022-09/msg00022.html


I would expect a cover letter for patch series.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.0-rc6#n321



=E2=80=A6

> +++ b/scripts/coccinelle/locks/missing_mutex_init.cocci

=E2=80=A6

> +// Comments:


Why do you suggest the addition of an empty comment field?



> +mutex_init(\(&mm->fld\|&(mm->fld)\))


An extra SmPL disjunction is probably unnecessary because of an isomorphis=
m.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/3f7496ff9c2c5d4fadae1=
e585aa458e1a0037972/standard.iso#L382
https://github.com/coccinelle/coccinelle/blob/19ee1697bf152d37a78a20cefe14=
8775bf4b0e0d/standard.iso#L382


+mutex_init(&(mm->fld))



=E2=80=A6

> +@r3@
> +identifier s, fld;
> +position p !=3D {r2.p};


Why do you think that such a SmPL constraint would be required?


> +@@
> +
> +struct s {
> +  ...
> +  struct mutex fld@p;
> +  ...
> +};


Why would the source code search repetition matter here?



=E2=80=A6

> +@r5 depends on r4@
> +identifier r3.s;
> +struct s *mm;
> +position p;
> +@@
> +* mm@p =3D \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)


I would expect that the usage of the asterisk in the first column should b=
elong
to the operation mode =E2=80=9Ccontext=E2=80=9D.

Will it become relevant to detect any more memory allocation function call=
s?


Regards,
Markus

