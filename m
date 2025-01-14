Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A82C02183
	for <cocci@archiver.kernel.org>; Tue, 14 Jan 2025 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Datn9phuFxk0kbjOypydb6XqNdPo6tslqy74qXkYuPY=;
  b=ROxyXwKxsX90TADyN2mvgcmn38eVCvX5cR6EDXpvhAE41rNQi08j2DwG
   dDrUq1ljKx7tHxPhCQNHZK7d31NAnyw1NYzkE9OsYg29TeqSGNmdKhc4R
   FLfkVUaGnW3t98E5qWCOV+V/CPEGqM9gMhCCHYfQ4LwMgdf9K4JNbPky/
   8=;
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
X-IronPort-AV: E=Sophos;i="6.12,314,1728943200"; 
   d="scan'208,217";a="203120659"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jan 2025 18:45:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 84F88E0D1D; Tue, 14 Jan 2025 18:45:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3E395E0077
	for <cocci@sympa.inria.fr>; Tue, 14 Jan 2025 18:44:26 +0100 (CET)
IronPort-SDR: 6786a279_e7rveI7fzxz4qgjT7MlES1uOoJPPjuOuS82Mo33TZILUuVw
 ZrWlSEcoXlh80LuvG64SWYSLiW4pVfJs2w0xfjg==
X-IPAS-Result: =?us-ascii?q?A0FPAgBcoYZng3yBCqpaglyCRIIKBAtIhFaBI44qjheLT?=
 =?us-ascii?q?4UAgVaBfg8BAwELAQFEBAEBAwSPdgIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAhABAQEBOQcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEXAg2BFhEEGQEBOB4BBjcCIxIBBQEiATSCX4JlA6YIAW6BBUKKQ?=
 =?us-ascii?q?wEBAXh/M4EBggwBAQbcH4FkCRSBNIhOAYFcAg6EOgmDOXonG4FJRIFKgkUBg?=
 =?us-ascii?q?j+GTIJpgjeETGeeTiYmAwcHDitJDgEhAyYzLAFVExcLBwWBcQECASw2MYFMe?=
 =?us-ascii?q?zmCDWlJNwINAjWCHiRYgiuEXIIYgi9HhA6FYoIUghGBdIIjHUADC2ILPTcUG?=
 =?us-ascii?q?0ycXYNxfBNDp22hA4QlBaFbM6pTmHwiqGECCgcGESOBSwsogVxNIxVsBoIwT?=
 =?us-ascii?q?wMZD446g2G+SiU1PAIHAQoBAQMJj2KBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gBxBM66dakp1Kp0aVgPXwFXXdLJyesId70hD6qkRc20qTiX8ra
 uTdZsgpHnJYVoqKRYdcLO7Sc29qBHnhOZICOAqVN/JMzUO01HYV72Kg7GSuQHIKmnR8qpz2a
 98b7NzErTLfCFHpPe/zg39PdhI+rm6GWOT5Ns2DU0CceinUdAD0+/VYTz3LmRGAC1HAZYyHI
 CAou5pjX6JV1pSTunTPBU4dtmGg93OmJjvewNDIzEMrDC0qxntyJOSKWnl4v+YOAk/vovLJQ
 P+4nHED2yYwpLLryPh6w==
X-Talos-CUID: =?us-ascii?q?9a23=3AxBsfbWqxBvHLDDC+BzQbkZPmUZ8aUHPMkHrcH2W?=
 =?us-ascii?q?pEmxSc+C4ZWW205oxxg=3D=3D?=
X-Talos-MUID: 9a23:4bwtyAVweEARi2Hq/GH2iSNHbZ542I6jLmoQrNINsZWeBRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,314,1728943200"; 
   d="scan'208,217";a="203120467"
X-MGA-submission: =?us-ascii?q?MDEr5N7EvMztABItqvUoCCMPjy/S4ga2Nf5HAp?=
 =?us-ascii?q?MlaPUQ1YrTibubOneO1gK/OLYZzKKkd8ZIzYSOf1GQ+nElHZ36f9J3VZ?=
 =?us-ascii?q?rvg86ZZdJnx7Q4t6W3rXX+fTUJ9X3hJ6sapDaeTJsJAuErv/7xHHScAq?=
 =?us-ascii?q?/Doqignj72xAdLJX0R1slkXg=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 18:44:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736876664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Datn9phuFxk0kbjOypydb6XqNdPo6tslqy74qXkYuPY=;
	b=BxWNa2ke47ntKA1RLAYvns6A4JzTTak081ryLzCHYsbkAhqSkMiqjnaarcYeTJFXZDbRJx
	89gdZM/UKenuAquIODECh2Tc0v1HdlFBxDNNEn4YiIG6DgYpXKLRuNfBhtHOoyhRB+9jvb
	4i8XsSNLif6IlHiVnF+A8GqF8qAwSBU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-0xa59UE7OkmWLNqj8-ygXQ-1; Tue, 14 Jan 2025 12:44:22 -0500
X-MC-Unique: 0xa59UE7OkmWLNqj8-ygXQ-1
X-Mimecast-MFC-AGG-ID: 0xa59UE7OkmWLNqj8-ygXQ
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e549e7072fbso10890701276.2
        for <cocci@inria.fr>; Tue, 14 Jan 2025 09:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736876661; x=1737481461;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Datn9phuFxk0kbjOypydb6XqNdPo6tslqy74qXkYuPY=;
        b=O8bSVkj0UPS7365b/nlfSb7Lj7511jyAK4icPWx3gG1Nx1fr9Vh/HwENJSQK1mWEcT
         5zSSsyT12hxZfZ+qQT9nggAYnpfdWrWyhcilKJbu2uKZdyxLPJJcrbBSps1sO3eUDcxD
         0Nbg7CpfuryPvoXevBqaXNdFJVOS6WWLPNoDlSLL5VYDyBUKvWKLj+AJ06b77UaTpg+k
         HuskjKhlkYrGmUXgCOEIgc70UilDClg5SSmjRA0/wQBN21EO0G8NHn6s5QxjnW0Vx1PI
         GP5Upv4zhXDrnyp3huPteLndK8KKsqgXqBsC1fobspju9qDE0Ncu9YZGwyLzAR2+1Rk6
         45tg==
X-Gm-Message-State: AOJu0Yw8J4x3D+921Xcs+MQQ+1WlBnV7b14UzSeJVaYBOXvywtX+Yvuo
	xE9IDIoawGESOnmvCM+8S3x6H+FhPvsLl1mHjyv5EnxZTrt9sbn9rZS+ItBK0Z95NiRJQt2Ytsk
	WPAbPgNOCQ7FRrJx9kAFc07uLpt88r/ZAeRJb581PA+CQ1dvrkYviBvFmFJKcflKFz5/8H94kmy
	y0p7aax+KBJIQFPUsxQTrGEVv8OxG1
X-Gm-Gg: ASbGncuRg/un4a2KFTdh9F1Dlz7E/5phqC/rfbpOuZAsZ671835ydyeb+4e94s6Bp1P
	eg6Hs53+xmwDUr/5mo3r9TApM1dtaUVWhao33
X-Received: by 2002:a05:6902:91f:b0:e3c:7c3f:253a with SMTP id 3f1490d57ef6-e54ee2127abmr16128490276.36.1736876661045;
        Tue, 14 Jan 2025 09:44:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0tWQXeWcIbEV4B2/HIZJn/V46s3d29VJ436dRmDcU0SSVCTMjuIkuIMf/9WWKETHnq7GCRqnEKF1Rx3avpk0=
X-Received: by 2002:a05:6902:91f:b0:e3c:7c3f:253a with SMTP id
 3f1490d57ef6-e54ee2127abmr16128472276.36.1736876660823; Tue, 14 Jan 2025
 09:44:20 -0800 (PST)
MIME-Version: 1.0
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 14 Jan 2025 11:42:50 -0500
X-Gm-Features: AbW1kvapsbD8n6QDRh6hcsf0yLb69Ie0itJWA-Wen-Wbwp98dDFI7xU8cGjHGoY
Message-ID: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com>
To: cocci@inria.fr, Maxime Ripard <mripard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 92gapidu2va8q58M385VnNlyni4h5IfuW9OQfXkvImo_1736876661
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000063306b062bae1cc0"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Ellipses usage in line addition
Reply-To: Anusha Srivatsa <asrivats@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 2204
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ%40mail.gmail.com>

--00000000000063306b062bae1cc0
Content-Type: text/plain; charset="UTF-8"

Hi all,
Wanted to know if ellipses usage is not allowed in the lines that we want
to add in the code. To be more precise,I want to replace
mipi_dsi_generic_write_seq() usage with mipi_dsi_generic_write_seq_multi()
. the coccinelle semantic patch that I am using is:








*//rule_1
->s/mipi_dsi_generic_write_seq/mipi_dsi_generic_write_seq_multi@@identifier
dsi_var,dsi_device;@@struct mipi_dsi_device *dsi_var = dsi_device;+struct
mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var
};...-mipi_dsi_dcs_write_seq(dsi_var,...);+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);*

this throws:




*init_defs_builtins: /usr/lib64/coccinelle/standard.hlexical error: invalid
in a + context: ...  File "mipi.cocci", line 9, column 39, charpos = 298
around = '...',  whole content =
+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);*

Just commenting out the function replacing the snippet (i.e having only
dsi_ctx being populated) works just fine. But the intended change is ofc
the proper usage of the _multi API.

Would be nice to know what is going wrong with this approach.

Regards,
Anusha

--00000000000063306b062bae1cc0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi all,</div><div>Wanted to know if =
ellipses usage is not allowed in the lines that we want to add in the code.=
 To be more precise,I want to replace mipi_dsi_generic_write_seq() usage wi=
th mipi_dsi_generic_write_seq_multi() . the coccinelle semantic patch that =
I am using is:</div><div><b>//rule_1 -&gt;s/mipi_dsi_generic_write_seq/mipi=
_dsi_generic_write_seq_multi<br>@@<br>identifier dsi_var,dsi_device;<br>@@<=
br>struct mipi_dsi_device *dsi_var =3D dsi_device;<br>+struct mipi_dsi_mult=
i_context dsi_ctx =3D { .dsi =3D dsi_var };<br>...<br>-mipi_dsi_dcs_write_s=
eq(dsi_var,...);<br>+mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,...);</b></d=
iv><div><b><br></b></div><div>this throws:</div><div><b>init_defs_builtins:=
 /usr/lib64/coccinelle/standard.h<br>lexical error: invalid in a + context:=
 ...<br>=C2=A0 File &quot;mipi.cocci&quot;, line 9, column 39, charpos =3D =
298<br>=C2=A0 around =3D &#39;...&#39;,<br>=C2=A0 whole content =3D +mipi_d=
si_dcs_write_seq_multi(&amp;dsi_ctx,...);</b></div><div><br></div><div>Just=
 commenting out the function replacing the snippet (i.e having only dsi_ctx=
 being populated) works just fine. But the intended change is ofc the prope=
r usage of the _multi API. <br></div><div><br></div><div>Would be nice to k=
now what is going wrong with this approach.</div><div><br></div><div>Regard=
s,</div><div>Anusha<br></div><div><br><br></div></div>
</div>

--00000000000063306b062bae1cc0--

