Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0017CD58D6E
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=476juWLLXH68WdEd6CCvoohOL74hVP8YdxJenm7T9uk=;
  b=fQTaHY3Rzrm2ZVX8o7M+o5nEGMWRjBO3YIBRBqNJ9nyNxqvIvrBnbprA
   i+KlwVffPAdO0n7GsQqEOxOKR0ROs2Xfg8S723LPlUJTKlHIvY3kInLfw
   6uMbSNtbuodL2tYWjt7dd0NLPEHA+0Gl/ii9GhMFZGHnKDgo5hWLLkpLV
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@googlemail.com
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724753"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0DCD9E0D44; Mon, 25 Nov 2024 17:57:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DDDA8E0133
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 12:48:39 +0100 (CET)
IronPort-SDR: 67446417_9VGFe9RwHBeqhpQPGCotzF6f8ZjaxmbLgULH2cbOdGbszud
 L9rYAxHdyeSO6SHhYJi4+Ax+bA3t7yCx/TB+TWg==
X-IPAS-Result: =?us-ascii?q?A0EUAADOYkRnfLLbVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfVk0BAtIA4RTiB2HMIIhA5FKjE2Bfg8BAwENOwkEAQEDBDiES?=
 =?us-ascii?q?AKKWQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?SIZBw4SKYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAg0fPwEBHQEBAQECARIRB?=
 =?us-ascii?q?BkBOAEDAQsGBQsNAgImAgIhEgEFARwGEyKCYIIvAQMOIwMRolOBBUKKRHp/M?=
 =?us-ascii?q?4EBgg0GgUcD2RIKQQ2BMIEgAgEGFIEGLgGEcoNZAYFsg2QZG4NieAInG4INg?=
 =?us-ascii?q?UqCdT6BfiFCBIE1BwEBIBWDRoJpBINxg0wSJU1GhCODSpsNJgkdAwcHDg0eS?=
 =?us-ascii?q?Q8FHANZIREBVRMXCwcFgSkhLAECAYJGf4E2KIEpAYFGgUpKgy6BXgU3Cj2CS?=
 =?us-ascii?q?mlNNwINAjaCJH2CTYUZgQuBFYJJTBkvAwMDA4ITgSuGBh1AAwtiCz03FBtMo?=
 =?us-ascii?q?QoBRoNBBgEBgQ4rBB0uCVdOIg0GkwSDTwGvbAuEJIwWlUczhASNBZlIiC+QT?=
 =?us-ascii?q?IwIgXiVcgGFJBEjgUQ6gVw0PBVsgjYTPAMZD44hg3qFFMI7RTICAQouAgcBC?=
 =?us-ascii?q?gEBAwmCOY5NNIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:R27/Yq02acJ1Xx8gcIvCXQqjBK4kLtp133Aq2lEZdPU1SL36qy
 jN9M5w6faQslsssR0b9uxoWpPtfZqGz+8W3WB5B97LNzUO3lHHEGgI1+vfKlPbehHDyg==
X-Talos-CUID: 9a23:nmyIqWNqLzvxPu5DRAx3zWsUEescb2SM7TCBDWCFFztDcejA
X-Talos-MUID: 9a23:9EIupAm4WsZt88flOKk3dnpBDJ9Vx5+zJXkdjK4gu+agKWtVMg+C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195642156"
X-MGA-submission: =?us-ascii?q?MDE5obRMYpXEq8cDxd2bilGYQI4o59Y87rqoPW?=
 =?us-ascii?q?GtRnaKFUbXIQU/dj/YJV54dOrBqEBFevZE9gOrbsT0BZaAzFr16qedGp?=
 =?us-ascii?q?LoZZSoPc8x4LIYEhXec7heCY6UIl3WjBEPHzWqMM2MhsnNJZ1LJgQQ+n?=
 =?us-ascii?q?KrwHP3hx5yLcRMND9BxAHVBQ=3D=3D?=
Received: from mail-yb1-f178.google.com ([209.85.219.178])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:48:39 +0100
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3882273bc8so3926849276.1;
        Mon, 25 Nov 2024 03:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1732535318; x=1733140118; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=476juWLLXH68WdEd6CCvoohOL74hVP8YdxJenm7T9uk=;
        b=Eg1aDLFAYUtYCPJkJR1prlEcOj1oWdV4fL2VuMH0h3Nzada+beJbGE2W5NKpwwJRqE
         wTUMhOCyMhzMTMIgaASYi6CYdC/EJPp+AB0+8TArBA2sPz1W5WH01WlgQEVOwKdN5sif
         L8ZAU9w+ZHxZ5Ivd22z04hMOT5Itbsi9OdTXrtYHlUa7Gw9Rrvgw7SKprfnV2VJYMn9O
         zXa707p3LCfQDnqipU3vkgKc+nG1CqLvN/GgLbVvjwMvlLpPo+4ghEBn8+mRB3atfXuP
         MdNglIpaxI7Lzhq9dDZ6qIstznzaUv3KL9/i6Sj+zkm/xgDostEm1AT+vK3Uqc2RfAFw
         tYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732535318; x=1733140118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=476juWLLXH68WdEd6CCvoohOL74hVP8YdxJenm7T9uk=;
        b=qIbPgUSK6BfCW72y6hI+Hdsa7407ksHQSU+WYB5sSlKdMva51SUWlvsJUMdqGrGXSH
         YgDPWS/xX0HdMQksB3QK5zwpeDE3HIb7vyrEFZgWZUbFgSWAccpmvMracsAmRyRmJWBN
         JM93mr3UdPmuNziNMj9nPXRDUYI0N/O0stp//Wx5KWXusYQC1RnNbraf83ExR1/hyJ4J
         0Z4I7Oifw05InfBIIkBzRt7lCKOySuDaQilXE8Ff2NdYNhAAMcL2Uwd5m71EJZQPkZ82
         EM60l2ri/tn/oUXhHmZfw3qmgcqNALKvzUn6Y2rtw2LH9IDXY5Be9zHUZYEufa0JZ/TW
         jBtg==
X-Forwarded-Encrypted: i=1; AJvYcCUI6VRlUnYdM3TO0LSHwlS5vwsqqQ6i5ETrqXbkUPmOzt8KEvvyyrGUUA8KKE1a3D4HAuwL+vU=@inria.fr, AJvYcCWzZ8hcCRPh+jG0LW4zhKGHcOqIrmyyHYNd/Qf4SFwUA7M/Xwf+CUVtd0NN+qcftIcd9Ev7WiOR5RsudJQ=@inria.fr
X-Gm-Message-State: AOJu0YwcknS2Pzg88hfbiKtGtKP1FAOUZnRKXipBNPq0TPuMPYcE02X4
	G5UOxNMRgU8lJUxE3Gu1BAIVmus2ssPDLswT1QueEeehdKsEJSMFMWZWmJEfaPpqug/ZPmO0Y5I
	Y3Ud/qwTJJO4ISgwUg40IlnHS5M0=
X-Gm-Gg: ASbGncsyerNtdP5mJeMraXehBxPT5qs9SmbmfHkgVcjZKhsNOHzHvYQRWJLsU6R1x6+
	gwzDzyPIXRSzvWPU0SdSpGBKgvGkEXFys
X-Google-Smtp-Source: AGHT+IGYP2SKdODKsnDK/PfBnKLbQWqO3MML2UPkyylWYXOgHgp7Wt8KYifNK0fRtunrvJy8VyVVbVwzaUlM3QnofG0=
X-Received: by 2002:a05:6902:2084:b0:e38:ea81:d01e with SMTP id
 3f1490d57ef6-e38f8aca119mr9503432276.8.1732535317875; Mon, 25 Nov 2024
 03:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-5-cgoettsche@seltendoof.de> <1045101183.70157813.1732534258584.JavaMail.zimbra@nod.at>
In-Reply-To: <1045101183.70157813.1732534258584.JavaMail.zimbra@nod.at>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 25 Nov 2024 12:48:27 +0100
Message-ID: <CAJ2a_Dd_sz2LYEEJJhiJE=JP81V4AvET=jgSyRe73eF-YjeXhg@mail.gmail.com>
To: Richard Weinberger <richard@nod.at>
Cc: LSM <linux-security-module@vger.kernel.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	chengzhihao1 <chengzhihao1@huawei.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, linux-mtd <linux-mtd@lists.infradead.org>, 
	cocci <cocci@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 06/11] ubifs: reorder capability check last
Reply-To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2118
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/CAJ2a_Dd_sz2LYEEJJhiJE%3DJP81V4AvET%3DjgSyRe73eF-YjeXhg%40mail.gmail.com>

On Mon, 25 Nov 2024 at 12:31, Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Christian G=C3=B6ttsche" <cgoettsche@seltendoof.de>
> > capable() calls refer to enabled LSMs whether to permit or deny the
> > request.  This is relevant in connection with SELinux, where a
> > capability check results in a policy decision and by default a denial
> > message on insufficient permission is issued.
> > It can lead to three undesired cases:
> >  1. A denial message is generated, even in case the operation was an
> >     unprivileged one and thus the syscall succeeded, creating noise.
> >  2. To avoid the noise from 1. the policy writer adds a rule to ignore
> >     those denial messages, hiding future syscalls, where the task
> >     performs an actual privileged operation, leading to hidden limited
> >     functionality of that task.
> >  3. To avoid the noise from 1. the policy writer adds a rule to permit
> >     the task the requested capability, while it does not need it,
> >     violating the principle of least privilege.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
>
> This change is unrelated, please remove it.

Sorry, somehow these two changes got erroneously combined in a single patch=
.
I'll send a v2 with them split into separate ones.

>
> > fs/ubifs/budget.c                     | 5 +++--
> > 2 files changed, 4 insertions(+), 3 deletions(-)
>
> [...]
>
> > diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
> > index d76eb7b39f56..6137aeadec3f 100644
> > --- a/fs/ubifs/budget.c
> > +++ b/fs/ubifs/budget.c
> > @@ -256,8 +256,9 @@ long long ubifs_calc_available(const struct ubifs_i=
nfo *c,
> > int min_idx_lebs)
> >  */
> > static int can_use_rp(struct ubifs_info *c)
> > {
> > -     if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURC=
E) ||
> > -         (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)=
))
> > +     if (uid_eq(current_fsuid(), c->rp_uid) ||
> > +         (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)=
) ||
> > +         capable(CAP_SYS_RESOURCE))
> >               return 1;
> >       return 0;
> > }
>
> The UBIFS part looks ok:
>
> Acked-by: Richard Weinberger <richard@nod.at>
>
> Since I was not CC'ed to the whole series, I miss a lot of context.

The series consists of similar patches to other subsystems and a
coccinelle script addition.
See https://lore.kernel.org/linux-security-module/20241125104011.36552-11-c=
goettsche@seltendoof.de/#t

> Will this series merged as a whole? By whom?
>
> Thanks,
> //richard
