Return-Path: <SRS0=+1Gz=OI=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97826C433F5
	for <cocci@archiver.kernel.org>; Sat, 18 Sep 2021 15:40:30 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8696127B
	for <cocci@archiver.kernel.org>; Sat, 18 Sep 2021 15:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF8696127B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="529172151"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Sep 2021 17:40:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 29BADE001B; Sat, 18 Sep 2021 17:40:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1D21EE0015
	for <cocci@sympa.inria.fr>; Sat, 18 Sep 2021 17:40:25 +0200 (CEST)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=keescook@chromium.org; spf=Pass smtp.mailfrom=keescook@chromium.org; spf=None smtp.helo=postmaster@mail-pg1-f179.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AJMtHiRfgmLAwgaz0szt0hdM9lGM+bd7LVj580XL?=
 =?us-ascii?q?Ho4xHfqnrxZn+JkuXvawr0AWRG9SCoK8bw8Pt8InYEVQa5piAtH1QOLdtbDQiz?=
 =?us-ascii?q?fssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB?=
 =?us-ascii?q?1JuPoEYLOksi7ze+/94PPbwlSgDexfLx+IRW0oA7MqsQYnIxuJ7orxBDUuHVIY?=
 =?us-ascii?q?eNWxW1pJVKXgRnx49q78YBg/SpNpf8v7tZMXqrmcas2S7xYFykmPHsu5ML3rxn?=
 =?us-ascii?q?DTBCA6WUaX24LjxdHGQnF7BX9Xpfsriv3s/d21SeGMcHqS70/RC+v5Ll3RhD2l?=
 =?us-ascii?q?CgHNiY58GDJhcx2kKJbuw+qqxhmz4LJfI2ZKP9yc6XAdt0YWGVBRN5cWSJBDI2?=
 =?us-ascii?q?icoUBDOQBMulEoIbgpVQDtge+CRW2Ce/z1jNEmmH60Ksn2OohCwHG2wkgEsoLv?=
 =?us-ascii?q?nvKstr1L7oZXP6yzKnPzjXIcvRb2TTj54fWaRAuvfaMXbVzccfK1UYvFxnFjlK?=
 =?us-ascii?q?VqYzkIjOV0/4Bs2+B7+pvTO+ijXMspA5trDa13MgslpXJiZwPylDC7Sh3wIY7K?=
 =?us-ascii?q?Nm6RUN0fdOoDpVduiCHOoZ4TM4vTGFmtTgkx7Abu5O2cikHxYo5yhPRZfGLboe?=
 =?us-ascii?q?F7wztWeqNLjp2hHZodbSijBix6Uit0vPwWtWw3VpQrSdIksPAum4Q2xHT8MSLV?=
 =?us-ascii?q?/lw80O51TqS0w3e6ftILV07mKfbMZIsw7E9moAOvUnCECL7nlj9grWMeUU+4Oe?=
 =?us-ascii?q?o7vzqYrX4qZ+YMI95kgT+Pb4vmsy7GOg4KgcOU3WC9eSyybHu/0n0TK9Fjv0xl?=
 =?us-ascii?q?anZv5TaKtoBqqGlBA9V154v6xe5Dzi4zNQVhWcLIE5BdR6djIXkO0vCLO7lAfq?=
 =?us-ascii?q?/mVigjTVmyvTeMr3kGJrNL3zDkLn7fbZ67k5R0Akzws5B6JJPFr4BJ/XzWkzqu?=
 =?us-ascii?q?dPEDh85KQu0w+PmCNVg04MSQ2WPArWWMK/Kq1+H+vovI/WQZI8SoDvyN/8l6OL?=
 =?us-ascii?q?ygn84glIdZqmo3Z4PaH+iBPhmIkOZYWDtgtgbC2sKsBA+H6TWjwinWDhIYGuoF?=
 =?us-ascii?q?4c7+z86BMryCI7FXYewmrmGwSm6ErVZY2lHDhaHFnK+JKueXPJZSy+fOYdKlTs?=
 =?us-ascii?q?HHeyiRoI63haptyfxy6BgK+vJ/2sfr521h4s93PHaiRxnrW88NM+ayWzYCjgsx?=
 =?us-ascii?q?gvgqBc93Lp4pE1gzxGEy6cq2pSw9PRW7vJNFx81bNvSlrMrTd/1XQ3Fc5GCT1P?=
 =?us-ascii?q?0Gr1O5Bk6Tsg2xt4TZgB6Adrw1nj+?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATEBwaa9sxPindbnv20luk+D+I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZhyYlC/Bw9vre5MjzuiWE6gr5NEtQ+uxofZPhfZq+z/BICOsqTNOftWDd0Q?=
 =?us-ascii?q?PCRr2Kr7GC/9SKIVyYygcy79YHT0G8MrDNJGk/o8Lz4Az9Nc0hztmB+KXtoevF?=
 =?us-ascii?q?1X9iQUVLRshbnmJE48qgfnGejTMoOaYE?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ANAACYahphf7PXVdFaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUUHAQELAYN4a4xrYIZFgieQZ4sBgXwLAQMBCwEBQQQBAYRhAoJ?=
 =?us-ascii?q?rAh0HAQQwCQ4BAgQVAQEFAQEBAgEDAwQBEwEBDQsQCDgmhWgNgjUpAYNkAQEBA?=
 =?us-ascii?q?xIoBgEBNwEPCxguNAEFARwGNYVXmwiBBD2LMIEzgQGCBwEBBoYogVoJCQEIgSg?=
 =?us-ascii?q?BjHh6JxyBSUSEOj6IEYIuhBE0gRGjCop+kh2DMoE3C507EJU5kSy2JjeEUAIKB?=
 =?us-ascii?q?wYQI4E9ghQzGggoCIMkUBkOjiAMFohkhWohMjgCBgsBAQMJiXUBAQ?=
X-IPAS-Result: =?us-ascii?q?A0ANAACYahphf7PXVdFaHAEBAQEBAQcBARIBAQQEAQFAgUU?=
 =?us-ascii?q?HAQELAYN4a4xrYIZFgieQZ4sBgXwLAQMBCwEBQQQBAYRhAoJrAh0HAQQwCQ4BA?=
 =?us-ascii?q?gQVAQEFAQEBAgEDAwQBEwEBDQsQCDgmhWgNgjUpAYNkAQEBAxIoBgEBNwEPCxg?=
 =?us-ascii?q?uNAEFARwGNYVXmwiBBD2LMIEzgQGCBwEBBoYogVoJCQEIgSgBjHh6JxyBSUSEO?=
 =?us-ascii?q?j6IEYIuhBE0gRGjCop+kh2DMoE3C507EJU5kSy2JjeEUAIKBwYQI4E9ghQzGgg?=
 =?us-ascii?q?oCIMkUBkOjiAMFohkhWohMjgCBgsBAQMJiXUBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="529172150"
X-MGA-submission: =?us-ascii?q?MDH/iUxnkWYhdkayyoZPfwZQBCOvHaCbuuMZdQ?=
 =?us-ascii?q?TWH/8a22Lvyw5JD3NJT4kf7U8YgEqCx5fXgrGRKct7LXwESGNxZD9q8c?=
 =?us-ascii?q?lRjNS0uuvAnHk8s4bDsuTEglnJ66BtLLghqFB1J4pED4GzdG8mtYRRJR?=
 =?us-ascii?q?vt389baSYFsU7V0mJgcxiSkw=3D=3D?=
Received: from mail-pg1-f179.google.com ([209.85.215.179])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2021 17:40:23 +0200
Received: by mail-pg1-f179.google.com with SMTP id f129so12788436pgc.1
        for <cocci@inria.fr>; Sat, 18 Sep 2021 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TA4ajMtDY2zeYm6bDwjNiA1iwBS4EbzsMp4bCdEQclc=;
        b=EklGDXnw36GRjrUKmhgkdR/RefhnGVHO5pVhgh2FD2alliTC4BdC20ZwKFrxVhMAWH
         BzsO3wkPsTZKaEXFmHIEadZJmJxmQUvM27OeOCNGZhSjQ1tIWBgVRoSvIKr5Xvh7ObJb
         375P/snE0JF8nU4NFX8AeQEFEIKAgz8co7a1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TA4ajMtDY2zeYm6bDwjNiA1iwBS4EbzsMp4bCdEQclc=;
        b=nfPGgCffxoeO0oMLJJsSoaZoMHWECw7VKB8uNJAlpbJ/vAroG0v8LRuPsAzeYmq4/8
         Lb09LN7/x87zLZJa6x7xBBU+h5ZQ96Z68MJiri+2t1+lWvcbiOXVMmhvkKykb0mcEIHd
         Vo3T1JP6UV8pqWfZNdYE+FiuV24VMqModSkT5OjOlwqveHFySoGTNLqC4nd9Dd2TOScM
         Vvz6Bz7FxtXOzyi9wknQaI6LdLzCvloqu5rLInxybx3WQOXwV0O9+bm5nNV5UMOlu1BC
         Lp5qdnrtzez8CTIujHbSaIsTdZXeQJ14NhMy9EcvpfBzTBRahso4RoAJQn3IXSiuE328
         qkag==
X-Gm-Message-State: AOAM530KtD/4HSywVTNnFL2wdhGvioFortTf57dWEaN7d15s7fbjeOft
	Ck360Jysv27oc+Vi+qMW8ewYHMOm5HP+wA==
X-Google-Smtp-Source: ABdhPJxLQWXP6FUU6FZWmzLgBxXDm/OxwNgEFtIJztAH5siEHbLzb1xPQNVO4+V2hmiw3cnxUjVhYw==
X-Received: by 2002:a62:1811:0:b0:43e:5d57:b449 with SMTP id 17-20020a621811000000b0043e5d57b449mr16285591pfy.64.1631979621467;
        Sat, 18 Sep 2021 08:40:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z17sm9547015pfj.185.2021.09.18.08.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 08:40:20 -0700 (PDT)
Date: Sat, 18 Sep 2021 08:40:19 -0700
From: Kees Cook <keescook@chromium.org>
To: Mansour Moufid <mansourmoufid@gmail.com>
Cc: cocci@inria.fr
Subject: Re: matching an arbitrary struct or union (but not scalars)
Message-ID: <202109180813.D8EC1ECE07@keescook>
References: <202109161609.9AB60A934B@keescook>
 <CALogXGUA2-ztW4eDLQ9RNCda8=8k8cSS_A230vMMAG0zCMeEfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALogXGUA2-ztW4eDLQ9RNCda8=8k8cSS_A230vMMAG0zCMeEfA@mail.gmail.com>
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 11
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-09/202109180813.D8EC1ECE07%40keescook>

On Fri, Sep 17, 2021 at 03:16:21PM -0400, Mansour Moufid wrote:
> This:
> 
> @@
> type t;
> identifier x;
> @@
> *   t x[...][...];
> 
> will match two or more dimensional arrays, like x[1][2] and x[][2] as
> well as x[1][2][3] and so on.
> 
> So altogether a script could look like this:
> 
> @a@
> identifier s, u;
> type t1 = {struct s, union u};
> type t2 = {struct s, union u};
> identifier x;
> @@
>     t1 {
>         ...
>         t2 x;
>         ...
>     }
> 
> @@
> typedef uuid_t;
> type t = {a.t1, uuid_t};
> identifier x;
> @@
>     t x[...] = {
> -       0
>     };
> 
> @@
> type t;
> identifier x;
> @@
>     t x[...][...] = {
> -       0
>     };
> 
> I assume this is for the Linux kernel? It looks like there are plenty
> of variables of those types but none initialized to {0}. (Although the
> script is not done running through the entire kernel, that takes
> forever.)

Yeah, this is for the kernel. Thanks for helping with this! I was able
to continue the construction and get it working. :)
Here's a test case:


#include <stdio.h>
#include <uuid/uuid.h>

/* Ignore 0-init (no internal compound type) */
struct only_scalars_struct {
	int a;
	short b;
	unsigned long c;
	void *ptr;
};

/* has internal struct */
struct has_struct {
	int a;
	struct only_scalars_struct inner;
	void *ptr;
};

/* has internal array */
struct has_array {
	int a;
	char buf[8];
	void *ptr;
};

/* has internal compound type (uuid_t) */
struct has_uuid {
	int a;
	uuid_t id;
	void *ptr;
};

/* has internal array of struct */
struct has_struct_array {
	int a;
	struct only_scalars_struct many[4];
	void *ptr;
};

/* internally defined struct */
struct has_internal_struct_def {
	int a;
	struct foo {
		int b;
		int c;
	} inside;
	void *ptr;
};

/* Ignore 0-init: no internal compound types */
union only_scalars_union {
	int a;
	short b;
	void *ptr;
};

/* has internal union */
struct has_union {
	union only_scalars_union z;
	void *ptr;
};

/* internally defined union */
union has_internal_union_def {
	union {
		int a;
		long b;
	} z;
	void *ptr;
};

/* has internal compound types */
union of_many {
	struct only_scalars_struct inside;
	struct has_union stuffed;
	union only_scalars_union scalars;
};

/* has internal array */
union of_array {
	char buf[4];
	void *ptr;
};

/* has internal compound type */
union of_uuid {
	void *ptr;
	uuid_t id;
};

int main(void)
{
	struct only_scalars_struct	a = { 0 }; // should be ignored
	struct has_struct		b = { 0 };
	struct has_union		c = { 0 };
	struct has_uuid			d = { 0 };
	struct has_array		e = { 0 };
	struct has_struct_array		f = { 0 };
	struct has_internal_struct_def	g = { 0 };

	union only_scalars_union	h = { 0 }; // should be ignored
	union of_many			i = { 0 };
	union of_array			j = { 0 };
	union of_uuid			k = { 0 };
	union has_internal_union_def	l = { 0 };

	char one[16] = { 0 };	// should be ignored
	char two[16][5] = { 0 };
	uuid_t uuid = { 0 };
	struct only_scalars_struct structs[4] = { 0 };
	union only_scalars_union unions[4] = { 0 };

	puts("hello");

	return 0;
}


And here's the cocci:


@compound@
typedef uuid_t;
identifier os, is, ou, iu;
type outer = {struct os, union ou};
type inner = {struct is, union iu, uuid_t};
type t;
identifier x;
@@

    outer {
        ...
(
        inner x;
|
        inner x[...];
|
        t x[...];
|
	inner {
		...
	} x;
|
	inner {
		...
	} x[...];
)
        ...
    };

@single@
typedef uuid_t;
type t = {compound.outer, uuid_t};
identifier x;
@@

    t x = {
-       0
    };

@array_of_compound_type@
typedef uuid_t;
identifier s, u;
type t = {struct s, union u, uuid_t};
identifier x;
@@
    t x[...] = {
-       0
    };

@multi_dimensional_array_of_anything@
type t;
identifier x;
@@
    t x[...][...] = {
-       0
    };



But it emits a bunch of warnings:

warning: compound: metavariable os not used in the - or context code
warning: compound: metavariable is not used in the - or context code
warning: compound: metavariable iu not used in the - or context code
warning: compound: metavariable ou not used in the - or context code
warning: array_of_compound_type: metavariable u not used in the - or context code
warning: array_of_compound_type: metavariable s not used in the - or context code

Can these be silenced in some sane way?

Thanks!

-Kees

-- 
Kees Cook
