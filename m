Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F2ED58D6B
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QOFP6FdjF7HR5DJ0NsQmq4Ef0zujb0dhq0/nwgl+fPQ=;
  b=LMqnaEu4/fHfSQV0N3BWi3nqN6gtf49BGak+yZQbtm6ph8TVlwOpTC7U
   os+ZIY9QnI0VouXO+sQ5NOnDbMSMFfh64XTXAOPBMkPuj/cqjQnZXQXwz
   0mak85l5oEOjJjNmCM4FZBPFXYd6Zqyu0qNR85L+u/WftwJvjj1RjBw+I
   U=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724643"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7F91AE0D8A; Mon, 25 Nov 2024 17:57:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 870C2E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 12:34:18 +0100 (CET)
IronPort-SDR: 674460ba_thQ5KGoRNxaoTlumvKejPDtpmkd0uKQ4dZz0rFDozshYzVM
 mbnXf7ERTkVxTRA7pNHRjOvDRatG5MGYMBWNU+g==
X-IPAS-Result: =?us-ascii?q?A0EVAABxX0RnfnyBCqpaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDggoEC0iEVogdhzCCIQOLc4VXjE2Bfg8BAwELAQFEBAEBAwSFA?=
 =?us-ascii?q?AKKWQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?TsHDhIphXsNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBARcCDX0BAQEBAxIRB?=
 =?us-ascii?q?BkBATcBDwsLCgMCAiYCAiESAQUBHBkIGoUQAzEDoWwBboEFQopDAQEBeH8zg?=
 =?us-ascii?q?QGCDAEBBtsmDWyBZAkUgQYuAYhLAYFsg2QZg316JxuBSUSBSoJ1PoFSTYF7D?=
 =?us-ascii?q?B0VOIMOgmmCRIExg14lhTYBg0mbDSYJHQMHBw4NHkkPBRwDWSERAVUTFwsHB?=
 =?us-ascii?q?YEpISwBAgGCRn+BNiiBKQGDEEqDLoFeBTcKPYJKaU03Ag0CNoIkfYJNhRmBC?=
 =?us-ascii?q?4EVgklMGS8DAwMDghOBK4YGHUADC2ILPTcUG0yhC0aDQQcBgQ0wHS5gcJMXs?=
 =?us-ascii?q?0eEJKFdM6pRiC+QTKNyAYULAgoHBhEjgUQ6gVxwFWwGgjBPAxkPjiGDesdLQ?=
 =?us-ascii?q?jU7AgcBCgEBAwmRBgEnDIFLAQE?=
IronPort-PHdr: A9a23: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
 8ovc0OIEUsoyenIfyk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:8c7fE62rmAYifyf60AITzwqjBA8kLtp133Aq2lEZdPWaSL3mqy
 nIpoVo6faUskdjZJhEo7u90ca7MAjhHPJOkPEs1PKZLXDbUQiTXeZfBOnZskfd8kTFn4Y2up
 uIMZIObuEYZmIK8PoSjjPIb+oI8Z2p9ru3jfzSw3ooYQZhcLF48gt1Yzz7LmRGACdDQbQ2fa
 DshfavZADBRZ3UVKqG77U+Lo3+T3Chrv/bSC9DIx4i5AOHly7tzJHRVzC38FM/flp0rYsKwC
 zgkwj07K24rrWe5TWZ7lT0xdB3tbLau6p+7EvmsLlkFt054TzYGriJkofy3kFQnN2S
X-Talos-CUID: 9a23:POgRmG83GybzVU81LyyVv2EuA4M+bWDH9U7zA2jpCn8qVKfScEDFrQ==
X-Talos-MUID: 9a23:KUa4iQiSP+fjbJEpCm4nQsMpDvs504KeMhA0oJBB5MO7cj1hER6fg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195640330"
X-MGA-submission: =?us-ascii?q?MDG0H3eLx9sjRMarBnck7/EDmsxwK7Lptsd9Mu?=
 =?us-ascii?q?MFyUoYZvQB15UzKw/Xg73X9fXj3grtPiYuG7rnButYyCpA7xbwBqC7q9?=
 =?us-ascii?q?60YhJJJRiSnPpCYO3EEspS9oCDsBiiNjBplxBDtwJgAD0RFYqVg4LNI9?=
 =?us-ascii?q?F3c2zDkjR0W57CW0q4g8uefA=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:34:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732534456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOFP6FdjF7HR5DJ0NsQmq4Ef0zujb0dhq0/nwgl+fPQ=;
	b=ReKwAG6xggBXaHM0846BJLqrG1U3HtaIF6bfC1jba60opx5dw2+TDs8ph7rrsgYIQBRygm
	G31BUmR0nuumOQGhPzE9dwfIsDvIMDCZVfbAXdYYkGu9P0wK9R5eqJH+etgxbyOAkDF2HF
	5Ok34sL08A9NdYzQTpyrgxyNgY3pLAE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-loqDXTBwMWC4GTfAH97Rcw-1; Mon, 25 Nov 2024 06:34:15 -0500
X-MC-Unique: loqDXTBwMWC4GTfAH97Rcw-1
X-Mimecast-MFC-AGG-ID: loqDXTBwMWC4GTfAH97Rcw
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-211ff2d7d70so45972595ad.1
        for <cocci@inria.fr>; Mon, 25 Nov 2024 03:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534454; x=1733139254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOFP6FdjF7HR5DJ0NsQmq4Ef0zujb0dhq0/nwgl+fPQ=;
        b=ER7lRCoCpOwTrBcGdCkvu/oCVRhzC/k25Dk6jv2Wb3gWwjH9tyKzn/tzxHhzKMhTL7
         lMPDD22y2v598MTpHvJWXbo7KU7TVJoP1BFpVMdT68bTMtUL19LLpkfagZ0ESkKX8c4j
         rv7HUIXbPhrsLtduuvtiYULPHLXC6QjZCqjPtSvoQuVgi0i/eP5cTxSwvmZ6DR7TiLFA
         380B4frIqFVtrz8jMT8/ZnHxGtDEaMGSWvx64JPl/V2MXBvVSrp6tu8Jri7crRiTcfgu
         OAXFoGF0fi0WkUbxJeDfoiWEmla4NfAV5lmjnAx/dG2c76G01j8OMYcyD0wUosiFO31O
         S0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWuhxz72IPlbXr5I8UoahsjiIBkHFkuJpocAy36taSrvzXi6BjWrq/JWNeWcO9F8vTJblTqgg==@inria.fr
X-Gm-Message-State: AOJu0Yw5d1spQj3u215tCXEy/M/svVSDOy2DqhteEE1LFEndn53peNJa
	6Kx0aDkJ5JkoygEpfVJ/mYU9e8xmjuVMBDPK3zYYmNDCPwisPaHDGVA//uTGlLU720JKI7R0jd6
	n3PCSdw1OM9RpecRsd1vuy4KcO7i8kEP3cCuXK7pSPZ++OsOK7pXAhZX5wnv/z1suRpvJOX57fk
	8JYQCwbQ/22nYyq5Agcg==
X-Gm-Gg: ASbGncsIcqO3owXey4S8HOczVYeStKEKhJReAQP/qfIunRe591V3gXd5mE0JGPp+EFW
	c9HipVd7tjfog0VQhKOowddfc1uz2PQ==
X-Received: by 2002:a17:902:f64c:b0:212:6981:7587 with SMTP id d9443c01a7336-2129fd0fc42mr208252755ad.24.1732534454151;
        Mon, 25 Nov 2024 03:34:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHblig9i49prrqDlUeZETVKtu2gFAI4HQKWoBxXGngksx/l9PRt93GGuLopiLDUeU5NzeAE1cUQ0J/uiU3YMRU=
X-Received: by 2002:a17:902:f64c:b0:212:6981:7587 with SMTP id
 d9443c01a7336-2129fd0fc42mr208252465ad.24.1732534453881; Mon, 25 Nov 2024
 03:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20241125104011.36552-1-cgoettsche@seltendoof.de> <20241125104011.36552-7-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-7-cgoettsche@seltendoof.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 25 Nov 2024 12:34:02 +0100
Message-ID: <CAHc6FU5t0cB=+9ijwx26NUEck1YS7304ue_5FRwqXRzBq14jjA@mail.gmail.com>
To: cgzones@googlemail.com
Cc: linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, cocci@inria.fr
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DwHBqoHIzi1dDIVrsrgk1OSfFi3IRHoOUrYQtrVdi4U_1732534454
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 08/11] gfs2: reorder capability check last
Reply-To: Andreas Gruenbacher <agruenba@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 2117
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/CAHc6FU5t0cB%3D%2B9ijwx26NUEck1YS7304ue_5FRwqXRzBq14jjA%40mail.gmail.com>

On Mon, Nov 25, 2024 at 11:46=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  fs/gfs2/quota.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/quota.h b/fs/gfs2/quota.h
> index f462d9cb3087..988f38dc5b2c 100644
> --- a/fs/gfs2/quota.h
> +++ b/fs/gfs2/quota.h
> @@ -44,8 +44,8 @@ static inline int gfs2_quota_lock_check(struct gfs2_ino=
de *ip,
>         int ret;
>
>         ap->allowed =3D UINT_MAX; /* Assume we are permitted a whole lot =
*/
> -       if (capable(CAP_SYS_RESOURCE) ||
> -           sdp->sd_args.ar_quota =3D=3D GFS2_QUOTA_OFF)
> +       if (sdp->sd_args.ar_quota =3D=3D GFS2_QUOTA_OFF ||
> +           capable(CAP_SYS_RESOURCE))
>                 return 0;
>         ret =3D gfs2_quota_lock(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHA=
NGE);
>         if (ret)
> --
> 2.45.2

Applied, thanks.

Andreas

