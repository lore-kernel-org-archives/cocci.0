Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0774C433F5
	for <cocci@archiver.kernel.org>; Sat,  2 Apr 2022 08:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=76Fz6/iK3uUdw96ptGh8IPBNQsJ+qk3r+wA5ZnlIn6E=;
  b=lw/AiNDL7LI+zrkWImLC7/ZL7FksPsAP4R4QTwDrFN72h68qxlmjtKrc
   MV+JnAARVkDfG7k6iNLnjOQhcaKmGag/98QMLf/1VjsqjfBly5k+zScFg
   uwBzrUmaTOj+t1Lr4CMxgbn67hH3Y7GNNraIa8ShB20j4QDSmxZD1EzrD
   k=;
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
X-IronPort-AV: E=Sophos;i="5.90,229,1643670000"; 
   d="scan'208";a="29666469"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2022 10:42:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B5556E0298; Sat,  2 Apr 2022 10:42:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BEAE4E00A8
	for <cocci@sympa.inria.fr>; Sat,  2 Apr 2022 10:42:31 +0200 (CEST)
IronPort-SDR: VeNOpX553fgsvpkU4j/2eSNLIttodTDBAq1p6QFD5aHtrstGu6/cwZEnW3BBm2b7HuY/F+/7+s
 vfwQLUczUkRwi8AonDLhu1xLaGQfm8KrCcfJ9zgms2FQNGglXSTLpnStYbuoOMokIi/lkAOOJ/
 qQNsqbKVApRNVu0GihJIk3VJw7LvMxCJ7K2JOy9jPXx2sZdYTlbvnmEGPfa1ySXeaWJ8uQcUIJ
 fh2VxR7UiQ2SRzEKqYuawYpXDEooU7Wv5WoJLIqpPzfSf0kNJ0DO4HHsZcoq8qn4+mW5I3HihV
 sovsUu6Z7gVYn/UXGqpK6Ibo
X-IPAS-Result: =?us-ascii?q?A0C/AQAoC0hihwQP49RaHQEBAQEJARIBBQUBQIFagih+V?=
 =?us-ascii?q?ysEC0SEVI5zgiiSQIwjCwEDAQ05BwECBAEBPYFVgnUChFoCHQcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2Bl4GZ?=
 =?us-ascii?q?ASBSwSBdAs0DYI1IoNsAQICASMdAQERJgEECwsODAImAgJXBg0GAgEBgwABg?=
 =?us-ascii?q?mQBAw0lC7ABgTGBAYIIAQEGgT8BAwKDAx8sIlKBXAMGgRAsiheENycQgVVEg?=
 =?us-ascii?q?TyDAz6CYwOBX4MagmWbCgIXesFxNAeCEoE6gUIMiUeUUwYULpZFDgaRdpZej?=
 =?us-ascii?q?RiZdDWBQ4F+MxokT4JpEzsBAgECDQECAgMBAgECCQEBAo4dGR6DboELg1aFT?=
 =?us-ascii?q?D80AgEBATMCBgEKAQEDCQGBVoNwAQGKPQEB?=
IronPort-PHdr: A9a23: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
 zbO6MFjqReqn7vXogc=
IronPort-Data: A9a23:QAKW5aAVgG34PxVW/3Xlw5YqxClBgxIJ4kV8jS/XYbTApDMn12YEy
 GNNWTjUMvvea2LxL9ogYYi28hgA68WHz9NrOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YThWlvR0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoz6Rpv19z
 8sVj7qtWFcSAPHouPVCDRYNRkmSPYUekFPGCX24rNDV0EDMNXfhqxlsJBtvZ8tCoLkxWDwIq
 ZT0KxhVBvyHr8e/2rGmUa9Bgso5Lc/kFJwSsDdswFk1CN5/GcueEvWTtbe02h8vnO9xP+iCQ
 vAyShlBNAvdQhlhFl0+XcdWcOCA3ySjLWQB9jp5v5Ef6G/Yxw1Zy6noKNOTe9qQRMwTkFzwm
 47d12H+Hw1cK9GVjzaImp6xugPRtSjjYa8eE6PgzNh3kQ2o+DA3KAxJC1Tu9JFVlXWCc95YL
 kUV/A8noq4z6FGnQ7HBYvGonJKXlkNFAYsBSIXW/CnclvuNu251E0BeFmYpVTAwiCMhbRAHv
 mJlcvvsAiFz9qKYQzSR+994TA9e2wBFcAfuhgddE2PpBuUPRqlt1Hojqf49ScaIYiXdQ22Y/
 txzhHFWa08vpcAKzb6n2lvMniihoJPEJiZsuFmHDj74s1gkPtb7D2BN1bQ9xakQRGp+ZgbQ1
 EXoZ+DFsYji8LnQyH3TG79l8E+Bvarfb2a0baFT82kJrmnxpSf6I+i8ERknah4hM8AYdCXvb
 VObsAw52XOgFCvCUEODWKroU55C5fG4S7zND6mIBvITPMQZXFLZrUlGOB/It0iwwRNEufxua
 f+zL5zwZV5EUv4P5GTtGI8gPUoDnX1WKZX7HsygkHxKENO2OBaodFvyGADVMbBhtfPd/129H
 hQ2H5Li9iizmdbWOkH/mbP/53hTRZTiLZyp+cFRaMCZJQ9qRDMoB/PLn+E+doYjk6kMzrXE+
 XS0W0l5zlvjhCSbeFvQNS05MOviDcRlsHY2HS0wJlL2iXItVoaY6vtNfZUAe7R6pvdoyuR5T
 qVedsjZWqZPRz3L9i4zd574qIA+Jh2niRjQbTWoan4zcsc4FQDO/9bleCrp9TUPV3bm65Fh/
 uf4jg6CGMgNXQVvCsrSecmD9VLpsChPgv92UmvJPsJXJhfm/r9qHCqt3PU5FMcBdEfYzTyA2
 gfKWhoVqLWfo4Ix99WV16mIo53wSrl7GVdGWXbW5/C6OHCCrGakxIZBVseOfCzcDT+lpv/9O
 L8Nl/ysYucamFtqspZnF+g5x6wJ5+zp++1QwDNiESiZdF+sEL5hfiKL0JUdrKFL3bMF6wK6V
 ljWo4tfPqiVftzoGhgdKVN9POiE0PgVnBjU7Og0eRmrunUooeDfCUgCbQORjCF9LaduNN13y
 +kWuPkQt161hC0sP4vUlStT7WmNcicNXqhPWkv222M3ZtfHC22uYKAwzgfz54yTLcpBOA8mL
 1d4QUYEa6t0niL/n7gbTBAhHtaxQbwRtRoMwFJqy5GhhI/envFutPFO2W1fc+mWpymrF8psN
 2ItO0AdyWBiOdt3rJArYl1A0D2tyPFUFoIdBrfJeKDko5GUa1Hw
IronPort-HdrOrdr: A9a23:vQ/8Bq5xPmAPWzbPGgPXwOzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuF+poboeVu68qT9JzjJppWPHtXg5gL1XYFNu4Rf3cdeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,229,1643670000"; 
   d="scan'208";a="10359818"
X-MGA-submission: =?us-ascii?q?MDFOgfHK3a8ll8L6NVRt2LnKmyNIjtmdcgsmOp?=
 =?us-ascii?q?PNPi05S4ok7YVCHRQCtOMWSb8kVsHKtdMwhAm8pP2QO1pf5xhx91zOfO?=
 =?us-ascii?q?u/vrF4SFGAEr4H6jXAtTarsNPGaZ/EbTUfjWhrVY1CT+rtGIWbKJ+heM?=
 =?us-ascii?q?G4KwPEmCulxraGNWkwe8laUA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 10:42:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648888950;
	bh=rDCXjOV7gf94cj2ucBE78BXPWNNEV6Vom/Bb1xaRn+I=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=ic1eaWTnGP83+elv4Mipf1aP9UWRuXQgOmB+1bRpsmu5S2ZZ0eq7pmoj7Yi03CikU
	 pgeDqoPFa/Rb9AiyOssq6tmaygVrVIXGh7yO/5pQ4oKLRu5k7x0ZZsydLKryQPuC0g
	 Vyvf01xNNPT8qskefO2h0TAA6BrF6uJV+CvHEc2o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.177.46]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq1CA-1oNhv53n8M-00nHZJ; Sat, 02
 Apr 2022 10:42:29 +0200
Message-ID: <300be2e3-15c8-712c-8e99-b2d91150d0d9@web.de>
Date: Sat, 2 Apr 2022 10:42:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <feae2a17-e570-e92-656b-3562fdaeb720@ewheeler.net>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <feae2a17-e570-e92-656b-3562fdaeb720@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p8JDw9nYl1po+mDnwDh4XqxU9rA4J0lcy27M/lYHiIYeHJcCG4V
 1sLN1ON4EpakJIVyjZsmVq4NH0CD/W8eGFpkErfomSekXHcKGhkkSu2G07KEOj68QHfWuUO
 le3nejD4wQsUdAjNC0j4HWA5j4ZxvzWLCAoa6sAgp+08MblKbUo1+vmt+0qObEaztqc5SD3
 C3UcQ2lUilqcqYHRbBeVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CL1Hg+0laFI=:u6yZeVhHvqHlUmHLEk13sj
 C3uAVXEDv58cZ4j2JKIMqo4PZN1jbNWnGM0Wacix4qi4W5yTYG75UqbgymTBCKThj/o1x/MgC
 7avszRtTuF+TCFFITZgRZD1UuWIBG8FNQ3/CD/5H2t88dGs0kxPFB8wYcwnCqQoav5FaRUuvw
 uJ6rWMon7zjLeiI5koM4QmI7tcHCR8qndiOR+RvDFvY+NsYPISDmc+bwWtnVPaRQhn9ZRNYeR
 9py89pdNQ3Xn44RAYz86wTQyxiLLr8aMSb+ZP9DVZFx7rZ+69aiyl/9flcPcPUf+B1Ym59s7/
 33F3GC6CODYIhAXbU9ImX9cBpxdbU1XzKI07+vRXa+ukibf0Nwm5JmrDqHCICMWfW9AMYG4RC
 atNUoutUCmJn1TcVBaSfHD1/busNzxGtFylJeL/BX/wA6RmDH/6MHAzzJ/OImXT81CRWwgmP0
 Cy2NoLta3BV9v2BHNhAbf5V9k6QGwDXnGRyq9CcZexlyAgVpMlkp/2Gniy59jH+8pdZU38/Oo
 QVuXvG46UMU3Z8S8LtxQA/ZZ/+5ltcvFl+NU58oz2gr3ylDrle2rE7q+EUbyX5733bzJLZ8Cq
 NL1V4wWVtWF4DP4pM2ZynYeqLl/Jr21+QGcMuVBi5p8AJVyI1Y1xpwZPV8lPeEa28ENtiBuJD
 OifxI9GPzO4LSOJKvKocHQTBf/pfiYjiF2CZahIsAGoOIDauNksGP5xvdEgkLr9uPSADPdVGM
 yCHwMHD98fI/rFcJhFnzTw8kpJ+mc15QWWvFZnQdmlHnWBpgV8F8Zkz5IHtx/QPwbxpFIQ8MA
 CdENomBA+vWWI0JaQeA1tcatg2SCfut9BQOcr/UnVGp5qraeTsV1JYvXKYrn7YGPgDoWi6P2I
 o3ulXrAD42BOuPgvy9UpFXf1npAWJCOC7iuHllrPybpJofAnVjrXbGPOXDG/Kdk2+dM2wB6B4
 LQqmy4AnwjfTVkwXkHOcM4qGN9G//4jtfES9FYfDtL77B2trlgEK7vW2o6a9H1ZPQN6Tcx+04
 F3L6tHxgLyykBDaElOFFf4P6CGvR5aWD17Vqqr0AkJ6gqkt6IhCsVHhafbpg5OEO8ZJgDjXPD
 33q/qbCK2iTJpo=
Subject: Re: [cocci] Checking the handling of =?UTF-8?Q?=E2=80=9Cspace-del?=
 =?UTF-8?Q?imited=E2=80=9D?= string literals by SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 331
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/300be2e3-15c8-712c-8e99-b2d91150d0d9%40web.de>

> I've tried to do something like this, but it is invalid SmPL:
>
> 	@ p @
> 	expression list EL;
> 	constant FOO, C =3D~ "BUG";
> 	@@
> 	-printf(FOO C, EL);
> 	+BUG(C, EL);


Thanks for your interest in software adjustments also for this area.



> Just ideas, I'm open to whatever you think is best for the project.


How do you think about to influence the evolution any further
also according to information from discussions around a topic like
=E2=80=9CAdding metavariable types for the handling of string literals?=E2=
=80=9D?
https://lore.kernel.org/cocci/alpine.DEB.2.22.394.2203271450370.3119@hadri=
en/
https://sympa.inria.fr/sympa/arc/cocci/2022-03/msg00140.html

Regards,
Markus

