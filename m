Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E227A112583C
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
  b=ehnlGaWZzVQ/z1t/TbmrB21nPFcFFCT/GdZMfKrC/8JB3M7yTVncXgBF
   6PDG6fC2VvIfh7WNr4e4zGbVCr2mYN+o0TT0HVFXXyUVhc6P2kCXgGZEw
   o78jMpdy1J+QJTdt2dlzOmgyKETL8/Vyd9CSc8FeC5E1Ce6Y0IdNjHJM5
   I=;
X-CSE-ConnectionGUID: T4mXYUoVSZaI5gYJ5eZdCQ==
X-CSE-MsgGUID: kH4S1/exSU2+Q8D103mvGQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267314551"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 15:38:36 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 561B7819DC; Wed, 11 Mar 2026 15:38:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1DC4B81988
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 15:13:14 +0100 (CET)
X-CSE-ConnectionGUID: ITjD9cLwT2CGqN4S0T5mNw==
X-CSE-MsgGUID: emNinq32QCOr3ost/iOhaw==
IronPort-SDR: 69b1787a_Q07B0hUYcefM2oZXbYF6V8Fu8zOl09Qvw0fiuWkaEoV6wTb
 GeImY3aPSCqBdUj9n3MVYO0q9bps8/+qjfnIk/g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GaAgBmd7FpfC7QVdFagQmEEYFmMwRUhFiIe4ZYgiSgK?=
 =?us-ascii?q?AEDAQwBUQQBAZIsAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEiGQcOEimGXIJiAYQAAQUSEVYQCwsNAgImAgIhEgEFARwGE?=
 =?us-ascii?q?yKCYIJ0A6J1gQJCiz2BMoEB3j6BcAkBCwGBCS6Fb4JlAYFwg2oahHonG4INg?=
 =?us-ascii?q?RU1gnU+iB6CaQSCIoEOiQqJcyYJHQMHBw4NHkYPBRwDWSwBVRMXCwcFXkVDA?=
 =?us-ascii?q?QIBgQUjSwUtHYEjIR0XFB9YGwcFEiEqB15jeIIBD4ZnAXkDLl4aDiICOlyBB?=
 =?us-ascii?q?gtaBYIsAhwDC2ILPTcUG0qOYj2CNYJpx34IhB6BZKAOM4FLlgeTGS6HZZBzq?=
 =?us-ascii?q?RYCCgcHESSBWyM8gSB9CGwGgjBPAxkP2xBCNTwCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:7kycfq8wIPbyZNZRjbduk+BFI+orL9Y04lQ7vn2ZhyYlDPBw9v
 re7cjzuiWE8Ar5NEtQ4OxofZPwJ080lqQFhbX5X43SITUO0VHAROoDnOjfKn/bakrDH4ZmtJ
 uIGJIOdOEYY2IK8vrS0U2WFc0/yMKL/K3tqeDV1Gd1UA1mApsMnmVEIzfePEkzawVPGIYjGI
 D03Ls8mxOQPVoSKuq0b0NrYwEBnbH2vaOjTxoPBxtizhKPgzOu4Lu/NxSDxB8RX3du7N4ZgB
 P4es7CjJlLesvUu3rh61M=
X-Talos-CUID: 9a23:umvxeW1FnstDKy00LF7vmrxfO/wnXizW6GjseWSXEEA1c+WpFFq25/Yx
X-Talos-MUID: 9a23:YOWbQwSEnwQZF5hZRXThgRdjMt4zuZ2FL1pWlo4a/MijNSVvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267307258"
X-MGA-submission: =?us-ascii?q?MDFuTs5MiF9uRGWC7Rfte26qDM3qK7jLMjTQX2?=
 =?us-ascii?q?Xos7d5IyXzDb9vJIP880xPLk59/DuhNanbQSNg8qi3DSz/RCqS7dvrgi?=
 =?us-ascii?q?o2e8Kvwn/oRnFJEUE6alv4XKQ3+FCp1wFXr5MgjIJPAfPyx+Kb8dD3yH?=
 =?us-ascii?q?ej7v701TQt2r7EWHu/m0NBYQ=3D=3D?=
Received: from mail-ed1-f46.google.com ([209.85.208.46])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 15:13:14 +0100
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-660ea6ceb5aso1641151a12.0
        for <cocci@inria.fr>; Wed, 11 Mar 2026 07:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238393; x=1773843193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=SZA0KbBAjhlabxtiaolzRl0rQUSP6VlosgODviA6SiJaxBYyS3BimKm+9qAaQQcFJj
         +HP9az7jfRMTwAvADsTyltSQqCsDa4myrUby4NSu5NOan9dmJLGs1CAqYe2jy3luO3LL
         2qTgOjNqPkPL3Jfzi5Bol69Wl2tRQtGJa52s3a85nLDxmo4H6znNTc/GLVC61XuKfdxz
         wLYdHkVq+5nuqPOlO/6K2IvCB3u1D5TZIfMvTSEVpGG9EOdU5XrXQ87IpDVkpwns58Tz
         Erdl+cQwxDNNnzDqg9yBtFdoLy/X1Zn/IxuacP61AZWM6er936kQq7xfFiZwPJFLqQPh
         QNeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVAwAzsaEXIlYS91HtK+Gan0RwjVnqvhpW8UbwinETs6ppRwdwBKzJlLY2N5oB7aTYd372zA==@inria.fr
X-Gm-Message-State: AOJu0Yze+W3StRDgbQqhS2jzoCNFe3pj7bsnlxXJV/grwJ+jBbssDXee
	GEQN6aDORfKyIZepJN3rB5HHljvEYmDLPudH2vVDQTXiLTG2x9XDcP+KUkcyrIsooVcEUg==
X-Gm-Gg: ATEYQzy09Ix0oCb8pmzoUxsD3tlu84MNJIjnCSmWj96vTW+zJwwI8hDXsYEHus5Dglm
	KmDMmPzXEn2DHo3/0KWJY/qIlEh9vflRbfQD9om6A3jUaRJudWsh+/8jgm6N8E/ORnQtSNBz6X8
	fZoGA8Av33QuslSfC78ObQ9DW39rJMcRhMiy13CRm1I1MEYVucooVtlBuogcdIvYAOsRzYzg3Kw
	BUh+1v8564/gJ+q9h0APwL9jVQIl+h5aNyveF/yUxXR7s/iF2TtD8z2NH/3OVaUrIte4o53lJVP
	XH+8jQh+9KU3j7yWrJIHXtXU8z7Ej8f0LZZovnokS8HL0d7bypjkbJbmIKBz7dGxLnbErbDeWEg
	oAL2y1Y2Jja7uP5gN1Y5awWOsKMgNoZ4zeNiwGAV8YmzlPAR5GNdzvQh73zZGNYJSEQk14U8C7Z
	NqIT8twQuKNjRYPCiUIrr/wR3t2ATpMulrVjldxFFIZj/ly8xCwhEmcWQypYRr7TMAc2Pjn/I=
X-Received: by 2002:a17:907:3e90:b0:b93:6b67:8ec6 with SMTP id a640c23a62f3a-b972d3cf07amr162462066b.5.1773238392931;
        Wed, 11 Mar 2026 07:13:12 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9736e2ca31sm30425066b.37.2026.03.11.07.13.11
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:13:12 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9423d62cbbso151320066b.1
        for <cocci@inria.fr>; Wed, 11 Mar 2026 07:13:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhvVpZhdoWTk8sebcmRz/sK9Ap5dO2C4Bk/u1MO8BwB81cPMD78wKDavIhMt8XfGEgWLroxg==@inria.fr
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
X-Loop: cocci@inria.fr
X-Sequence: 3416
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/YzajKMxGeSQUPBchblRljQ>

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
