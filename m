Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F588606A31C
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=hDiFmHJa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:cc:reply-to:in-reply-to:
   references:message-id:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=071dvjybJPSt6PG1XAe371+QIXnii3TJph7g2jUJUOU=;
  b=hDiFmHJa6LCpsYbKZrUTR+SkpSa4MNuzNH96/+jRExJqu9vI92KfLbHV
   7NHV1EyXUo7mxUrxsvQxfgBxBUCivWALZYdbIjO0S6VWzeYGGLfkQnQPW
   0MOoKuUp9+A0nSRrjpejstOV/jBGZ3MVkQ0BKAgAUPsRD8B0ZSlOl2ot0
   0=;
X-CSE-ConnectionGUID: DwKXN5loS9+xfXndOLwWjQ==
X-CSE-MsgGUID: ubCesHLnRjCTGPOdvNQVXg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305111779"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 15:52:02 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9AD9081C19; Thu, 12 Nov 2026 15:52:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 29FEA80F43
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 15:51:56 +0100 (CET)
X-CSE-ConnectionGUID: wr0Cb1m3RwarhDW0nIEaIw==
X-CSE-MsgGUID: wSWgxVTPSHSjz6UypF3UxA==
IronPort-SDR: 6af5d28b_u5pvu2YAI8pxfuSFjDmn2j13oE2sR1kcSWWQRG8ZfqmWcVi
 tazr0Gncsm4/4ZLD7WxbkS+JZVuzYJKfE9J69+g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HrAQDR0fVqjgUqG9RaglmBblOBBVQUMgcIjhuIfZIZj?=
 =?us-ascii?q?gcPAQMBDU8CBAEBAYUEAo4fAh8HBAUuBg4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QEEAQEBAgEBAgQDAQEBAQIQAQEBAQEBOQUOO4ZcjBqEAQEBAQIBJxECPwULB?=
 =?us-ascii?q?AcJPSsrBhuCeoJOJwQDAbwBgQEzgQGEZtljgR9JDBSBOYV0gm4BinYnDg2BS?=
 =?us-ascii?q?EWEEDE+hEOGRgSCIoEMl2YHBx4mHVscA1ksAQ8RNRMXCwcFYEVDA4EGI0sFL?=
 =?us-ascii?q?R03bCEdFxEeWBsGBRIgKkBDW4ESgQVdgSsoXQEBAR9GLQoLgXUCglGBI10CA?=
 =?us-ascii?q?UlBDgdFUwklQxJHJCIIEgkBExosCoEaNTwJJj8VDFsMCAMaBRomAh8IAgsCD?=
 =?us-ascii?q?HQoERATHR4kLwUaJj4bCn4HZj03CQwZBAIBQkIdEgKWd4FEeZNmB5FMoUA8h?=
 =?us-ascii?q?CqBdIIQnWISHBeqcpkIqUWBfiSBXH0IGoF6gQ9PAxkPji4NCdIbRHECBwIHD?=
 =?us-ascii?q?gMLhUaMVoFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 qXuVrAUNe4aXcS9kNCoVw09hqGQMoiF6o8=
IronPort-HdrOrdr: A9a23:B0Kdda991g22TPZADqNuk+D/I+orL9Y04lQ7vn2ZhyYlF/Bw8P
 re48jztCWE9Ar5N0tBpTntAtjifZqYz+8N3WBzB9aftNWKghrPEGgB1/qY/9QxIVyCygc178
 4JGMIRNDSzNykDsS+d2njeLz9K+qjizEnHv5a98588JTsaEZ2I9z0VNu+AKCFLrRd9aqYEKA
 ==
X-Talos-CUID: =?us-ascii?q?9a23=3Azo1e2WkhcMn8j9Qd7itf5/7y0dTXOWLHlFzaekr?=
 =?us-ascii?q?jM3lgUr25dgeW2Y5tstU7zg=3D=3D?=
X-Talos-MUID: 9a23:OGYIuQpTe7yIoOf784cezy5ZC8h43ZiWM2A2k4dYhticG3dNKx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305111741"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEE2ePaYdOHnoZ4eSJ7IV7dFYEBnxJpyappH6?=
 =?us-ascii?q?Vv2LTA3vR9TF0IrTc6px+PE4BRlWa0B1YLT8pMOj0UjGGUubWcNYExMU?=
 =?us-ascii?q?ZnqPEG38bDcl30viopqQWBf8lZIPTKlNjOdXR/9W93DE4VkxfyHwDRhS?=
 =?us-ascii?q?tCIKMLwFOCFETOEFBygBmLYA=3D=3D?=
Received: from smtp5-g21.free.fr ([212.27.42.5])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 15:51:55 +0100
Received: from lettres.chocolatnoir.net (unknown [IPv6:2a01:e35:39f0:1580:aa20:66ff:fe1e:6826])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 687DA60139;
	Thu, 12 Nov 2026 15:51:54 +0100 (CET)
Received: by lettres.chocolatnoir.net (Postfix, from userid 126)
	id 38EF1CE8E20; Thu, 12 Nov 2026 15:51:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
Received: from lettres.chocolatnoir.net (localhost [IPv6:::1])
	by lettres.chocolatnoir.net (Postfix) with ESMTPA id 7B9EFCE8E1D;
	Thu, 12 Nov 2026 15:51:53 +0100 (CET)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 15:51:53 +0100
From: picca <picca@debian.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Reply-To: picca@debian.org
Mail-Reply-To: picca@debian.org
In-Reply-To: <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr>
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org>
 <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr>
Message-ID: <b4048ae138808c03693d43cd183c7ab8@debian.org>
X-Sender: picca@debian.org
Organization: Miaouh
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
X-Loop: cocci@inria.fr
X-Sequence: 3802
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/QWq0YevBtAJqulHDMx-Y_w>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1

> Alternatively, if it's easier, could you retry after removing the
> following line from standard.h:
> 
> #define INLINE inline
> 
> That looks problematic, but I'm not sure that that definition should be
> applied if there is not another parsing error in your code.
> 
> julia

It works without this INLINE

-----------------------------------------------------------------------
Finished
-----------------------------------------------------------------------
diff =
--- ana_read.c
+++ /tmp/cocci-output-2311372-3e6202-ana_read.c
@@ -646,7 +646,7 @@ static void read_spec(Ana *ana)

  		sprintf(STRING,"x title %s break",XCOLNAME);
  		put_command(&ana->rod.menu, STRING);
-		plotxye(x,y,e,1);
+		plotxye(&ana->pg, &ana->rod.menu, x, y, e, 1);
  	}

  	for(i = 0; i < ncolumns; i++)
@@ -988,7 +988,7 @@ static void read_srs(Ana *ana, int versi
  		{
  			sprintf(STRING,"x title %s break",XCOLNAME);
  			put_command(&ana->rod.menu, STRING);
-			plotxye(x,y,e,1);
+			plotxye(&ana->pg, &ana->rod.menu, x, y, e, 1);
  		}

  		/* Get column number of y values */
