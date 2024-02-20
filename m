Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2980BC48BC3
	for <cocci@archiver.kernel.org>; Tue, 20 Feb 2024 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JnXtKHFoUFTL/BiULYHRDKYHVPj7qewbRtrtUnShqpk=;
  b=mZ6XgMUoc0j5VOXXKRh2TUYnme5TFxMoHaruqFvfAbDAenZQ4EIf+89w
   QAMc1ZTZllOqAM43Wd7+RwBk4zkCjPGXoiCG1PiAc7Dhxydb4Ce1nTLJk
   6hsEvFRlwEaOAe8dLlr+AKEJ2OxEy39ftGub3KSkQjQ2PGezvfr6uh0v+
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,172,1705359600"; 
   d="c'?scan'208";a="152889769"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Feb 2024 15:05:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 36514E0CD7; Tue, 20 Feb 2024 15:05:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D8B7E008A
	for <cocci@sympa.inria.fr>; Tue, 20 Feb 2024 15:05:37 +0100 (CET)
IronPort-SDR: 65d4b1b0_FG2Usz6A9sN2fJe9j+Q3ZHLjnRlmpatA7hOWpBFccFFGMPA
 +EmS9DO1X7LSMbkSEzKq6MDVGSQg2V/3UcDpyiQ==
X-IPAS-Result: =?us-ascii?q?A0FAAADHsNRlhwsR49RaHQEBAQEJARIBBQUBgXsIAQsBg?=
 =?us-ascii?q?jh8VjIEC0gEBIRLiB2HJ4F1LYQ+k3CEBYFWFIEsPggHAQMBDT0EAQIEAQEDB?=
 =?us-ascii?q?DcBBoFNgnSHZgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEjFwcOECeFbA2CVRiBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwINO?=
 =?us-ascii?q?moEGQEBESdcAgRtAgEBgnwBgioBAzEHDQavQH8zgQGCCgEBBoJnrHQfLCJWg?=
 =?us-ascii?q?VoHAwaBSAGICxoBBWWJaA+BVUSBFSeGBAeBPFSDRIJoghiDEimBJoFZMT0lh?=
 =?us-ascii?q?GxggkIBhz+GL4FwA4EFaxsQHjcREAUODQMIbh0CMToDBQMEMgoSDAsfBVQDQ?=
 =?us-ascii?q?AZJCwMCGgUDAwSBMAUNGgIQLCYDAxJJAhAUAzgDAwYDCjEwVUEMUANkHzIJP?=
 =?us-ascii?q?A8MGgIbGw0kIwIsQAMREAIWAx0WBDIRCQsmAyoGNgISDAYGBl0jBw8JBCUDC?=
 =?us-ascii?q?AQDKykDIXQRAwQKAxMHCwd6g0YEE0QDEIE0iiSBZQMZKx02CgIBC209NQkLG?=
 =?us-ascii?q?wZCnxcBggpyThQTGBdkCoFDL5JJH5B/ggyeEmw0B4I0gWAFgVwMhGWEE4Ejl?=
 =?us-ascii?q?R0GEy+XMQ4Gkl8uh1aQVYt4gXeVPBOFOYFkOoFcMxokgzYSAQwwAxkPjiAMD?=
 =?us-ascii?q?QmEC4RhimZCNQIBOAIHAQoBAQMJhUYBAYNaZ18BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NO98UaGhvZ6Woj5NpLqExMeALOsnbusQ8zAXPjNKOH5om62j+/
 xG+c5x6faaslgssR0b6LW90cq7IE80l6Qb3WB5B97LMTUO01HYSL2Kg7GSoAHIJw270PJB3q
 F9dKVEBMT3FkUSt7eC3OD1KbYdKMLsytHOuQ4y9QYKcengBpsL0ztE
X-Talos-CUID: 9a23:Xqz+sWFgoaou7lq1qmI86HBOB8QifUbbkkeXYEikKnR3E7iKHAo=
X-Talos-MUID: 9a23:M317nQtOvWgE+/q96c2ngBJOLuRNxvmSAUUirrss5dCDbhFSAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,172,1705359600"; 
   d="c'?scan'208";a="152889740"
X-MGA-submission: =?us-ascii?q?MDHSfrwX5jhcrjxmAvR7Yz48MyQe8Yl3665kdY?=
 =?us-ascii?q?aq97n5xTGq1RLTDPxiyEAJC57SkPa6ptqK4QnE0BLfDknec2L/uWFPr/?=
 =?us-ascii?q?BjfSutSyxyW/WSTijB7HH4xwWEWxNZok413169C/jFqoH0ulFNseXkIy?=
 =?us-ascii?q?0HCopV/aYX8cwaSPG4n9BIfg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:05:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708437936; x=1709042736; i=markus.elfring@web.de;
	bh=KpjXqCKyQklZbxdouEi6zKPqTc1cpWj5+cLK4ALMVzg=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=PFCO63fKshYAqz29x946JIoOn3XxcJPCnW2GaH784WYPDPlYp4o8/EGsv2YH6rKL
	 g1wAniPkKaLwyT4EaMLwwUIfH398kPAXpXWNtrZLCL+pGR3cpkRvdGykLWxbPTuRv
	 nHf3sZORGUFbBuH9CBLCWtGGEpHhH6ufkFs+BlQOAueCBb4W/3vkGWrvmXDXSUlGb
	 TEgjn5wl+9aUq+yAzE1EL7MHghXVpM8mLx3mP9UTdI0sfV49ye7G8mWWoLWrP749I
	 d7yL7wsiPdCvQt2xaHwtHUA7N5LEzVzo/P2drs2sloV01Y4FVybmuxOoHY+5fIYKe
	 DpXXW2DdC4WabZHJgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6YJ1-1raUoI480P-006sX6 for
 <cocci@inria.fr>; Tue, 20 Feb 2024 15:05:36 +0100
Content-Type: multipart/mixed; boundary="------------1CboMD3cvAYUymSOlDPJCeAj"
Message-ID: <755ceff5-2eca-433c-8cba-c0ac0d46b3fc@web.de>
Date: Tue, 20 Feb 2024 15:05:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
X-Provags-ID: V03:K1:pqQUYVdJ56Wk3ayasRGU/AuqkEqXrCNiRTCl+FnadWkk2s2LKon
 +ackCcs+gsBEywnhJvlxeUVTejW9NJb/mdn2VZyx2L2n1odI5W4Ei95zw4DweAMSvj9Npuo
 XTl3BLlgqGk0T8dDAnpECrxt5Tvc94sP4OQmYR71oP24+BJIYc60iUzdKqAM0Mg8acl1wAN
 /3pjGT3rxNAAZZgQTR6Aw==
UI-OutboundReport: notjunk:1;M01:P0:QEPeIY+Ued8=;T41New+KY/fly0L9HcXK3KlyZe9
 5s24NGGqC5kNSZh+qI4PeTFK9YQAKg6KAynlXjYgx4yvb2vGtz9QnjVJPj/Mutx8oog9auCke
 P/18txNjiYWdAMf/98WzyapNvE/PxH81veD4eb97AUYBul16eRJzMC4dejeuOKpRIornIiGLh
 MecMV3xA5zRXiT0S7Yd19SyXDm7tY6T6kBLDPOuJQw+9fNX94+8RigSi5772BhFFs+qFjVn5X
 KcziHvqqE45BcKlw4RNmnQvYx/aIgHJDCU44cdbKjXhWX71Yd6DcOY1LPb4md1eDMuQcUZHM0
 ZCp2tnMS+q0Vh833BUWj5OsnQF7YSNScSNUE2CZEsQR3dcVPR0bLkWb4HTJnwwwTvnZ1oY0Lf
 0mLptPu5XPCsLrDz38z+hE4E26+DH6CG8miQ3AZyTrEJrLG+oEqP5m1Y8aHvr02BX3yHnxB6X
 SLiLieLVOTNgNE+eEIGYMr0ebLW8jZYazYEESJbNv8gUqxh4fgB3srj1SdtQRzM/dSPq+gYVu
 4ukKoIvbCHit/FfRMNOiHBn3ryCr5hUpCGMbfpLK+kDUmVhzSuoKkjjWhFW+2ZbnuX7KBc4md
 WcjHCTInCtWCnKufkAlMxur0saCeAnC/TTf9SxKkPvyIStR6ymR2zEiJWqf17D2CPvRxCFWo+
 zAbwXOByqo12MMz/bSXMyH10ivv5LNCNROuYd2KIDJidA4bt2RPomFBwG+T2AETKueeb2hPn+
 /CSpPIlMq9TWKO07gT9vo26g0t10bRJzJ9qnIvGTMJJ984i3TfGhxZXm4p/xRh9WELeEEMe2X
 gCm/M1nBPl27IKQjqjK/IZyN4ZhnpAsmaQGO/KidBfghw=
Subject: [cocci] Moving fwnode_handle_put() calls to a single place with
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1589
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/755ceff5-2eca-433c-8cba-c0ac0d46b3fc%40web.de>

This is a multi-part message in MIME format.
--------------1CboMD3cvAYUymSOlDPJCeAj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I would like to achieve another known source code transformation
also together with the software combination =E2=80=9CCoccinelle 1.1.1-0073=
9-g68c580f1=E2=80=9D
for the implementation of a function like =E2=80=9Cpmic_glink_altmode_prob=
e=E2=80=9D.

Unfortunately, I stumble on the following test result for the attached two=
 files.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time spatch --ti=
meout 123 --show-trying pmic_glink_altmode-excerpt2-20240220.c ../janitor/=
adjust_exception_handling_in_pmic_glink_altmode-20240220.cocci
=E2=80=A6
SPECIAL NAMES: adding device_for_each_child_node as a iterator
=E2=80=A6
     trying function: pmic_glink_altmode_probe: pmic_glink_altmode-excerpt=
2-20240220.c:10
timeout (we abort)
Fatal error: exception Coccinelle_modules.Common.Timeout

real    2m3,829s
user    2m3,014s
sys     0m0,420s



Will there any further software improvements become possible?

Regards,
Markus

--------------1CboMD3cvAYUymSOlDPJCeAj
Content-Type: text/plain; charset=UTF-8;
 name="adjust_exception_handling_in_pmic_glink_altmode-20240220.cocci"
Content-Disposition: attachment;
 filename*0="adjust_exception_handling_in_pmic_glink_altmode-20240220.coc";
 filename*1="ci"
Content-Transfer-Encoding: base64

Ly8gU2VlIGFsc286Ci8vIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvbG9nL2RyaXZlcnMvc29jL3Fjb20vcG1p
Y19nbGlua19hbHRtb2RlLmMKLy8KLy8gW1BBVENIIDMvNl0gc29jOiBxY29tOiBwbWljX2ds
aW5rX2FsdG1vZGU6IGZpeCBkcm0gYnJpZGdlIHVzZS1hZnRlci1mcmVlCi8vIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNDAyMTcxNTAyMjguNTc4OC00LWpvaGFuK2xpbmFy
b0BrZXJuZWwub3JnLwovLyBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyNC8yLzE3LzI3OQoK
QHJlcGxhY2VtZW50QAppZGVudGlmaWVyIHJjOwpjb25zdGFudCBjOwpAQAogPCsuLi4KIGlm
ICguLi4pCiB7CiAgICAuLi4gd2hlbiAhPSByYwotICAgZndub2RlX2hhbmRsZV9wdXQoZndu
b2RlKTsKKAorICAgcmMgPQotICAgcmV0dXJuCiggICAgICAgICAgZGV2X2Vycl9wcm9iZSgu
Li4pCnwgICAgICAgICAgLSBjCikgICA7CnwKLSAgIHJldHVybiByYzsKKQorICAgZ290byBw
dXRfZndub2RlOwogfQogLi4uKz4KIHJldHVybiBQVFJfRVJSX09SX1pFUk8oYWx0bW9kZS0+
Y2xpZW50KTsKKworcHV0X2Z3bm9kZToKK2Z3bm9kZV9oYW5kbGVfcHV0KGZ3bm9kZSk7City
ZXR1cm4gcmM7Cg==
--------------1CboMD3cvAYUymSOlDPJCeAj
Content-Type: text/x-csrc; charset=UTF-8;
 name="pmic_glink_altmode-excerpt2-20240220.c"
Content-Disposition: attachment;
 filename="pmic_glink_altmode-excerpt2-20240220.c"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQovKgogKiBDb3B5cmln
aHQgKGMpIDIwMTktMjAyMCwgVGhlIExpbnV4IEZvdW5kYXRpb24uIEFsbCByaWdodHMgcmVz
ZXJ2ZWQuCiAqIENvcHlyaWdodCAoYykgMjAyMiwgTGluYXJvIEx0ZAogKi8KLy8gU2VlIGFs
c286Ci8vIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L25leHQvbGludXgtbmV4dC5naXQvbG9nL2RyaXZlcnMvc29jL3Fjb20vcG1pY19nbGlua19h
bHRtb2RlLmMKCi8vIGRlbGV0ZWQgcGFydApzdGF0aWMgaW50IHBtaWNfZ2xpbmtfYWx0bW9k
ZV9wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRldiwKCQkJCSAgICBjb25zdCBz
dHJ1Y3QgYXV4aWxpYXJ5X2RldmljZV9pZCAqaWQpCnsKCXN0cnVjdCBwbWljX2dsaW5rX2Fs
dG1vZGVfcG9ydCAqYWx0X3BvcnQ7CglzdHJ1Y3QgcG1pY19nbGlua19hbHRtb2RlICphbHRt
b2RlOwoJY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0Y2g7CglzdHJ1Y3QgZndub2Rl
X2hhbmRsZSAqZndub2RlOwoJc3RydWN0IGRldmljZSAqZGV2ID0gJmFkZXYtPmRldjsKCXUz
MiBwb3J0OwoJaW50IHJldDsKLy8gZGVsZXRlZCBwYXJ0CglkZXZpY2VfZm9yX2VhY2hfY2hp
bGRfbm9kZShkZXYsIGZ3bm9kZSkgewoJCXJldCA9IGZ3bm9kZV9wcm9wZXJ0eV9yZWFkX3Uz
Mihmd25vZGUsICJyZWciLCAmcG9ydCk7CgkJaWYgKHJldCA8IDApIHsKCQkJZGV2X2Vycihk
ZXYsICJtaXNzaW5nIHJlZyBwcm9wZXJ0eSBvZiAlcE9GblxuIiwgZndub2RlKTsKCQkJZndu
b2RlX2hhbmRsZV9wdXQoZndub2RlKTsKCQkJcmV0dXJuIHJldDsKCQl9CgoJCWlmIChwb3J0
ID49IEFSUkFZX1NJWkUoYWx0bW9kZS0+cG9ydHMpKSB7CgkJCWRldl93YXJuKGRldiwgImlu
dmFsaWQgY29ubmVjdG9yIG51bWJlciwgaWdub3JpbmdcbiIpOwoJCQljb250aW51ZTsKCQl9
CgoJCWlmIChhbHRtb2RlLT5wb3J0c1twb3J0XS5hbHRtb2RlKSB7CgkJCWRldl9lcnIoZGV2
LCAibXVsdGlwbGUgY29ubmVjdG9yIGRlZmluaXRpb24gZm9yIHBvcnQgJXVcbiIsIHBvcnQp
OwoJCQlmd25vZGVfaGFuZGxlX3B1dChmd25vZGUpOwoJCQlyZXR1cm4gLUVJTlZBTDsKCQl9
CgoJCWFsdF9wb3J0ID0gJmFsdG1vZGUtPnBvcnRzW3BvcnRdOwoJCWFsdF9wb3J0LT5hbHRt
b2RlID0gYWx0bW9kZTsKCQlhbHRfcG9ydC0+aW5kZXggPSBwb3J0OwoJCUlOSVRfV09SSygm
YWx0X3BvcnQtPndvcmssIHBtaWNfZ2xpbmtfYWx0bW9kZV93b3JrZXIpOwoKCQlhbHRfcG9y
dC0+YnJpZGdlID0gZHJtX2RwX2hwZF9icmlkZ2VfcmVnaXN0ZXIoZGV2LCB0b19vZl9ub2Rl
KGZ3bm9kZSkpOwoJCWlmIChJU19FUlIoYWx0X3BvcnQtPmJyaWRnZSkpIHsKCQkJZndub2Rl
X2hhbmRsZV9wdXQoZndub2RlKTsKCQkJcmV0dXJuIFBUUl9FUlIoYWx0X3BvcnQtPmJyaWRn
ZSk7CgkJfQoKCQlhbHRfcG9ydC0+ZHBfYWx0LnN2aWQgPSBVU0JfVFlQRUNfRFBfU0lEOwoJ
CWFsdF9wb3J0LT5kcF9hbHQubW9kZSA9IFVTQl9UWVBFQ19EUF9NT0RFOwoJCWFsdF9wb3J0
LT5kcF9hbHQuYWN0aXZlID0gMTsKCgkJYWx0X3BvcnQtPnR5cGVjX211eCA9IGZ3bm9kZV90
eXBlY19tdXhfZ2V0KGZ3bm9kZSk7CgkJaWYgKElTX0VSUihhbHRfcG9ydC0+dHlwZWNfbXV4
KSkgewoJCQlmd25vZGVfaGFuZGxlX3B1dChmd25vZGUpOwoJCQlyZXR1cm4gZGV2X2Vycl9w
cm9iZShkZXYsIFBUUl9FUlIoYWx0X3BvcnQtPnR5cGVjX211eCksCgkJCQkJICAgICAiZmFp
bGVkIHRvIGFjcXVpcmUgbW9kZS1zd2l0Y2ggZm9yIHBvcnQ6ICVkXG4iLAoJCQkJCSAgICAg
cG9ydCk7CgkJfQoKCQlyZXQgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCBwbWlj
X2dsaW5rX2FsdG1vZGVfcHV0X211eCwKCQkJCQkgICAgICAgYWx0X3BvcnQtPnR5cGVjX211
eCk7CgkJaWYgKHJldCkgewoJCQlmd25vZGVfaGFuZGxlX3B1dChmd25vZGUpOwoJCQlyZXR1
cm4gcmV0OwoJCX0KCgkJYWx0X3BvcnQtPnR5cGVjX3JldGltZXIgPSBmd25vZGVfdHlwZWNf
cmV0aW1lcl9nZXQoZndub2RlKTsKCQlpZiAoSVNfRVJSKGFsdF9wb3J0LT50eXBlY19yZXRp
bWVyKSkgewoJCQlmd25vZGVfaGFuZGxlX3B1dChmd25vZGUpOwoJCQlyZXR1cm4gZGV2X2Vy
cl9wcm9iZShkZXYsIFBUUl9FUlIoYWx0X3BvcnQtPnR5cGVjX3JldGltZXIpLAoJCQkJCSAg
ICAgImZhaWxlZCB0byBhY3F1aXJlIHJldGltZXItc3dpdGNoIGZvciBwb3J0OiAlZFxuIiwK
CQkJCQkgICAgIHBvcnQpOwoJCX0KCgkJcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0
KGRldiwgcG1pY19nbGlua19hbHRtb2RlX3B1dF9yZXRpbWVyLAoJCQkJCSAgICAgICBhbHRf
cG9ydC0+dHlwZWNfcmV0aW1lcik7CgkJaWYgKHJldCkgewoJCQlmd25vZGVfaGFuZGxlX3B1
dChmd25vZGUpOwoJCQlyZXR1cm4gcmV0OwoJCX0KCgkJYWx0X3BvcnQtPnR5cGVjX3N3aXRj
aCA9IGZ3bm9kZV90eXBlY19zd2l0Y2hfZ2V0KGZ3bm9kZSk7CgkJaWYgKElTX0VSUihhbHRf
cG9ydC0+dHlwZWNfc3dpdGNoKSkgewoJCQlmd25vZGVfaGFuZGxlX3B1dChmd25vZGUpOwoJ
CQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoYWx0X3BvcnQtPnR5cGVjX3N3
aXRjaCksCgkJCQkJICAgICAiZmFpbGVkIHRvIGFjcXVpcmUgb3JpZW50YXRpb24tc3dpdGNo
IGZvciBwb3J0OiAlZFxuIiwKCQkJCQkgICAgIHBvcnQpOwoJCX0KCgkJcmV0ID0gZGV2bV9h
ZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgcG1pY19nbGlua19hbHRtb2RlX3B1dF9zd2l0Y2gs
CgkJCQkJICAgICAgIGFsdF9wb3J0LT50eXBlY19zd2l0Y2gpOwoJCWlmIChyZXQpIHsKCQkJ
Zndub2RlX2hhbmRsZV9wdXQoZndub2RlKTsKCQkJcmV0dXJuIHJldDsKCQl9Cgl9Ci8vIGRl
bGV0ZWQgcGFydAoJcmV0dXJuIFBUUl9FUlJfT1JfWkVSTyhhbHRtb2RlLT5jbGllbnQpOwp9
Ci8vIGRlbGV0ZWQgcGFydAo=

--------------1CboMD3cvAYUymSOlDPJCeAj--
