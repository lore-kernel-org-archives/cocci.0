Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A091CF9C68
	for <cocci@archiver.kernel.org>; Sun, 22 Sep 2024 09:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6z/uepYY8U3gsYcBFkhT8cGL4AFftJumTo1ztLs5+NY=;
  b=QqoRvGVSs1NQjJwwWD0OCiaLzsRxnb4Grbxz13AWiskmNqLZgg+8e4d4
   epJVvXCiZEJX/HscSAvO5itVL40tb1aNaMzVTOjmPQtky1mOtdI9ehBgw
   RMWbBzhyaZUc87IOkf2lltWEziV+AgeIAbPWPKHrUZ2gNNNQreAEncTEs
   E=;
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
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184408840"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2024 11:34:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3D756E0133; Sun, 22 Sep 2024 11:34:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 87532E0133
	for <cocci@sympa.inria.fr>; Sun, 22 Sep 2024 11:34:11 +0200 (CEST)
IronPort-SDR: 66efe493_vbSVgjyUIivjoGHG8qKDtHMCDRTo2F/B9s8/GSBErYrv51F
 0k/tF1jTFKXSpP6GM8DN2HxdnsVYdvGM9R+D7zw==
X-IPAS-Result: =?us-ascii?q?A0GuAQCa4+9m/wsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYJDB3ZaMwQLSAglhCmPTYF1MIQ7mASBVoFAPg8BAwENOwYBAgQBA?=
 =?us-ascii?q?QMBA4FJgy0KAneJDAIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECA?=
 =?us-ascii?q?QECBAYBAoEKCAuFL0YNgmMBEHkbdDACAQEBAQEBAQEBAQEBAQEBAQEBFwINO?=
 =?us-ascii?q?kQBAQECASMEGQEBEScECwsaAiYCAlYGARQBAYJ9AYIvAQMOIwcNBrRJfzOBA?=
 =?us-ascii?q?YIMAQEGgmfXcx8sIleBYwMGgRouAYhKAYYihDsnD4FVRIE8C4JABzE+gmEEg?=
 =?us-ascii?q?V6DW4Jpkg2CEIlIFiWIYnCQZlJ7HANZIRMBVRMXCwkFiTgKgxyBbiaEFQiBK?=
 =?us-ascii?q?xODX4FnCWGHZ2KBDYE+gVkBRoJzSoNQHIFdBThJglFrTjwCDQI3giokaoJag?=
 =?us-ascii?q?S8EBYNqHUACAQttPTUJCxsGPatfgVtIgj9EUSzILjQHgjeBY4FjDIonlSsGE?=
 =?us-ascii?q?y+XPg4GknOYdiKNWZsigW0BNoFZMxokgzZSCw4PjiGDejPGVUE1AgE4AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBhj6BQwgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:/3xVfqk9lez9cbQgjSxjQKno5gyuJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIfX26OOP6JMWXyfo8gOou+oE5UvZbdmoc3QQdqq31mEVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayazp8B56r8ks14Kyj4mlA5zTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1LK0IzBI0XpN0wBFNoz
 d1IeAlUdjOc0rfeLLKTEoGAh+wmK9T3epwSsDdswFk1D958GMqFGf+Vo4YHmm5p7ixNNa62i
 84xTDN1bwnbJTBLNE0WDp0Wg+qiwHXyG9FdgAvF+fZvsziJk2Sd1pDCHf32VN2qQflvuX+c/
 1320l3XHSgzYYn3JT2ttyjEavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPXO/qOawjkqWSdNaI
 VYdvCsot6k7skKxJuQRRDW9p2OY+AERUZxcHoXW9T2w90Yd2C7BbkBsc9KLQIVOWGIeHFTGC
 nfhcxLV6T1TXHm9THWA6vGLoDn0NSV9waruo8MbZVNt3jUhiNhbYtHzohJLD6O/yNH4cd016
 y7ftzAw3t3/kuZSv5hWPjn7b/aEuZXDCAI4jukSsqRJ8SshDLOYi0eUBZQ3IBqOwEt1jrVMg
 ZTcp/Wj0Q==
IronPort-HdrOrdr: A9a23:ebDWPqqnOvfD1Az5NzCPhhEaV5r1eYIsimQD101hICG9Afbo8/
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkOos1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3A5upf32u3W7LbL4m2Qj+NIjc46IsAVX7Y9XfffXT?=
 =?us-ascii?q?/DFRPcJzFGWbJ4IB7xp8=3D?=
X-Talos-MUID: 9a23:ofSwQAh36OJP3b3IHcOYoMMpG+pPwIqvKEQxq7I/v5C7BQFJFSikpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184408827"
X-MGA-submission: =?us-ascii?q?MDGjS8mjCgWUQmjsSpC6hRtcJDiQfEPQPuUeod?=
 =?us-ascii?q?mc9ncam74skj0Al0iObqTWW2mrnFBLTM++2Cj0QhUV84Jse09/N/iYJq?=
 =?us-ascii?q?OI+2XeMb70eN4livV9HFqGh70KMAQ5S8lfwgtf7xcTW4enxKeodmIWN2?=
 =?us-ascii?q?aBb3VbrgrU384zVhXESMhoYg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 11:34:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726997640; x=1727602440; i=markus.elfring@web.de;
	bh=6z/uepYY8U3gsYcBFkhT8cGL4AFftJumTo1ztLs5+NY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kgPzp+p1zDsuklgnl6rROPaXewgGCJAmdv3F8kdqFHE6wKbDPZPMCQjfs42+o8ho
	 4Fzzs0KpOQGSMFOrc2SpP/qv+Pe4L4fjcq3p120C2yj5LxvJUaBC35bYwCUsRSZmn
	 jAWeP7SFvoydPysPshQyPbtEg2MIsqP3MxtNVf/ZZ/e/wtbv2WwefgWiEZGGzR1TC
	 3B4CO7ON2Ks654zuqTMdToZFoPtOAkMTNpyMvK/8rNxoOH9PceLHK149NzQHLYQFP
	 B2yFgtj1hN4HMlzzDVx7PvsQ8WcFHbRveul+ZuqBdQp07Ctv34ntHmjiIwQlxSnbF
	 q2M6E8c7ymGv+il6bA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N943B-1ruxXb0F79-00rLsM; Sun, 22
 Sep 2024 11:34:00 +0200
Message-ID: <c2b0fc58-a399-4376-a4a4-2f7a3ed219f0@web.de>
Date: Sun, 22 Sep 2024 11:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
 <alpine.DEB.2.22.394.2409212209470.3471@hadrien>
 <b1872e36-154b-477f-907a-7fc98b301931@web.de>
Content-Language: en-GB
In-Reply-To: <b1872e36-154b-477f-907a-7fc98b301931@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5buKsg8OLEiRyAeVahPtQZE/2Lyme9dKbwdT+4CCTQXo9eVf3Z
 aKUF/UDfHcY4xzboBelq/cq6PQ02L9hst8B2kqlcTYFYf07gdNVAhxpiXPzJacL/h7H7ICu
 VU88HNCXAP4HiDTb/WThfUn4pxOsm3voa2uZum5NT92NSzUaposEkcoXAszvLqrQ7FSkRSM
 7fn1FMfkLWJsou+ZftJ2Q==
UI-OutboundReport: notjunk:1;M01:P0:vQLEdvIZe6k=;ZpiHFlc6LM5RjB3xm1vpeHC5jQS
 AdIA323/SfIXwQ1ZfrbytsJAUCWqI0YosWPuEEuwRjghuX00YF/6IA8S/PcYQ3qjSeZGxkbPa
 B4NHXAU6vXqAvGctH0DSjZ/MyTFsDDa9YT6ugeIaz5NuN684iF+w55PsKzpoDsASck/LjsgGk
 dym4U1qf7u3I/C3ThNr+V7nFyxTGyOtAdhDXXxBARvUN4d/9UsExnZo0ps+3g+mHT3SSvvLLb
 8pnrRyTdPr4OcX2I2Q2mKH72PzZp+uy6O122a5klQANLhmEt0/2WqeuykAjzR3QRsWhIjstws
 JsCBpRQLbEZh0iCEDvw6k+8kozB8BrGJonI64/lQDOE+RQo9msxUIsZHaRCyMmYTVmzfOAqHK
 6iWDYBynWI8hIwmXYB1rczDDFNzD0k/npytFSueTbuqyNzlR3PGevwJmQ4qzt4vCmp67w+62g
 QIal+BkSpwoS0cjicvsFstLIk7ZBP1ol5sx/Zlaq3PrWBL2JQwxLgJO3ivI65WlSju+GOeYvY
 z0b25F4KyMNlMZVgxIwHTLMG9Bv/NbM/OUkXPMKYGho8vzMpWrko9Ov/ePxUFHw9uw6aDduWR
 y0mPbLCFdApQ4h3C6sZiFszL4bO1vDMxzmGcbxbYFu4hs4dp9Nxj0wvRiwaxn/EAAuIh4xxkN
 5gLR9cFxS/BedwOF81vFuCSupn2dyd4si1or/i1L7QxNIVLSGYn66QIQiGQN19Ulp7ZtAsFD3
 ggiXgQF5lMGfAo+smmxGV+bLZlB/eGI21d3568iKTyyWDVbcgXMgfyDEzj8UG199ROL1MVdzw
 O3w2DAQbFdQ4uSUluMsWJsWA==
Subject: Re: [cocci] Determining a return code variable for a jump target
 (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1876
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/c2b0fc58-a399-4376-a4a4-2f7a3ed219f0%40web.de>

> I might be =E2=80=9Clucky=E2=80=9D for some function implementations
> when they contain only a single integer variable for returning
> result values.

It seems that my source code transformation approach is still too incomple=
te so far
if I would like to be able to improve also a function like ath12k_pull_reg=
_chan_list_ext_update_ev().
https://elixir.bootlin.com/linux/v6.11/source/drivers/net/wireless/ath/ath=
12k/wmi.c#L4683

It contains the following variable declarations.

	int ret, i, j;



SmPL script variant:

// See also:
// ath12k_pull_peer_assoc_conf_ev
// https://elixir.bootlin.com/linux/v6.11/source/drivers/net/wireless/ath/=
ath12k/wmi.c#L5612
@adjustment2@
constant c;
expression e1, e2;
identifier rc2, x;
fresh identifier target =3D "free_" ## x;
@@
 int rc2;
 <+...
 if (...)
 {
 ... when !=3D \( x =3D e1 \| e2(..., &x, ...) \)
-   kfree(x);
-   return
+   rc2 =3D
           -c;
+   goto target;
 }
 ...+>
+rc2 =3D 0;
+target:
 kfree(x);
 return
-       0
+       rc2
 ;


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch =E2=80=
=A6/Projekte/Coccinelle/janitor/use_common_kfree_code2.cocci drivers/net/w=
ireless/ath/ath12k/wmi.c
init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
=E2=80=A6
SPECIAL NAMES: adding list_for_each_entry as a iterator

previous modification:
MINUS
  >>> rc2


According to environment 1:
   adjustment2.rc2 -> id ret


current modification:
MINUS
  >>> rc2


According to environment 1:
   adjustment2.rc2 -> id j


exn while in timeout_function
adjustment2: already tagged token:
C code context
File "drivers/net/wireless/ath/ath12k/wmi.c", line 4975, column 8, charpos=
 =3D 151798
  around =3D '0',
  whole content =3D       return 0;



How will corresponding case distinctions evolve further (with SmPL disjunc=
tions)?

Regards,
Markus
