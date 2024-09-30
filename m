Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09EECE835E
	for <cocci@archiver.kernel.org>; Mon, 30 Sep 2024 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9hpPqVnNjoSsPgDmrCpjCYGtNIyeF2kadwHKP/cqRs0=;
  b=A8v5NWJtpZOcqZGexVSTGxpJEmlYD9reG2DTbmEBwKoqMQICMcs6WVzI
   8UAQHBAynYbHn9mpTezMtOs8SJFE/7ZitUJMAqHUNlRt72/WO6J5tzVwb
   snBlcKdIKAcV+ry+QvWk8aImQV6W1CmDjb/y8B4VGdtBudQwcoG7Fuob0
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="186031879"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2024 17:38:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CA1EEE0CD0; Mon, 30 Sep 2024 17:38:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 35536E0035
	for <cocci@sympa.inria.fr>; Mon, 30 Sep 2024 17:20:31 +0200 (CEST)
IronPort-SDR: 66fac1bd_4Im+kwhSpeglPde17AEfasMFmEY4hTJmstkY7ZYILuIUHUE
 GNnbzeraa944ZJoPw0AIhox1mXxzK2EWjkCmKIw==
X-IPAS-Result: =?us-ascii?q?A0H/NABqwPpmfzDQVdFagQmBT4JEfVk0BAtILYQpkCAKB?=
 =?us-ascii?q?oE8A4t1kE2BVhSBLD4PAQMBDTsJBAEBAwEDgUmDN3kIBQICAYh/Ah4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBIhkHDhIphXUNg?=
 =?us-ascii?q?lyBERthAgUDCTACAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQINH2EWER0BGx0BAxIQDwImAiMBEQEFAVeCYIIvAQMxAxEGol+BBUKLP?=
 =?us-ascii?q?IEVBQIWgQGCDQbaWwoZKA1sA4FgAgEGFIEGLoRzKVuCOhoBBW16hD6CUGl6J?=
 =?us-ascii?q?xt9gRCBFTWCWIM8BBiBEQESAW6DDoJpBI43RYIsYYIahUoMgUWBPXwlTodog?=
 =?us-ascii?q?ReEF4xzJggBBhcDBwcJBQQcBgUFAkIJBgUKEgMEAwQEAQILEwkDAwIOAggDA?=
 =?us-ascii?q?ggGDgIRAT8SBBMKDQsDBgUfCAIEBwwRChcCAwMCAgMCBQMDBQUFAgMFAwQDB?=
 =?us-ascii?q?QMDAhEBBgIFDQgGCwUFBwIGAgQIBQICAwMDAgQPAwMDAgUCAgMDAQIGDwYCA?=
 =?us-ascii?q?gMFBgMDAwMDBgMDAgYDAwICAwIDAQMCAwECAwICAggCAgMFBAUCAgQIEAICA?=
 =?us-ascii?q?gIDAwgDAwoEAgIEAQQCBAIEBgIEAgIBBgIDAwIDAgcCAgQCAgICAwIEBQIDA?=
 =?us-ascii?q?wMCAgIBCQIFAQEGAgMDAgMFAwkDBAUCAwgBAQICBwcDAwQDAQIBBQQCAgYFA?=
 =?us-ascii?q?gMCAgQCBAUDAgMGBgIBAwIKBgMFAwMDAwIDAgMDAgUCCAICBAQFBAIFBAIEA?=
 =?us-ascii?q?wMDAQoCBgMCAgUBAQICBAMCBAQHAgIHDwMCBwUCBQUFAgcBBgUCAgMCBgECA?=
 =?us-ascii?q?gYBBgIEAQINAQECAgMEAwMHAgQDAggCAwMPAQMDCQYFBAUEAwkEDwIEAQgDA?=
 =?us-ascii?q?QEECAIEAwIMAgIgAgULBAQXCAMBAQMBAQICAgINAwIDAgIDCgIDAgoGBAIEA?=
 =?us-ascii?q?QEBBAQBBAIBAgcEDgkFCAgBAwIBBAYBAhAFEAkDBwQCEAYKBQMCAwUBBRUDC?=
 =?us-ascii?q?AMJAgQMAw0CAwIGAwYCBgEGAwcLAQEHCAUDAwMCFQECAg8IBAYOCAIDAwMEC?=
 =?us-ascii?q?gMSAgYOAwMCAwIBAgICAwUEBQIHAwMKBQIIAwIIBQMHCQQKAgoCBgMCAgICB?=
 =?us-ascii?q?QwBAQEBAgMCBQMHBwgIBAUEAwEBBgYMHgICAwQPAwkDBgsBBQUBAwICDgMGA?=
 =?us-ascii?q?gMGBgEJBAEFBAkCBQcGBQIBFBQHBgIKAgcCAgIDAQIICQgCAwIKBAEOBBkCB?=
 =?us-ascii?q?QECAgMHAgMCEwMDBQQIAgICAgMCAQoLAwICAwMDAwUFAwIZAwMCAQoFDAUEA?=
 =?us-ascii?q?wQCAgEdAwEFAgMKAQUJAQYCAgMCBQIDBgQCBAEOAQEBAwYLCRQCAgIJCAMIA?=
 =?us-ascii?q?wUNAg0CAwUCAgs9CwUBAQQDAQgBFy0CBAIGDAEBAQIDBgICAhUFBQMFAwgBA?=
 =?us-ascii?q?wECEwgGAgEDCgoCAgQCBgMDAgoDAQgCAgIPAwkCBwINAgIDAwwPBAMDAwMIA?=
 =?us-ascii?q?gICEQkKAgICDAQKAgkCAgMGAQIDAwUDAgEBAQQvAgQHAQMGCgMCAgIJCAoJA?=
 =?us-ascii?q?wMFAwwBBgQBAgMMAQECEwQJAwIBAgEBBggBAQIEAQQCBwYCAgICCgMFAwIDB?=
 =?us-ascii?q?RMFBAICGQMEBQMFAwMEBwECBQQKCQIFAwIEAwMCBAQCCAUJBAMLBgEBAQMEA?=
 =?us-ascii?q?wEBCAcHAwIBAQMBAQoLCA0IAwgDBgkDAQYBAQUaAgMOAgICAwIBCgYIBQIDB?=
 =?us-ascii?q?g0CBAIZAQwDAQMDBQ4EFAMEBQICDwwBAgMDBAUDBQICAgMCAgIFBAECBAIEA?=
 =?us-ascii?q?QgECQECAgIDAgEBAgQGBQICAgMCBwwHAwQCBgIGAgMCBwsLAgMGBQUDBQIeA?=
 =?us-ascii?q?gMCAgQDAxUBBAECAQIDAgIDAgMEAQMDAgEBAQMHAgICBAEBAQQGBQICAwwCA?=
 =?us-ascii?q?wMBAQYBAwECDwYFBgQBCgMCFAMFIgIPBQgBJgEEAgIBAjYCAgMEDQgFAgIHA?=
 =?us-ascii?q?gQMAgQPBQMDDgYWBgEECAQFBAQMCgMGDgcXEQEBBAQCCAQCAg0HAgwCAgYEA?=
 =?us-ascii?q?gIHIwYDBQkDAgUFEAICCwIEAxUEBBsDAQIKAgIYAgEHAQISAQcEARQCCgMCB?=
 =?us-ascii?q?wYHAhwCAgMDBwQGAQkDBAkRAwsBBQYFAQEEEQECAQIBAQIDAw4BAgIHAgIBC?=
 =?us-ascii?q?QICAQECDQgBBAMIAgUDBQMKAQEBAgEECQQPBgMFAwMHAwQCAwIGAgQEAgIDA?=
 =?us-ascii?q?wIDAQUDAgECAwkCAQ8RCg8CAgMEAgYCAgEEKwQBFQUCAwQCAgcCAgMBAgECA?=
 =?us-ascii?q?gIEAgQCAgYDCQgBAgIHAQICAgMWAgUBBAkDAwUSDSMDAwECAgIDBwoDBQIBA?=
 =?us-ascii?q?QIEAwUDAwkNBwIDAQIBAwUDAQIBAgkDBwICAwMFEhkFAwIPAwIBBQQCCBILB?=
 =?us-ascii?q?wEBDxYFBAkFFQMGAgMGFwsEBQMDAwEMBQwOAgILAxcFAQQHAQMQCwMEBAIDA?=
 =?us-ascii?q?xICARMBAwQCCQIEAQIIAgICAgIEAQEFBAIEAwIFAgQBCAQFAwMOBAMICQMFA?=
 =?us-ascii?q?wwUAgICCQIDAQIDAwMEDQgWDQMCDhsKFxMHBwMDBAsCCQMEDQIEAgIBBgMGC?=
 =?us-ascii?q?gYWAQIYAgIGDgQDAwgDAgMCAgECAgIBEwICCQgNBQkFBwIWBAIDCAEJAxECA?=
 =?us-ascii?q?wIUAQYCCAMHAQEEAgIaEwoBAQMBAgEHJgILIxYGEwMDGAQEHR0CCQMjDwMLC?=
 =?us-ascii?q?QgTPQELBzIENAEUFAcrIV+cHY5sKYFbSIFkJYFTLIIfHgsvknWDEI5ooQBng?=
 =?us-ascii?q?zsFim2BJJVAM4QFjQGZP5h2jXuVThOFMBEjEoEyOmxwcIEBgjZPAxkPkhuFF?=
 =?us-ascii?q?LZ8PzICATgCBwsBAQMJjAmBSwEB?=
IronPort-PHdr: A9a23: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
 ZMPTvlQU1lnT5sn
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:WaBrRqNdyguIhMBcTsKjsMiBIKoaSvp037Dk7TEXdfU1SL3/qy
 nKpp4mPHDP+VUssR0b+exoW5PgfZq/z+8W3WB5B97LNzUO01HYSb2Kg7GSpwEI2BeTygee78
 pdmmRFZ+EYxGIVsfrH
X-Talos-CUID: =?us-ascii?q?9a23=3AqO03Q2h9FU0C/fKvDV54aAGVsTJuKELH4Gr/Ggy?=
 =?us-ascii?q?DAmdXYb60clKW+rojqp87?=
X-Talos-MUID: 9a23:dt8XdAWVriRhUWPq/CPnmyw6FuM52qqBKFwTirgbq8yICiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="97802183"
X-MGA-submission: =?us-ascii?q?MDHPWLTvxeYvi4pQz9/K7kNwQZyIH+ia67jU3F?=
 =?us-ascii?q?mnOC2iRQUeu54pxsw1gplyxtEK+WfLuWiRx7ZU5HJCrFtpm3s2uC8SFY?=
 =?us-ascii?q?zHnviZlg23xaG30XpSyeT1sApOgPKJdgKsRZm5zWBMNorvnko+g5bNFC?=
 =?us-ascii?q?ywX0sOrljyjZgg8cObsSMA9g=3D=3D?=
Received: from mail-ed1-f48.google.com ([209.85.208.48])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 17:20:30 +0200
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso5202826a12.3
        for <cocci@inria.fr>; Mon, 30 Sep 2024 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727709628; x=1728314428; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9hpPqVnNjoSsPgDmrCpjCYGtNIyeF2kadwHKP/cqRs0=;
        b=Il0VnI7A6IA3sP3ahhDRlSUkkaia0YcN7ftxzncfSas38AIncant0c1ebEjnQ6Msoc
         WpGzmd2Z6Pp6SmpagIDrpk9uJaTVnrh4k27YyStUrYxpgWMv+/nZGV3OERwhgjsWHzEd
         SYe5+7+dotOcOw8lAAHgn9x3pCAz6BVBDIeG0L+zdR1WNCbRIST0FI2KbpLseZgPnhRk
         0gmV50cPJ31hAKg3rjitqDP09xYNfdAlUa7JW5Beamz1r+/tCppfRqX5IZ2jVdMWUQb2
         SQrxbM/+4iMGLdKwgBRKlJASDW5FtyZ1BMah/cDmpzvahdbbF4lXqNEJ77URvGDIxuy6
         fSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727709628; x=1728314428;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hpPqVnNjoSsPgDmrCpjCYGtNIyeF2kadwHKP/cqRs0=;
        b=HoRqVUOAYtML1c69cOM2nJ+nOFmZ/QTO7yh/e03K8An1nOReK4DvUVlUu4TSgC0xcd
         UMGaQt1T+9K9tC5ysJ6kcVmcTtc8n2FaD1jCgXbUXa2p7+WQL/wtzlo0qgnsxUz4tg1G
         tNmC7zNhL5kl5pvRIE5BFmXce4fBFgQNCQvUVEm2a6tvHJzWKAlF9R8zsVZMUmSFjZ5E
         jJobvoi8Cc99ebXzsflsY2JBnQe6oPJXmJ+7lswldeSBHF/TZz0Glx0t1yhNrTDMDAQ0
         J54kYEXxled7zRQFiNuF3G14vpZNrHo5azhUyEiCaPXZ+2i6txvw3wVZYAY7wSahLuOq
         VdzQ==
X-Gm-Message-State: AOJu0YzMRJXWKdNnL/muQq9zQPiT00EldtFkyKzx3SrcrDBeaA9sk8I8
	Khp/ZZXMZItSrQJvQRLlUpvbmzrhlfK1J9QLtpNaYCYr1m+oQjTEbPsttGbWwMYdyftD9AaboUa
	E2sBUMddWNhKCai2L2oA+yUeNTdnKRi2GVWn8cVuo
X-Google-Smtp-Source: AGHT+IFM6uC1vJK68lLWSqeMvW6PlF2NzALtk3BwSPSqhsfO/3GvKOXsFHoVHZVJuGP1tO5NJpblSLQyaz9T+KaAuLU=
X-Received: by 2002:a05:6402:d08:b0:5c3:1089:ff23 with SMTP id
 4fb4d7f45d1cf-5c88262c8d3mr11087088a12.35.1727709627487; Mon, 30 Sep 2024
 08:20:27 -0700 (PDT)
MIME-Version: 1.0
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Mon, 30 Sep 2024 20:21:08 +0500
Message-ID: <CACzwLxiohvUHUxm2XM8B08RwY6VCLuK1p32Ek2Y0M+t1wTfX8g@mail.gmail.com>
To: cocci@inria.fr
Cc: efremov@linux.com, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Assistance in Coccinelle script
Reply-To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1897
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/CACzwLxiohvUHUxm2XM8B08RwY6VCLuK1p32Ek2Y0M%2Bt1wTfX8g%40mail.gmail.com>

Hello,

In the scope of task [1], I'd like to use Coccinelle as grepping tool
to find in Linux mainline tree code where the 2nd parameter "from"
to copy_from_user(..., from, ...) is passed without __user compiler
attribute. Please advise with the attached inline at the end of email,
as I, seem, can't figure out per reading the documentation myself.

$ spatch --version
spatch version 1.2 compiled with OCaml version 4.13.1
Flags passed to the configure script: --enable-opt --enable-ocaml
--enable-python --enable-pcre-syntax --enable-pcre --prefix
/home/user/.opam/default --libdir /home/user/.opam/default/lib
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

[1] https://bugzilla.kernel.org/show_bug.cgi?id=206267

I've crafted the following script with Denis assistance,
though it still doesn't work as expected.

There are several cases how parameter can be passed to
copy_from_user:
1. in parent function parameter (@r1@)
2. in parent function body as the variable with __user attr
   or via u64_to_user_ptr() helper

There are candidates for missing such as constraints:
https://elixir.bootlin.com/linux/v6.11/source/arch/powerpc/math-emu/lfd.c#L12
https://elixir.bootlin.com/linux/v6.11/source/arch/powerpc/math-emu/lfs.c#L23

It does find the separate cases (r1 and r2 both conditions),
however on `@missing depends on !r1 && !r2@` rule, I expect
that it should match only results with missing r1 and r2 rules, yet
it still matches the false-positive. Here is an example:

$ spatch --sp-file copy_from_user.cocci kernel/user_namespace.c
init_defs_builtins: /home/user/.opam/default/lib/coccinelle/standard.h
SPECIAL NAMES: adding __user as a attribute
HANDLING: kernel/user_namespace.c
SPECIAL NAMES: adding DEFINE_MUTEX as a declarer
kernel/user_namespace.c:1231:5-19: copy_from_user match !!!

, where in kernel/user_namespace.c:

1215 ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
1216 size_t count, loff_t *ppos)
1217 {
....
1231 if (copy_from_user(kbuf, buf, count)) // <--- this is false-positive match

Attached inline Coccinelle script:
---
// __user exists in parent function parameter.
@r1 exists@
identifier f, param;
position p;
type T;
@@
f(..., T __user param@p, ...)
{
...
copy_from_user@p(..., param, ...)
...
}

// __user exists inline copy_from_user() casting.
@r2 exists@
identifier f, ptr;
position p;
type T;
@@
f(...)
{
...
(
T __user *ptr = ...;
...
copy_from_user@p(..., ptr, ...)
|
copy_from_user@p(..., u64_to_user_ptr(...), ...)
)
...
}

@missing depends on !r1 && !r2@
identifier f =~ "copy_from_user";
position p;
@@
f@p(...)

@script:python@
f << missing.f;
p << missing.p;
@@
msg = f + " match !!!"
coccilib.report.print_report(p[0], msg)

Thanks in advance
--

Sabyrzhan
