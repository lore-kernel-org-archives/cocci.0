Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C091C4332F
	for <cocci@archiver.kernel.org>; Sat, 15 Oct 2022 15:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HD8wOW7nRKLac5r9ZMd3Azn53bxrQKWE0ugINY8NzoI=;
  b=sffR+yWLbtf0RParROfIIynqbqrf7xI9cGeA4dRynX4wHzn7nzuVtH5L
   srZPl3uQvH3xGX9SQ1NsD0tEK5cQAeptBrzbbW9aVpIXotjGDeLivgBPP
   Q8UuvBtqk2i15y6PgRlLjFs3WVnWRlttxkkhGkIU5rhC5a64EAIWJ88qM
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
X-IronPort-AV: E=Sophos;i="5.95,187,1661810400"; 
   d="scan'208";a="65307660"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Oct 2022 17:12:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 40981E0137; Sat, 15 Oct 2022 17:12:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 45CD1E0038
	for <cocci@sympa.inria.fr>; Sat, 15 Oct 2022 17:12:45 +0200 (CEST)
IronPort-SDR: 634acded_Ue0mOH/XLiB8WMFuiyMUySTurGsqOsyHhLNrMBDSoK4MBVU
 5dzX7797q/wPiX7+Z/uuh+4kfIsVdYjVzk/GYpQ==
X-IPAS-Result: =?us-ascii?q?A0DyBACQzEpjhwsR49RagQmBT4IlgVcuBAtFhE6QcAEoi?=
 =?us-ascii?q?0GHJ4wvCwEDAQ0/AQIEAQGEewoChGwCHQcBBDMGDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBAQEZCRcHDhAFIoVoDYI1KYNlAQICASMdAQERJ?=
 =?us-ascii?q?gEECwUGGgImAgJXBiSCbIJtAQMNIweqaoEygQGCCAEBBoROHywiU4FcCYERL?=
 =?us-ascii?q?YcXiCF6JxCBVUSBSAGBCIE+MD6ERINXgmaSHYJHhgo4A0QdQANGNBgDFAMFI?=
 =?us-ascii?q?QcDGQ8jDQ0EFgcMAwMFJQMCAhsHAgIDAgYTBQICTTQIBAgEKyQPBQIHLwUEL?=
 =?us-ascii?q?wIeBAUGEQgCFgIGBAQEBBUCEAgCCCYXBxMzGQEFMicOCSEcDhoNBQYTAyBvB?=
 =?us-ascii?q?UIPKC9pKxwbB4EMKigVAwQEAwIGEwMgAg0pMRQEKRMPLQcpcQkCAyJlBQMDB?=
 =?us-ascii?q?CgsAwlAByUkPAdYOgEEAwIQIjwGAwkDAiSBSzEmBQMNFyUIBTcbBAg8AgUGU?=
 =?us-ascii?q?hICChEDEg8GJ0cPSj45FgYnSAE2Dw6dSYFjYwyTda8/NAeCHIFHgUoMnnszA?=
 =?us-ascii?q?4NQkxIGkhOXFqd0gXgkgVszGiSDNk4DGQ+OOR6DbootPzQ7AgYBCgEBAwmFR?=
 =?us-ascii?q?wEBhQwBAQ?=
IronPort-PHdr: A9a23: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
 chWIle6fFkyC+9cFUlvWtAPcs8fYw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ERw4RK85a/XzVGslXvFuk+AaI+orL9Y04lQ7vn2ZhyY0TiX+rb
 HXoB17726XtN91YhodcL+7Scy9qB/nm6KdwLNhWYtKGTOW3ldAT7sP0WKB+VLd8kTFn4Yx6U
 4jSdkGNDU0ZmIK6voSizPIcOrIruPnzEnSv5al8593JzsaFp2IAj0JdjqzIwlLZE1jCYAiHJ
 SRovdWvjbIQwVtUiyDbEN1INQqLLDw/q7bXQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,187,1661810400"; 
   d="scan'208";a="65307659"
X-MGA-submission: =?us-ascii?q?MDEYCbyZTeRqsclS7yC+MGZBeNFXIZlF+gacCH?=
 =?us-ascii?q?qXyOPCQjNQjLkdMFj+KSXTRcYlgL1x7XMrABNirHA7xMKxe1vJu5iTCy?=
 =?us-ascii?q?1JvlYRFnQh5bMfk8RJI48ZCAwgbr5r1ePpHZqN6ufvd6D/eDDJmksNwP?=
 =?us-ascii?q?QJC102CsBjTICV57IkjfGmBA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 17:12:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665846759; bh=HD8wOW7nRKLac5r9ZMd3Azn53bxrQKWE0ugINY8NzoI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GpFXyTGVRvju0NcdwSktokSAWiKbVCLBw0QAsq2BfkpYXgPR2SxrNTfy6knyemmbA
	 JDJI7/+Uw7OrJHN/aq9L5S9bzDlX8MKAX67zv/SQ44x7tCFdCDbqF5cIaTpVS5Nhii
	 s0rs8I+0byMdldBsnJkd/8jHwytc4VEU9AVWZef84p4G83SPcNCCC9d3oX4tFmddwc
	 dEg8FFoMe2iHqRuve43xJECIOwo2ZRFCQHZYAEmYxr0xhqZpk1S4T0wmFDpxPMJr8h
	 ++OTWTmV1vEj02KK0Pp1iuHnj+mL9RQaKW4E13l6H5k7KhTS8HuXpDM7kNYPpFsiHw
	 UEK6h1VV9QkgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.81.160] ([94.31.81.160]) by web-mail.web.de
 (3c-app-webde-bap48.server.lan [172.19.172.48]) (via HTTP); Sat, 15 Oct
 2022 17:12:39 +0200
MIME-Version: 1.0
Message-ID: <trinity-1ddd0e69-3785-475f-ac01-ba838dac2762-1665846759728@3c-app-webde-bap48>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Oct 2022 17:12:39 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <90ab83bb-6ac-488-251a-5f5dac2f2b6@inria.fr>
References: <7bda3ec2-1335-4451-dc59-b70faa216750@intel.com>
 <90ab83bb-6ac-488-251a-5f5dac2f2b6@inria.fr>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:smO1sUV/ddUCe8mESYBGLPZtsC1ZrwI7iLFvML9JmTmPZ5ppGyKaMvXcJ97EmjgGhO/be
 pJFkj5i7YxMqGKSVAN1koU2L0LH9Vi7btqpf5WDr2JZ1EpfWeKu05yokpIwXrWXnQR1rFdxTtu8k
 I6IHuMKGwIvN+KYz57ZsOUhqAo0EmCaNb6XX+Yf0vN5C/KB3N3/nS1lYRzkNeTDaHvama+uU2dy/
 mcwgurPBwyHY8cEpqw0TiKgVakChbX1Y/KMcgEdL2EU1kqwz9kEHfQeuddqSycjyb5HiT6yfIOzZ
 uo=
X-UI-Out-Filterresults: notjunk:1;V03:K0:0TbOyarurtQ=:OdNQUbVB9Smk23/bx5tUPi
 FUPHiCfprwJDDVf61crQrq72HQnVEAlOtoUHXaDZ9gjr2WjTeAmu5DV3wJJd49MS3/i0gmWbW
 XIBCW0iP4bbpVAzxaczq+XvbsUlRlGbbihM+/FNSOZVDN6cwasAVGWpsGmyV59+gIyfCADgvC
 QuMgc+xX+xhVtYrCTixtCyh4ba6vJFkDDjUnieoc5QkWMfT99iaYFyg5EheecIiWGugNUQhoC
 bJ5e22ZA5dp1GUPbieBkzWrdijWVy6/E/SKdwS8zFc3I+uwpLmUfx050eJz5NUb9i0rel4GNc
 nDyrfSSrRy1fbUZi/l2blTRMA/eUONa2XQdbvj276UMsw8wD1HKqqE2EEABeyvKIkgo+7Sf99
 mnyISpSe3VfoAG2EhOu+zrxrLKgGPT8JKPBtXltZ7xZW6pbVcYRpA24ynxthmRR4EG84gL1iH
 cy99ZEqEJNFUUjBDPZy2Z+6oFM8NUpDagazYdumJyRJHJ94zTOOcqwYeH53cSxRX/MuB4fUeC
 0gn5Q9bGI7Mt1Ae1cbQ02MWgkYD5ohSbGpAcYRGrCXaDPxBSFK0fW0m3Qg3Bv3sR0tB+K/zeO
 qBLlVy9RHvIzL1kPBOpEGluPI6TwvlEmPK8Tq3kcR6b6L13LPzpLeLwl3lfTIGsysJy0RCfLt
 VtW9xVkdEYnq9udOSSUSJsqncoEzbRyJp1dnj10gnMcW4Q2zHMGZ/bWFTTEA6aWB0HmpuTRDd
 IukFYOw2lyLcx/wQUw9AMa4Lg9/zEjR7zIRUInxVLnG+xrT5xRytuUl/bn/JC8nxy5TuyRRYr
 6/lv5EzmrubkWT/PMLAyUjxxJhZT0QGJNe60GGhN1oQKg/IboKaltBPuSy1AjTsbxwgIA/C8O
 Xv1hwud76qqvMy0FWDhDa8CfzAXwMcKlVEyUcRsdAcaCc/DFwaBhr16v99lcM9r8UpxM4UrCK
 KYCDGVLTuUSYLHyP7qp1cFoeH5YyUot6AZgFYz/c9K8Nj/vKAo4FdSrNUJILXBHSOn/SmzmDz
 eKFJe1HoNIpOdzLKKDCXoyTRH5jd91hoUJiU8l6jb4CJG98CClsRAZIgaByrTZWTfaL8TKmMc
 VDpttCFJzt+qdq02EX5gxTUxLdG1xvR0TwcEcc6qXv/cEEsJiVOv5NgaG8VWVeI7A7zve/tDh
 7bw3rl9nVvys5badxZlJoOle/881sCEI89UQtnLb6ZCLwhoYbUersi59ZHHwx1zo+VGlpWjW0
 joP1sVBDWe7kEzb9Cd4X9NI8ww96OxCIYmIP1vPUlZpLajlOS+MrPFdGw7qYAwApel2Skh+l6
 7fEZUs17
Subject: Re: [cocci] How to fix diff generation for adding if statements
 before return statements?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 649
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-1ddd0e69-3785-475f-ac01-ba838dac2762-1665846759728%403c-app-webde-bap48>

> I will try to see why this adds two, though=2E

Would you like to reconsider also the following implementation details
for the generated diff according to the presented transformation test case=
?


> > Following script:
=E2=80=A6
> > @@
> > @@
> > + if (1)
> > + printf("b\n");
> > +
> > return 1;
=E2=80=A6
> > produces:
> > @@ -1,9 +1,15 @@
=E2=80=A6
> > int b()
> > {
> > + if (1)
> > + printf("b\n");
> > +
> > +
> > return 0;
> > }
=E2=80=A6

Open issues:
1=2E Indentation for added if branches
2=2E Number of blank lines=20
3=2E Return values

Regards,
Markus

