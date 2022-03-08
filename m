Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D29FC433EF
	for <cocci@archiver.kernel.org>; Tue,  8 Mar 2022 01:17:27 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24885772"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2022 02:17:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22709E09B6; Tue,  8 Mar 2022 02:17:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6520BE004D
	for <cocci@sympa.inria.fr>; Tue,  8 Mar 2022 02:17:20 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: 5Dl2pX9FuOJBnquD1lLFTA1ur+8tMc8x8vRog7G3sGzHg7D4jhhl7SOwdaMwm9j5wnBp37Tprd
 kpRZ2YqKsKWCJb0UDaJgTb66ole+I7Z+x68MNTV2c3FFn0sAf/Pwk/x9CHVCEWgHM3V4b9Gobk
 bGx7Fc9de58q0WMYe8joQkiYK7EGMR2cXE2o93tv5/4pk3lNPSrCwdfGny+7Odos00YmRJQhnX
 bEEGi/tFnPdflXx1HCEIt3Sq+kBBa5Pma7k9js91XCv9wnG1ddCJTdvS9FMHVw1wzZ7QGSlTno
 YOfv3Y7OiHZxU42YfWy4END9
X-IPAS-Result: =?us-ascii?q?A0BVAwDgrSZi/0Xcza1agmOCKAd3VgEBASkEC0QChFKOc?=
 =?us-ascii?q?4IonF+BfAsBAwENOQgEAQGEQkUChB8CHQYGMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECAwQBgQgsAWMBZwGBTgGBeQYEMA2CNSkBg2QBBAEjVhALQ?=
 =?us-ascii?q?gICVwaDFwGCdSEPrXGBMYEBiXUGgTyOSCccQIFNgTyDAz6CTBcEGIRggmUEl?=
 =?us-ascii?q?VOCFxCBTXChdVSeEoNTiwqUTBoulkSRZpZVjROZZoE/IjyBWR8UGggmCoMlT?=
 =?us-ascii?q?QECAQIBDAECAgECAQIBAgEIAQECAZcihWsgAQEBMQIBAQEKKQIGAQoBAQMJk?=
 =?us-ascii?q?W8BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:wxG0ha78Sqe2ONcfNor3YAxRtBjBchMFZxGqfqrLsTDasY5as4F+v
 mQcUGuGaK3fNDOje9glYNy2/UoGu5SHn9BiGlFpri09Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UYYoAwgpLeNeYH5JZSlLxqho2uaEvfDjW1nX4
 Yiq/JWEULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 PBmqp27byopB6rvmrUXDgYbGhEmbaITrdcrIVDn2SCS50jWNXbzw/hjCEwse4sV5o6bA0kXq
 qdecmhQKErZ36TokdpXScE07ignBMLsN4geknVh1i3CS/s5QZ3OR6jQo9lVwF/cg+gRTamHO
 JZJAdZpRBrHRjlUEAZOM5cFl+iJmVavIxRT92vA8MLb5ECIkFIqgee9WDbPQfSBQs5en26Dt
 2fe9iL4BAsbPZqR01K4HmmEg/+JkDz7VY8WGaf+8PN26LGO+oANIDg9Slqwh9S5s0mdWYNVd
 lNX8xp2/adnoSRHUeLBdxG/pXeFuDsVVNxRD/A25Wmx90bE3+qKLjNbEWMZObTKoOdzFGN6j
 AbY9z/8LWU36OX9dJ6LyluDQdqP1cU9KH9EaDAEQAYB7sOlpowv5v4ucjqBOPXq5jEWMWusq
 9xvkMTYr+9I5SLs//zglW0rexr2+vD0ovcdv206nguNt2uVnrKNaY2y8kT85v1dNoufRVTpl
 CFax5bAs7BWU8jVzXXlrAAx8FeBvK7t3Nr02gEHInXc327wpRZPg6gPiN2BGKuZGp1YJ2S4P
 x+7VfJ56YBTMXauYLV2ZYn0U51C8EQTPY+Nax0VB/IQCqVMmPivp3k/NRbNhDm2yCDBU8gXY
 P+mTCplNl5CYYwP8dZ8b751PWYDyn9syGXNa4r8yhj7g7OSaGTMGeUBMUCSdaY086OJrQHY6
 ZBZOtfTk0dTV+j3Yy/2948PLAlQcSNhXc2v95VaJryZPw5rOGA9EPuPk7kvTIxSgPgHnOn/+
 HzgCFRTz0DyhCCZJFzSOGxjcr7mQb12sWk/YX43JV+t1nV6OdSv4a4TeoEZZ74i8OA/n/d4Q
 +NcK5eEA+9TUXLK5DQQYJ3wtspkeQjy3VCCOC+sYT4eeZ98RlWTpoS+Jla2qHADV3Plu9E/r
 rus0hLgbaACHwkyXtzLbP+Pzk+quSZPkuxFX3zXfotZdnLq/dU4MCf2lPI2fp8BcE2R2juA2
 g+KKh4Evu2R8ZQt+dzEiK3Y/YekF+xyQhhTE2XBtOvkMDmc83WjzIJEXfzOez3BDTum9KKnb
 ORT7vf9LPxexgoR6dIhSuoywPJs/cbrqp9b0h9gQifBYWOrPaw8cHOI6s9C6/9WzbhDtArrB
 E/WootGOa+EMd/OGUIKIFZ3dfyK0PwZxmvI4fIuLBmo7SN75uPaA0BCeRSTiCFQKLZvdoUo3
 b556sIR7gW+jDssM8qH13oIrD7UcyVcCqh35IsHBILLixYwzg8Qa5LrChjpvMOFZeJKPxR4O
 TSTnqfD2upRnxKQb3opGHHR9uNBnpBS6gtSxVoPKlnhdgApXRPrMMm9MAjbTzi5Cj1Cw6R+J
 WhmOkl4P+OI8isAaA2vmYyzM1kpOfFb0hWZJ5g1eKnxS0izSneLIXI9NOuJ8Vpf9W9AFtSeE
 Hd01069OQsHv6jNMu8aXU9+t+elQMNx+wDGldrhGcmZd3X/jfwJnYf2DVc1R9Db7Q/dSaEJS
 SSGPAq9VEEjCRMtng==
IronPort-HdrOrdr: A9a23:LU+N8qw1B0t3ovObprwlKrPwKL1zdoMgy1knxilNoH1uA7Wlf6
 LHppsmPHDP5gr5NEtApTnEAtjkfZq+z+8S3WByB8bHYOCOggLBR+wP0WKh+UyGJ8SUzJ8+6U
 4PSchD4QLLZ2RSh8yS2njaL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="7871748"
X-MGA-submission: =?us-ascii?q?MDEhFvQKQFMaP8pJgHzxmi7jVEJJy/C1wAv0/t?=
 =?us-ascii?q?NQVMgOjRdogzTPdd35KfqouQF9qPHHkAZfX57GcKT/TsJA9q6knl4SN3?=
 =?us-ascii?q?yJINdlkzk6R3NGl8rd3Ijmh4tSQvEtJcokrHuO7Lb3oK/csSxRW5+iXB?=
 =?us-ascii?q?icZD9akY/RHNDSIaAX3mXFHQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:17:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id F07DB48;
	Mon,  7 Mar 2022 17:17:15 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bGOHB-krrfKV; Mon,  7 Mar 2022 17:17:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id DB09640;
	Mon,  7 Mar 2022 17:17:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net DB09640
Date: Mon, 7 Mar 2022 17:17:12 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <c147926e-d46a-30fd-3efd-a5886eb2dd91@web.de>
Message-ID: <7edfa5f6-94b3-befd-ea55-ea2a2d72a77@ewheeler.net>
References: <df8a810-dcb1-4bf2-178d-178943e6e458@ewheeler.net> <caa0adde-7dd-e571-fa2-ee2a650b328@ewheeler.net> <alpine.DEB.2.22.394.2203070900200.3091@hadrien> <2018915-898b-778-b5e-c8683697ed40@ewheeler.net> <c147926e-d46a-30fd-3efd-a5886eb2dd91@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1310195061-1646702234=:1906"
Subject: Re: [cocci] [PATCH v3] Fix support for "complex double" in
 parameter lists
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 185
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/7edfa5f6-94b3-befd-ea55-ea2a2d72a77%40ewheeler.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1310195061-1646702234=:1906
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 7 Mar 2022, Markus Elfring wrote:

> >      Patch v2: Fixed: strange type2, maybe because of weird order: complex
> >      double
> 
> …
> 
> 
> >      Patch v3: Added signed-off-by.
> 
> …
> 
> 
> I suggest to reconsider the detail if such patch version indications
> should belong to the patch description (or not).
> 
> Would you like to take another look at advice from an other information
> source?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/process/submitting-patches.rst?h=v5.16.12#n705

Good point.  It was a courtesy for Julia so she could easily see the 
difference.  Maybe only the subject needed the v3 marker.

--
Eric Wheeler


> 
> Regards,
> Markus
> 
> 
--8323328-1310195061-1646702234=:1906--
