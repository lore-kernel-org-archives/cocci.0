Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC57C4345F
	for <cocci@archiver.kernel.org>; Thu,  2 May 2024 08:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DoRdBmofdmwnnzOqip3PjA7CCNodxvdhEcPwdLET/90=;
  b=MTRjyQGSrB6uV2h2s3vuW6kXHPVMuDpP8iSMKDPjkIj0vXgGGoB99Kod
   kxA/Gk69DbMDzPsiweI2DNxQ2hyI1hXKd6eKKdcGNFG1/Nem+xkvZLU8t
   uHwBm1IUmKR0cuTH2JZgfw1cTWXS+y/z8d1Hsb2p60obI39Z+NcAoPiLJ
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164177731"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2024 10:54:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 16400E0133; Thu,  2 May 2024 10:54:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A70E6E013D
	for <cocci@sympa.inria.fr>; Thu,  2 May 2024 10:54:38 +0200 (CEST)
IronPort-SDR: 663354cd_wfRr67rwhth/B5dNC+fyj/PWALzsf2B0gvMnzaHpfpKjgDw
 di9+qps/r+rVmHE96pAweWknedlrFLm+LFwcifw==
X-IPAS-Result: =?us-ascii?q?A0GTAgD9UzNmh3yBCqpaFggBAQsSDECBRAuCRHyBCgQLS?=
 =?us-ascii?q?I1ShkqCIpgyhVuBQD4PAQMBCwEBOQsEAQEDBI0vAh4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBAQEiFwcOECeFcA2CSi6BDmUJO?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBGAINgRQoBgEBOHR9gl4BgmQDEaooAYx1AQEBd?=
 =?us-ascii?q?oE0gQGCDAEBBoJm2xkJgUiILgGJQnonFQaBSUSGT4M+g0iCL4USlFhBjBuBU?=
 =?us-ascii?q?RwDWSECEQFVExcLPgkWAhYDGxQEMA8JCyYDKgY2AhIMBgYGWSAWCQQjAwgEA?=
 =?us-ascii?q?xA0AyBvEQMEGgQLB3WDMQQTR4E4iX2CCYE0giCEIUuEd4F4DmKFbB1AAwttP?=
 =?us-ascii?q?TUUGwYioFGEQQEqITYbYJN6nWOVAwcDhBMFjAmVHgQWM4QFgVaRXQw5kjcuh?=
 =?us-ascii?q?1iQXI10h06TGwIKBxeBZTqBXHAVgyIJRgMZD44gGYNhmUVCNTsCBwsBAQMJi?=
 =?us-ascii?q?SKBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vVALpTw6Ilp6Kyc5VFO9Tg0xg==
IronPort-HdrOrdr: A9a23:NIuRlKotP6uULzmG9LFduQMaV5vILNV00zEX/kB9WHVpm5Oj5q
 KTdaUgpHzJYWgqOE3IwerwSZVoIUm2yXZ0ibNhRItKLzOWyFdATbsSrLcKpgeLJ8SQzJ8h6U
 4NSdkYNDS0NykFsS+Y2nj5Lz9D+qj6zEnAv463oBkNPGQaD52IrT0JdTpzeXcGPDWucKBJbq
 Z0kfA33AZIF05nCPhTAENpYwEgnbH2vaOjRSRDKw8s6QGIgz/twLnmEyKA1hNbfyJTzawk+W
 3llRW8wqm4qfm0xjLVymeWtv1t6Znc4+oGIPbJptkeKz3qhArtTIN9W4eatDRwjPCz5E0smN
 zspQ5lG8ho8Xvecky8vBOo8Qj91zQF7WPk1Daj8DjeiP28YAh/J9tKhIpffBecwVEnpstA3K
 VC2H/cn4ZLDDvb9R6NouTgZlVPrA6ZsHAimekcgzh0So0FcoJcqoQZ4Qd8DIoAJiTn84oqed
 MeSP00pcwmNm9yXUqp51WH8+bcBkjb2S32GXTqj/bllQS+WkoJlXfwivZvw0vov6hNOKWsr9
 60QJiA0os+EvM+XOZHHv4IRcbyImbRQRTKWVjicGjPJeU9IWvEr5Oy2Kk4+O3vWJFg9upspL
 3xFGhDrGY3dgbVBdaQ0IYjyGGcfEyNGQ71wsVSo6N0oKH4WdPQQHO+oFxCqbrUn9wPRsLcQP
 q9I5RQHrvqKnbvA59A20nkV4BVMmR2arxYhj+VYSPGnivnEPyhigXgSoefGJP9VTI/Hm/vCH
 oKWzb+YM1G80CwQ3f9xBzcQWnkdEDz9Y95VPGyxZlc9KEdcolX9gQFg1Ww4c+GbTVEr6wtZU
 N7ZLfqiLmyq2W69XvBq29pJh1eBEBI56iIaQIEmSYad0fvNboTsdSWfm5fmHOBOx9kVsvTVB
 VSolxmkJjHZKB4BRpSQ+5PHljq+Uf7/kj6O6v0spfzkvvYRg==
X-Talos-CUID: 9a23:uCAcHm72iS6rWe4iPNsszFRFC58veGbhnFTxcmOHFHxOVOO7YArF
X-Talos-MUID: =?us-ascii?q?9a23=3AfrAcIAzKicLlAK8lDBCXYBMxuM6aqIqoBVgxrIg?=
 =?us-ascii?q?DgtCrMjxAZyfDlWWaR4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="86200237"
X-MGA-submission: =?us-ascii?q?MDHSoZVsk2Lnl5u4sFUsqJb6EFfsu1gfcmv7Xy?=
 =?us-ascii?q?f/3zkCzQtvM6FZZ5y9cjPXxmpSeSuRjvN5dUl7IkE/vXRBjdVEaUXUCd?=
 =?us-ascii?q?b9hDIi24bv1wEY8EZJLbgxObCML2va0Lnuq5Cp+omYYce8sXAt4PyA3p?=
 =?us-ascii?q?SDAdrDshKqXgi4980/0gUH8g=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:54:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714640076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=DoRdBmofdmwnnzOqip3PjA7CCNodxvdhEcPwdLET/90=;
	b=FsgHU0Xa7YuUXk+nCqmC1S26zr8TpYBUTIp4te2wGBaLLUIgtpDqIJcZDFddUnZZp21z5V
	q4PYaKf2yOcYqef7rzdVJkhhNkUfxswhoUyBERan0tqdnX9xIXDUQkwuYqh4vUFN/EFURP
	mbOUXG/4f944+7+8Z3q4+c6901SupLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-rmRtKHrkOsaWJyKUv2N7wg-1; Thu, 02 May 2024 04:54:34 -0400
X-MC-Unique: rmRtKHrkOsaWJyKUv2N7wg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C82680B3DD
	for <cocci@inria.fr>; Thu,  2 May 2024 08:54:34 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C702EC680
	for <cocci@inria.fr>; Thu,  2 May 2024 08:54:33 +0000 (UTC)
Date: Thu, 2 May 2024 09:54:33 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: cocci@inria.fr
Message-ID: <20240502085433.GA30267@redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1676
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240502085433.GA30267%40redhat.com>

OCAMLOPT  parsing_cocci/parser_cocci_menhir.ml

This single file takes a very long time to compile, about 34 minutes
on my 2 year old Intel laptop.  It's quite large too ...

139201 ./coccinelle-1.2/parsing_cocci/parser_cocci_menhir.ml

I've observed in the past that the OCaml compiler doesn't handle
single large files well.  It seems to have some O(n^k) behaviour.

Is this a known issue?

Rich.

coccinelle 1.2 from tarball
ocaml-5.1.1-4.fc40.x86_64
ocaml-menhir-20231231-3.fc40.x86_64

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

