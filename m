Return-Path: <SRS0=9MZy=OL=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9BDC433EF
	for <cocci@archiver.kernel.org>; Tue, 21 Sep 2021 04:08:34 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFBC611C7
	for <cocci@archiver.kernel.org>; Tue, 21 Sep 2021 04:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CFBC611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="529484223"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Sep 2021 06:08:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1E650E0019; Tue, 21 Sep 2021 06:08:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EF4B5E0015
	for <cocci@sympa.inria.fr>; Tue, 21 Sep 2021 06:08:26 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=keescook@chromium.org; spf=Pass smtp.mailfrom=keescook@chromium.org; spf=None smtp.helo=postmaster@mail-pl1-f176.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3A+C/q+B9F8S8nQP9uWfm8ngc9DxPPW53KNwIYoqA?=
 =?us-ascii?q?ql6hJOvz6uci4ZAqOvL4w0xfgZsby07p8ke3YsqTtCyQrwK2qlzQ8SqFKTAIPk?=
 =?us-ascii?q?s4MngYtU4avAEz/K+P2PWRhRJwRHFBq8GumPkdLBc3we0PdomGo7T4VBx7zKRd?=
 =?us-ascii?q?5Kv76F4LMk8i7zeS/94DcbwhIhje2fK9/IgixoQjNrMcdnJFsKrw2yhvHo3tIf?=
 =?us-ascii?q?/pZyGZ1Ll+NnBjy+9m98od7/ytfp/wu+chAUb7nf6sjVrxXEC4mM2Eu68L1sxT?=
 =?us-ascii?q?IUBaC6WEdUmUSlRpIHhTF4RTnVZr/rif2quxw0zSBMMboUb47Ryit76ZzSB/pl?=
 =?us-ascii?q?igHMSI58HrKgcB0la5XvQ6tqwB6z4PSfYqbNudxfrnFcN0URWRPQNtfWS9PAoy?=
 =?us-ascii?q?zc4QAEugOMP1Er4XhvVYCsQeyCRWyCO7p1zRGhmX23ao/0+k5FA/JwhIvH8kTu?=
 =?us-ascii?q?3nKq9X1M6QSWv2ywanL0zrMcehW1iv66IjPcRAsuu2DXbJqccrWzEkvFh7FjlC?=
 =?us-ascii?q?KpYziJTOV2f0Avm6G5OVvSeyhkXQoqx1tojex3McsjJHEiIIVxF3A9yh0z5o4K?=
 =?us-ascii?q?cO2RUN6fNOpHpVdui6aOYZoXM4vXmNltSg7x7AYp5O2ciYHxIkoyhPBZfGLb4e?=
 =?us-ascii?q?F7BLnWeuXPDx2h2pldaqhixqu9UWs0O7xW8mu3FpUsyZIncPAum0P2hHS8sSLV?=
 =?us-ascii?q?/9w80S71TqS2A3e6vtILEE7mKbBNpIsw7A9m5wOukrZBCD2gl/5jKqOe0Uk5Oe?=
 =?us-ascii?q?o7+Pnb63jppCGNo90jhjyMrwqmsCiGOg4PBUCUmqa9Oim273j+kr5QLpOjvIoi?=
 =?us-ascii?q?KXWrJfaJcEDqq64BQ9azJoj5g6hAzu61NkUh3oKIVJfdB6ZkoTkNEvCLO36APq?=
 =?us-ascii?q?+m1islS1kx/HCPr3vGJXNKX3Dna/ifblj9UFc0xY8zddY55JXEbwOPPLzWlX2t?=
 =?us-ascii?q?NzdDx85Lgm0z/zgCNVn2YMSQXiPDbOBMKPOrV+I4foiLPWLZIAJpDn9KuMo5+X?=
 =?us-ascii?q?ujH88gV8SZ7Ol3ZoRaHCiH/RpOV+VYXT2goRJLWBfnBc6TeWirFSdWDpXLyKwQ?=
 =?us-ascii?q?qY973c/AZ2vCYPrR4a3gbXH0j3tTbNMYWUTKV2BCj/DcIKHE6MPZS+JKchmkRQ?=
 =?us-ascii?q?PVaKmTo480FeprgCsmOkvFfbd5iBN7cGr79Ny/eCG0EhqrVSc6uyW03uKSmBpm?=
 =?us-ascii?q?yUPXTBkhMiXQGR4w1aHlLB82rlWTIMNofxOVQg+ONjXyOkoU7gatSrKfs2OTVe?=
 =?us-ascii?q?7R5OhGz5jF7oM?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AWOM936lRdp6tJVPbdJJea1my29rpDfIB3DAb?=
 =?us-ascii?q?v31ZSRFFG/FwWfre+Mjz8SWE8gr5OUtQ4uxoXZPrfZqyz+8X3WB8B8bBYOCigh?=
 =?us-ascii?q?rUEGgA1/qb/9SDIVyZygc1784JGMhD4Z/LfCFHZK7BgTVQeOxQp+VvnprY4Ns2?=
 =?us-ascii?q?DE0AceipUcxdBstCZTpz23cZeDV7?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ANAAASaxphf7DWVdFaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUUHAQELAYN4a4xrYIZFgieQZ4sBgXwLAQMBCwEBQQQBAYRhAoJ?=
 =?us-ascii?q?rAh0HAQQwCQ4BAgQVAQEFAQEBAgEDAwQBEwEBDQsQCDgmhWgNgjUpAYNkAQEBA?=
 =?us-ascii?q?xIoBgEBNwEPCxguNAEFARwGNYVXmwiBBD2LMIEzgQGCBwEBBoYogVoJCQEIgSg?=
 =?us-ascii?q?BjHh6JxyBSUSEOj6IEYIuhxeVa4tenRuDMoE3C507EJU5kSy2XYRQAgoHBhAjg?=
 =?us-ascii?q?T2CFDMaCCgIgyRQGQ6OIIkGhWohMjgCBgsBAQMJiXUBAQ?=
X-IPAS-Result: =?us-ascii?q?A0ANAAASaxphf7DWVdFaHAEBAQEBAQcBARIBAQQEAQFAgUU?=
 =?us-ascii?q?HAQELAYN4a4xrYIZFgieQZ4sBgXwLAQMBCwEBQQQBAYRhAoJrAh0HAQQwCQ4BA?=
 =?us-ascii?q?gQVAQEFAQEBAgEDAwQBEwEBDQsQCDgmhWgNgjUpAYNkAQEBAxIoBgEBNwEPCxg?=
 =?us-ascii?q?uNAEFARwGNYVXmwiBBD2LMIEzgQGCBwEBBoYogVoJCQEIgSgBjHh6JxyBSUSEO?=
 =?us-ascii?q?j6IEYIuhxeVa4tenRuDMoE3C507EJU5kSy2XYRQAgoHBhAjgT2CFDMaCCgIgyR?=
 =?us-ascii?q?QGQ6OIIkGhWohMjgCBgsBAQMJiXUBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="393526720"
X-MGA-submission: =?us-ascii?q?MDGRKSk6jNBYdaXBH2oKfK41fzVu5UdVuxpngC?=
 =?us-ascii?q?6WXgKgGY1Ilo13Jy60eUuoxPnL8JTqIM4EBi3rN6UjoKSI54FDEWG5VE?=
 =?us-ascii?q?qywlyHVN5kZNWgzemW3Vu4u9tPIORJFAwXdtquO8RA7di0ORtKy6bRxN?=
 =?us-ascii?q?wdIROVSUOi8NHcQdrhcspy7A=3D=3D?=
Received: from mail-pl1-f176.google.com ([209.85.214.176])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2021 06:08:25 +0200
Received: by mail-pl1-f176.google.com with SMTP id 5so12484965plo.5
        for <cocci@inria.fr>; Mon, 20 Sep 2021 21:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UkUvCILfcVG/jtusP3nEhNht88oEoBUM3EtsnPkuCZQ=;
        b=GdfHW+whLAvX29HQp4I39zUk85wEeB1sOf5Fvyqc+AxLIjk68JcTlaXwZaw7WyoXfb
         mpipdu59g94XdWDet4m/hZsLM57Fm+F2grqJbE/kuyHDexGpkOon3hH5KSeOGYQm2ObF
         BLZgeG2fTlTCg7EaXXwD1Uo7uL6UXwbJ2jRgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UkUvCILfcVG/jtusP3nEhNht88oEoBUM3EtsnPkuCZQ=;
        b=ST1TeiJ/eXfHwwvMFNbk2u4xSuA1zGwhPZaTqwcaL9Nca0lVFjXgv05+O3spgG0lP9
         D8gg/uowa0s4ofiFCuASM7XcfE45jyho40J5cuhD4McOypW5aSWkucSOIU5xFuw39UZE
         SwwWHeWZfO1BEH1xRrmg55s7PMTjIbhMQKuMjUdTwa98xVVt6QsG8Fo+8GdlICChztvm
         16V28Xa6pq53ui/wr6Vc9FwULFZ0oBVrqoR/j3bKrmFTeeolR/tu4WkYeQJvV6nqXLts
         t9wlH5U7yjPGK1JehmzHAhme5YMIct2p9n7uZCEXQujvvZMzXnj76jPeCIOokZMv8bTE
         pxcQ==
X-Gm-Message-State: AOAM532HmKt+cjzYtl07oZt1PsiUjA/LMB2ZehM4wUm6OQpXkIjqX41l
	cgaHEKMh9/Vn94UWhMNI2qC649L5VtxeXQ==
X-Google-Smtp-Source: ABdhPJwCzXaVoEA5WOAy7wvmHHZBL+m8DQt2TR9euuypRaulFIdlqu0D7W7icap91x10ZeaIw9HS4Q==
X-Received: by 2002:a17:902:ec8e:b0:13c:8897:8c33 with SMTP id x14-20020a170902ec8e00b0013c88978c33mr25655440plg.87.1632197303273;
        Mon, 20 Sep 2021 21:08:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f24sm13990424pfk.198.2021.09.20.21.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 21:08:22 -0700 (PDT)
Date: Mon, 20 Sep 2021 21:08:21 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Mansour Moufid <mansourmoufid@gmail.com>, cocci@inria.fr
Subject: Re: matching an arbitrary struct or union (but not scalars)
Message-ID: <202109202107.E21EEF4BFC@keescook>
References: <202109161609.9AB60A934B@keescook>
 <CALogXGUA2-ztW4eDLQ9RNCda8=8k8cSS_A230vMMAG0zCMeEfA@mail.gmail.com>
 <202109180813.D8EC1ECE07@keescook>
 <alpine.DEB.2.22.394.2109182050320.2929@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2109182050320.2929@hadrien>
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 16
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-09/202109202107.E21EEF4BFC%40keescook>

On Sat, Sep 18, 2021 at 08:50:57PM +0200, Julia Lawall wrote:
> > But it emits a bunch of warnings:
> >
> > warning: compound: metavariable os not used in the - or context code
> > warning: compound: metavariable is not used in the - or context code
> > warning: compound: metavariable iu not used in the - or context code
> > warning: compound: metavariable ou not used in the - or context code
> > warning: array_of_compound_type: metavariable u not used in the - or context code
> > warning: array_of_compound_type: metavariable s not used in the - or context code
> >
> > Can these be silenced in some sane way?
> 
> The problem is fixed.

Awesome; thank you! I'll need to start building coccinelle from git now.
:)

-- 
Kees Cook
