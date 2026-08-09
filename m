Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D537C5DF81
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=h8lW4W332DtSVDSz/dr4gcyaJXuSGVqZYaGIa/fIcrg=;
  b=qNqoD8RhCTG0AbOyAxoaIwYZfNoU+YfmwvubFh1EAF1yj/Pbn8Y3kaKo
   Uy2mCQRbADCLetrPessigw9oFyN/3MnzskYdjOi0gPPF3gNuj24K0wumH
   Yy436G6InuZ9t8q0oj/ydhmm//wPaiYCHkCGTCG/sb6iqUZtCpWmYF54H
   0=;
X-CSE-ConnectionGUID: WG7BW6VmQdyh4jY5RT5KXw==
X-CSE-MsgGUID: OGPgKeQZRFaR4UaMQusXVA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; 
   d="scan'208";a="291206668"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:34:57 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CB53781657; Mon, 24 Aug 2026 09:34:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 458F480514
	for <cocci@sympa.inria.fr>; Sun,  9 Aug 2026 06:53:45 +0200 (CEST)
X-CSE-ConnectionGUID: 6+Yp0anPRzuA4pXGDCjX9Q==
X-CSE-MsgGUID: fuqtJb1PRI+4YLRp2edxyQ==
IronPort-SDR: 6a7807d8_01CZqWxbBf49sCXDDzcB2irSnkpoeeG5gzD/2/F+HWd9tm9
 OS/43FQOFBwWhB1Pn3cXlcVmWuWh/fkHFXVCDBw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EQBwB2B3hqfLLWVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHUwOKTIE/PQIPAQMBCwEBTwIEAQEBAgSEfo1pAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOEimGTw1JARABB?=
 =?us-ascii?q?AEBggGBJWECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQIsYSsLAQ0BGx0BAxIQWwIRAQUBIgESgwKCIwEGEAEDNwIBt1aMcBYFA?=
 =?us-ascii?q?haBAYINBoJq138KGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO4UjhHiBIYEYg?=
 =?us-ascii?q?RCEfoIfgjmGMASDLpJlAQcHHxIIARwGCAICSBUSAwQDBAQBAgsTCQMDAg4CC?=
 =?us-ascii?q?AMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEisKAyoLEg8DDQYFFQEIBgICB?=
 =?us-ascii?q?AQCBAwCCQICBQMEAgQNAwQBAQgCAi0DAQMZCAkIAgsFERgMCwcxAxAJAx8DF?=
 =?us-ascii?q?BwIRQgGFgEaBwUGCzcVBQwRAQIbAiAEHREIAwEbBAIBCQMBAwEVBAIUDhACE?=
 =?us-ascii?q?i4LAwIMAgkIDBcCAgIGAgMDAwoBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDA?=
 =?us-ascii?q?wMFAgIKBgkBAQEBAwICCAMHAwoJAgUDGwMbBQECAgMCAQIHAwcIAw0DBAIDA?=
 =?us-ascii?q?wMEAQICAQEBAgMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDBQMDBQUCAgUFAwUCA?=
 =?us-ascii?q?goCAwMDAgEDAhwIAwYDEAEQAwMGAQMHAwcCBAMJAggDAwgIAxcDAwUBAgIEA?=
 =?us-ascii?q?wMICAQDAwQCAgMMBQMCAwMFAwMHAgQCBAMDAQUBAgcCAwcCARgDAgQIBwcFA?=
 =?us-ascii?q?gsEAggEDQkEAgQCAg8EBgMDBwEBAgEHBQYDAgIRBQgKBQYCAgIcAx0BAw8GA?=
 =?us-ascii?q?QkFAgEFDgcFAgIYAwYCAwYFAQMBCgsBAQIDCgECBAIFAwMBAQMCAwIGAwMCB?=
 =?us-ascii?q?QUFAwkHBQwFCQEDAwYFAgMCAwIDAQIIBAYFAwQCAgMDBQEEAgMDBAMIBwUDA?=
 =?us-ascii?q?wUCCAMDCQMDCwICIAIFAwMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDB?=
 =?us-ascii?q?gEDAgEDAwgLFSUDAQUDAwIBAwIFAwMYAgIEBQMDAwMDAwgEAgIBBwYEAgICA?=
 =?us-ascii?q?QUFBQQDBQYCBAMIAQEFAwMFCA0BAgcMAw4GAwcDAwQEAwIFDAIDBAEHCgcHC?=
 =?us-ascii?q?wkIBwwBPAwHCiQEBAwqARQUBQQlGWcHBwKNdiGCRQGBDoN6AQEBkhqSNKAhS?=
 =?us-ascii?q?R4JAQYCYYFngQoVCi+bX4V8GjOXU5MYAS6YWiORcJJHhD4CCgcHESQSgTI6g?=
 =?us-ascii?q?VwzGiOBAW2BSVADGQ+SI8woNTU9AgcCBw4DC4VeiSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
 guNnzYFc28JBaJCShdC+UY0OuDGxCXlgeYrFw==
IronPort-Data: A9a23:+rlCaKOl/1DRuxfvrR1Uk8FynXyQoLVcMsEvi/4bfWQNrUpx0mQOm
 DceCG+OOfreYDejLYhwPdvl8UoPsZLVn9NqSAZtpSBmQlt09fbIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVqicfHw3HVY6IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bNNwRcawr40Ird7kky1BjOkGlA5AJmNaga5Aa2e0Q9VfrzG4nhdxMUfaEPRoZWd
 86bpJml82XQ+QsaC9/Nut7Tbk0QT7fOChOFg3xQVrLKqkAqSvsaj87XnNJFAatmo23hc+JZk
 b2hhrTpIesdBZAgrcxBO/VuO3EnbPceoNcrFlDk2SCb5xWun3IBWJyCBmluVWET0r8f7W2ja
 ZX0gd3CB/yOr7ve/V61dgVjrppgHdGzNYUngGN95G3BPdkKapLzEpyfsLe03B9o7ixPNfPXZ
 s5ccT42KRqZPE0JNVAQB5Yz2uyvgxETcRUC8APT9fdxuTGPilUugNABM/KNEjCObchWkEiF/
 DqepzWpKh4fPd2bjzGC9xpAg8eVzXKmB9tJSuPQGvhCjkCK2k4ZUSUsdBjnkN2DkhSzV8JOE
 hlBksYphfNvrRT0H4eVsweDiHWDtRUdc8FBFvUzrgCL0KvdpQiDblXoVRZEYd0i8dcyHHkkj
 wDZ2dzuAjNrvfueTnf1GqqoQS2aZ2skNTcLYxc+XxYsv8HTj60YjCKed4M2eEKqteEZDw0c1
 NxjkcTTr7AajMpOz6HiuF6e3GLqqZ/OQQo4oA7QWwpJDz+Vhqb0OuRECnCCsp6sybp1qHHf5
 BDofODAtYgz4WmlznDlfQn0NOjBCwy53MLgba5HRMR4r2v8pRZPjKhf5zZxIEohM8APP1fUX
 aMngisIvMU7FCLyM8dfOtvtY+x0l/SIPYq+DZj8MIEeCqWdgSfdoEmCk2bKgji1yCDBUMgXZ
 f+mTCpbJS9LUfU/kWfuG7p1PH1C7nlW+F4/jKvTl3yPuYdyrlbMIVvcGALWM7Br37DOuwjP7
 ddUOu2DzhgVAqW0YTDa/cRXZRoGJGQyT8K+4cFGVP+xEiw/EkEYCtjV3ewAfa5hlP9rjevmx
 Cy2dXJZ71vdvkf5Dzu2REptU57ReKpujGkaOHUsNGm42nJ4boeI6rweRqQNfrIm1bJCyKd0R
 sYaZ86vHeRrdQXX3SYScKun/ZJQLgSvoQeoISCeQSMeeqR4TFfj4e7UfQrI9QgPABGotMA4n
 aaS6wPDTbcHRCVgFMzzetv163+Q5F8zwPlTWWnMKfltIHTcypBgcXHNv6VmMvMyJgXm7RrE8
 QSvWDMzh/TH+q0x+/n33ZG0lZ+jSbZCLxALDlvgzOiEMAfB9TCe2q5GauGDeA7dWE7S+KmPY
 eZ0zen2AMYYnWRl4pZNLLJ28Z0Qv9ffhadW7gBBLkX5a16GDrBBIH7f+eJtsqZL5KFSuCroe
 0ap1+RZB460O5LeIAZMHDYmU+WN7uFLuz/w6f9uHl72yhUq95W6UGJTHSK2tgpjEJVPPrgI+
 9wR4Pwt11Tniz4BEMq3sSRPxmHdcl0CS/oGs78ZMq/Kiy0q6FVLO67ZBhPX/7SjQohrH2MsK
 AC6nKDp2rZWnBLDV1ERFnH9+/VXqrpTmRJNzWJYCUm7i4PktMBmwTx86TA9FFhUwC5Y0ul1B
 HNZCk1tKYiK/BZqnMJmXV3wPy1wXzqi5V3XyXYSsX/wFnmTSW3GKVMiNda3/Ew293xWeh5Z9
 uq6zFnJfCnLfsbj+DkbQm9g9uLeSOJu+j34mMyIG9qPG784a2HHho6sfW85lAv1M/guhUHop
 fhYw8goUPfVbRUvmqwcD5WW8Z8ySxrefWxLfqxHzZMzRGrZfGm/5CiKJ0WPYfhyHv3t83KjK
 slQN8lKBgWf1iGPk2ghPpQyAYRIxdwn2NlTXYnQBz8ik6CepT9Xop7v5nDApGs0ce5Pz+c5C
 K3sLgynLELBq0dQqWH3qOt8BlGZevgBPQ314/C0+r4GFrUFq+BdTnsx2bqV4VSQDhFV+iDNm
 QHqeIr6zLBb5ohwrrToCYFGIRu+EvLodeGy6Avomc9/XdDOFsbvtg0utVjsOTpND4YRQ9hak
 besssb9+UH44JIaYjv+oIaQMatk/uCgdbNnCd32J3xkgieyYs/gzB8d8WSeK5YSstdiyuS4Z
 gm/eu2iXMU0XopD+XhrdCRuKRYRJKDpZKPGpynmjfCtCAAY4DPXPuGc6n7lQmFKRBAmY6SkJ
 FfPhM+vwdREoKBnJhwOXahmCqAlBm7TY/ItctmpuASICmWtvEi5hYLjshgd8hDONGiPFZfrw
 JDCRyWmTi+IhoPz8Ih7vbBx7zotN1QssdloKwhZs5RzhiuhBWELEfUFPN9UQttImyj1z9fja
 CuLcGImDj7nUC9ZdQnnpu7uRRqbGvdEL+KRyubFJK9IQ3ze6EK87LpdGuNI5n53fn77yLjiJ
 4hBqjv/OR++xpwvTuEWjhB+bSGL2duCrk/kO2ik+yAxP/raKboP3X1lWgFKUEQr1unTwV7TK
 zFdqX9sGSmGpI2YLSqkU3FQERAd+jjoyl3EqMtJLMn34+2m8QGL9BEz1ywfHFHOgATm6YPin
 U/KelY=
IronPort-HdrOrdr: A9a23:/HcceKA0Sd/aLAXlHemE55DYdb4zR+YMi2TDGXoBLCC9Ffbo7P
 xG+c5w6faaskd3ZJhNo6HiBEDiewKlyXcW2/h2AV7KZmCP0wuVxelZjLcKqAeQfxEWmNQtt5
 tIQuxRDJnfAzFB4voSIzPVLz/j+rS6GdiT9J7jJr5WIz1XVw==
X-Talos-CUID: =?us-ascii?q?9a23=3A/dG1M2pUiLuZKSSnsD9JlRbmUZ5mQ2WFxXHoGV2?=
 =?us-ascii?q?lIDpxeJK5Yl2gqZoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ajw4Ifgy0cYsTYzGilO8sL64iXE+aqKqzEVwvm8w?=
 =?us-ascii?q?+gejHaR1UAS/HgTinU7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,213,1779141600"; 
   d="scan'208";a="289571366"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHZwqJcQa24y+JDm1UEIdN+uhrhAl7dGo/V8L?=
 =?us-ascii?q?xui3cXftXq9zg2mVROpdVLI/L1HCaJI4rJayzGbivK+XClSayhL4msVY?=
 =?us-ascii?q?PuGdBzo6duLiErPMD49k/Sd43rV+3d7iGWQF+0dbcD4ozA/tZ50G2z7K?=
 =?us-ascii?q?NKu7syeGIzSQeK7UO3QoKp2g=3D=3D?=
Received: from mail-pl1-f178.google.com ([209.85.214.178])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 06:53:44 +0200
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d01663d816so6057975ad.1
        for <cocci@inria.fr>; Sat, 08 Aug 2026 21:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786251223; x=1786856023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h8lW4W332DtSVDSz/dr4gcyaJXuSGVqZYaGIa/fIcrg=;
        b=PXND1EbSUmTDAVOx9ZWtkqNd26hDfSLuilO3IK78CSXVfEGq0zA3KPIlToPX+Autz/
         Gz6bs3BaSSN7y/aOAZOo2dJs1aj2oVUqTTO6QCp6YQQJxba8+Ti0+0YX0697FT4wwbtM
         0khfbw0b5aK8tOwOuW1mlBebnpzrtta/RjJLEvP5ZifXo7h7n8dQoSfPbL335YSKw4Jo
         AcHJngHx3RL3vdjvt/tK4DtqpS6s2AiphU+oEki8fTk2LoAqmwvRoAOAcP3xkc05Ysz0
         PbcFSLdn+U04l/1HMxYDA/PDKfgXOMCwjUJ6p5RYv8SCVCONkjrosV+3gtshJk/AD0gE
         to/A==
X-Gm-Message-State: AOJu0YyQwmPP5ZsH1NABJW1H1o2X6pGooIYWNGkHOimYnzV6YHKccb/W
	2AqTNa3cTq3ISxqkFabGMGczVHr8Qz1wW8sqBZFkcIV4yG/7Kwd75fJb
X-Gm-Gg: AR+sD13+OSG+MnuheWR5NKpj6I/UCv0HbiK1fmQMvjdkf/s1XBdAf/T6aH6DR2wRjN0
	CumIWuakaqgqEyFtcaQFoGIY54rxtVO4XMhUSrAJVD2qK0wDmZ86kC44bQld7RHLe4hZLUJtb+c
	FTDIPVwrnW9P0a8HVtPbI/kGXsD5uVC2WHTObZWPuGRzmfINY8p1qPfXJL9roJNsPHTfzzI3mHn
	gRzlqTMLt/gIrqYwTD0gTmHD8kjp8+rU7QCDdMhYVm83BIyy/K+cViRSJR4rUNunGa61lB87ZPz
	Lra+nNl7Lq4rDsBchDBmD68KeMG+lAPfjyf/WvfedUFEwj3ZkEZvfImIOt7nQsToep+pbSZOX7c
	hgC3pknse7MO4ZOo8WxotRJd/zEOh0iFSLQ7X0hQmy0YdyOk8KjQFM1ZB/VLEW5SR3k8BuVQJM+
	Gn15NiFMZZyGIMjDYMn2aVT3zdSvGX3PW826mWFZAB3TX7gXvWW0al0WjRC3ZgVeBuXw==
X-Received: by 2002:a17:903:3d06:b0:2ca:b4b9:4586 with SMTP id d9443c01a7336-2d106e4d5dbmr246805145ad.19.1786251222900;
        Sat, 08 Aug 2026 21:53:42 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a8e90sm21788605ad.66.2026.08.08.21.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 21:53:42 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr
Date: Sun,  9 Aug 2026 13:53:34 +0900
Message-ID: <20260809045335.1273602-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: misc: struct_size: drop unneeded
 parentheses
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3693
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/vcs9krVZmkQmytCpWdGl0g>

The outer parentheses and the single-branch disjunction don't matter when
just matching and reporting a line. Eliminating them reduces the
complexity of the pattern to match and gives a performance improvement in
the non-patch cases, like the previous minmax change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 scripts/coccinelle/misc/struct_size.cocci | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/coccinelle/misc/struct_size.cocci b/scripts/coccinelle/misc/struct_size.cocci
index 9b02c37438e4..406884d68d43 100644
--- a/scripts/coccinelle/misc/struct_size.cocci
+++ b/scripts/coccinelle/misc/struct_size.cocci
@@ -29,9 +29,7 @@ f
 expression E1, E2;
 identifier m;
 @@
-(
-* (sizeof(*E1) + (E2 * sizeof(*E1->m)))
-)
+* sizeof(*E1) + (E2 * sizeof(*E1->m))
 
 //----------------------------------------------------------
 //  For patch mode
@@ -55,9 +53,7 @@ expression E1, E2;
 identifier m;
 position p;
 @@
-(
- (sizeof(*E1)@p + (E2 * sizeof(*E1->m)))
-)
+ sizeof(*E1)@p + (E2 * sizeof(*E1->m))
 
 @script:python depends on org@
 p << r.p;
-- 
2.43.0

