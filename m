Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE462C433EF
	for <cocci@archiver.kernel.org>; Sun, 20 Mar 2022 22:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Bevgqjg0Qegqz00SDZrn2rvaLPmAGfLR24Nougz5vlY=;
  b=Dhj15tqyhGcwr5TzU3QfHxIOBz/FNA5uPT4actP64h1vghYvdiEISMxm
   ZbF64DxP5qMp4YAP5+3O7VDE8s7oh3qiV98uxGcoyW4RFs1tZWR9uTT8w
   A4w+c8iqgFKzaBsST3FqiOrHQ174CIkf7Hx9CkMcW/fpKOUckdbqwZkMI
   I=;
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
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="27107074"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2022 23:16:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 24235E01B9; Sun, 20 Mar 2022 23:16:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 91830E0069
	for <cocci@sympa.inria.fr>; Sun, 20 Mar 2022 23:16:02 +0100 (CET)
IronPort-SDR: GL2JaJpAuU1Xf5SR8HnlhfJQGBWBys5T0kec8VQJ1Q3AFMO6QZuBZDDuJgeb58cvTAf/+Nl5N3
 FYTC5Nkob1boAq4DkHB4yUtr3mWElwhuXdIMiYKD21GIs2wJ2mKyziTIZFuNxu/WZtgDJEq2dE
 ztk02d12SgyW4P5W5oPRQt+LosgsObYQoqHgnMpYxYhpv+TC8IOop0LJDt/icJd6O4aasDieJm
 LxPP+gyyk0QOYKy8AIwo21SbmEbUNVm9JBcbMmc7zNNq73XkMP4WaPgfF1REDvCSjinDyFIUzj
 n9RnKW93qHVzv4k2uQgzXlZE
X-IPAS-Result: =?us-ascii?q?A0AUBQBmpjdi/0Xcza1agQmEAgeBTQEBASkEC5YzhB+aQ?=
 =?us-ascii?q?AsBAwENQQQBAYUHAoQ0Ah0GBjQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAQBVjIsAWMBZwGBTgGBeQYEPYI1KQGDZAEEATo/EAtGVwaDF4J2Ia0yg?=
 =?us-ascii?q?TOBAYl7gTyOSSccQIFNgRUnDIJ3PooiIgSYJXmBMIE4olCLKZJtg1OfXgYUL?=
 =?us-ascii?q?pZJkXWWW6cCgT85JYFZHxQaCCYKgyVNAQIBAgEMAQICAQIBAgECAQgBAQIBj?=
 =?us-ascii?q?lOOOSEBAQFpAgYLAQEDCZFyAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:NMdHs60xd3GhqVXKSvbD5Rl3kn2cJEfYwER7XKvMYLTBsI5bpzQOn
 TYbCGCEPPaLYDf9eosiOo7n9EkF6MTdzYA3HABo3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jX4
 YuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt91I1
 N9khayKch4sOfD2msksdDQfCy4raMWq+JefSZS+mcmDiUDZc3bhx/h0Skc7IeX0+M4uXjoIr
 6RFbmpXNlbd1opaw5rjIgVors8kJ8LqFIceoW17izzGDfsrRZ3ZBaPH+be02R9q2ZkWQq6BP
 aL1bxJCYDKaPRprA20KM604v9aln2X+diZX/Qf9Sa0fuDSNl10ugNABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb34T6M7XuogsfdnCbxQotUFbui9/csjkf7+4AIIBgGE1akofS0jkOkHdRSN
 yT45xbCs4A/zVChZ+nNZSahpXnZhBwxav19VPU1vVTlJrXv3y6VAW0NTzhkYdMgtdMrSTFC6
 mJlj+8FFhQ07+LIESP1GqO86GLtaXJMfAfucAddFVNdi+QPtr3fmf4mczqOOKulyNDqGTz9x
 z2Q6i4zm93/bPLnNY3grDgrYBr2+vAlqzLZAC2MBgpJCSsgO+aYi3SAswSz0Bq5BN/xo5nol
 CFsdzKixO4PF4qRsyeGXf8AGrqkj97cbmGD3gczTslxqGTwk5JGQWy2yGolTKuOGp1aEQIFn
 WeJ5F05CGF7YxNGkpObk6rqV5pxnPewfTgUfv3LbtdDZpVrdQmMuXk3DXN8LEi2+HXAZZoXY
 M/BGftA+15FUfw/pNd3Ls9DuYIWKtcWnjqCG8qkk0z5jdJzphe9EN84DbdHVchhhIvsnekf2
 4832xKix0oNXevgTDPQ9IJPf1kGIWJiVcLyqtdLbaiOPQprFWUsEbnXzK94I95pmKFcl+Hp+
 HChWxYClAGl3SCedVyHOiJ5dbfifZdjtnZlbyYiClafxCRxa4iY6qpCJYA8eqMq9bE9wKcsH
 eUFYciJHt9GVi/Dp2YGdZD4oYE7LEariAuCMjCLej86e5I8FQXF9sW9Llnr9TISFWy6qsszr
 rmtzEXdTIZaH1ZuC8PfafSOyVKtvCFHxLkoBxaRfoBeIRy+/pJrJir9iu4MD/sNcRiTlCGH0
 wu2AAsDobefqYEC8O7W2fKOobCvHrYsBUFdBWTasOi7bHGI4mq5zIZce++UZjSBBnjs8aCva
 OgJnfHxNPoLwARDv4ZmSus5yLJ46sTvqrJewx4iGnjXNgz5BrRlK3iA/M9OqqwUnOMC41PrA
 x7W94kII6iNNePkDEUVelgvYNOD4u5IyDPc2vI4fRfh7yht8bvaD0gLZ0uQiDZQJadeOZ8+x
 btzo9Yf7gGy1kgwPtCdgnwG/miANCVdAaA38JwFAILmjgcxjFdPfcWEWCPx5ZiObfRKM1Ure
 2XI3/Ca2u0An0eSIWAuEXXt3PZGgcpcsh59zGgdewaDlO3Di6JlxxZW6zk2E1pYl00Vz+JpN
 2F3HERpPqHSrSxwjc1OUm3E99ut3/FFFpgdCmfllVE1i2GtRirAM20wNOKA5gYf/n40kv23O
 l2H4D6NbNooVJiZMugOtYpNr/34Ucc3+xLClc2jEt7DGZQmCdYgbmlCekJQwyYKwqoNaInvo
 ehx4P02ZLL7OCMUrrd9DYSGvVjVpNZoO0QaKcxcEGg18a0wtd18NfVi66x8Ry+VG8H3zA==
IronPort-HdrOrdr: A9a23:ZWlBNq4KnfJoyWa1RwPXwMzXdLJyesId70hD6qkRc20tTiT7//
 rAoB1173HJYVoqOU3I3OrwXZVoIkmsk6Kdg7NhWYtKNTOO0ADEQL2Kr7GSpAEIcBeOlNK1u5
 0BT0GgMrfNJFJx5PyKgzWFLw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="27107072"
X-MGA-submission: =?us-ascii?q?MDFQAfJtYA27lbWgSMoRNpcRhnkAT29TJNnQCD?=
 =?us-ascii?q?yXaaPrx2RsjnO8O5pJANQwwpTegtwdehuHekeYu8sAFkgtHnVqjeT0MY?=
 =?us-ascii?q?h+OIx/k9qCp2aZ1O6Wc3/zB/xLfNagqet/aQyCrV5teFgGgiian/OAjq?=
 =?us-ascii?q?IvB69dzKT1WE7FeAVjkLTKDg=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 23:16:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 405E481;
	Sun, 20 Mar 2022 15:15:59 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uLxkRQq8qUr3; Sun, 20 Mar 2022 15:15:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 5553540;
	Sun, 20 Mar 2022 15:15:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 5553540
Date: Sun, 20 Mar 2022 15:15:56 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203202224290.2917@hadrien>
Message-ID: <e38ea5f9-ccc2-408f-6331-5f4ed643d199@ewheeler.net>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien> <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net> <alpine.DEB.2.22.394.2203200732590.3429@hadrien> <21f037cf-d0b8-8b25-163d-1d46c3a1f1d0@ewheeler.net>
 <alpine.DEB.2.22.394.2203202224290.2917@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 266
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/e38ea5f9-ccc2-408f-6331-5f4ed643d199%40ewheeler.net>

On Sun, 20 Mar 2022, Julia Lawall wrote:

> > hmm... is there a new version or does my OCaml not support the feature?
> >
> > ]# ./spatch.opt 2>&1 | grep jobs
> >   <no output>
> >
> > coccinelle-git]# ./spatch.opt --version
> > spatch version 1.1.1-00106-ge65a6dd compiled with OCaml version 4.05.0
> > Flags passed to the configure script: --prefix=/usr/local/coccinelle-git/
> > OCaml scripting support: yes
> > Python scripting support: yes
> > Syntax of regular expressions: PCRE
> 
> You have to use the --help option to get the complete set of arguments.

]# ./spatch.opt --help 2>&1|grep jobs
  --jobs          the number of processes to be used

There it is!

I find it strange that -h and --help behave differently. IMHO, -j is 
useful enough that you might consider adding it to the default output.


--
Eric Wheeler


> 
> julia
> 
