Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63820C02198
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2025 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bYRTrXtZjEWyWEGlvnUb3xgMnnGAZ53RnHPLzIwwWgA=;
  b=W9xEa+a7wRz4/Bzs63zrw7W5l1YrJA5XF995mvxzFbIGqwK5rbXsCi2A
   kvjMOC5btgD+cWMwr8QjimO+1AxJSm56TsfEM8S40Hev2rzywTKjV8psq
   vt8V8z6QkCr5O7XNmby182kMDHr+i0Mu4PlX/8UqNxMZTiV0FJVKYXb+k
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,269,1732575600"; 
   d="scan'208";a="207282310"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2025 12:26:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E179E0D1D; Sat,  8 Feb 2025 12:26:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2BECBE0261
	for <cocci@sympa.inria.fr>; Sat,  8 Feb 2025 12:26:52 +0100 (CET)
IronPort-SDR: 67a73f7b_yB7ZIQLoJc/P98KTiIz7MzX2r6OUuY1g7jHh1huagCUEX8z
 NpgmwziRc/cfeZpKcNBxIxU4bEf5b2jZZA8OGqw==
X-IPAS-Result: =?us-ascii?q?A0EtEwC+PqdngwsR49RagQmEF4FXMwQLSIRWj0+BdDCEO?=
 =?us-ascii?q?4c7lBwPAQMBDUEBAgQBAQMEhQACiwQCHgcBBDQTAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAhABAQE6Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAkdEAQEBAgEjBBkBAREmAQQLCxoCJgICVhsBAYJ+gjABAw4jB7BLfzOBA?=
 =?us-ascii?q?YIMAQEG2lwfLCJXgWUJgRouhWyCYwGKYicPgVVEgTyDAz6BD4J7OU2DDoJpg?=
 =?us-ascii?q?jOESGeXH4M3iTBSexwDWSwBVRMXCwcFgSlIA4ERI4EjBTVBOoINaUk6Ag0CN?=
 =?us-ascii?q?YIefIIragQFgS2COYRDhE2FWoE6WIFgAwMWEAGCMXB4HINVeR1AAgELbT03C?=
 =?us-ascii?q?QsbBj2fOYUqgnTGDzQHgjiBZoFjDJ9cBhMvl0MOBpJ7mHykEYUdgX4jgVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OOoQUxUtCNTwCBwEKAQEDCYVGAQGKRDSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Otn+favHs5Ydj2yox0JYLcyA7skD1dV00zEX/kB9WHVpmwKj9v
 xG+85rsyMc6QxhP03I/OrrBEDuex7hHPJOjbX5eI3SPzUPVgOTXf1fBMjZskDd8xSXzJ8j6U
 4YSdkBNDSoNykKsS+Z2mmF+qcbsb26GfuT9J7jJh5WJGkAV0gj1XYaNu/8KCJLrWJ9dP8E/f
 SniPavjgDQCUg/X4CUBmQlQ+OGnNHCjpTgCCR2fSIP2U2hjS6I9LW/KBST3g4fXzRTqI1Sil
 TtokjW5riDr/r+8RPX13bS45NK3PPtx8BOHtbksLlmFhzcziipeaV8UPm5sDc5rPrH0idTrP
 DArw08P8N69nPWeXvdm2qf5zXd
X-Talos-CUID: =?us-ascii?q?9a23=3ANtyo1GlOCRUi0D5HoWteh9Yk5srXOXyE/nD5exC?=
 =?us-ascii?q?1MFYzV42SRQCeoag8itU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AA0/OJA6pOfFVPts6/FiK9VmGxowzzZyJUV8Jgak?=
 =?us-ascii?q?sos2EJTYtPT69vGuoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,269,1732575600"; 
   d="scan'208";a="108555157"
X-MGA-submission: =?us-ascii?q?MDFMcmgdRZ3stYweWBkAbn09age47+C6hNQACU?=
 =?us-ascii?q?gyJWl/qkTq/T6ad7SPTLiq6ZLLgqwlgQ2It4y6MwwQlYFSpQz7hPGJhA?=
 =?us-ascii?q?CzLm+MmQSjq/eWjGMcaaoz7TDU+AlA23CLpjA5Omgf/HRdsawR9cuUXP?=
 =?us-ascii?q?xablUf9Qqs7vjTZRbgGaMWhQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 12:26:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739014008; x=1739618808; i=markus.elfring@web.de;
	bh=bYRTrXtZjEWyWEGlvnUb3xgMnnGAZ53RnHPLzIwwWgA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JQkFsW5RnjdiffYFDMGQ0LtXOPt9Qv1SmzUYv47sTs6+sdkQJDdyYnXhDVopLSEe
	 G8hAb8fuNCKVGhU4BeLvbZBnf0V8f++W2tilIrdQtuWbvjjXdG7lGr2lovdPjimkz
	 HqycigL/Jn8Bfa4p4miVMDIlsdAYsRdLmr7ZnTgRVCJZcJzmagMSLMJkqR1LPPC8q
	 5parBi3CPeuBJVy+M0aomonvEKAqdX7Qrz8uQ4DOvSrpP+ao2f1CbJIZEBpkuoWLI
	 cTa7ULLknmJ2l/ofmc1Yox4usmAyzLCrLhmSCubwPlJMQLtJyHnrii0U12tZmkczo
	 Hider1QwaiBU872kqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.11]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1t6Hhl2m7Z-00lkac; Sat, 08
 Feb 2025 12:26:48 +0100
Message-ID: <6bbdaca7-2fa0-4bdf-bdc7-ba76a5a1d171@web.de>
Date: Sat, 8 Feb 2025 12:26:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
 <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
Content-Language: en-GB
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jJUpKxrOdbdZ1LSo8gtUL2IstWgUFYZkMVF5FG5H5+ujcDca5rv
 XiiEERAX1NUzAHqf97DgVxfVaas+N3Q4XqgWsGWiQ5Rh0zWzQHm048yNiAFeHraXTFPLKes
 o618B/5TAl2qOk9+c+pN6WlP+LfBuauhmEpuyhDprYpTRbuxsH+w5VoAUKVXm77+KzIrGvL
 h0jvcyPuqKucZiJXsW8ww==
UI-OutboundReport: notjunk:1;M01:P0:gv1SjwHUdgQ=;V4gKQKDwykiWpKpYdbmO9XFZU4/
 sL1ZSnPtIgzKXz6eHstkhS4rilfK5ZV36rQuWnK/T92AVJrlSYl2Qylu+UGcDvCFAIAB79f3P
 GmK6A3DjusGD8S0JxOLJvG74u/9sPkhK+5z4G6kjr6tjH3o+vkmSAXSNM8z+P0LMXPUda+dOC
 ikv2B+TXFqepfzUuYzqQEQYoNnJTp7hYoWTJr6+xuyLPbClm8jugLIiPSo8ExI3hPHznKx6fl
 6Op2tBF9zjkEvLSCPiG4aAu/YLriyPkZ+RCQs8d0yI926eS4gsTSFkvu0MGirrGfS2aXFzYsx
 iHvVmNuLL3nvsZ9HAa+GeaHgh7ySnfnfXOWgouHiPeZulFeWm3cBlOQ6NLKuQQH3dTtZa+q9F
 8pnPa0id7eQg0VowJcIUnAm4LlqooycsYr91t4oGx0xE1h9seQHKNLEpttFpGFxywJGjE0xx8
 +yFUnYSV9qRTeyzF2+v+NPmIawkwJHs42XL0NbjERAj5woIVaLh84cnczq7WZXIsDIFyoCjRW
 LtZbpZNjT9C+NpxUzQcJsmNG6WO0riTLmdvoJ6J0Mp/NpI67xgVYnCC+a5ii93o/sh2/2dpfK
 7+hQhTHeouBpmevykBfvtytpON3NnEo6HrMipARqZTJP2EhyFQgl3U/WJayMxlZ3J/0Ym+fGA
 K+WsZPOuEaEEOg7QRYt97B2TaNPBBTSCvyHKh6+nmDq05mtPadDPzqPKbk1Er868m/eobzv49
 1hx9f2qTfAeTixrzq0sZ+mDlwdfHC3/a0Z5lSTIR0id0DX+87oimwVsjsTvhT4jLlsl5ujsCI
 jE3GUrGIc62pl0OhYo21hS3T4ZyEjzgnvUWPyPE/kEl4htiLUQIVvaiR2NxhCiVSH2nVhL7Qp
 lUnrNh3Y79mAr0IuGl5hzmIuRVTU4SXrOonsCMiabdeGHuiZ74USwcYIB+y9Xf1TO/mnHgfhT
 qti8THa3qKyYrZX/FmowXEn8d4w9EWOt2h0IMjL/zvkBkOGLfan/hmnEb1ls7YT42MyvMyNzZ
 zTXWqG+K7ItTVH9uV5fuwDYedKLTwC3wcnDhWQpUAhw2RE4M7Vo3GdPbkO0a+lzTN3SkNKazN
 exVQ9HDmUxcd8Jy2vfS7z410pR1PzL4nRIv41DUqygS922/M/oC3SalbDZJXFwNLWB59IIfNe
 20/Kmdps9gtto8QmVKZ4Cf5OZ8edPfF9HnMTjaub9sj1NSy9i1pNseuAWcMg2dJLsOYO6FFxV
 UYB/C39sKMe4Rok3pahxI7XUIB6W3BpR7YtbIf8w8xy9zMryTjB+8JhlNxPKESAYamH8WHdTc
 78QfsjftRBQRTyBljg+QVtSaV7rWmXYhv0n2wzcEG43ZTO+M5XHOUwfSzcVUeoYVIQY2CS+jF
 R2tDV0Dl5ncjQZnKV0YI5uVsVLiJOP2M24HVhzHPUZYkUFaqngu1Rr00oME/nEq07/ZY3IB5E
 B+OJZMA==
Subject: Re: [cocci] Checking SmPL test cases?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2371
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/6bbdaca7-2fa0-4bdf-bdc7-ba76a5a1d171%40web.de>

> That seems ... simple enough?
Can you get further development ideas from test data like the following?

SmPL script example:
@deletion@
identifier i;
@@
 static inline int
 i(...)
 {
 ...
-if (rnr_elems) {...}
 ...
 }


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time spatch dele=
te_statement3-Johannes_Berg.cocci test-beacon_len-20250206.c
=E2=80=A6
diff =3D
warning: deletion, node 19: statement[1,2,4,5,7,8] in my_beacon_len may be=
 inconsistently modified
warning: deletion, node 16: [fortrue][1,2,4,5,7] in my_beacon_len may be i=
nconsistently modified
warning: deletion, node 15: for[1,2,4,5,7]* in my_beacon_len may be incons=
istently modified
=E2=80=A6
@@ -7,12 +7,5 @@ my_beacon_len(struct cfg80211_mbssid_ele
 {
        int len =3D 0;

-       if (rnr_elems) {
-               u8 i;
-
-               for (i =3D 0; i < rnr_elems->cnt; i++)
-                       len +=3D rnr_elems->elem[i].len;
-       }
-
        return len;
 }

real    0m0,058s
user    0m0,041s
sys     0m0,016s


Another source file example:
static inline int
my_beacon_len(struct cfg80211_mbssid_elems *elems,
	      struct cfg80211_rnr_elems *rnr_elems,
	      u8 i)
{
	int len =3D 0;

	if (i < elems->cnt) {
		len =3D elems->elem[i].len;
		if (rnr_elems) {
			len +=3D rnr_elems->elem[i].len;
			for (i =3D elems->cnt; i < rnr_elems->cnt; i++)
				len +=3D rnr_elems->elem[i].len;
		}
		return len;
	}

	return len;
}


Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time spatch dele=
te_statement3-Johannes_Berg.cocci test2-beacon_len-20250206.c
=E2=80=A6
real    0m1,653s
user    0m1,635s
sys     0m0,017s


May I expect the generation of corresponding difference output here?

Regards,
Markus
