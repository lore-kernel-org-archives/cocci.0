Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58451EFCD73
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 09:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uRvzQkIdWQkYsC4UfK6eRjs3DcstWHMkhBDdXfdrisM=;
  b=c0aduGFBMH8wb8erbOXeKyAJcHtiZ4OB1otFLqlGU95kPB2YnV5b+F71
   L/9VJSORge/kyf3CkO/1tqRlmCeAI6sCctaGHcb0W2XMqdLO70DKZtnKM
   4osvMIRSbvd//WD61NvBGV1uB9jXnbJmKLU5qlvfT13HukXWRv/et0v60
   E=;
X-CSE-ConnectionGUID: 2068qQZDRwup9q3BUcES8g==
X-CSE-MsgGUID: cCwOJq78TESJlkpQSdivFA==
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266839714"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 10:49:32 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AA19581883; Mon,  9 Mar 2026 10:49:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 80E76838A2
	for <cocci@sympa.inria.fr>; Fri,  6 Mar 2026 00:20:18 +0100 (CET)
X-CSE-ConnectionGUID: 2ZwmYkMWToSl5cIKCon/OQ==
X-CSE-MsgGUID: A6WnaCTOSweYjW0TaFvlVQ==
IronPort-SDR: 69aa0fb3_7jGSBKon99AsEBzdqSCiRjWjZHCVlp9TuggFWyntQNLczH1
 RHzKyg2cbpe87RkFmUmeeZ6E6hRCDMvx+Apa6yA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FhAQDQDqppj/4EaaxagQmBUIJBgWYzBAtJhFiIe4ZYX?=
 =?us-ascii?q?AEGjTWGNIodgVWBfQIPAQMBDVEEAQEDBIUAjSICHgcBBDEIDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhk8NgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CDYEAJx0BATcBNAImAl4BgxSCIwdKA6wogTKBAYIMA?=
 =?us-ascii?q?QEGgmjZQoFnCRQBgQouiFQBhQB0O4NFgSEbfYEQhH2IHoJpgiaBDoomiQRIg?=
 =?us-ascii?q?QIcA1ksAVUTDQoLBwVeVTMDKgsSEhgVbjIdcDMSLA8IM1gbBwWFSg+Ic4Fig?=
 =?us-ascii?q?ROCdwMLGA1IESw3Bg4bBD5uB418PoI0gQ6DJsR2gT6EJqFxATOXUpMZLphYI?=
 =?us-ascii?q?qQ3hGiBagE3gVwzGggoCIMiTwMZD446iHrDCEI1PAIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:DVuXga8+Fj6iFW0fvSxcDrUDmXqTJUtcMsCJ2f8bNWPcYEJGY0x3y
 WAbCmDXaKnZN2Cne9p2ao6/oRkHv8WHm9VmGwQ5r3tEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjPzOG/ylTraZZ0idfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCROsMpvlDs15K6s4GhA4wRlDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9FIs+liLvybnoRSbfUOwWU4lIOM0R1qkUqSoQai87XBdJEAatlo23hc+NZl
 L2hgaeNpTIBZcUgrgiyvy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTjZtf2z8bGeddVrvcB+J+jIF4QZ/VZZmGSx4fYOGfgvQo3W4sUexzAtnMtDW/XTf
 cwUbXxodhuojx9nYwhNTstmwaH0wCOiL1W0q3rNzUYzy2HX3CRy3aLrPd6TfcaFLSlQthzG+
 D6Wrz+hUnn2MvS2lwWD+1mQodTQkBL5Z9ouHZOm8sBT1Qj7Kms7U0FJCQrq+pFVkHWWX9tAI
 kgQ0jgvqKIo/QqqSMP8Vlu2uhastRkXUNt4CPw/8AjLy6zO4g/fCHJsc9JaQMAhroktQiEw3
 VLPnN7zAzFr9rqPRhpx64t4sxvoCzcQHGwnWhMDdg9Y6PjAi4Y1yTX2G4ML/LGOsjHjJd3n6
 xujxBXSap0PitRNzKKm51vKxTGhvJ7ESkgy/Aq/soOZAuFRO9TNi2+AsAWzARN8wGCxEwHpU
 J8sx5n20Qz2JcvR/BFhuc1UdF1T2xp6DNEsqQUzQMVwpm/FF4+LdINZ5Th/bFtkOcYCfjvub
 07eoktQ4pQVVEaXgVtMS9vpUawClPG4ffy8D6C8RoQVOPBZKlTYlByCkGbMhAgBZmBwyvlnY
 f92sK+EUR4nNEiQ5GPoHbhHjuZznX5WKKG6bcmT8ilLGIG2PBa9IYrp+nPXBgzgxPLb+Ffm4
 JxEOtGUyh5SduT7b2OFucQQNF0GZzxzT5z/t8UdJKbJLxtECVMRLabb4YogXIh5wIVTtOPDp
 U+mVmFilVHQuHzgKCexUE5FVo/BZ5hFkC8EDXQeBmrwg3kHSqSz3ZgbbKoyLOUG9vQ87PtaT
 MslWsSnA9ZVeATl5gYicoT3965kVRW0hDChOziuTyg/cqVBGS3I2I7AVSn++BYeChGYsZMFn
 ISh8QfAULw/RwhGJ+THWsKFll+ekyAUp7NvYhHuPNJWRnTJzKFrDC7A1tkMPMAGLET49Auwj
 gq5L08RmrjQntUT7tLMuKGjqrWpGctYGm5xPTHSzZSyBBng0luT+61ye8fWQmmFT0LxwruoW
 stNxfKlMPEnokdDg7AhL5lVl5AB9/ndjJ4E6D97HUf7TUWhUZJhBXik4fNhlINwwp1hhA/nf
 X7Xp/d7P+2SNdLHAWwhAlMvTt6+2ME+nhjQ6vUII3vG2hJnwYrfUWtuEkmNrAd/MIpKNJgUx
 LZ9mcwOtC26pBkYEveHqSF2r27XD2ELCfR+vZQ8BKvulg4gzwxGa7eBFCTz65CrQPdPO3kMP
 TW7qvfjhbNd50yaaFs1NyHH8tR8jKQ0miJh7QE9NXXQvfSdnd4x/hla0QpvfzRv1h8djt5CY
 Dl6BXN6NYCl3mlOhvEae0uOBgsYJhmS2nKp+mszjGeDEnWZDD3cHlYcZ9SI0lsSqV9HXz5h+
 7qd9mbpfBDqcOz13QowQURVkOPif/Mg6jz9nN2bIOrdE6kYeTbFhoqcVVgMoTbjAuIzgxTjj
 stu9+BSd6b6FHAxp4sWNoqk7okTGSu0fDF6ffJc/a0yDT79fhO20mOwMEyfQJ5GCMHL1k6aM
 PZQAPxzeS6w7wu0lQBDN5Uwe+d1uNUL+Os9fqjaID9akrmH8RtsnpHi1gn/o24JWedes9sPF
 ZzMfWmgFE2RmnpmtGvfp+ZUOmeDQIclZS+t+MuX4ek2B5Y4n+U0Sn4L05ywpGSzDAtr2zm2r
 THzTfba4MI6wLs9gra2NLtIAjuFDO/aVcOKwViViMtPZ9aeCvX+nVoZhXe/NjsHIIZLfcp8k
 ImMl9vF3EnlmrISeEKBkrmjE5h53+mDbNB1AOnWckYDxTCjXfXy6SQt42q7cJxFsO1M7/mdG
 jeXVpGCSs43afx8mltudClsIzQMAf/Wb4Dhhx+HgdaiNxw/6THDffSbrSLHTGcCeiExbsi0T
 ke+vvu1/dlXobhdHBJOVbksH5Z8J0SlQqc8McH4sT6DFGSzn1eeof3YmAE97S3QQGyxeCogD
 UkpmjClHPhzhE3J8D2dm5B1pFsMC2tniuR2fU8H/dNyzTegAwbq6Ajb3YouUvlpfu7ajfkUp
 w0hqEMhBD/7UDACdg/ziDgmdhnKHfQAY78VORRwl355qE6K6EeoA7Z78CpkpXBsdVMPCQ1hx
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:I3HvzqP6NZxSfcBcTsijsMiBIKoaSvp037Dk7SFMoDhuA6ulfq
 GV7ZAmPHrP5Qr5N0tNpTntAsa9qBDnhPtICOsqTNSftWDd0QPCRr2KhrGD/9SPIUPDH5ZmpM
 VdT5Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AHpvQGmhELhANHEhiUN5+Y3XoSjJuKE/CyUbTBnC?=
 =?us-ascii?q?EDl1tFba0anSX/uRDqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AACSiRw70yacv+Q2mOVobpfLKxoxBvZuoAWsxtq4?=
 =?us-ascii?q?ZtviGCnRMMhmDiAqOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,103,1770591600"; 
   d="scan'208";a="266488308"
X-MGA-submission: =?us-ascii?q?MDGKNZHlGelqPIUnoyyVQIq+C/xeMhdtv/U/y0?=
 =?us-ascii?q?JOctzzFZUoQK8J+o173QAszesCTtNklkGAsjtAuvpzG7jt05/kWqzaW5?=
 =?us-ascii?q?vOxgZMmBypyyuquY1E5bKlbyZQOAQ33RmOBTwXuYs1hQHVGpNkGkisPm?=
 =?us-ascii?q?qoReY3GhW4RKd4qXM3PzCfNA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 00:20:18 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BED0F60126;
	Thu,  5 Mar 2026 23:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163C0C116C6;
	Thu,  5 Mar 2026 23:20:14 +0000 (UTC)
Date: Fri, 6 Mar 2026 00:20:12 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>
Message-ID: <cover.1772752564.git.alx@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v1 0/1] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3349
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/A_1V1QM-YxlM1QbMoscoeQ>

Hi!

This is a script to help find and replace uses of ARRAY_SIZE() to find
the end of an array (a pointer one past the last element).  We already
replaced some uses a few months ago, fixing some bugs while doing that,
and now I've written a coccinelle patch to do it elsewhere.

This is the first time I write a script under scripts/coccinelle/, so
take it with a grain of salt.  I've tested it, and I see no false
positives.  However, I've found several false negatives (for example,
in macros, or where the argument is a struct member).


Have a lovely night!
Alex


Alejandro Colomar (1):
  scripts/coccinelle: Add script for using ARRAY_END()

 scripts/coccinelle/misc/array_end.cocci | 93 +++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 scripts/coccinelle/misc/array_end.cocci

Range-diff against v0:
-:  -------- > 1:  f1c9dff5 scripts/coccinelle: Add script for using ARRAY_END()
-- 
2.53.0

