Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22BDC433EF
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=MESIg+oZV2ZsTdB44xa3lSxBTw/P6IVtbsUaZKnhwck=;
  b=XcbJJlqmNeenJdfu6MQETouilHm1wpz8cm/APd+LtsQBIFJlbn202kjA
   qxOupRthoxZdeflZSYcAYhSFePLxZNickmFiOrOcNX1cSw0w9Fnfg4IHw
   jvxbkB+8gOMLHNWuqxlCcH4J3bn8QnccsaFwunLwafNX/uJo5zRGlNSQN
   0=;
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
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27015058"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 18:05:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B4805E0210; Sat, 19 Mar 2022 18:05:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AEAE6E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 18:05:05 +0100 (CET)
IronPort-SDR: cy/LL90vMEgHVf1nyQIrJUGCg9N1BHew0lIloP/AyX8UmHbZtiMY3s/aFsvKZvwnrN1krQvwUM
 KIcqI0PbO98pw/gK8VUMASioCdD0TJWPc1PZFPI96q1Yqyxet3gQfp4ZhzdrEw136qHJrzHMw4
 MuaL4cPYLx4ZwQ5Gy6xQvdC7NdavX1XfhcJG/M/32QBPYhsQGSniwlr4jwC4KJBD4VIzcakHs5
 1RAKC+ftzINJOAtvUZulwnOoS8f2vKfBU4BFc45weuz34cvRxuzv2pkx1QVHfjaLQJoXDYkxWa
 gQ9wjNm3XtWG3uBOAKYsZKbC
X-IPAS-Result: =?us-ascii?q?A0BeBQD0CzZi/0Xcza1aHgENLwwOC4QLB4FNAQEBKQQLh?=
 =?us-ascii?q?Fo+jnOCKJ5fCwEDAQ1BBAEBhQMCAgJRBYNeAh0GBjQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBgQgsAWMBZwGBTgGBeQYEPYI1KQGDZAEEAQwXV?=
 =?us-ascii?q?hAJAkICAlcGgxeCdiGRcJwMgTGBAYl7gTyOSSccQIFNgTwMgkcwPodfgmUEl?=
 =?us-ascii?q?xxygTWUdI4KgUFUnhaDU59eGi6WSZF1llunAoE/OSWBWR8UGggmCoMlTQECA?=
 =?us-ascii?q?QIBDAECAgECAQIBAgEIAQECAY4oFo5OIQEBAWkCBgEKAQEDCY9OAQE?=
IronPort-PHdr: A9a23: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
 Qs=
IronPort-Data: A9a23:NkCj16DawT2pSBVW/xLlw5YqxClBgxIJ4kV8jS/XYbTApGkg0GQAm
 GcfXzjQOvqLa2ujc41wa9/noxgB68DVnINrOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPgUlvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYo27Ynsxc7
 c5Njp21Ywg4OYn829w4fzANRkmSPYUekFPGCX2v98GMz0DLd3b2hfNjECnaP6VBpb0xWzkTs
 6ZCcHZTP3hvhMruqF6/YuJrjc8iBM3qJ58E/Hx/zTzUCfs8B5bOX80m4PcCg29p25gTQp4yY
 eIwYAVIRS/aICEMKwcTAp5lx7qzplfwJmgwRFW9/vZpuDmMnGSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyHNiW1jOB9lq+h+rFhyq9WYQIFbT++OQCvbGI7mkDThAJVVa2pfSjzEizR7qzN
 nD45AJ1/Kku2WmwTuL8Wje3sXmgjl0kfvZ5RrhSBB629oLY5AOQB24hRzFHacA7uMJeeQHGx
 mNljPuyWmMy6Oz9pWa1s+bL/WnraED5OEdbPXdcJTbp9eUPt23as/4iZtNzVqOqjtD4HTzqh
 TaHsEDSZon/b+ZQh81XHnid31pAQ6QlqCZvvm07uUr8sGtEiHaNPdDA1LQixa8owUbwZgDpU
 II4s8af9vsSKpqGiTaARu4AdJnwuarabWOE0A80T8Jwn9hIx5JFVdsMiN2ZDBw2WvvohBezP
 RG7Vf15u/e/w0dGnYcsP9zqWpt6pUQRPdn6Vv3ZatdUY556MVfelByClmbLt10AUSEEz8kCB
 HtsWZ31XChAVvg/kmbeqiV0+eZD+x3SDFj7HfjTpylLG5LFDJJMYbtaYlaIcM4j66aI/Ffc/
 9pFbpvYzxRETPa4bzbX/IMXIEpMK3UnXMikp8tSf++FAwxnBGB4UaOKm+t8ItA8kvQHjPrM8
 1G8RlRclgj1i0rHHhrWOHptX7XiAMRkpnUhMC1xY1vxgyo/YZyi5bs0focseeV17/RqyPN5F
 qFXe8iJDvlVZC7A/jARMcv0oIB4LUT5gQOVIzHjbSc/cpNkShaP/NL4J1O9+C4LByuxlM0/v
 7z5jF+AG8JeHlg7AZ+POvy1zl63sXwMo85IXhPFcotJZUHh0Il2MCiv3PU5FME7NkmRzDWt0
 QvLUwwTovPAotJr/YCR17yEtYqgD8B3AlFeQzvA9b+zOCTXojijzItHXLradDzRTjqpqqCyI
 +hKz/zxNPAd2lBHr9MkQbpsyKs/4frppqNbl144Ry+TMg33U74wcGOb2cRvt7FWwuELswWBW
 nWQpotQN4KPNZ63C1UWPgckM7qOjKlGhjnI4P0pC0zm/ysrrqGfWEBfMkXekiBbN7cpYoopz
 f145ZwT+0qylRonP9KLlGZS+njVdi4MVKAut5c7Bo73i1NxlgoYOcGFVnb7sMOVdtFBEkg2O
 TvK1qDMsLRr2RaQeXQEE3WQj/FWgo4DuU0UwQZadUiJgNfMmtQ+wAZVrWYsVg1QwxhKuw6p1
 rOH66GhyWSyEzZUaAxrWnDqFh5BCRCd91a3zVYV/IEco49ESUSVRFDR+87UlKzaz46YVjxa5
 62Djmv6UTvneMzrmC0/RSaJbhAlocNZrmX/dQPOIyhBN507eib+xKKxZWcFrxb9R8U8mCUrY
 AWsEPlYMcXGCMLbn0H350R2G1jdpNBo6VGumc1cwZ4=
IronPort-HdrOrdr: A9a23:+lx2CaxrCoZUEcFEAC2bKrPwKL1zdoMgy1knxilNoH1uA7Wlf6
 LHppsmPHDP5gr5NEtApTnEAtjkfZq+z+8S3WByB8bHYOCOggLBR+wP0WKh+UyGJ8SUzJ8+6U
 4PSchD4QLLZ2RSh8yS2njaL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27015057"
X-MGA-submission: =?us-ascii?q?MDGMpTG/veOZiYQZgAERmtwdx16rWkbl/JFHOM?=
 =?us-ascii?q?p7rQPRWofYU1SrMdARrWezGhHXsZUtRR5xrUpdFCnVEAjvX2j2o0f44d?=
 =?us-ascii?q?TLZfaEQKsvGxZBZAozSJfFLN60ri4/McCimXJrMA5dgnXYluIiXMsWZk?=
 =?us-ascii?q?jorMbJ2dBRxV2Rw816ttUeAA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 18:05:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 178CC81;
	Sat, 19 Mar 2022 10:05:03 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eu11MzGGh36V; Sat, 19 Mar 2022 10:05:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 0604E40;
	Sat, 19 Mar 2022 10:05:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 0604E40
Date: Sat, 19 Mar 2022 10:04:59 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <869caaec-da7f-36a8-5048-817177756bc7@web.de>
Message-ID: <7da5a4-cec7-3112-e811-8e427acd1441@ewheeler.net>
References: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net> <75237f17-66ae-21c3-8796-c656315d99d0@ewheeler.net> <db684d7-8b40-d3be-969f-cb399e39d4c3@ewheeler.net> <e7182c14-5551-111d-7c41-16fb747fe505@web.de> <alpine.DEB.2.22.394.2203191219370.3204@hadrien>
 <869caaec-da7f-36a8-5048-817177756bc7@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2054788762-1647709310=:28642"
Subject: Re: [cocci] Can fields from structs be used added code as
 expressions?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 248
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/7da5a4-cec7-3112-e811-8e427acd1441%40ewheeler.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2054788762-1647709310=:28642
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 19 Mar 2022, Markus Elfring wrote:

> >>> 	// Add the compare_T() function call and compare_T function definition for each type:
> >>> 	@ r2 @
> >>> 	identifier struct_name.I;
> >>> 	fresh identifier FN = "compare_"##I;
> >>> 	@@
> >>> 	f()
> >>> 	{
> >>> 	++  FN();
> >>> 	}
> >>> 	++void FN(){}
> …
> >> I doubt that you would like to add only a single function (or macro) call
> >> within the implementation of the function “f”.
> > He has ++, which allows adding as many definitions and calls as there are
> > values of name.I.
> 
> 
> How do you think about the usage of further change details?
> 
> * Should the identifier “f” be a metavariable?
> 
> * Additional context information for relevant source code places
> 
> * Non-empty function implementations are probably preferred, aren't they?

Look closer at later rules in the SmPL.  The empty function definition is 
built out further down.  That is a placeholder for the compare_T functions 
that hold the all comparisons.

The reason for the functions is to group them by type (or really struct 
name) because otherwise ++ will make them randomly ordered.  At least 
grouping by function gave some amount of organization.

-Eric

> 
> Regards,
> Markus
> 
> 
--8323328-2054788762-1647709310=:28642--
