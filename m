Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44785C3DA59
	for <cocci@archiver.kernel.org>; Fri, 19 Jul 2024 10:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=rxgM9mXuLGa/LojJb6czz4pvjLO+xqqndYTBhaQgubo=;
  b=fswQ2yo2oSDCA9CeXXCgSsFebDp++Zq9yKxs+394JHg6Z1f8ke/wRnoy
   0IpGVL/Nbnt46Vqm4yPxXbc9bRO314uFcAh3noRTnQmg4bzrYTS+MLkF7
   y0pVuX4cWhFTP7GaVOQjc2IlD+7xgg8zZ5IKnA8Q66IW797/ohpDuulS1
   o=;
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
X-IronPort-AV: E=Sophos;i="6.09,220,1716242400"; 
   d="scan'208";a="176186291"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jul 2024 12:21:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22548E0D1B; Fri, 19 Jul 2024 12:21:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5D745E0131
	for <cocci@sympa.inria.fr>; Fri, 19 Jul 2024 12:21:26 +0200 (CEST)
IronPort-SDR: 669a3e26_zPvAVhhiYwMXjggLYknItwq6v4rbI1sGi0JB3JGSSJfL9TC
 ZBPTuraRKnYQtOXXJDUElqTUNIYsOsjPiifriHw==
X-IPAS-Result: =?us-ascii?q?A0EdBQDSPJpmhw4P49RagQmBT4JEYiBUMwQLSIRWj0iGY?=
 =?us-ascii?q?Ic5h1GIc4FWgUA+DwEDAQ1BAQIEAQEDBIFMP4JvA4k0Ah4HAQQxCA4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBAToHDjuFdQ2CYBiBEoEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFwJHbR0BAREnNAImAnMBAYJ8gjABAzEHrmyBM?=
 =?us-ascii?q?oEBggwBAQaCZ9dyHywiV4FjCYEaLogYGgEFZ4l3D4FVRIE8C4JAB4F0AYQKg?=
 =?us-ascii?q?w6CaYgKAYcbiiuMBCYLjWaBTxwDWSETAVUTFws+HQIWAxsUBDAPCQsmKQY5A?=
 =?us-ascii?q?hIMBgYGWTIJBCMDCAQDQgMgcREDBBoECwd3gyUEE0QDgTeJYYMxghqEGgiBQ?=
 =?us-ascii?q?oNpgWsMYYlsgT6BYYNJSoR0gQgdQAIBC209NQkLGwY9rSx9ehOWE7IuNAeCN?=
 =?us-ascii?q?oFhBYFeDIh/lkwGEy+XOw4Gkm2YbKM6hVOBaQE3gVwzGiRPgmdPAxkPjXgBP?=
 =?us-ascii?q?wKEFMweQTU7AgcBCgEBAwmFRgEBg1qBSgEB?=
IronPort-PHdr: A9a23:qyNTSBHnf7Fd+StHsK8TR51Gf6ZHhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k21BmUBM6BtroE07OQ7/qxHzRYoN6oizMrTt9lb1w/tY0uhQsuAcqIWwXQDcXBSGgEJ
 vlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+I
 A+5oAjfqsUam4tvJrs+xhfXonZDZuBayX91KV6JkBvw+MO98IR//yhMvv4q6tJNX7j9c6kkQ
 rNUCygrPXoy6MP3qxfIUBGB5mEbUmUYkxpIBxbK4RTnVZrvsSX0q/Rw1jCCMcL5Ub47VzKi7
 7x2SBDzkycIKyQ58GDMhcNuiq9QvQ+sqAZ+w47QZ4GVKeZ+c6bAdt4UWWZNQsBcXDFHD4ihb
 YUAEvABMP5boYfzqFQBowWwCwmxCuzzxTFFnWP23bQg3ug9DQ3Kwg4tEtQTu3rUttX1M6ISX
 PiywqbS1zXDbO5W2Szg44bHdhAhr+uMXbN2ccre1EIiEATLgU+KqYzmIjOVzf4BvWef7+puT
 +Kvimgnqw5qrzmh2MgjkZPFiZ8LxV3d8yhy3Yk6K8GiRkFhfd6kDIVftzucN4ZuXs4vXWBlt
 SQ0xLAIt5O3YCgHxIkoyRPBdfGLbYaG7xb+WOqNLjl1mXFodbGhihi8/kat1uLyW8a23VpXs
 ydIjt/BvW0O2RzL8sWLVOZx8lm71TqRyQze6PtILV00mKbBNpIszaY8m54cvEjZECL6hV/6g
 ayXe0k+/uWl6+Lqaaj4q5+YKo90kR3+Pbo0msKiAOQ5MxYBUnCH9em6ybbt51f2QK9Qgf0zi
 qTZsI7VJcAcpqOhBg9V1Zsj6wqlAzaoztsXhmMLI09bdx6fjojpPU/BIOzgAPuhnligji1ny
 +7YMrDjGJnBM3jOnK38cbty80JczRA8zdFb55JaELEBJ/fzV1f2utPCFB85MBG0w/39BNty0
 oMeV3iPAq6fMKPdqlKJ6PwgLPKWaIAIpjnxM/4l6OX2gn8jhVAdZbWp3YcQaH2gA/hqO1+Zb
 mb0gtcdDWcKuRIzQ/DtiFKeTTFTZm2/X7k85zE+EIKpF53PRoGrgLyb3Se0BIdaZm5cCgPEL
 XC9fIKPUPYkaSSII8YnnCZXe6KmTtoE3AutqRSy5r5pNOvS9WVMkJv518VuocDXmwsz8zNcE
 MmXlW2AGTIn1lgUTiM7ifgs6Xd2zU2OhPAQa51wENVS46kMSQImLdvGyOc8DdnuWwXHd9PPS
 VC8Q9zgDytiBskpzYooZEBwU86nkgiFxzCjVpocjb+WH9oZ9qzG3n7+D9lwwTDK2fpplEEoF
 /NGLnbunatj707WDo/NnV+ekvOPfL4fwTWL2WON12uIs2lHXQQ2XaiWFWsHaB7wqtL0rljHU
 6foCbkjNV5ZztWeL6JRdtDzpVBBWeulJ9nUJW6884upLTCPwL7ELI/jemFHmT7YFFBBiQcYu
 3CPKQk5AC6l5WPYFj1nU1z1MQvq9qFlpXW3Q1VRrUnCZlB917ez5h8ehOCNA/IV0LUevS49q
 jJyVF+j1tPSAtCEqkJvZqJZKd865V5G0yreuWkfdtSFJrphm0VYXgB5pULo2D1oB48GncVr5
 HImwQxuKL6JhUtbfmDQ1pTxN7vLb2jqqUr2MeiMgA6YiYvQo/tcjZZw40/utwyoCEc4pnBu0
 t0PlmCZ+o2PFg0ZF5T4Tkcw8RF+4bDceCg0oY3OhhgOeeG5tCHP39UxCa4r0BGlKp16ObmHC
 RS0PskUHcmoJ8Q1llLvYh9Ob4UwvOYketircfeLwvvhGe96ny+9y0lD7pp81E2k6Cd2DOLFl
 cVgobnQzk6MUDHyi02ku8b8lNVfZD0cKWG4zDDtGI9bYqAakZ8jMW61OIX3w9x/g8SoQHtE7
 Bu5AFhA3sa1eB2UZli73AtK1E1Rr2b10Se/yjV1lXkuoM/9lGTryv7haQFBF2pFXmhkgn/zL
 ILyg91SUEWzbgcvnQeo/g6gnvId/v4gaTCOBx4UNyHtZ3lvSK6xqqaPb6stoNszvCNbXf79K
 VGWR7jhogcLhibqHm9Q3jc+JHmhvpT0mQA/iXrIdi8p6iCDJocpmFGGuI+5J7YZxDcNSShmh
 COCA1G9O4Ps5tCIj9LZtev4UWu9V5pVeC2tzIWatSL963c5ZH/31/21hNDjFhA3lCHh0Nw/H
 wDBthXhec/G06qgMORoVlZlDhnw5oApf+M22pt1n5wW1XUA09+w9GAEjHy1HNFVw6P4Y1ISS
 DRNz9Ofs22HkAVza3mOwYz+THCUxMBsMsK7bm0h0SU498lWCa2Q4e8MjW5vr1G/tw6Ufellk
 2JX16418HBDybJs2kJl3mCHD7sVB0UdISH8i0HC8YWltKsOLG/9dL+tyAxhkNrnALzKq1NZX
 2vlP4csGjVv599zdk3B2jv/5+SGMJHZP9cUqwHRmRDdieNYbo08nLwGiGJua2f6oGFgwPUxk
 Bhtm8izuoTebW5q+cfbSlZRZDjyet9W8SrmirxG2J+f2Yz2WJ5mH30dVZ/sB5pECRo0svLqf
 0aLGTw48DKAHKbHWBWY4wFgpm7OFJaiMzeWImMYxJNsXkvVIksXmw0SUDgg+/xxXgm32Mzsd
 lt47TEN9xb5rBVL0OdhKxj4VC/Wug6pbj4+TJXXIgBR60lO4ELcMMrW6ewWfWkQ5pq6sAmEM
 XCWfSxNCnwVHFOJDRbvM/jm5NXN9fSZGvvrL/bKZubry6QWXPOJyJSzl4p+qmzVbIPVZCYkV
 qB9gxYQOBIxU97UkDgOVSENwifEbsrB4Qy55jUytMe0tvLiRAPo44KLTbpUK9RmvR6s0sLhf
 6adgjh0LTFA29YC33jNnfI61UQRljooWj2jC7UGugbSQaiWlqIdXHt5I2tjcdBF6a4xxFwHI
 cnAltb8zaJ1lNYwDEpZE0PskIelaIZZRgP1fEOCD0GNOrOcIDTNyMyieqKwR4pbi+BMvgGxs
 zKWe6cCFjGEiiWvSB2ld+1B3nnz1Pl2p4y3NBpgWzCLpD3OdRCxdtN632Re/A==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:B9uokK6g9uEn24e+OwPXwBTXdLJyesId70hD6qkDc20uTiX4rb
 HNoB1/73XJYVkqKRUdcLy7SdC9qBDnhPlICOsqTNKftWDd0QPCXeJfBOPZowEIcBeOjtK1u5
 0QCJSWROeAa2RSvILU5hKnG80szNTC3KejnvfG0nthJDsHV0ii1WhE48Sgf3GeiDMpOXPxLv
 uh2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3AP/ELOWkBZ/5uCSDHsWQMfR5U/B3XOXDF01jvBgi?=
 =?us-ascii?q?cMGY3S6GzT32Pp5hUqOM7zg=3D=3D?=
X-Talos-MUID: 9a23:TJK3gAQdkzYketq6RXTBhilfPsB3552CL2wfwMoZo9eBOAlvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,220,1716242400"; 
   d="scan'208";a="176186284"
X-MGA-submission: =?us-ascii?q?MDHPDTo6feRmDO6IM+Cvl/zzCrVFIZSnqj7W8I?=
 =?us-ascii?q?vlGMQUNb6ort2k8sazHxEjfvXITP/+yqLdPsHgAo2EJY84nLiyo5QPOG?=
 =?us-ascii?q?H0agokhHfijUz4PXk9UnNn01DyXX2zcU1Do9xCmr6UC++iI7USypgBUK?=
 =?us-ascii?q?yczSOH3mv4QNLTGLzG8SYAeg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 12:21:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721384485; x=1721989285; i=markus.elfring@web.de;
	bh=rxgM9mXuLGa/LojJb6czz4pvjLO+xqqndYTBhaQgubo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZWl3VB299UsAie8+H1SXxLa2b/oCNOq3MoKnX1sfR3/mbVQUFF8dOUdvN5gjXNvH
	 68Ti6GfOiiN/YKFnYAGny7q7rxNibyOpeB3gD1W0KAIUgZPLzQFlntBxsTNysrIxN
	 cFwQpe+rDqYLuK6Tf7gZR+ZjT4Hc4Q8SCqA9+P2LEYtD4fliSuF8wrC6BF8+j3jgb
	 /mjWzglm0CUb29bLFuSbPMPUxgVeM71qe+JOAcNKY4LgRBfPWgx/yWtTAYlyNPtoP
	 uU3lHjLMUKj/u/OiONJ31GWNiT5kx2Hi+PNnsBt+X8gbKys5CHkJmbu2C9+PfS07C
	 fAup9aUY5hgFev7fVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWz8v-1sopvI0iFd-00Sd7P for
 <cocci@inria.fr>; Fri, 19 Jul 2024 12:21:25 +0200
Message-ID: <76a0d20b-7328-4e5d-a8b8-c687bb11773e@web.de>
Date: Fri, 19 Jul 2024 12:21:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lek2dTxtT4wAEKHzk5bvZfA88SDSC/bJgHvFbRXuy1WK2ZWBish
 Oa+1KIj5SnYsW3bATDZ/uyDRPWNdHXMfqdmI1DV5eQI4sfISnLubL07bHME7fWtMTGdp5D5
 mcRhHpqGhKQhDgHHA6yNpu0sHwQs5N0JdvuHSu0rEbsntl9W+3hoguy74ocMM3NgvTfiAO2
 eZjOH1iosOf03nz6pb7tg==
UI-OutboundReport: notjunk:1;M01:P0:9j7HRsNzJuU=;YAgrhPme9nVw4aSjh48/1MtkZ5W
 jIvnO2v3iVLCZoHpPOF4YL5baURgvNhMocuQ3zER3Y4U5SDerIhBbv/vLnEGxhbLlxrv3zQ/m
 9ZCRpTrYyNKRsNVVteRNRLo8RRpRbk3Uu7/vSIEvdapd01kBAV8sX4N4xYSZR9lEYi7FgnFY2
 dfWdqaLodP2+z3sKNRUqVDxDr1kTbERPbq/btThWtjCoqFkqMFW3uRyqbBGGtiCxsLzaIe3c+
 x72Obd2udi2Sp7lFOd69uWkuMqVHO870XlguPgLudxZNx+FnOsLXV88D2d6hjAPIRWmULFTLy
 CEmGFCwls9PKmt3m0m+6q74S5WTxPgmc7kpI2fxzZ1MsQVGQJx3f2VY8hVZ+3XGWdluqp1SPk
 qShJYHivOG2k+we7nLhmQR7zzDExT5MRSWlPSAeQpn2Xh4mZ6gaf61xcBD5nDuxgId0evpj44
 9sLbinfP810cMDYAWPRr6XGQhqHNMswO1YWMfyO3GuN1zEHRLrN5ajaBNWq2g9zvpRG8Ps/ye
 DRMwiYgHmjPoX6Wwlvd31cZhPf8DYmFdIJh9mkfTtZY1GRwiAqpKZuJGQ6Tm44uqEzjrgcG/k
 /UQkBzdcFWXZLzz6f8d6Zqgqxh9/M/uJ9ndmDnbM4GqkjvhGUG0BJDBSq2uDk16/3Cfxye+pV
 87difZzCLpqEAkQd3ND7ZnkPU1IQvPnCYgxJV/8Cr3gBVe3z4TeVLMaB6w2z8iIpGV2xvDtpX
 DLASNq8jJy406dHmwRG8307Dh659W/X0qhvnM3+Lm4lBaw0t+hhGPTuwY1nYMJ9sSX4LiJij5
 BH0Yir6zoxjokz1d4Pg9xdjA==
Subject: [cocci] How to fix parse errors for two SmPL scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1809
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/76a0d20b-7328-4e5d-a8b8-c687bb11773e%40web.de>

Hello,

I stumbled on undesirable behaviour once more also with the software
combination =E2=80=9CCoccinelle 1.2-00021-gac9af0e8=E2=80=9D.

A)

@replacement@
constant char[] format1, format2;
expression check, input, target;
expression list el;
identifier x;
@@
-if (check)
-   target +=3D x(input, format1, el);
-else
-   target +=3D x(input, format2, el);
+target +=3D x(input, (check) ? format1 : format2, el);


Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci use_ternary_operator3.cocci
=E2=80=A6
minus: parse error:
  File "use_ternary_operator3.cocci", line 8, column 14, charpos =3D 144
  around =3D 'x',
  whole content =3D -   target +=3D x(input, format1, el);


B)

@replacement2@
expression check, context, target;
expression list inputs;
format list fl1, fl2;
identifier action;
@@
-if (check)
-   target +=3D action(context, "%@fl1@", inputs);
-else
-   target +=3D action(context, "%@fl2@", inputs);
+target +=3D action(context, (check) ? "%@fl1@" : "%@fl2@", inputs);


Another questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci use_ternary_operator4.cocci
=E2=80=A6
minus: parse error:
  File "use_ternary_operator4.cocci", line 8, column 14, charpos =3D 144
  around =3D 'action',
  whole content =3D -   target +=3D action(context, "%@fl1@", inputs);


How can corresponding software components be improved?

Regards,
Markus
