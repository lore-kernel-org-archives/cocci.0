Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7293BC433F5
	for <cocci@archiver.kernel.org>; Sun,  3 Apr 2022 00:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0BACoFaBIhhru8D0f7+Bv441Cebw0djlrpG/rxTtbzU=;
  b=o71fcAwUk2mGCcZhafPk1GUoKz7jE0HFy1lVbfyHRxXpPlRiyKce6wR+
   KniwJl4JYdzjLed3igR+cU3/eGK6wyarjnN0lbTE/v6oxDgHGq2OtHSVB
   U6yTrXrUZCBacDwNaqL/NEVBDKAN/2BKfKhSrcoyIdEar1jyXZ1KAXwzC
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29707766"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 02:25:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4771BE0298; Sun,  3 Apr 2022 02:25:52 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EBD54E00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 02:25:46 +0200 (CEST)
IronPort-SDR: MBC5k2uZfcEzCFF91KTl3wJkBLZcm8AhhUPG6tnsoLrWrKyIJ+9MUQ7chfoV0qs2FdD0CtUBVq
 7AWGpIDkiJ3Ic1xqwl6+xjut5Gh34ZpfUM5bsn5kUuyNWJVifIm/7JmcHmkn6//YWUEJGHjOps
 5R6UOQpmP2MyAGmCfEimj/rLjrg3BqB0pCK+8eieoi86qUTklQQVPn+6/cm6e1LRWTku9+RkMb
 zaP0bXyrT0kptM2NEzA0IWM/NfOjX32byXgp8jukdzoZNSQY/x3kFEUCo0skhRCbFcwx2ruMjF
 5+VcwIK6xGI2qlG9xxhv3237
X-IPAS-Result: =?us-ascii?q?A0AgBQDR6Ehi/0Xcza1ahQsHd1YBAQEpBAtEhFSRG55jC?=
 =?us-ascii?q?wEDAQ05CgQBAYISgnUChFoCHQYGNBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBAFWMiwBYwFnAYFOAYF5BgQwDYI1KQGDYwEBAQECASNWEAsYKgICV?=
 =?us-ascii?q?wYTgwQBgnUhD64YeoExgQGDTwEDAoYhBoE8iheENyccQIFNgTyBFYFuPoJjA?=
 =?us-ascii?q?4R5gmUEmwYCF3qjMVSeIINTixWUUwYULpZRkX6WXo0YmXQ1gQo5JYFZHxQaC?=
 =?us-ascii?q?CYKO4JpEzsBAgECAQwBAgIBAgECAQIBCAEBAgGOU4R5g1aFaiEBAQExAgEBA?=
 =?us-ascii?q?TMCBgEKAQEDCQGBVo4vAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:n9rd56jWumD9xdAdoLIxAwrwX161UhYKZh0ujC45NGQN5FlHY01je
 htvWG3SPPzbYGegf9F3PY3noEIAucWAxoJiTANv+Cw8RCNjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq/5WFYAXNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NpluYGqdVsVM6L1teERaRxHNSFefqBj0eqSSZS/mZT7I0zudmuqzupuAUwyMJde/OtraY1M3
 aVHc3ZXNk3F3bjuhuzqIgVvrpxLwM3DN4QUsXBIyTDCEe1gTI/DTqjO6MUe2jos7ixLNayPO
 JJGNmQ0BPjGSxBvZ2sML5whoOSLjCTmUD99k1KRrLVitgA/yyQqjOa2YYWFEjCQfu1emU2Tp
 0rd7mHhC1cbMsaewHyL6BqRavTnmDO9VZ0SGbC8++QshlCProAONPEIfVemu8XltkOxYv9aJ
 3YR5Qwujes/0WX+G7ERQCaEiHKDuxcdXf9ZHOs79ByBx8Lo3uqJOoQXZmUeN4F+5afaURRvh
 wDZxYq4bdB6mOTNESr1y1uCkd+l1cEowYIqYD9CQBQF7tTnrZt1iB/TJjqCLEJXpoGtcd0T6
 2rWxMTbu1n1pZRVv0lc1Qqd6w9AXrCTEmYICvz/BwpILmpRPeZJnbCA51nB9upnJ42EVFSHt
 3Vss5HAsLBfV83SzHXQGbtl8FSVCxCta2S0bblHRMJJythQ0yT+I+i8HhkgTKuWDir0UWS1P
 hSC5lM5CG57MWSqYKJzbpiwDc9vlfGIKDgWfqu8Uza6WbAoLFXvwc2YTRHIhziFfYlFuf9XB
 Kp3hu73VilKUf03lWXuLwrfuJdyrh0DKarobciT53yaPXC2PRZ5kJ8JbwmDaP4X9qSBrFmH+
 tpTLZLamRFeS/HlJCTI8YMeKV0Qa342Gcmu+cBQc+eCJCtgGX0gUqWNmul5JtU5xqkFxP3V+
 nydW1NDzAStj3PwKTKVNiJpZoTpUMsttnk8JyEtYAilgiBxfYa14a4DXJIrZr17pvd7xPt5Q
 qBdKcWNC/hCUBrd/DEZYcWvpYBubk371waPJDa+JjUgf5NtQwHTvNnpYlK3piUJCyO2s+o4o
 qGhj1mHGsBbGl0+VcuPMaCh1VK8u3QZidleZUqQL4kBYljo/ahrNzf10K09LfYMHgqflDGU4
 ACbXEUDru7Xro5ortSQ3fKYr52kGvdVF1ZBGzWJ9q6/MCTX8zbxwYJEV+rULznRWHmtpfend
 aNY0PHxPfkKhhBMvpYlS+Rnyqc35t3Oob5Gz10+QC6RNwnyVuptciucwM1ClqxR3bsH6wG4b
 UK45YUIM7u+Ps64QkUaIxAob7nd2KhMyCXS9/k8PG7z+DRzoOicSUxXMhTQ2jZRKqB5bNEsz
 es74ZNE7hz5hwUqP9uCgzoS8WmQdyRSX6Iiv5AcIYnqlgtykA0ZO8SBU3Ov7cHdcchIP2krP
 iSQ2vjIiYNc8VWeIXA9In7AgLhGjpMUtREXklJbfwaVmsDIj+Mc1QFK9WhlVRxcyxhK3oqf4
 ISw25GZ8UlPw9tpuCSHd2W8XQxeBBCU/kHrjV0EiAU1iqVuunPldAUA1SSlpSj1MF6wuhBf/
 aqE0yDoTjbnccX8xG00VFINRzkPizBu3lWqpS1kdvhp27E+YCH5memjemoFph/qG4U3iVGvS
 SyGOgpvQfWTCBP8aJHXx2VXOXr8hfxEyKF/rSldwZ40
IronPort-HdrOrdr: A9a23:Z+GIf6zIiRo4DFgdpmF6KrPwKL1zdoMgy1knxilNoH1uA7Wlf6
 LHppsmPHDP5gr5NEtApTnEAtjkfZq+z+8S3WByB8bHYOCOggLBR+wP0WKh+UyGJ8SUzJ8+6U
 4PSchD4QLLZ2RSh8yS2njaL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29707763"
X-MGA-submission: =?us-ascii?q?MDGb1DVOruYdyyIaPWe6430Agu5B4En30c0KDN?=
 =?us-ascii?q?XO5InWUmlOfZGLNx4lE1Uha89RRCzsfiGSOlZ2kPuIQGyZ+EMTcTvGUW?=
 =?us-ascii?q?d3vUm1AL70y1ttGhG/3GuoBpsmQ+FCTseK2n0es7Z3im6ezVqwOuacAM?=
 =?us-ascii?q?C8Dr0v2MSKkm7iyujUX0cZmQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 02:25:46 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id C2FC84A;
	Sat,  2 Apr 2022 17:25:43 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id grG4_Cqq0nTn; Sat,  2 Apr 2022 17:25:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 676F439;
	Sat,  2 Apr 2022 17:25:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 676F439
Date: Sat, 2 Apr 2022 17:25:31 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <300be2e3-15c8-712c-8e99-b2d91150d0d9@web.de>
Message-ID: <24fefed0-f544-ee40-f21d-6f50a3f1d76e@ewheeler.net>
References: <feae2a17-e570-e92-656b-3562fdaeb720@ewheeler.net> <300be2e3-15c8-712c-8e99-b2d91150d0d9@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-794514799-1648945539=:23870"
Subject: Re: [cocci] Checking the handling of =?UTF-8?Q?=E2=80=9Cspace-del?=
 =?UTF-8?Q?imited=E2=80=9D?= string literals by SmPL
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 343
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/24fefed0-f544-ee40-f21d-6f50a3f1d76e%40ewheeler.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-794514799-1648945539=:23870
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 2 Apr 2022, Markus Elfring wrote:
> > I've tried to do something like this, but it is invalid SmPL:
> >
> > 	@ p @
> > 	expression list EL;
> > 	constant FOO, C =~ "BUG";
> > 	@@
> > 	-printf(FOO C, EL);
> > 	+BUG(C, EL);
> 
> 
> Thanks for your interest in software adjustments also for this area.
> 
> 
> 
> > Just ideas, I'm open to whatever you think is best for the project.
> 
> 
> How do you think about to influence the evolution any further
> also according to information from discussions around a topic like
> “Adding metavariable types for the handling of string literals?”?
> https://lore.kernel.org/cocci/alpine.DEB.2.22.394.2203271450370.3119@hadrien/
> https://sympa.inria.fr/sympa/arc/cocci/2022-03/msg00140.html

+1 for matching (and inserting/appending to) a series of quoted literals.  
I could have used that a few times recently and I don't know how to use 
cocci+python (yet!).



--
Eric Wheeler


> 
> Regards,
> Markus
> 
> 
--8323328-794514799-1648945539=:23870--
