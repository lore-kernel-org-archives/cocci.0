Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A330C433F5
	for <cocci@archiver.kernel.org>; Fri, 20 May 2022 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:references:in-reply-to:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LWjATMt6Re6wGHyzkgg45Xhfz4tIloDrlHgAFRMN7BE=;
  b=nCYq2o3PjsfxJyj38FRgu4hr8ARTqghR7SsmTPF5Wfcwm/P97pM0zdxE
   i7wT4RDoMHqYTm1Xyg2861vf66DKxmNeJPpCKCd/9JgAkerC8f8jwds6/
   PHE4Lw1YDhRxKm2QaZwH7nKNYpBzX8yzl48H858rjFi8IXJOz+ZtJ637/
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.91,239,1647298800"; 
   d="scan'208";a="37333709"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 May 2022 14:35:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 65E1AE0096; Fri, 20 May 2022 14:35:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 58521E0094
	for <cocci@sympa.inria.fr>; Fri, 20 May 2022 14:35:20 +0200 (CEST)
IronPort-SDR: ZX8RUBy+FnAszy2rVZYvJ7pAl4tvB2UpVGTPpbte9QgTbz8sZsStdukUdBPDSckx0C+M88m64i
 lAh731yLtS1b1hXs683qyBF9uv2KxHgolHnOMw/QpCaGhtbQVP3ndxaeiFMLfVVrYBg0c/8bap
 tad2AK9HmCv6MBdLjjClXZlbkLrpofxF503MN2nhVe1kYG6G+XYDZr+00PL8YiVoh7NWk8fdpK
 +xInBoSmJg4tdZ4GJI4fbL2YxIPnJchQNuLI7s0zH//LDB8TiiYV3dR5vOrnHhkbnAqXZE+SsC
 iQCt2rx3GVxOu+YQaaIQsQRP
X-IPAS-Result: =?us-ascii?q?A0ApAAB6iodifyvQVdFaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIjflUtBE4DhA49iCFfhWeCJQOBE4sNkEQUgWgLAQMBDAE7BQIEAQE9gRGCN?=
 =?us-ascii?q?IEAAoU/Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETA?=
 =?us-ascii?q?QENCwkHCAoHDg4FYAFhAwFEgU+BdAsDMQ2CNSKDbAEBAQIBDAYRBBkBGxgGA?=
 =?us-ascii?q?wELBgMNDwImAgIQEQIRAQUBHBkiglyCYgEDDSQEC5AWjxqBBEGLMn8WBReBA?=
 =?us-ascii?q?YIJBoFAAYMKChkoDWo6gR8CAQYJAQgSbCwBhhaITCccgg2BFTaBBoE3gxWCC?=
 =?us-ascii?q?gGDb4JlBF+MeoYUgVYEDgwPAwMCEBQDDQ8yJAICAQELAgYGBAYDAQEGAwkCB?=
 =?us-ascii?q?AISAgIEBxgKEggUAwIGAiAFAQcFAQQDEgYMEAEBCAYGAQQCCgECAgUFDAMBE?=
 =?us-ascii?q?QEEAgYCBAQEGBQEAgQHBgIJCQcFFgsECgIWARwCAQYMBQMCAgICAgQVBwENB?=
 =?us-ascii?q?QICBAcIAgcGAwIJAgMFBwMDBAcMBgwOAQMBBwEEBQMNBAEBBgILAwUKAgECA?=
 =?us-ascii?q?wwBAQcECAEBAgIKAgEEAgcBAgUDAgMIAwIDAwICAQEEEQIHAwQCAwEGAQEFA?=
 =?us-ascii?q?wIFAQMDAgEDAwMCAQQDBgkKBAgBBAQBAQERAgcHAgYDAwICAgIFAQINAQIBA?=
 =?us-ascii?q?gQDCAYCAxUBAgQBCgEFAgMKAgcDAQECBwUKAgcFAgcCAgMCAQUDDQEDBQIDA?=
 =?us-ascii?q?QEDAwIEAQIBAwMJAQMCAwMCAgICBQIDAgICCQMGAQcDAgEBBAUBBAMBAgoEB?=
 =?us-ascii?q?AMEAgQCBwIHAgQHAgEEBgMHBgQCAQcBAQQKBAMDAwEBBwECBQICAwIGEgYHA?=
 =?us-ascii?q?gQBAwQECgICDAIHAQECAQEBAQIDAgcFDgEBAQMCAwYCBQICAQEDCAgDAgEEA?=
 =?us-ascii?q?QUDAQQFAwcCAQUJAgkDAwkDAQEFAQMBCQMDAwIJAwECAgILBAMIAwMCAwQCA?=
 =?us-ascii?q?gICAQMCBwUIBAEECgICAgECAgYCAQMaAQIDBQICCQwBBAICAwEDAQECCAQJB?=
 =?us-ascii?q?AIDBAIBAQMCAQICAQUCAw0GAQEBAQIDAwECAwEBBgcCCAIzFQEDAwIBAgICA?=
 =?us-ascii?q?gUCAgECAwICDQEBAQQCAQIBAgYBAwECAgMBAwECAgYCDAMIAgEHAQUDAwICA?=
 =?us-ascii?q?wEBBRAFAgEEAgECCQUCAQEBBAEDBAQIAgIBAwMCDgIEAQQBAgEBIwMEAgMBA?=
 =?us-ascii?q?xcBAgECAwMDBAYHBgIBAhMBAgEBAQUBAgEBBAIEBAcKAwICAgYDAwUBAQIDA?=
 =?us-ascii?q?gEBAQcMAgICEwIECgkDAQYBCgYGFQMBAQQCAgECAgIKAwECAgEDAgkCAQIBB?=
 =?us-ascii?q?SQDAQEPJAEBAgIBAgIDBAcCAQQHAw0CAgEBAQUGDQMCAwgMAgwDAgIDBQMCA?=
 =?us-ascii?q?gQBAgQMCgECAgECAgQFBQMDAQgHBQ0FDQsBAgIBAwgBBAMRAgYDBQUDAwIBC?=
 =?us-ascii?q?QEFBicBBhhPlHILgUwtBgEtYQETCBAgD1F9IpJsN41ei1yTfWtfghFnixuOd?=
 =?us-ascii?q?YYullCSCZZnjSuDWpEAhH8CCgcGECMSgSyCFU0jFTsxgjcTOwECAQEBDQECA?=
 =?us-ascii?q?QEDAQIBAgkBAQKOHQwWg1CFFIVMPzQCAQEBNgIGAQoBAQMJgjqDCiYTCwGKQ?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:fdLkA615FhgB26lZ2fbD5fp3kn2cJEfYwER7XKvMYLTBsI5bpzYCm
 DQdDD3XP6yDN2byLdklPIq+o0wP7Z7cnNNjTlRt3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywobVvqYy2YLjW17X4
 YuryyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt8tR5
 u9vlsepcCowYKaTv/UZDBJcDC4raMWq+JefSZS+mcmazkmDfne1hvsyVwc5OooX/usxCmZLn
 RAaAGpVP1bT2qTsmOL9FrIEascLdKEHOKsWpHh6xDvxAvMvQJSFSKLPjTNd9G5s2J0eQ6iPD
 yYfQWtIMU6aOSdvA0swObZgk9uw3lPfVjIN/Tp5ooJuuzSJpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zDOE9jehiraKk3+gHo0VE7K8+7hhh1j7KnEv5AM+TnuVm9ua0VeHdssBI
 BMz6y5xpqwt+xn+JjXiZCGQrHmBtx8aftNfFewm9Q2AopY4BS7JVwDoqRYROLQbWN8KqS8Cj
 QDWwou4bdB7mPjEFiLHr+b8QSaaYHBNdQc/iTk4oRzpCuQPTak2hxPLC9tvSeu70oazFjb3z
 DSH6iM5gt3/bPLnNY3rozgrYBr2/vAlqzLZAC2JBwpJCSsnPeaYi3SAswSz0Bq5BN/xoqO9l
 HYFgdOCy+sFEIuAkieAKM1UQuzzt6fVbmeC0Q40d3XEy9hL0y7yFWy3yGEuTHqFzu5ZEdMUS
 BSO5V4Bu8M70IWCNPcoM9PZ5zsWIVjITIy5DJg4n/JBZZ9+cALvwc2dTR/44owZq2B1yftXE
 c7DL66EVC9GYYw6kmfeb7pCidcDm3FmrUuOFMuT50n2gdK2OiTJIZ9bawDmRr5ivMu5TPD9q
 Yk32z2ikEUBDoUTo0D/reYuELz9BSNgVcym9ZYGKbLrz8gPMDhJNsI9CIgJI+RN95m5XM+Rl
 p1kckMHmlf5m1PdLgCGNiJqZL/1DMRwqHs6OWonOlPxgyovZoOm7aE+cZorfOl/pLYzk6IsF
 /RVKd+dBvlvSyjc/2tPYJT4qrtkfkv5iA+LOR2jfzViLYVrQBbE+4O/cwa2rHsOAyO7uNEQu
 bql0g+HE5MPSx4zXsnTYfOriVi2uCFFyu51WkLJJPhVeVntoNA6cXyv0qdvLphVexvZxzac2
 wKHOjsipLHA890v7d3EpaGYtIP2QeZzG0xtGWOEv7u7MC/t+HX6nd1NXeOOSjDqVG3u/ZKka
 +gIner3N+cKnQoTvodxT+RrwKY564e9rrNW1F4/TnDCblDuB785Z3faho9AsapCwrIfsgyzA
 xrd9t5fMLSPGcXkDF9Be1Z/P7rbjakZymvI8PA4AETm/ysrrrCJZkNfYkuXgytHIbopbY4on
 bU7tMgN51DtgxYmKIzd3CVd9mDJI3BZFqt77dcVB4jkjgdtwVZHOMSOBijz6ZCJStNNLkh6f
 WPO1fSa3+xRlhjYbn4+NXnRxu4B154AjxZHkQ0ZLFOTl9uZ2/I60XW9K9jsoti5E/mG7w5yB
 oSvH0h8JKHL8jsxwcYfBCajHAZOABDf8Uv0o7fMeKs1UGHwPlEh7kVkUQpOwKzd221Zdzlfu
 rqfzQ4JlB70Kdrp0HJatVFN8pTeoB8YyuEGsM+iFsWBWZI9ZFIJR0NoiXUg83PaPC/6uKELS
 SSGMgq9hW0X+BP8e5EGNrQ=
IronPort-HdrOrdr: A9a23:PyJ0cq3u4h5hFkSWfvCFkQqjBJ8kLtp133Aq2lEZdPUMSL39qy
 ncpoV96faSskdqZJhAo6H6BEDuexPhHPJOjLX5eI3SOTUO21HYUb2Kj7GSoAEIcheWnoU26U
 4jSdkdNDSaNzdHZLPBgTVQZOxP/DDoysyVbKzlvhFQpElRGthdBilCe36mLnE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,239,1647298800"; 
   d="scan'208";a="14658669"
X-MGA-submission: =?us-ascii?q?MDGt8d8zVvbBjjuawohL6buLpYs5s24pWFInUl?=
 =?us-ascii?q?dHO3RwlhOQ8dMRSYqvwjZCIoSgtc0/Xt42j60BnuSae5g/qqbg4dNVA9?=
 =?us-ascii?q?jy4Ioi+KTbxmrzVEGvI8KlgQ9ti91ESZ2DaWUm2Um+17Fp3rDk3t3AQd?=
 =?us-ascii?q?IuOovxFUWq/r004oz9RpPmzg=3D=3D?=
Received: from mail-ed1-f43.google.com ([209.85.208.43])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 14:35:19 +0200
Received: by mail-ed1-f43.google.com with SMTP id i40so10612163eda.7
        for <cocci@inria.fr>; Fri, 20 May 2022 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:references:user-agent:in-reply-to:message-id
         :mime-version:content-transfer-encoding;
        bh=LWjATMt6Re6wGHyzkgg45Xhfz4tIloDrlHgAFRMN7BE=;
        b=J2znRD8taAtZiP8ikd/luC9QjJKthAG/BVob8s37AIa9oLkFVvt2CXpd0J5kLwW0uO
         g3LesXrLh0m1tNTmObhImyW3HStI3gVqlWPYzSMzOs7un10bOjEkxnEdrw96TJ1DprxB
         24XjT6ycPkEbZRo5e7EtQ5s+4uESBjV4PRW/ScsVzJfeetvVvzfp+hIzGaaV7IvpLzkp
         lqg1LpAPMRPzxYwcSK+hej6OWrRAxGOSuwtOWXk5g1ypqfauciuW43bKfy2ecpqLYAxP
         z5y3cc18q9Kk7QhecTDVyjUCdMb4R1IXIkr36+WJUdWFI3H1ohc/c0Q/R4iZ0RaU/muu
         olPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LWjATMt6Re6wGHyzkgg45Xhfz4tIloDrlHgAFRMN7BE=;
        b=BDWi7tUNEoPsFWMRSFQorCBkF70mzDmfPnexXyx/zfs/n72GHROU/BieLK77G8pN+y
         fPRxJQEk87CzGhKCc05llJnzN/LlBOQEOjuk2CnrVJMmImQcZF7Yq6kLhp3QEMqoD2eT
         +PLYXP9lsyjy8NlhQOTKy2v+k2anrWzYERP+w5PqYAFhsXtXHgX3fR7D3YNjWOrTLw+n
         LJ83Wvcz94jbuyoRT4JW7Jt2ayo6PwJWkxH/TjuovydHvJIK64hZKic4voNrVu57hJSb
         bS3nxfld8yQSUZoMp5MW6E5CVTYPF9nD/gpyBO1cLcM/cRji8090nVpSpzLC3uzXFoCP
         PEXg==
X-Gm-Message-State: AOAM530pgCvCeL0KN4/gxfmI99MIUcyROJRy5hWN38Mu0StQy0yWp4tL
	WfQBytxOxKf1H+em1rzawn6UyRdL+8YidQ==
X-Google-Smtp-Source: ABdhPJyoaswgbNSTVPy139Prw1XwT0kVMVD9l/2J503i6tEWojL5TxsLx3FVcAzPOmvmuIrBY1fAEw==
X-Received: by 2002:a05:6402:2750:b0:42b:2616:7cdb with SMTP id z16-20020a056402275000b0042b26167cdbmr3972747edd.306.1653050118346;
        Fri, 20 May 2022 05:35:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a12-20020aa7c80c000000b0042617ba637esm4275142edt.8.2022.05.20.05.35.17
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:35:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
	(envelope-from <avarab@gmail.com>)
	id 1ns1qf-002XYL-6F
	for cocci@inria.fr;
	Fri, 20 May 2022 14:35:17 +0200
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: cocci@inria.fr
Date: Fri, 20 May 2022 14:16:59 +0200
References: <patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com>
Message-ID: <220520.86tu9k1iwq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [cocci] Matching VAR followed by foo(VAR) with no other use of VAR
 in the function
Reply-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 403
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/220520.86tu9k1iwq.gmgdl%40evledraar.gmail.com>


I came up with the below patch today to find code in git where we e.g.:

    struct strbuf sb =3D STRBUF_INIT;
    /* code here that doesn't use "sb" at all */
    strbuf_release(&sb);

I.e. "unused" code that the compiler wouldn't spot. The rule quoted
below works, briefly:

    - T I =3D INIT;
      <+... when !=3D \( I \| &I \)
    - \( REL1 \| REL2 \)(&I, ...);
      ...+>

But I noticed that it didn't spot some other cases, so I tried this:
=09
	diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.c=
occi
	index 52c23e15310..25c322fa1ff 100644
	--- a/contrib/coccinelle/unused.cocci
	+++ b/contrib/coccinelle/unused.cocci
	@@ -10,6 +10,5 @@ identifier REL2 =3D~ "^(release|clear|free)_[a-z_]*$";
	 @@
=09=20
	 - T I =3D INIT;
	-  <+... when !=3D \( I \| &I \)
	+  ... when !=3D \( I \| &I \)
	 - \( REL1 \| REL2 \)(&I, ...);
	-  ...+>

Which helpfully catches other cases, e.g. now we spot this, which looks
like an artifact of me using <+... (one or more lines?):
=09
	diff --git a/graph.c b/graph.c
	index 568b6e7cd41..ba57f56fcb1 100644
	--- a/graph.c
	+++ b/graph.c
	@@ -350,8 +350,6 @@ struct git_graph *graph_init(struct rev_info *opt)
	                        graph_set_column_colors(column_colors_ansi,
	                                                column_colors_ansi_max);
	                } else {
	-                       static struct strvec custom_colors =3D STRVEC_INIT;
	-                       strvec_clear(&custom_colors);
	                        parse_graph_colors_config(&custom_colors, string);
	                        free(string);
	                        /* graph_set_column_colors takes a max-index, not =
a count */

But that modification also produces some broken patches, e.g.:
=09
	diff --git a/builtin/rm.c b/builtin/rm.c
	index 84a935a16e8..7e2b4355713 100644
	--- a/builtin/rm.c
	+++ b/builtin/rm.c
	@@ -395,13 +395,12 @@ int cmd_rm(int argc, const char **argv, const char *=
prefix)
	         * any file at all, we'll go ahead and commit to it all:
	         * by then we've already committed ourselves and can't fail
	         * in the middle)
	         */
	        if (!index_only) {
	                int removed =3D 0, gitmodules_modified =3D 0;
	-               struct strbuf buf =3D STRBUF_INIT;
	                int flag =3D force ? REMOVE_DIR_PURGE_ORIGINAL_CWD : 0;
	                for (i =3D 0; i < list.nr; i++) {
	                        const char *path =3D list.entry[i].name;
	                        if (list.entry[i].is_submodule) {
	                                strbuf_reset(&buf);
	                                strbuf_addstr(&buf, path);
	@@ -417,13 +416,12 @@ int cmd_rm(int argc, const char **argv, const char *=
prefix)
	                                removed =3D 1;
	                                continue;
	                        }
	                        if (!removed)
	                                die_errno("git rm: '%s'", path);
	                }
	-               strbuf_release(&buf);
	                if (gitmodules_modified)
	                        stage_updated_gitmodules(&the_index);
	        }
=09=20
	        if (write_locked_index(&the_index, &lock_file,
	                               COMMIT_LOCK | SKIP_IF_UNCHANGED))

I.e. here &buf is used between the two lines, so this wouldn't compile.

I suspect this is all because that "WHEN !=3D &I" isn't doing what I
expect it to do, but I can't find what I'm missing.

I also tried to come up with a rule for matching a similar pattern where
code like this does nothing useful:
=09
	static void foo(void)
	{
	        struct strbuf sb;
	        strbuf_init(&sb, 0);
	        // fprintf(stderr, "%s", sb.buf); // not if this is here=20
	        strbuf_release(&sb);
	        // strbuf_reset(&sb); // nor this=20
	}

And came up with:
=09
	@@
	identifier I;
	@@
=09
	- struct strbuf I;
	  ... when !=3D \( I \| &I \)
	- strbuf_init(&I, ...);
	  ... when !=3D \( I \| &I \)
	- strbuf_release(&I);
	  ... when !=3D \( I \| &I \)

Which seems to do the right thing, but given how the rm.c case behaved
above I don't understand why it won't fire if I uncomment that code
(which is good!) but the strbuf_reset(&buf) case above isn't caught.

Full diff quoted below, and also at
https://lore.kernel.org/git/patch-1.1-7d90f26b73f-20220520T115426Z-avarab@g=
mail.com/

On Fri, May 20 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Add a coccinelle rule to remove variable initialization followed by
> calling a "release" function. This rule automatically finds the sort
> of issue patched in[1], and more.
>
> We happened to only have occurrences of strbuf_release() matching this
> rule, but manual testing reveals that it'll find e.g. the same pattern
> if "string_list_clear()" were used instead.
>
> 1. https://lore.kernel.org/git/042d624b8159364229e95d35e9309f12b67f8173.1=
652977582.git.gitgitgadget@gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> This overlaps but cleanly merges with the small series that [1] is in,
> but just adding a coccinelle rule to catch this seemed like a good
> thing to have. We even have another such case in builtin/merge.c, near
> the change made in [1]!
>
> FWIW I wrote this working rule too, but there were no in-tree hits for
> it, so I didn't include it:
>
> 	// Unused declaration + malloc + free()
> 	@@
> 	identifier I;
> 	type T;
> 	// malloc(), xmalloc(), calloc() etc.
> 	identifier MALLOC =3D~ "^x?[mc]alloc$";
> 	@@
>
> 	(
> 	- T *I;
> 	  ... when !=3D I
> 	- I =3D MALLOC(...);
> 	|
> 	- T *I =3D MALLOC(...);
> 	)
> 	  ... when !=3D I
> 	- free(I);
>
>  builtin/fetch.c                 |  3 +--
>  builtin/merge.c                 |  4 ----
>  builtin/repack.c                |  2 --
>  contrib/coccinelle/unused.cocci | 15 +++++++++++++++
>  diff.c                          |  2 --
>  5 files changed, 16 insertions(+), 10 deletions(-)
>  create mode 100644 contrib/coccinelle/unused.cocci
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index e3791f09ed5..600c28fdb75 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1113,7 +1113,7 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
>  			      struct fetch_head *fetch_head, struct worktree **worktrees)
>  {
>  	int url_len, i, rc =3D 0;
> -	struct strbuf note =3D STRBUF_INIT, err =3D STRBUF_INIT;
> +	struct strbuf note =3D STRBUF_INIT;
>  	const char *what, *kind;
>  	struct ref *rm;
>  	char *url;
> @@ -1281,7 +1281,6 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
>=20=20
>   abort:
>  	strbuf_release(&note);
> -	strbuf_release(&err);
>  	free(url);
>  	return rc;
>  }
> diff --git a/builtin/merge.c b/builtin/merge.c
> index f178f5a3ee1..bb6b0580659 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -375,7 +375,6 @@ static void reset_hard(const struct object_id *oid, i=
nt verbose)
>  static void restore_state(const struct object_id *head,
>  			  const struct object_id *stash)
>  {
> -	struct strbuf sb =3D STRBUF_INIT;
>  	const char *args[] =3D { "stash", "apply", NULL, NULL };
>=20=20
>  	if (is_null_oid(stash))
> @@ -391,7 +390,6 @@ static void restore_state(const struct object_id *hea=
d,
>  	 */
>  	run_command_v_opt(args, RUN_GIT_CMD);
>=20=20
> -	strbuf_release(&sb);
>  	refresh_cache(REFRESH_QUIET);
>  }
>=20=20
> @@ -501,7 +499,6 @@ static void merge_name(const char *remote, struct str=
buf *msg)
>  {
>  	struct commit *remote_head;
>  	struct object_id branch_head;
> -	struct strbuf buf =3D STRBUF_INIT;
>  	struct strbuf bname =3D STRBUF_INIT;
>  	struct merge_remote_desc *desc;
>  	const char *ptr;
> @@ -589,7 +586,6 @@ static void merge_name(const char *remote, struct str=
buf *msg)
>  		oid_to_hex(&remote_head->object.oid), remote);
>  cleanup:
>  	free(found_ref);
> -	strbuf_release(&buf);
>  	strbuf_release(&bname);
>  }
>=20=20
> diff --git a/builtin/repack.c b/builtin/repack.c
> index d1a563d5b65..52f8450f1be 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -609,7 +609,6 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>  	struct child_process cmd =3D CHILD_PROCESS_INIT;
>  	struct string_list_item *item;
>  	struct string_list names =3D STRING_LIST_INIT_DUP;
> -	struct string_list rollback =3D STRING_LIST_INIT_NODUP;
>  	struct string_list existing_nonkept_packs =3D STRING_LIST_INIT_DUP;
>  	struct string_list existing_kept_packs =3D STRING_LIST_INIT_DUP;
>  	struct pack_geometry *geometry =3D NULL;
> @@ -955,7 +954,6 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>  	}
>=20=20
>  	string_list_clear(&names, 0);
> -	string_list_clear(&rollback, 0);
>  	string_list_clear(&existing_nonkept_packs, 0);
>  	string_list_clear(&existing_kept_packs, 0);
>  	clear_pack_geometry(geometry);
> diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.=
cocci
> new file mode 100644
> index 00000000000..52c23e15310
> --- /dev/null
> +++ b/contrib/coccinelle/unused.cocci
> @@ -0,0 +1,15 @@
> +// Unused init assignment + release()
> +@@
> +identifier I;
> +type T;
> +constant INIT =3D~ "_INIT";
> +// stbuf_release(), string_list_clear() etc.
> +identifier REL1 =3D~ "^[a-z_]*_(release|clear|free)$";
> +// release_patch(), clear_pathspec() etc.
> +identifier REL2 =3D~ "^(release|clear|free)_[a-z_]*$";
> +@@
> +
> +- T I =3D INIT;
> +  <+... when !=3D \( I \| &I \)
> +- \( REL1 \| REL2 \)(&I, ...);
> +  ...+>
> diff --git a/diff.c b/diff.c
> index ef7159968b6..57997937071 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1289,7 +1289,6 @@ static void emit_diff_symbol_from_struct(struct dif=
f_options *o,
>  {
>  	static const char *nneof =3D " No newline at end of file\n";
>  	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
> -	struct strbuf sb =3D STRBUF_INIT;
>=20=20
>  	enum diff_symbol s =3D eds->s;
>  	const char *line =3D eds->line;
> @@ -1521,7 +1520,6 @@ static void emit_diff_symbol_from_struct(struct dif=
f_options *o,
>  	default:
>  		BUG("unknown diff symbol");
>  	}
> -	strbuf_release(&sb);
>  }
>=20=20
>  static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,

