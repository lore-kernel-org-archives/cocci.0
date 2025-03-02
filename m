Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93863C282D9
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eplFgMaQsQyB+/Zy+raMLdi8B0lOyb9eqEbr6SEobIY=;
  b=SEbNbfdIVuqmBGoNC1VKU62EF6P7Jx4CF+FEbYVu/j7l9gfH8E9jW7Hm
   fYWT2tHF5UQsjqsCOrqWgTOhzA/KE/mLUKxodkJCrwws1owGuau/K8E27
   dTSSRbh6lam49r2bLrYGYoleBIuCM73S9yMk93RiuSE5aKzEo1j6Gp7E6
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@google.com
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211069186"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4DBF8E0DF5; Tue,  4 Mar 2025 10:58:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6D87FE0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 19:24:25 +0100 (CET)
IronPort-SDR: 67c4a24d_v/Q8Wo4jqEIui07Pz4P5cTtp8KjNYu70zFk1f+hs7me5gUB
 XUx6SBhXznLibRnTndifp8YbNcRoGRjFNaLsZTA==
X-IPAS-Result: =?us-ascii?q?A0ECAADFocRnfLWgVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVY0BAtIhFaIHYcygiEDkUeMTYElA1YPA?=
 =?us-ascii?q?QMBDUQEAQEDBIUAAosVAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBIhkHDhIphXsNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RcCR0MBAQEBAxIRHQEBNwEPCwsKAwICJgICIRIBBQEcGSKFEQMxA6IygQVCi?=
 =?us-ascii?q?kR6gTKBAYIMAQEG2ycNbIFlCRSBBi4BhX+CTwGBbINmGYN9eicbgUlEgUqCd?=
 =?us-ascii?q?T6CH0ICgTc+OIMOgmmCM4FpAYM9mgWOLSYJHQMHBw4NHkkPBRwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSlIAQIBbCIjgSMFNAo3OoILaUk6Ag0CNYIefIIrgheCN4IXgiZEGC8DA?=
 =?us-ascii?q?wMDgymFUoIRgV0DAxEFDwGBboExdxyDfX+CMII6HUADC2ILPTcUG0yhZTqEO?=
 =?us-ascii?q?giBPR0uYGULkxqDUbAGhCWIZJh+M6pWiDCQTaN6AYUlESOBRDo8gSAzGggbF?=
 =?us-ascii?q?WwGgjBPAxkPjiGDeshuRTI8AgcBCgEBAwmPaDSBSwEB?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
 b8biodDD616GpDehEfxh+8UvA==
IronPort-HdrOrdr: A9a23:lqf80ahNAE5m//H1/mCC8FDAh3BQXioji2hC6mlwRA09TyVXrb
 HVoB19726JtN9xYgBcpTnkAsO9qBznhPlICOUqTNOftUzdyQ6VxeJZnOjfKl/balTDH4dmvM
 8KT0E9MqyTMbEQt7eD3ODXKada/PC3tI+vnvnX1HpgQEVHbKt6/x5lBgvzKCFLbTgDK558O5
 aV+9ZdqyDIQwVwUu2LQlcAG8bMzuekqHskW3E77twchTVmQQnI1FcyKXil4is=
X-Talos-CUID: =?us-ascii?q?9a23=3AKz3hpmiQ84zamdn6kAuBASa9qDJuX1/c3nf/Cla?=
 =?us-ascii?q?CVF1ZSpKqW1id5fMnqp87?=
X-Talos-MUID: 9a23:gNEA0Qr0EKT1Zft+7NQezwB+K5tP2qaoM0Mql5w6lu/VFyF7GijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,328,1732575600"; 
   d="scan'208";a="110433899"
X-MGA-submission: =?us-ascii?q?MDGGxdrEe/OSkEpOt2sTcU/1ID4UTE7YboQLHR?=
 =?us-ascii?q?uCPEIAEafip6lMhMgV4udeofLuEs2ZW4gefzNpxqZPa3HQ001hnNcqqJ?=
 =?us-ascii?q?4aYwLEiP7b3gLTxv7Qa1/I6mryuV6OiN9sEHGZZ2gYFQ5aPY411hv6bV?=
 =?us-ascii?q?Km/g4vWuppA3bJfGF03Qc5iQ=3D=3D?=
Received: from mail-qt1-f181.google.com ([209.85.160.181])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 19:24:14 +0100
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-472242b0da5so35561921cf.1
        for <cocci@inria.fr>; Sun, 02 Mar 2025 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740939852; x=1741544652; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eplFgMaQsQyB+/Zy+raMLdi8B0lOyb9eqEbr6SEobIY=;
        b=knXoFxJBR4NK/v/trOGEAwQdiVlOOewmiqjxiE8V8UntOq06FmA4FOJrxwus0CjU5V
         5DC41XOq9GYNSlTd+gg8+rfSdjjji/gOmfOBCer328mg+rXfn7bGCHryqt/zwe43MdbY
         2EhPtju1QMH/HBQLtRI79om9AdOLTgdXOqtPTteH62spLwqQK+ZDpd4cnxrKnHlXBKBo
         DlpTa4OUywJI3TvHOde3n0WmuqXVZIRI6cVnmRkjH+Ab4YXAneyZDnPB8PlJcoqXayr2
         Ii1pnNtsSb4XIWLS6GXrnWPT8ozvaBVQm1NIYd1XebeJVt2wUjUPGCkW5ieZdaGpVDBp
         lHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740939852; x=1741544652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eplFgMaQsQyB+/Zy+raMLdi8B0lOyb9eqEbr6SEobIY=;
        b=USauUnzlmOSIsG4MKsKqkOO93LrOMF5LYPaqtB3pc3uXHQKH21as0Jtvwar9FPGExq
         mvovxfvsFF/5dwL56bbh8TPwyqIdUT5mqFNVGSVl3+o31HXXu3R/JHWLCbD5aDn5Mvt+
         MjKGZwBpR58Sj2JKWMlIZwp6b3dNyzXbmrjjZDudyzmxZpn5SVjzYZHc3tSrXKawmkzj
         Tuf0b5YwFV4TTwuRRO684+nwXwdVCbJA4tWBprLVgW/eF82vEqxHg6ipmT6uQl2X00St
         2zBtPsAnvusTrElPRfMnNzW176DbCqu/zun6OsnUBzFis+2wVjg+AXIe+ApFrEuhdYtm
         kWCg==
X-Forwarded-Encrypted: i=1; AJvYcCXVCMvyW3AgiX21eoeUCwqNRBEQZ2l5lvMGL3D2EXExwGigQK+0QyaPikk7zBw27dPVCX7/ZA==@inria.fr
X-Gm-Message-State: AOJu0YzR4k+pq1cFS6NyUQSsJdHuNYBVz2nxS1GArttH59kA3UyHy328
	m3oBvyiYIs7JgM2Ge0MSziRlkPg0zZMOAEG/Ovm11evUEFR5iWaXZD56vyl128NTe+62kkDQmmQ
	J+hl8nzbx720xCmEQbDoy8pIvjTMVlpMFxk9Z
X-Gm-Gg: ASbGncu9415f8l1h0ysXmQKkZqPsB5vw6CArIF9VUhefarBA0qfWCvvZC6hGHqvJ9nw
	hUcaRi5qDfYIKvWJF+19Qj2FZRVt06ZzwhEwK6TBmHn6Zyv8R1Siil075OPM9E2+Uakl2E9BBML
	D/TMSHDaqI07PnEdzIosukbWnY
X-Google-Smtp-Source: AGHT+IHoUp0qt690gXNPlU7guXUDhkYKEDbwO5J8amkbaeQJ9dEnWaV7+9NCNo2WRt5tUi1lg142+lTNChtitwgUcIo=
X-Received: by 2002:a05:622a:293:b0:472:3f6:92a2 with SMTP id
 d75a77b69052e-474bc0ee7d8mr177701781cf.38.1740939851650; Sun, 02 Mar 2025
 10:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20250302160657.127253-1-cgoettsche@seltendoof.de> <20250302160657.127253-7-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-7-cgoettsche@seltendoof.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 2 Mar 2025 19:24:00 +0100
X-Gm-Features: AQ5f1Jr0FDOQ9D4KLNOprqJYo7eUxi0ui0k4VkgLi_xZ_6fJwr97NMU8vRrNx1Q
Message-ID: <CANn89iLDDfWJqtxnC463t5aM_p4-4iUjVNfvuxZs=_DXeThGww@mail.gmail.com>
To: cgzones@googlemail.com
Cc: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	cocci@inria.fr, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 08/11] ipv4: reorder capability check last
Reply-To: Eric Dumazet <edumazet@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 2499
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/CANn89iLDDfWJqtxnC463t5aM_p4-4iUjVNfvuxZs%3D_DXeThGww%40mail.gmail.com>

On Sun, Mar 2, 2025 at 5:07=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
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
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
