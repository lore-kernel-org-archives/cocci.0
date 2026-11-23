Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE8606A321
	for <cocci@archiver.kernel.org>; Tue, 24 Nov 2026 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=Adnby1Z4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=vRsattF1Rz3wlZk1sO3QBcklCFu7YC5VSfU+TN1COtU=;
  b=Adnby1Z4yCpOEa/YZ7/49GA2bj44LJb0+YnIZboi6mONF5zgrQSM/v64
   wl8zmgG3WdTIGDKmVQpx/6F/ln1R1kLszRuhR1JrdAgkwQ6Mpmf3Uj6KI
   syZQAM3mtY/zx47HnpKUP4WYA0RqLMqXrnxPCTYG7oqxvDyk+UMlTfgqL
   M=;
X-CSE-ConnectionGUID: 1aRkOZoHR4ier2sh41DHUw==
X-CSE-MsgGUID: DXX+6Fs7Tmee9wjfP7+tsw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,230,1787004000"; 
   d="scan'208";a="307039680"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2026 11:09:44 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 802BD82561; Tue, 24 Nov 2026 11:09:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 59B5D8053D
	for <cocci@sympa.inria.fr>; Mon, 23 Nov 2026 17:28:38 +0100 (CET)
X-CSE-ConnectionGUID: osTDiP47QwCTHnE3ohHt0w==
X-CSE-MsgGUID: SrJUL0YxTSSDYaKQXdp6tQ==
IronPort-SDR: 6b0469b4_aDOnrZrPSbYPd0THVkINoXaQM3jmxeZUiqmoeDB3J3VaYIY
 3SnmUm43tzuqE0uuBCAyQUro2HSsat5j8fIs6Tw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GlAgA0aQRrfDVSfUpaglmCQVqBETQEC0mEWI9TgiSeK?=
 =?us-ascii?q?YEkA1UCDwEDAQ1RBAEBAQIEgUuDMwKOIgIeBwEEMgcOAQIEAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NjBoBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARcCR0QBAQEDIx0BATcBDwsLDQICJgICIRIBBQEcB?=
 =?us-ascii?q?hOFJQEGSwOwI4tygQwmgQGCDAEBBt4gCRUBgQkuhgiCWgGBcYQIhAN6JxuCD?=
 =?us-ascii?q?YFKgnc+gmEChTyCaoImgQyQPIgLJgkdAwcHDg0eRg8FHANZLAFVExcLBwWBJ?=
 =?us-ascii?q?UMBAgFnHiNLBS0dgSM7FxEeWBsGBRIgKkBCAVuBEoEDXYErKF0BAh8zEy0Vg?=
 =?us-ascii?q?XYCgTeBGoEjXQIBSUEOBzkMUwklQxJHJCIIEgkBExosCoEaNTwJJj8VDFsMA?=
 =?us-ascii?q?wgRCQUaRwgCCwIMdCgREBMdHiQvBRomPhsKgQwnHx4bDgIfEAYWBGILPTcVG?=
 =?us-ascii?q?UqUZIQydYFAo2yjMoQrhHWDd5kMM6pyLod9kF2jbYVHESSBSwcsgVwzGggbF?=
 =?us-ascii?q?WwGgjBQAxkPkiTOO0YyPQIHAgcOAwuSHIFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wZy1Zq45NsLeARe/cgPXwdOCI+orL9Y04lQ7vn2ZFiYlF/Bwxv
 re/sjziyWE6wr5AEtQ5uyoELKLQHPC+ZMwyZR5B8aLYOCHggbJEGgQ1/qd/9SAIVy3ygc579
 YFT0EQMqyMMbERt6nHCTeDYoodKbW8gdmVbQm39QZFcelFA5sQvTuRIDzrQXGf3GJ9dMwE/K
 P13LsRm9JLEU5nO/hTf0N1C9QrxOe7364OAyR2eyLPszP+0kL31FeSKXHxtX1xMkIpsNEfGA
 7+4lfED4qYwqCGI3TnpjfuBuFt6aHcI6x4dbexY6YuW03RYjjDXvU6Z5Sy+BQO5M2/4lcjl9
 fB5z06Od5o1n/Xdmap5TPwxgjJyl8VmjLf4G7dpUGmjd3yRTo8BcYEr5leaAHl500pu8w5+L
 5X3lieq4FcAXr77WjADpnzJl5Xf3iP0DsfeN0o/jxiuEwlGfxsRLkkjQ1o+VE7bWDHAc4cYa
 xT5YrnlYdrmBuhHgDkl1gq5setUHQ1FhLDb2wrgebQ6DRdmmt1pnFo7/D3801tyHt6cegP28
 30dp9zjblLQ4s/Z798AuBpe7rvNkX9BSnXKWqXLBDeCK0aNzbspvfMkfIIzdDvQ4YQxJ8+3K
 7MS0xVrgcJCgbT4cbl5uwXzjn9BF+lVTDhjvpT/YR9p9THNfzWGBzGT1Zrm9CrovUBDqTgKq
 aO0J46OY6REUL+XYlOxAHwQJ9UND0XV9AUoM8yXxaUrtvMMZCCjJ2TTB//HsubLd8fYBKIPp
 IuZkmGGCwb1DHYZpbRummlZ0/Q
X-Talos-CUID: 9a23:jV5a/G9RlabRMUEseYyVv0kPJuwkSiGC9Wj7H2++JD1uSJ2JEUDFrQ==
X-Talos-MUID: 9a23:Me/aighbdAhyVaepUXwnesMpD91K3oD2OVAxqq4qisCnDBx8I2mBtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,229,1787004000"; 
   d="scan'208";a="163640828"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHPIbQv3zhQFwO6vfKSRFHN4P/b5abhvzRcbF?=
 =?us-ascii?q?bPCLB03bsw3KTHZQWrupt/vHGOtx8s6+LcAxCULW7F5NoHXgx6AvLYk4?=
 =?us-ascii?q?POj21XrQbfKiH0QuIzZcE6/pxg6QNZmQpC6jeDGh3ueRaf4OkHJTbmpI?=
 =?us-ascii?q?u+Be3wiXdssVD6GlVpkmG3HQ=3D=3D?=
Received: from mail-dl1-f53.google.com ([74.125.82.53])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 17:28:36 +0100
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15dd124bbe7so2401113c88.1
        for <cocci@inria.fr>; Mon, 23 Nov 2026 08:28:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795451314; cv=none;
        d=google.com; s=arc-20260327;
        b=L+qCYzJoeGWO7rSAB30HdBWdbhZO+hrNGeVx/++MRIHuKwmpUGwhCyRHQs3AvdPuRa
         ELMBeBfZqwD/wemlZpEuK+UkQqp2Pr0Wvm59eRJCo+SVT2FZY66EJ3y3PS1DX25cvD52
         IfcD8IQZFWHQffXbQd9/LAK0KlS/hlY51+Rh8HvX3LzctlBmFDx6ByX8rFZq/JeF1Miq
         gP6iHF1DuXDGZvcvb9OuLFNkNqJgzN/Z8Wo9tdBbg/H246r+9IKcXnjtF15gZQGOpgQl
         R1fxI6m0MbXyCFuuncUyX4gX1sSy5yaFUWtJSAsExZxRxTwqofIie6akOz2J90OPHyIH
         3C5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vRsattF1Rz3wlZk1sO3QBcklCFu7YC5VSfU+TN1COtU=;
        fh=6ilgXIO39XuCbcUZ+ZYHCDAF6Z6ONf2UhH70gQmeecc=;
        b=Ur8vhwUFkoeB4F/upA4/DXRPgjg3yLNA5zLXyW1wovUm9Q1L/X7/OBAr34xZ6jO34C
         MzGdNWr5LjrU7g4RrXM/UKYijoujfaGGUGHkiCmzRvME4FK81998BfQSq51Q8S7B1e5W
         w4V1MPKRXrGATAHAwqMvJ9k3MgJX6s2nftaV2yzqxapkBj/atNeGdzvudiN64rE4oxHt
         BApLDSaFlJDLOY5Q7fcisIdCV9a8yvOGnTmE5fFDLWwbH9g72r50NJKACEohgtuFgarR
         mC8YUlM7Iso0cijWHpDCMai9OCbwIzP4eJ2A6szgB8hYYje2n6aUjxJDWy782KpLcWQ4
         OHww==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795451314; x=1796056114;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vRsattF1Rz3wlZk1sO3QBcklCFu7YC5VSfU+TN1COtU=;
        b=2PjI4NzEWRpAoEVIG458gpv+ev2zfRpDHQ7drr0AiIMf+2I1OFtHy/xejmxX5Id1Ig
         8CoRS58Kr8VNK/jy+9SFM0O3LrNMhyKPZN6aR/318xdk6qtByeA4q0RB4NX6OXEYs/WD
         9GZWtohr4wXek9KwByg0JbXGZsgedcHxqcYkCZs/MugMaJhFUNs2+guIuIy6DEwo4t3V
         ZUZFj7oOdp6azSM52imiiqqi7sTkvEGUrSb6hmdpSRUzp0VAqXKk8TwQ453RfIckCYmp
         C6GLnr8hsEV5ap4/DNzTQs4XiijzDR+7PuigtjttPO2+BsnhOsIQ8f9W7zHh4Y6bXAxx
         qlKw==
X-Forwarded-Encrypted: i=1; AL+hErGqSvVpF8d6PAZ6R7oPCUf+ezCJPq9X1bE0fAQ1768zwxpJ5bktpVmtymNoYtOnUfrIrXwZSA==@inria.fr
X-Gm-Message-State: APuU4Z9W79VDh6hhI47u98EZJyN737woePJXnXKEr8hfnFYNfaFOgx48
	BORAuQQrxjS07CuT2k26EJ4rJhUDIHbHlu/hRUmvmDnVw1W8gEwog1vItQiZptPfPA3oRicMLnc
	jaMTRybCMig2Wzl9LibkGjitioEz/LI6LKs513Q9o
X-Gm-Gg: AZFdTZcIW3+W5+8eZJvuSzPtFWEngQfn1zV2eNVWPrLmXilI/zHko74HreVYZvB/Bsm
	wpDN4/hiK9agl8biF5xBgmXN4Skp6B8zhVUVBs7wFZBfG/QFddmsM9OOfBTLLq3zY1STIC/1of3
	PLijIwSsie+H94X6avCkI7pm/wOFz3jIgi3vKa2ojxevSnC04SDQ4W1mbbFEaHRf1m4cRhK7/41
	qVhDRVB6Kiz8MMWn2UzeAdINCB0GRsbdZTabwB0+0Qv+TAojA6AX1NUu0jNDGY6GRUwdSWG9Mwg
	025T8kl4EyQ00IHvWVDSzcCjMEZvIqeWi3eK/v6YKtufJQlPcTaobkoc8UBIjHDKdd7vmBFwMM5
	WSj3vekJtDIe783egeYfNAHRVu2GLtwpkfEsnOUr4mwA2ZqqlIQi89oDjeebXfbn68A==
X-Received: by 2002:a05:701b:450f:10b0:1a7:78a3:bda8 with SMTP id
 a92af1059eb24-1b56f87ae87mr4771793c88.27.1795451313861; Mon, 23 Nov 2026
 08:28:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123104616.226112-1-elver@google.com> <4f7c329e-d722-427e-8279-14c55fce7d71@acm.org>
In-Reply-To: <4f7c329e-d722-427e-8279-14c55fce7d71@acm.org>
From: Marco Elver <elver@google.com>
Date: Mon, 23 Nov 2026 17:27:56 +0100
X-Gm-Features: Aa3M54r7226v11V6STsNIBjJkWPCqk7bRTsVzfqJ-i1JkqSXxWMh_d9IQN7SFjk
Message-ID: <CANpmjNP5DqQwUuO5jKOK=KM9njyBNnY5xHbL--QF=r3ZjfRELA@mail.gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, cocci@inria.fr, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3] coccinelle: locks: Add must_hold.cocci
Reply-To: Marco Elver <elver@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 3821
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/TUB9HDJphKL49h5UCQSmdw>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 17:26, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 11/23/26 2:45 AM, Marco Elver wrote:
> > Clang's context analysis treats lockdep_assert_held*() as an assumption
> > that the lock is held. A function that asserts instead of being
> > annotated with __must_hold() therefore passes the analysis, but its
> > callers are never checked.
> >
> > Add a script that reports functions which assert on all paths that a
> > lock is held, where the lock can be named in a function attribute, and
> > which are not annotated with __must_hold*(), __releases*(),
> > __cond_releases*(), __context_unsafe() or __no_context_analysis. A lock
> > can be named if all identifiers in the lock expression are parameters or
> > member names, or if it is a global of the form &name or &name.member.
> > Functions that mention the lock before asserting it, e.g. to acquire it,
> > are skipped.
>
> Bart Van Assche <bvanassche@acm.org>

Thanks!
Ack or Reviewed-by?

Aside, do coccinelle scripts go through a specific tree?
Otherwise, I might just take it through the -kcsan tree.
