Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBAF105F792
	for <cocci@archiver.kernel.org>; Fri, 13 Mar 2026 10:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Y0p6Wia6p9UArJK4wtyTlXTnRT4xcD1Px6GZuMRFGio=;
  b=FpqMU2uTDY+xcKmvbB+1O5K6wAToVOtVy3O8OVI6OsxljSZcgyrmat+D
   p0ElD6nGipMiV45hEh1vvYEopz2bPuN8+Pk8gok230jQ9oxe8cNCGhXLk
   s9yD3a2fafFvjLGhl+Lqlg+lFU47GlS3/5iiZ0WMDGfpBScijuLfofQVq
   o=;
X-CSE-ConnectionGUID: N1MfnxihTmu3pcQRNpWLCw==
X-CSE-MsgGUID: 4r2VPLdRSUeWxShuWwS3OA==
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
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208,217";a="267644964"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2026 11:27:47 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0FF7E81D0E; Fri, 13 Mar 2026 11:27:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3D54182D93
	for <cocci@sympa.inria.fr>; Thu, 12 Mar 2026 16:43:54 +0100 (CET)
X-CSE-ConnectionGUID: X/+Rv478QFqY0b3VD6Cldw==
X-CSE-MsgGUID: 11LUddRQRWq+jzFbgTOdpQ==
IronPort-SDR: 69b2df3a_uOO5V/cX52TjaaShfc9K5opvx1ZSEs/MiF6Ta1fQNHG7Yzk
 4vg7BRBQJSAcgTIzweHQ52BgFX44YRFkJsn5uZQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FSLABQ3rJpheJU31FagQmBUoE7GwJnaB9eNAQLSQgVj?=
 =?us-ascii?q?FmHNYIhbJEuii6BVoF+BgkBAwENFAIBAg4WFAQBAQMBA4UAjSUCHgcBBDgCD?=
 =?us-ascii?q?QECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAUBJhiAvA?=
 =?us-ascii?q?QyCWztxgSUBAQEBAQEBAQEBAQEBHQINB1dmAQERJxEBDIEaBBuCegGCHQcPQ?=
 =?us-ascii?q?AcNBq9DgTSBAYIMAQEGgmjYfy0WgWcDBoFLAwGFAmuCShsBBSVJbAGETIRpD?=
 =?us-ascii?q?4FVRIFKgkSDORcEgguFdSKCJnoUHYtThzQsgRgiAyYzLAEPETUTFwsHBYFmA?=
 =?us-ascii?q?yovLTI8Mh2BIz4XM1gbBwWFGg+IcIFhgRODJQMLB2Y9NxQbBgGBNY0RXD2DQ?=
 =?us-ascii?q?gErgV8LE3qiQYF8oUY0B4I4gWeBZAyJCIEmlUIuF6prmQYijWeVYIVYghYMg?=
 =?us-ascii?q?VwzGoNaTwMXAg+NeAFBgh6GXMNQRjICOgIHCwEBAwmSHi49YAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NwFpoK0hfImEN6T1HRAEVAqjBGUkLtp133Aq2lEZdPUMSKylfr
 OV7ZcmPH7P+VEssRQb6Ku90ca7L080maQf3WBzB8bFYOCFggqVxehZhOPfKlbbdhEWg9Qz6U
 4WScRD4bPLZ2RSvILUzE2AFdMhysnC0I3Av5an815dCS5HQ5slxQJ4BgGHVm1OLTM2fKbRX6
 DshPav7wDQHEj/QP7LYkU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3A9bqvX2u+wHe8F6MWVpnvm7ui6IsVNT7n0iuPc3a?=
 =?us-ascii?q?WEFcxQuarZQG7/K97xp8=3D?=
X-Talos-MUID: 9a23:WzNz9wVFPKmBhIzq/Ga1oAxuOP1R2Zu3S0Ifv58Jh+6ILRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,116,1770591600"; 
   d="scan'208,217";a="267524872"
X-MGA-submission: =?us-ascii?q?MDFEqnnSYTniB26OddpFUt3Twvgf/b0KvGjwfY?=
 =?us-ascii?q?NCMcau8dAewymIK5EiNvVbNvSolcmkaZQpa263dKcessrBaZLbnFYWzY?=
 =?us-ascii?q?I9ANTz2YW//d39aUXsBiXRWYrXdEScxiOtUg2YqgnbH8+rkytVW0b3PB?=
 =?us-ascii?q?hFWHNcQCk5m7y+ujFCucm+IQ=3D=3D?=
Received: from mx1.ist.ac.at ([81.223.84.226])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 16:43:53 +0100
From: Alice Lee <Alice.Lee@ist.ac.at>
To: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: Can Coccinelle parse files where macros are used as binary
 operations?
Thread-Index: AQHcsjYep8nLBSYGA06CAzIMKRr3TQ==
Date: Thu, 12 Mar 2026 15:43:51 +0000
Message-ID: <274abdf3dbbe4c3e8f1f33fba516c8b3@ist.ac.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.15.51.121]
Content-Type: multipart/alternative;
	boundary="_000_274abdf3dbbe4c3e8f1f33fba516c8b3istacat_"
MIME-Version: 1.0
X-FEAS-Client-IP: 10.17.21.11
X-FE-Policy-ID: 1:3:0:SYSTEM
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] Can Coccinelle parse files where macros are used as binary
 operations?
Reply-To: Alice Lee <Alice.Lee@ist.ac.at>
X-Loop: cocci@inria.fr
X-Sequence: 3425
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/j3cUvfeIb7w-PnWtmZrDcg>

--_000_274abdf3dbbe4c3e8f1f33fba516c8b3istacat_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

  *   Hello,

I am trying to use Coccinelle to search C codebases (I split up my question=
s to make the threads more clear) and I am struggling to understand the sco=
pe of the --macro-file argument.
  *
  *   Can macros used with #if in the source code be defined in a file pass=
ed with --macro-file, and then the right sections of source code are ignore=
d? I was unable to get a small example to work, so I assume that I can defi=
ne the macro but then there is no preprocessing to drop code. If I'm not ov=
erlooking something, how would you recommend I parse a file including these=
 lines and then uses LS/RS as binary operators<https://git.musl-libc.org/cg=
it/musl/tree/src/string/memcpy.c#n50>:
  *

  *
#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
#define LS >>
#define RS <<
#else
#define LS <<
#define RS >>
#endif

I'm especially confused by this example because Coccinelle also cannot pars=
e a version in which I remove the code above and put one of the pairs of de=
fines in the macro definition file.

Thank you,
Alice Lee

--_000_274abdf3dbbe4c3e8f1f33fba516c8b3istacat_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFo=
nt&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols;">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;=
,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&q=
uot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p><span id=3D"ms-rterangepaste-start"></span></p>
<li>Hello,</li></div>
<div><br>
</div>
<div>I am trying to use Coccinelle to search C codebases (I split up my que=
stions to make the threads more clear) and I am struggling to understand th=
e scope of the --macro-file argument.</div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;=
,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&q=
uot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<li><br>
</li><li>Can macros used with #if&nbsp;in the source code be defined in a f=
ile passed with --macro-file, and then the right sections of source code ar=
e ignored? I was unable to get a small example to work, so I assume that I =
can define the macro but then there is no
 preprocessing to drop code. If I'm not overlooking something, how would yo=
u recommend I&nbsp;parse a file including&nbsp;these lines and
<a href=3D"https://git.musl-libc.org/cgit/musl/tree/src/string/memcpy.c#n50=
" class=3D"OWAAutoLink">
then uses LS/RS as binary operators</a>:&nbsp;</li><li>
<div><br>
</div>
</li><li>
<div><span style=3D"font-family:Consolas,Courier,monospace">#if __BYTE_ORDE=
R =3D=3D __LITTLE_ENDIAN</span><br>
<span style=3D"font-family:Consolas,Courier,monospace">#define LS &gt;&gt;<=
/span><br>
<span style=3D"font-family:Consolas,Courier,monospace">#define RS &lt;&lt;<=
/span><br>
<span style=3D"font-family:Consolas,Courier,monospace">#else</span><br>
<span style=3D"font-family:Consolas,Courier,monospace">#define LS &lt;&lt;<=
/span><br>
<span style=3D"font-family:Consolas,Courier,monospace">#define RS &gt;&gt;<=
/span><br>
<span style=3D"font-family:Consolas,Courier,monospace">#endif</span></div>
<span id=3D"ms-rterangepaste-end"></span></li></div>
<div><br>
</div>
<div>I'm especially confused by this example because Coccinelle also cannot=
 parse a version in which I&nbsp;remove the code above and put one of the p=
airs of defines in the macro definition file.</div>
<div><br>
</div>
<div>Thank you,</div>
<div>Alice Lee</div>
</div>
</body>
</html>

--_000_274abdf3dbbe4c3e8f1f33fba516c8b3istacat_--
