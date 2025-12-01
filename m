Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF79D116F1
	for <cocci@archiver.kernel.org>; Mon,  1 Dec 2025 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:message-id:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=z/QPRrUyXMJo/q64cvzxBo6SwO93TUdX7KUC2vtbxY8=;
  b=hIt4RoZ4+RmWwVBiFwTwqlPwNjaPrmdl/EWVIFpg7h6yxR/LhvGgrOPm
   1hTSb07N5cQTk/xeBDw2QARZdsOOLCp4ERRoBKwTVE9qPByaLVnMbYII1
   i+12INT8fwBY54rDlcocYlKDARsrTAttTFrK2bSz0OIEp/0bLNbJINWpX
   0=;
X-CSE-ConnectionGUID: SoPSLTnLSpyZ/dWSbYZxBw==
X-CSE-MsgGUID: AzkRouu+TaKSgXfXx+3/tg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@posteo.de
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="252166243"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Dec 2025 16:28:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BC94DE0157; Mon,  1 Dec 2025 16:28:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A8F9E0157
	for <cocci@sympa.inria.fr>; Mon,  1 Dec 2025 16:28:39 +0100 (CET)
X-CSE-ConnectionGUID: S0euQpbpSJyaRD5dhC3x1A==
X-CSE-MsgGUID: 6ltQheI8QjSN9R0XAgXdCQ==
IronPort-SDR: 692db427_VtYA3GyHxWTn4DI1EQcs1PIyEX3LfzT4nqTFPMKIFPJ+qpo
 7c7MaezkRJ4vVaZ0QeckWSUfJvFA93MXi5NLRxQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G8AgDCsi1pg0EkQ7lagQmEEIECXjMHCEkIjUiJDZIGj?=
 =?us-ascii?q?gIPAQMBDUQLAgQBAQMEgUyDNIxnAh8GAQQ0EwECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEFAQEBAgEBAgQGAQIQAQEBATkHDjuGTw2CW4EsgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEXAg0fP14CBgEBOIFXgnoBgiICTwcBDAazN4E0gQGCDAEBBoJo2?=
 =?us-ascii?q?T2BZAMGgUqFboJlAYsND4FVRIQOb4JhAoF1OIV3giaBDoYkgnCQPSyBHhwDW?=
 =?us-ascii?q?SwBDxE1ExcLBwWBYwOBCzI8Mh2BIz4Ycz1Xg0kjZw8GgRGDT4kYD4pPAwsHZ?=
 =?us-ascii?q?j03FBsGAgGBNZQRUIIoB4EOLCClX4E2oUU0B4I4gWeBXgYMii6VQRIcF5dgk?=
 =?us-ascii?q?wuZBo4ImzmBfyMugS5NJIM2TwMZD44tDQmDXjPEfEM1PAIHCwEBAwmFaROMI?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RzyOpE9A/Rp/qxUeA==
IronPort-HdrOrdr: A9a23:1wxnZ6i6Nq+DGTdi4FPndnuhF3BQXscji2hC6mlwRA09TyX+rb
 HKoB17726XtN91YhsdcL+7V5VoLUmzyXcX2+Us1NWZLWrbUQKTRekIgLcKqAeBJ8SRzI9g6Z
 s=
X-Talos-CUID: =?us-ascii?q?9a23=3AF22Nvmokab7MteB5B4ldH3zmUft9f2Dk1H3IGG2?=
 =?us-ascii?q?pAFxFFbGVYgSAoYoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AKlmfUQ0QCMi+3x+AmLNxVs1WhjUjvaCyMUAAsMU?=
 =?us-ascii?q?/ufKiZBYoCx6SvDice9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="132446275"
X-MGA-submission: =?us-ascii?q?MDEqid+yj+GjYxAM8lYFSm/2VVTaUh3FKpnjqr?=
 =?us-ascii?q?PXsjE4WTm6jnK727u0Kf96buCid/3TTISZ+GpB6bhhsCsoFkfNcBbylp?=
 =?us-ascii?q?5SNLijYvK7+FMTANYV+JlQE4Cus6IP7kZsA4bUtWd0Sxvwv+FxLsJNU/?=
 =?us-ascii?q?3myctglfexv/BjtVwVXKQ6nQ=3D=3D?=
Received: from mout01.posteo.de ([185.67.36.65])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 16:28:39 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 43B44240027
	for <cocci@inria.fr>; Mon,  1 Dec 2025 16:28:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764602917; bh=z/QPRrUyXMJo/q64cvzxBo6SwO93TUdX7KUC2vtbxY8=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=f80cBJEK9BVFdfdJ+tAMPyJlycbWN6cyTOzyR76Iz9tNOrEUskTOULyoE3vBiuz2A
	 UfO7pTTYHc+tc7FcCy4Lzzz3dUaOQSh7cytN28JOIvixE1GrZ2UOW94a1PUHfUb9pa
	 sTcGZ7WNaX6fg8DvCtOdKcEMmQa53kzceubVaoAQJN5RVmCBYpgRu48USFYZJnAmdY
	 kaO0Dn9oYCI7NR6q/i6k/2y9aq0Pa1FgiLr6bUnjd+W0CsdHMcAkV/T1neb+1vued8
	 vagUV99mPEGJhScZb3E6Hjf+r6JKue22HtcTG9IGtrNPSmQH1f6M9OoepsLAosLNq7
	 dhy9R8WrRpRaQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dKnqS4BqQz6tx2
	for <cocci@inria.fr>; Mon,  1 Dec 2025 16:28:36 +0100 (CET)
MIME-Version: 1.0
Date: Mon, 01 Dec 2025 15:28:36 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
Message-ID: <7bb043f9fd00c7e20ebc75353e697a51@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: [cocci] bug: Matching a specific declarer actually matches any
 declarer
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3229
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/7bb043f9fd00c7e20ebc75353e697a51%40posteo.de>

Hi,

to reproduce the issue, try mutex2.cocci from coccinellery [1] with the 
code below.

Expectation: Only spin_lock calls where the variable was declared with 
DEFINE_MUTEX() are patched.

Actual: The declarer name seems to be ignored. All spin_lock calls are 
patched, regardless of the declarer name

// mutex2.c
DEFINE_MUTEX(my_mutex);
OTHER_DECLARER(other_mutex);

void main() {
     // this should be changed, declarer was DEFINE_MUTEX
     spin_lock(&my_mutex);

     // this should not be changed, declarer was OTHER_DECLARER
     spin_lock(&other_mutex)
}

// mutex2.cocci
@def@
declarer DEFINE_MUTEX;
identifier m;
@@

DEFINE_MUTEX(m);

@@
identifier def.m;
@@

(
- spin_lock(&m)
+ mutex_lock(&m)
|
- spin_unlock(&m)
+ mutex_unlock(&m)
)

The unexpected result:

$ spatch --sp-file mutex2.cocci mutex2.c
init_defs_builtins: /usr/lib/coccinelle/standard.h
HANDLING: mutex2.c
SPECIAL NAMES: adding OTHER_DECLARER as a declarer
diff =
--- mutex2.c
+++ /tmp/cocci-output-71243-6eaa4e-my.c
@@ -3,8 +3,8 @@ OTHER_DECLARER(other_mutex);

  void main() {
      // this should be changed, declarer was DEFINE_MUTEX
-    spin_lock(&my_mutex);
+    mutex_lock(&my_mutex);

      // this should not be changed, declarer was OTHER_DECLARER
-    spin_lock(&other_mutex)
+    mutex_lock(&other_mutex)
  }


Could you confirm, and maybe suggest a workaround? I used the 
coccinellery example as reproducer because it's public, but actually 
stumbled upon the issue in a simpler case: I searched for all 
occurrences of DEVICE_ATTR_RO(attr) in the Linux kernel, but actually 
found every place where *any* macro was used to declare something.

Cheers
Tobias

PS: I'm using spatch 1.3 from Debian trixie.

[1] 
https://github.com/coccinelle/coccinellery/blob/master/cris/mutex2.cocci
