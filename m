Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01472C433EF
	for <cocci@archiver.kernel.org>; Sat,  2 Apr 2022 21:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YmZlq9ZUUQnBrw+x8zuGcU71a0vefMZRAKiXHbdNjbg=;
  b=ViyIMFAxHDWunqnOJNM9hZmSwuZEhG3Wmbh6F74HPdFYxoita5gYltM3
   fWM63JPjERKO0YShh2WInE+NZYHx4++t1JDqZB8qxEz4xhtVNqF4Af1P1
   Y4sfB/rsq2EnoSTaW4kGSU7SherxtS8wNeUXjAmyO83FQ3QmMg/tVWmvp
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29701346"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2022 23:19:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BC07DE033B; Sat,  2 Apr 2022 23:19:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DE20BE00A8
	for <cocci@sympa.inria.fr>; Sat,  2 Apr 2022 23:19:06 +0200 (CEST)
IronPort-SDR: 7Bead6ASKJN6MbhtRh1UmCX94dR0fszeqQZTGE14Ira8QM5Suus9/aMq3fC3Gd//vSi/3J5k+A
 BBsjCg0ItrJQaDDRiS0Hs7SmXcS3V8BCukpQXtL0ifBE4/dw9V5f4jNwpBoIz37RPlJQK+dqcT
 1AseKpv+pMWzKXeEsgIU335+0QpsHbqYSLJQ9PJximTfl30wDA8ldGIjyfxA1jF378qW+X5lN5
 H0+voxz501ODMoUXq1JzqEJ+CsjhsEhI9eN/19hLM9Ujt17utjR0drXyjZreyup5y2gsyvnGIJ
 WVmu2YZeyJpoY4MQI+JT4INX
X-IPAS-Result: =?us-ascii?q?A0AmBgBMvUhi/0Xcza1agQmBWoIoB4FNAQEBKQQLlAuFT?=
 =?us-ascii?q?plBgXwLAQMBDUMEAQGJYwIdBgYyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBAGBCCwBYwFnAYFOAYF5BgQ9gjUihCyFFIMXrzGBM4EBiXyBPIYUW?=
 =?us-ascii?q?IgJHECBTYE8glOGAIUyBMAeiy2Sc4NTBZ9jBhQug2KSb5F+ll6hU4FVg2SBP?=
 =?us-ascii?q?ykBNIFZHxQaCCYKgyVNAQIBAgEMAQICAQIBAgECAQgBAQIBjXQBjxchAQEBa?=
 =?us-ascii?q?QIGCwEBAwmQBgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:nndU96t0fjk2v04chtj/MONScufnVHNYMUV32f8akzHdYApBsoF/q
 tZmKWCEOPjeN2L1eYp1atuwoRwE6MLXx9I2TwI5ri5kFH8QgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCY0idfCc8IMsboUsLd9UR38g52bBVPyvX4
 Ymo+5GHYgf/s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCncy9SF4RJoaUofRDCgJELSclY7d+xIaSdBBTseTLp6HHW378hfhxDEw7OYACvOB6HQmi9
 9RBd2tLNEjewbjsmPTlG4GAhex7RCXvFIgYsXph5TXYFuo9B53cQ6jH4dJCmjE9mqiiGN6EN
 pVBMGEzNXwsZTVBPloPK4sQktz1h1fYeWdaiHCn/4Yetj27IAtZi+Sza4uKKrRmX/59lUGTr
 WPu5HX8GhhcNdqFyDPD/GjEuwPUtSbrHo8NFLC18vNwxlue2gT/FSH6S3PrrPjgslaVA+tPd
 RUP5hQo9vYozHCSG4yVswKDnFaIuRsVWtx1GuI86R2Qxqe83zt1FlToXRYaN4N77J5eqSgCk
 w7Wz4mwVFSDpZXMESrFnop4uw9eLsT8EIPvTSoUCwYa49TupIwpyBTCUr6P8ZJZbPWuSFkcI
 BjQ8EDSYon/auZRjc2GEajv2W7Em3QwZlddC8W+djvNAvlFTICkfZe0zlPQ8OxNKo2UJnHY4
 iRUy5TAtbpVUMHV/MBofAnrNOv4jxpiGGaH6WOD4rF7qmrFF4CLI+i8Hw2S1G8ybphfKGC5C
 KMikQ5O5JJeOHawbKl8JtroY/nGPoC7fekIl5n8MLJzX3SGXFTco3E2PB7JgDiFfYpFufhXB
 Kp3uP2EVR4yYZmLBhLvLwvE+bN0lC04203JQpX3k0au3baEPS7HTbYeLEDIY/854a6ArR+T9
 dtDbpPYxxJaWez4Qy/W7Y9KdwxRdyBmXMyvppwFbPOHLypnBHolVa3bz4QhTJM5za5boeHFo
 yOmUUhCxVui23CecVeWampuYa/EVIpkqS5pJjQlOFulgiBxYYum4KoFWYEweL0rqL5qwfJuF
 qlXf8SbHu8JRyvH9jkZYIO7qoF+LUz5iQWLNiujQT4+Y585HVCSoIe5J1e2+XBXXCSttMY4r
 7mx7S/hQMIOF1Z4EcLbSPOz1Ffv73ITr+JFQBeaKNdkfkixopNhLDb8j6JpLphUewnD3DaTy
 y2fHQwc+bvWu4Yw/dTE2fKEooOuH7csF0ZWBTCGv7OmcyTF/meuxYJaFuCFYWmFBm/z/ayjY
 8RTzu39aadbxwwS7tMgSrs7n7gj49bPpqNBylo2Fnv8b2O0VuFqLE6A0JQdraZK3LJY5FW7A
 xrd5tlANLyVE8r5C1pNdhE9Z+GO2K1GgDXU9vhpckz26DUuoeiCQQNfIBmBhShQNv1zPZ98m
 bUtv8sf6gqejBs2M4/c0nsOrznVciUNA/c9q5UXII73kQ51mFtMVpzrFXOk6p+4bdgRYFIhJ
 SWZhfeciu0ElFbCaXc6CVPEwfFZ2cYVoBlPwVIPT7hTdgEpWhPjMNxtHTULosB9ywUB3v1zN
 2VvOlczI6iSl9utaA6vQEj0czytxjXAkqAy97fNvGnYVFWzEGHSLGAwPeuXukYU7wqwu9SdE
 K6wkA7YvPWDQC019i8zQlJ+7fH8TdF88gDY3saqA6xp2nX8jSXN2seTWIbDl/cr7Q7dSqEKS
 SmGMducsZHGCBM=
IronPort-HdrOrdr: A9a23:C1yNeqNwD3jjt8BcTtGjsMiBIKoaSvp037BL7TEUdfQ2Gvb2qy
 nAppomPHPP6Qr5O0tQ/OxoWpPwI080nKQdieJ9UYtKNzOW21dAQrsD0WI8+VfdJxE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29701341"
X-MGA-submission: =?us-ascii?q?MDFD6qg+Ty7qV3l25OxUSNZQZj57mZGIvWMxFF?=
 =?us-ascii?q?NZH0QwXLwOoW+8bGUey3Pi2sGAeLpnjI45M8ySytZzahyr+BX16QKU62?=
 =?us-ascii?q?PvuWdrQIScmoTbi5eYXfRva3CGIL6EkkgJMLmMwdJu8ATs+cgFatgDVM?=
 =?us-ascii?q?0YcPaaE8dO9O3pYVVYdbghsQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 23:19:04 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 5309646
	for <cocci@inria.fr>; Sat,  2 Apr 2022 14:19:02 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TVoidZ4xNa0U for <cocci@inria.fr>;
	Sat,  2 Apr 2022 14:19:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 5A2D439
	for <cocci@inria.fr>; Sat,  2 Apr 2022 14:19:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 5A2D439
Date: Sat, 2 Apr 2022 14:18:59 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <4f40e17b-67ed-97f0-10ca-41285d7c3d1a@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] How do you concatinate string constants in SmPL with
 python?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 338
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/4f40e17b-67ed-97f0-10ca-41285d7c3d1a%40ewheeler.net>

Hello all,

I would like to do something like this:

@ r @
constant C;
@@
-perror(C);
+pr_err(C ": %s\n", strerror(errno));

Thus in python I need something like C = C + C ": %s\n".

I've tried a few things, but I don't think I'm anywhere close to getting 
it right.  Can someone help with how this should be setup?

Also is there a reference for the `coccinelle.` and `cocci.` python calls 
that seem to be available in a script:python section?

Thanks for your help!


--
Eric Wheeler
