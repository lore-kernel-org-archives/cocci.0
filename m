Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230A4CCA477
	for <cocci@archiver.kernel.org>; Sat,  4 Jun 2022 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8Cb4jJbLua0R34RMx3IOjc1BhHKPm3t+Lvy9o4RJOk0=;
  b=YCFRNTIWObXlSHxzufmxAC2rIeWBFHMeYxq7pQw9X51nhKm9ezbES5iv
   rrXIGnOCc8Qb3IYaCGLRwVkwFQs9zikHn4WCpgyDyzhIhXELkMriepiYE
   Ynuhmx2AbDW0K9XNx/LI/VkRCZgBBZDgsio1B+RyrqYSA83Y3gZE+U204
   A=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gatalith.at
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="diff'?scan'208";a="39502603"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Jun 2022 15:19:15 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2B783E02B4; Sat,  4 Jun 2022 15:19:15 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A4B12E007E
	for <cocci@sympa.inria.fr>; Sat,  4 Jun 2022 14:11:52 +0200 (CEST)
IronPort-SDR: D0rxraTOcN5vccRfFVIPQ2YXFm35iWZDX/+bUS4Vg0NpLO0fmVT+cAitvwDKZwMNg0RxkJDr/s
 41cVUsnkm72YXFymbPO37R9fddKJph8tEdPSDc2Kca1DXF8SEKUvDieMLqB6vivnKChzeWSwaf
 s0/AwbPglwsWwLxu0Nhde/N5KV+72R5J3aFoVsiIZDClnh3s2zHvTId/rvIq7a95o/YSeNVF7g
 4+vbP1I0fpOKAiiwB9jL1oka/SaE7DW8vuWeBV/OpaWtfPzJSA5/0pLWlvERFanxA28TWPzwo3
 baAV1pTXpCNFBzri36XZwopb
X-IPAS-Result: =?us-ascii?q?A0B4CQBMS5ti/0j1hC1aHgEBCxIMQIFEC4FSUgd5Vi0HC?=
 =?us-ascii?q?ESUEAEBB4xskzsLAQMBDTcIAQIEAQGFAoVIAh4GAQQzBg4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAGBCCBkaoFPgX8LAzENgjUihDIBASwMLkJgg?=
 =?us-ascii?q?n6DGAEOq3yBM4EBgggBAQaBPwGGHgcJgT2NaHonHH2BEIEUN4MygQUKgVMCg?=
 =?us-ascii?q?gAthW6XZQNJNBKBIUQtAQgGBgcKBTIGAgwYFAQCExJTHQISDAocDlQZDA8DE?=
 =?us-ascii?q?gMRAQcCCxIIFSwIAwIDCAMCAy4CAxcJBwoDHQgKHBIQFAIEEx4LCAMZHywJA?=
 =?us-ascii?q?gQOA0UICwoDEQQDExgLFggQBAYDCS8NKAsDFA8BBgMGAgUFAQMgAxQDBScHA?=
 =?us-ascii?q?yEHCyYNDQQjHQMDBSYDAgIbBwICAwIGFwYCAnEKJg0IBAgEHB0lEAUCBzEFB?=
 =?us-ascii?q?C8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY2GQEFXQYLCSEcKREFBhYDI?=
 =?us-ascii?q?3EFSA8pNTY9KJphggWiYJ8HghuBPYVygySCB5UkhUSjF5ZojS2Ua4UbgXcmg?=
 =?us-ascii?q?VlNODuCaAlFAQIBAQENAQIBAQMBAgEBAQkBAQEBjh0JDguBQUaBSYpgPzQ7A?=
 =?us-ascii?q?gYLAQEDCYVFAYpOAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:NSAsAakPbZmbYT2cdkbEGJvo5gwWIURdPkR7XQ2eYbSJt1+Wr1Gzt
 xJJXmmBOamMZjekKNwgao3n80oGvsDSm941HAdprns9QltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTrSs1hlZHWeIcg944f5Ys7N/09cAbeSRWVvX4
 4us+5GHYTdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /0Wsr3qSlYvNJf9v9UiUBUCDWJQN7d/reqvzXiX6aR/zmXJemflx/RyDAc/IeX0+M4rXCcXr
 qZecmxQKE/Z7w616OrTpu1EmcUxBMbiIIobu21gizjFZRojacmeEvybtIIBtNs2rt1pE/COS
 pEkUxxIbQbvXERRFnUtAatryY9EgVGlK2YF8Dp5v5Ef6G/Yxw1Zy6noKNOTe9qQRMwTkFzwm
 47d12vwHhgeNcCfjzOZmp6xugPRtXj8edgRRbuyzM9NsWKQyjYNSzMcT2Lu9JFVlXWCc95YL
 kUV/A8noq4z6FGnQ7HBYvGonJKXlkNFAYsBSIXW/CnclvuNu251E0BeFmYpVTAwiCMhbRAHv
 mJlcvvmDCBmtLyJSTSU6t94TA9e2wBJcgfuhgdeF2PpBuUPR6lp0nryoi5LSvLdszEMMWiYL
 vDjhHFWa08vpcAKzb6n2lvMniihoJPEJiZsuFiLBDL8tlkmO9L+D2BN1bQ9xakaRGp+Zgbb1
 EXoZ+DHs4ji8LnUzXLSG7tl8E+BuK3fa1UwfmKD77F7r2/woxZPjKhW7S11OV8hPcMOeVfUj
 Lz75mtsCV46FCXCUJKblKrqV5V7kPK6S427Ph0WB/IXCqVMmMa81HkGTSatM6rFySDASIkzZ
 sWWd9iCF3EfBfg1xTa6Xb5Eg7Ai2ik6xH/TA5nnlkz13b2bbX+TaLEELFrXM7Fmsvne/F2N/
 oYNLdaOxjVeTPb6M3ve/oMkJFwXKWQ2WMLtoMtNe+/fegdrQTlzC/LYzb47VZZimqBZyrXB8
 n2nAxYKx1PjjHnGNQXMY2w6MOHjWpN2rHQaOy0wPA/1iid9O9zztP8SLsJlc6Mm+epvye9PY
 8MEI8jQUO5STjnn+igGacivpYNvQx2nmAaSMnf3ezM4ZZNhG1TE99K4LAvi8C4CUni+ucck+
 uTy2QrHSJ4CWwQkBdqPMKCjyFa4vH48nuNuXhKVc4YNIh+wqNBne37rk/s6A8AQMhGSlDKV2
 jGfDQocueSQ8ZQ+98PEhPzcoor1QfFyGFFWQzvS4bqsbHCI8WO/yItBTObOdCyEDDH4/6CrZ
 ON0yfDgMaRazQkU6dAgS+5mnfAk+t/ih75G1QA1TnzEYmOiBq5kPnTbj9JEsbdAx+MBtAa7M
 q5VFgK25VlU1ALZ/F8tyM4NYe2f3PUVhjmU5OhdzIDS+nps5LTeOalNF0DktcCfBOId3EAZL
 SMJt8cK4gi+lhpsO8ruYuV86TGXNnJZO0k4nshyPWIo4zbHDnlNaIDVDi7q4NeGd72g96Xsz
 iC83ML/uliX+qYOn7ff25QAMSqxSKniYCx38WI=
IronPort-HdrOrdr: A9a23:OykCdao+4IHLgXHPbLu0wg8aV5oweYIsimQD101hICG9Vvbo9f
 xG/c5rtiMc7Qx6ZJhOo7290cW7LU80lqQU3WByB9aftWDd0QPCEGgI1+XfKlPbdBHDyg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="diff'?scan'208";a="15919951"
X-MGA-submission: =?us-ascii?q?MDElZ5Cu1kkKu4jlpLMPM2z9Yk17KCKqJNXSKl?=
 =?us-ascii?q?Fr0PIlfrHt2nsxBYPitAwODzdnDoiXkWMSc83hfJw3Jrv7xXBMaA0qCx?=
 =?us-ascii?q?cKCu6ISdzKHgvDkudqMH08R385qlB/2XEldGbiwAIoanrjTcLvNyqhys?=
 =?us-ascii?q?wsI2NSjFVfSRnHjW4W0IOdVw=3D=3D?=
Received: from gatalith.at ([45.132.245.72])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 14:11:52 +0200
Received: from yt.nih.at (2a02-8388-0bc0-8200-c43c-399e-1723-0e5a.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:bc0:8200:c43c:399e:1723:e5a])
	by gatalith.at (Postfix) with ESMTPSA id BA25A390A00
	for <cocci@inria.fr>; Sat,  4 Jun 2022 14:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatalith.at; s=dkim;
	t=1654344710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=8Cb4jJbLua0R34RMx3IOjc1BhHKPm3t+Lvy9o4RJOk0=;
	b=LSifT4BKLv4MAt8hwq9Pctbjp3A2q6J8YW2K6XtabvP3NonP+14HY3+QBP3FbSTznuR3+0
	wLEMVeXMR5SMNYdl8UGXZG5B1zxZxHQ2SkbMO7h3psgU2v+7Km1iaQpG2WLDc4CeekPe6i
	BW1OIb6kRLcrxvxA6VPBLoDb+O5M2Tg=
Date: Sat, 4 Jun 2022 14:11:49 +0200
From: Thomas Klausner <wiz@gatalith.at>
To: cocci@inria.fr
Message-ID: <YptMBWjnTCgTQJVD@yt.nih.at>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UYy3R/ATY6OyH/R6"
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] coccinelle PR#280: Fix unportable test(1) operator
Reply-To: Thomas Klausner <wiz@gatalith.at>
X-Loop: cocci@inria.fr
X-Sequence: 412
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/YptMBWjnTCgTQJVD%40yt.nih.at>


--UYy3R/ATY6OyH/R6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I've filed pull request 280 on github and was asked to present the
patch to this mailing list.

It fixes an unportable test(1) operator in the configure.ac script.

Cheers,
 Thomas



https://github.com/coccinelle/coccinelle/pull/280

--UYy3R/ATY6OyH/R6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test.operator.fix.diff"

commit 59466d94cbdf4d731106fe79379bdddfb4bcdb2d
Author: Thomas Klausner <wiz@gatalith.at>
Date:   Sat Jun 4 12:45:37 2022 +0200

    Fix unportable test(1) operator.
    
    Only bash supports '==', POSIX requires '='.
    
    Signed-off-by: Thomas Klausner <wiz@gatalith.at>

diff --git a/configure.ac b/configure.ac
index 0f314dd0..28f9cdea 100644
--- a/configure.ac
+++ b/configure.ac
@@ -331,10 +331,10 @@ AS_IF([test "x$enable_pcre_syntax" != "xno"],
   ],
   [dnl
     AC_CHECK_COCCI_EXTPKG([pcre])  dnl  will set $enable_pcre to 'yes', 'no', or 'local'
-    AS_IF([test "x$enable_pcre" == "xyes"],
+    AS_IF([test "x$enable_pcre" = "xyes"],
     [dnl
       AC_MSG_CHECKING([if pcre depends on bytes])
-      AS_IF([test "x`$OCAMLFIND query -r -format '%p' pcre 2>/dev/null | grep bytes`" == "xbytes"],
+      AS_IF([test "x`$OCAMLFIND query -r -format '%p' pcre 2>/dev/null | grep bytes`" = "xbytes"],
       [dnl
         AC_MSG_RESULT([yes])
         AC_MSG_CHECKING([if bytes is an actual module])

--UYy3R/ATY6OyH/R6--
