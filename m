Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4A4C83029
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Tdc7GlitcDcXw1642bQHxN0XsrYkEF7Z3gv6RZ4tCpc=;
  b=RdHYWBMFeCGhuGbN5sBcSnMHVBRac0RIq/VJCjF9nnxH3XE2O1qJjmdI
   yK3pJ69TQc6ha73N58t5P7L9ei1jxSi+m0YQVvC5ZUXC1qM83kTdOMNfL
   j6pg5U/BD08T1iRNK5a2wuUMI418ZxUcGcxNa/HLosvEZhjNc8yyVXjdW
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208,217";a="229472200"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 19:23:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 40354E01A8; Sun, 29 Jun 2025 19:23:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B9714E0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 19:04:24 +0200 (CEST)
IronPort-SDR: 68617218_07rELacV0xFCW9w/A2LsUi9lriXK3fIuNbNHrbUweoOnZaz
 O54rBY8bIEIvaVYG5pfxf2PVnNalo24cdfVy+hw==
X-IPAS-Result: =?us-ascii?q?A0H0BABgcWFogTGAVdFaglyBQTFSgQBaMwRUhFWPUIF0i?=
 =?us-ascii?q?3cyhnCEWHmEB4FVgUA9Ag8BAwEMAUoFAgQBAQMENwGESIt0Ah4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDjuFew2CW4EsY?=
 =?us-ascii?q?QIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAg0fd?=
 =?us-ascii?q?xEdARseAxIDCzkCJBEBBQFXgmABgiEBBhABAzIDARAGlgePQIEFQos+gRUFA?=
 =?us-ascii?q?haBAYINBtpfChkoDW0DgWICAQYJAQqBNYR2KVyCPBoBBSVIawIOhEODOYEhg?=
 =?us-ascii?q?WNFgTyBFIUOAQECgguDLoJpBIIiRD4UHYRdhBiCZIw5AQcHMQkcBggCAkgFE?=
 =?us-ascii?q?BIDBAMEBAECCwkKCQMDAg4CCAMCCAYZAT8MBgQVCAkPDB8KAggEEQooIhIrC?=
 =?us-ascii?q?gNbFQUbCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItBAMGGwkIAgsFFBYCD?=
 =?us-ascii?q?AQHBzIDEgEICgYDBgMEAgICCwcCAwMDBwELCwkCAQMCAgUCAgEFAwICCAMCA?=
 =?us-ascii?q?QEJAgMCCAECAgECAgIEAQcBDQEBAgQCAiQCAQMIBgEBDQIGAgIBAgICBAIEA?=
 =?us-ascii?q?QgLBAgBAQIBAgIBAQEEAQgDAQECAgMDBQMFCA8NARULGQMEBQICEgICAQcBA?=
 =?us-ascii?q?gEBAxkCAQMDBAELAgEBBBsEFwIWJAIZAgEFBQUBAwQLEAkDAgUEAgIGAgQOA?=
 =?us-ascii?q?gcEAhoEAgIBAwQGAwECCAICBwQEBgMBAgIHFwIEEQECAQMCAgIJCgQFBAMEA?=
 =?us-ascii?q?wICAgEMAwECAwICAQIBAQMBBQYNEgIBAw8IBAICBwICIQ8LAQIBAQYGAwMDC?=
 =?us-ascii?q?gMBCgEBBgIBAhIFAgICBAECAgYEJQECAQIBAQEFAgECAQIEAgcCAQILAQUCB?=
 =?us-ascii?q?gECAgkBAgECAgIBAgEBAgYCARUBAgICAgIDAQMGAgICAgICCQICAgIFAgUDA?=
 =?us-ascii?q?gMFAgUCAwMCAgMEAwkDAwgDBgQCAwEBAQIBAgICAQIBBQIDCQEBAwIBAgICA?=
 =?us-ascii?q?gMGAgUFAQMLBQkBAQIBAwUDAwQDBgENBAMCBAICAgIEAgEFAwMCBQELAQIEA?=
 =?us-ascii?q?gEDAwMEBAMBAgIKDAIEAQEBAQIBAgIKAwIFAQMDAREDBAEGBQUGAgcJAwICA?=
 =?us-ascii?q?wIDAgQDCQQCBAMDAgICAQEKAgIBAgEBAwMHBhABAgICAQ8CAwMEAwQGAwUJA?=
 =?us-ascii?q?QMHAQEBAQECFAMCBAURBgQCAQEeARUCBwEEAyceAgICBwECAgICAwICAwMDA?=
 =?us-ascii?q?QIBAQIDBQEDAgIDAgECAQYCAwMDAgUDAQkFAgIDAQMBBQEEBAIHAQICAg4BA?=
 =?us-ascii?q?wICCQIHCQQEAgETEwICAgIBAgIBAgcBAQIDAgUFCAIBAQECAgMCCwICAQIBA?=
 =?us-ascii?q?gIDAgMCBgEJCAYBAgEBBQQDCgIDJAMDBAUDAgICAgcCBAMZAg0GAQQDBQMFA?=
 =?us-ascii?q?wgDBgICAw8DBwYHAgcEAgQCAgICDAQCAwMHBQICAgIEAQENBAcCAwICEgMBA?=
 =?us-ascii?q?QECFAIJAyMPAgEUCBM9DAcuBAQMKgEJCxQHBiWBABCRCFuEIxMsFIM6AQEBk?=
 =?us-ascii?q?iaDX5o3lFE7CQEGAmCBZ4EKFQotineBJpU8BlWXOZMVAS6HZZByiyWCYpVch?=
 =?us-ascii?q?S4CBAEBAQMHBxEkEoEyOoFccIFugUlPAxkPkiG9E0E1CzECBwEKAQEDCYVph?=
 =?us-ascii?q?2uBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:O4RFWKy7vA5Bo0URKDGlKrPw8L1zdoMgy1knxilNoH1uA7elfq
 WV9sjzuiWE6gr5NEtQ/OxoW5PwOU80l6QFhrX5VI3KNGKW21dARLsD0WKI+UyHJ8SRzJ846Y
 5QN4Z7TPP/ZGIUsS842mWF+hQbreVvPJrHuc7ui0xgRQxmbq0lywtiEA6UHglXaWB9dOME/V
 Onh/Z6mw==
X-Talos-CUID: 9a23:H1ttoG2H2KnIEvDikgKU3LxfEMt9a1SGlHnrDVLgUkp4E6aKZByM5/Yx
X-Talos-MUID: 9a23:tweX7Qv3G/rgXxL2x82nrzw7MMpZz6CVA3suts1f4Y7VFDFrJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208,217";a="229471343"
X-MGA-submission: =?us-ascii?q?MDH0mkdI/av/kdalX/JQX3E0iqDHFlI+AI5L8E?=
 =?us-ascii?q?MAHJgwvBFajK/NoCFiXDmZt3Q+GNoFI5YP+WTdl4/oOg9vgKag42oM7+?=
 =?us-ascii?q?wjyuqvFj/bO6GJc52AVvFwcLegDKTlRzrngSZWonuYf+t7gezNYptp93?=
 =?us-ascii?q?JHyyPQRHP+emNAyDI4aHOnbg=3D=3D?=
Received: from mail-wm1-f49.google.com ([209.85.128.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 19:04:24 +0200
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4539cd7990cso2126375e9.0
        for <cocci@inria.fr>; Sun, 29 Jun 2025 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751216664; x=1751821464; darn=inria.fr;
        h=mime-version:subject:message-id:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tdc7GlitcDcXw1642bQHxN0XsrYkEF7Z3gv6RZ4tCpc=;
        b=i/p1apuf98itl3xQwJNR9/7KmjDcV/2lDLZzWtxJZH48vDE9Zby96D3JgKvn49R1tr
         5ivqCqNhp1IBZQKPZ89SlfEDdMSwOiPjb33Vl9LMKaLPx4dzJTnoBBK7B57wHpIqoCpe
         qw4OxwdII90eBQKl78BPatSoE6NsZa3k0UeaTHzG236gYzhVCCTRaJApBQpB0wJQrLLH
         4Jaa50TH7QTdY55LSknrmf3c8ac38xsqkNMM8ifm6m5jrcp430i3HYrdEkx9+ZUeNAsm
         nY+VKFHWfFPoj46g/irbYuUEieevkQNNQ99BZ0jW/HB9Fh+YpGoQs04OZDfQfvfgI2SW
         oL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751216664; x=1751821464;
        h=mime-version:subject:message-id:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tdc7GlitcDcXw1642bQHxN0XsrYkEF7Z3gv6RZ4tCpc=;
        b=E0+YWMhhw/MCey81WyWV0qZy3SB6p+J8svM8gyv6A3HYgL9YF8JXNEUMjDkFvYezsj
         FdOUus4BnYIRRlB9US/5tI3PsyOfPR+ITOinz9p+qLFWH6MjLqwadicwooG47MvAxSak
         m46XLSrRPmhGAa0s6It91vIhhbf97dBWbesmiSfZCzbhAQN8wbkioGor5r05PZV+UdMz
         wMT5I19FVO+biDAAEd70/k5P6/oGqo5cY8uDuKkf7NrKrFIvCGxmYqym43NHEF1ekuW0
         M6xLXQyI/j8G/nwgfR8jqSwAQnazPmObYjP0/lVSO/ErCSP3FIeGibgK/FHpnJXuqeBD
         ww3g==
X-Gm-Message-State: AOJu0YwL6ids0DAR71ewhYYz8rfJ9+q5dJ80t4VldPebEP1gd0dyqT/0
	idjQTm9QJwwq/it78R+6l3pwOphIaB8kySSkQ7vZLVR0WxKdddKTtIvQHcXZfg==
X-Gm-Gg: ASbGncutPRB/hwOO87gyzCM+qEdjoa+oYaeX3l8qhb2DTN5jgIF8AeZWPQQgIeEJ0/4
	jYy+aWMmCJdHL2v2UV3k/xOqViPg3BZRp5SHd9yENZTkHmQYigEU4z0CrZe3MJHcAJA9tRbpezO
	OLQb3SzkG8pSAfBjCEB5tvwdDP/A50OchSpz5sCMyTZ8NLUU9gdSOMtvafjpoORMyR9CMERjWCy
	ZM+gLaXn2xCgIssvonnuPpnTzudZFmXlLDQEQDmW3oE5lrfmzSbssvBf7GRzSLtnVOnXNkxXsdp
	HDBrSaBtJRW1ifNGjtw500BXrMuJWigQnPUH1epD6EKp44jSo78iMnpqPhQKWVk1T7m4Yefa76u
	+TzOksBSu6cTH8nKXsNe0lA4=
X-Google-Smtp-Source: AGHT+IFB9C3ryxvkajPDIyBoRhuuEleJ3o7zLg6vVoDLqCKXUGkfYOfwAYj/dCUiuLuW4HL7sK1Tvg==
X-Received: by 2002:a05:600c:8b2c:b0:442:f904:1305 with SMTP id 5b1f17b1804b1-4538f2c8001mr104126995e9.6.1751216663330;
        Sun, 29 Jun 2025 10:04:23 -0700 (PDT)
Received: from [2a04:ee41:3:2418::ffff] ([2a04:ee41:3:2418:ec97:de8:ed49:4bc4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe587sm111848365e9.19.2025.06.29.10.04.22
        for <cocci@inria.fr>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jun 2025 10:04:23 -0700 (PDT)
Date: Sun, 29 Jun 2025 19:04:16 +0200
From: devnoname120 <devnoname120@gmail.com>
To: cocci@inria.fr
Message-ID: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark>
X-Readdle-Message-ID: 7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="68617215_71f32454_1255"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: devnoname120 <devnoname120@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2817
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/7c65be39-dfc3-4b9c-9acd-dd94d1225db8%40Spark>

--68617215_71f32454_1255
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I'm trying to insert two fields inside a struct, right before the use of =
the macro =60randomized=5Fstruct=5Ffields=5Fend=60. You can find more inf=
ormation about the macro here: https://stackoverflow.com/a/72675757

Here is the unified diff that I'm trying to convert to a semantic patch:

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9ea614e09f56..c153abffd4c5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
=40=40 -1467,6 +1467,10 =40=40 struct task=5Fstruct =7B
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * New fields for task=5Fstruct should be a=
dded above here, so that
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * they are included in the randomized port=
ion of task=5Fstruct.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
+=23ifdef CON=46IG=5FKSU=5FSUS=46S
+=C2=A0=C2=A0=C2=A0 u64 susfs=5Ftask=5Fstate;
+=C2=A0=C2=A0=C2=A0 u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
+=23endif
=C2=A0=C2=A0=C2=A0=C2=A0 randomized=5Fstruct=5Ffields=5Fend

=C2=A0=C2=A0=C2=A0=C2=A0 /* CPU-specific state of this task: */

Here is the file that it applies to: https://github.com/devnoname120/kern=
el=5Fxiaomi=5Fsm6150/blob/fce5582771e1254af065aaa2778940659e246611/includ=
e/linux/sched.h=23L1470

I tried the following semantic patch:

=40depends on file in =22include/linux/sched.h=22 exists=40
=40=40

struct task=5Fstruct =7B
...
+=23ifdef CON=46IG=5FKSU=5FSUS=46S
+ =C2=A0 u64 susfs=5Ftask=5Fstate;
+ =C2=A0 u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
+=23endif
randomized=5Fstruct=5Ffields=5Fend
...
=7D

However I have the following error:

=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --linux=
-spacing include/linux/sched.h
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h
SPECIAL NAMES: adding u64 as a type
minus: parse error:
=C2=A0=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, charpo=
s =3D 194
=C2=A0around =3D '...',
=C2=A0whole content =3D ...

I also tried the following code:

=40depends on file in =22include/linux/sched.h=22 exists=40
identifier END =3D=7E =22randomized=5Fstruct=5Ffields=5Fend=22;
=40=40

struct task=5Fstruct =7B
...
+=23ifdef CON=46IG=5FKSU=5FSUS=46S
+ =C2=A0 u64 susfs=5Ftask=5Fstate;
+ =C2=A0 u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
+=23endif
END
...
=7D

But it yields the following error:

=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --linux=
-spacing include/linux/sched.h
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h
SPECIAL NAMES: adding u64 as a type
minus: parse error:
=C2=A0=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, charpo=
s =3D 209
=C2=A0around =3D 'END',
=C2=A0whole content =3D END

I'm not sure why I have this error and I couldn't find an answer after lo=
oking on the internet and reading the Coccinelle grammar.
Could you help me figure this out=3F


Thanks=21
devnoname120

--68617215_71f32454_1255
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div>Hello,</div>
<div>&=23160;</div>
<div>I'm trying to insert two fields inside a struct, right before the us=
e of the macro =60randomized=5Fstruct=5Ffields=5Fend=60. You can find mor=
e information about the macro here: <a href=3D=22https://stackoverflow.co=
m/a/72675757=22>https://stackoverflow.com/a/72675757</a></div>
<div>&=23160;</div>
<div>Here is the unified diff that I'm trying to convert to a semantic pa=
tch:</div>
<div>&=23160;</div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span>diff --git a/inclu=
de/linux/sched.h b/include/linux/sched.h</span></div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span>index 9ea614e09f56=
..c153abffd4c5 100644</span></div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span>--- a/include/linu=
x/sched.h</span></div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span>+++ b/include/linu=
x/sched.h</span></div>
<div><span>=40=40 -1467,6 +1467,10 =40=40 struct task=5Fstruct =7B</span>=
</div>
<div><span>&=23160;&=23160;&=23160;&=23160;&=23160; * New fields for task=
=5Fstruct should be added above here, so that</span></div>
<div><span>&=23160;&=23160;&=23160;&=23160;&=23160; * they are included i=
n the randomized portion of task=5Fstruct.</span></div>
<div><span>&=23160;&=23160;&=23160;&=23160;&=23160; */</span></div>
<div><span style=3D=22color:=23098658;=22>+=23ifdef CON=46IG=5FKSU=5FSUS=46=
S</span></div>
<div><span style=3D=22color:=23098658;=22>+&=23160;&=23160;&=23160; u64 s=
usfs=5Ftask=5Fstate;</span></div>
<div><span style=3D=22color:=23098658;=22>+&=23160;&=23160;&=23160; u64 s=
usfs=5Flast=5Ffake=5Fmnt=5Fid;</span></div>
<div><span style=3D=22color:=23098658;=22>+=23endif</span></div>
<div><span style=3D=22color:=23098658;=22><span>&=23160;&=23160;&=23160;&=
=23160;</span></span> <span>randomized=5Fstruct=5Ffields=5Fend</span></di=
v>
<div>&=23160;</div>
<div><span>&=23160;&=23160;&=23160;&=23160; /* CPU-specific state of this=
 task: */</span></div>
<div>&=23160;</div>
<div>Here is the file that it applies to: <a href=3D=22https://github.com=
/devnoname120/kernel=5Fxiaomi=5Fsm6150/blob/fce5582771e1254af065aaa277894=
0659e246611/include/linux/sched.h=23L1470=22>https://github.com/devnoname=
120/kernel=5Fxiaomi=5Fsm6150/blob/fce5582771e1254af065aaa2778940659e24661=
1/include/linux/sched.h=23L1470</a></div>
<div>&=23160;</div>
<div>I tried the following semantic patch:</div>
<div>&=23160;</div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span style=3D=22color:=23=
e50000;=22>=40depends on file in =22include/linux/sched.h=22 exists=40</s=
pan></div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span style=3D=22color:=23=
e50000;=22>=40=40</span></div>
<div>&=23160;</div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span>struct task=5Fstru=
ct =7B</span></div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span>...</span></div>
<div><span style=3D=22color:=23098658;=22>+=23ifdef CON=46IG=5FKSU=5FSUS=46=
S</span></div>
<div><span style=3D=22color:=23098658;=22>+ &=23160; u64 susfs=5Ftask=5Fs=
tate;</span></div>
<div><span style=3D=22color:=23098658;=22>+ &=23160; u64 susfs=5Flast=5Ff=
ake=5Fmnt=5Fid;</span></div>
<div><span style=3D=22color:=23098658;=22>+=23endif</span></div>
<div><span>randomized=5Fstruct=5Ffields=5Fend</span></div>
<div><span>...</span></div>
<div><span>=7D</span></div>
<div>&=23160;</div>
<div>However I have the following error:</div>
<div>&=23160;</div>
<div>=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --=
linux-spacing include/linux/sched.h<br />
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h<br />
SPECIAL NAMES: adding u64 as a type<br />
minus: parse error:&=23160;<br />
&=23160;=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, char=
pos =3D 194<br />
&=23160;around =3D '...',<br />
&=23160;whole content =3D ...</div>
<div>&=23160;</div>
<div>I also tried the following code:</div>
<div>&=23160;</div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span style=3D=22color:=23=
e50000;=22>=40depends on file in =22include/linux/sched.h=22 exists=40</s=
pan></div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span style=3D=22color:=23=
af00db;=22>identifier</span> <span style=3D=22color:=23e50000;=22>END =3D=
=7E =22randomized=5Fstruct=5Ffields=5Fend=22;</span></div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span style=3D=22color:=23=
e50000;=22>=40=40</span><br />
&=23160;</div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span>struct task=5Fstru=
ct =7B</span></div>
<div><span>...</span></div>
<div><span style=3D=22color:=23098658;=22>+=23ifdef CON=46IG=5FKSU=5FSUS=46=
S</span></div>
<div><span style=3D=22color:=23098658;=22>+ &=23160; u64 susfs=5Ftask=5Fs=
tate;</span></div>
<div><span style=3D=22color:=23098658;=22>+ &=23160; u64 susfs=5Flast=5Ff=
ake=5Fmnt=5Fid;</span></div>
<div><span style=3D=22color:=23098658;=22>+=23endif</span></div>
<div><span>END</span></div>
<div><span>...</span></div>
<div><span>=7D</span></div>
<div>&=23160;</div>
<div>But it yields the following error:</div>
<div>&=23160;</div>
<div>=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --=
linux-spacing include/linux/sched.h<br />
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h<br />
SPECIAL NAMES: adding u64 as a type<br />
minus: parse error:&=23160;<br />
&=23160;=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, char=
pos =3D 209<br />
&=23160;around =3D 'END',<br />
&=23160;whole content =3D END</div>
<div>&=23160;</div>
<div>I'm not sure why I have this error and I couldn't find an answer aft=
er looking on the internet and reading the Coccinelle grammar.</div>
<div>Could you help me figure this out=3F</div>
<div>&=23160;</div>
<div>&=23160;</div>
<div>Thanks=21</div>
<div>devnoname120</div>
</div>
</body>
</html>

--68617215_71f32454_1255--

