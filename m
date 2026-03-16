Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE481F3382E
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2026 09:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Qv1VMF53sdKP6bJibYOvKzCWdPjDE6ssBK/hqv9X/0w=;
  b=oMCYk1dFQ+BkyX0JeM9UjkddlG2zyHMueLwqFXUmc8uljipTxvgxa6Cp
   E5sx4T3GKA0BK/mp813EcS5VniVrKqTJ4a28TXmMuxSiNt/LW1ML4dFv1
   e6dUOMeEfOGzq9FYUdyCewT+XNXSe6VTX1x6XXJT6P/a9nfAFfD8nvZXk
   I=;
X-CSE-ConnectionGUID: cs9NDLh+QziO4jpDbA6waw==
X-CSE-MsgGUID: I/VNK+s2QXqiFaHZtkVuRA==
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
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="scan'208,217";a="268119344"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2026 10:40:42 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 607B1822FD; Tue, 17 Mar 2026 10:40:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C7C3880E28
	for <cocci@sympa.inria.fr>; Mon, 16 Mar 2026 13:56:16 +0100 (CET)
X-CSE-ConnectionGUID: +e0L9QM6SxSWw1rMaEKs3A==
X-CSE-MsgGUID: vwH9gGAuRUukro7l+zZLxw==
IronPort-SDR: 69b7fdf0_sC+ijTf4DEyzd3Ab3rlCO2YakyskbuQCx1bGpQ9AeBHMKIe
 VtzWAY1pIfV8iuW0fy2xw3oyryf2Y7/8HiJnA1Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E+AQB6/LdpheJU31FaHAEBAQEBAQcBARIBAQQEAQGCE?=
 =?us-ascii?q?IE9AYEDgWU0BAtJHZYvA4ETkQSKLoFpgWkCBgkBAwENUQQBAQMBA4UAAo0jA?=
 =?us-ascii?q?h4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBA?=
 =?us-ascii?q?UBJhk8NgmIBM4IWLBR2AQEBAQIBLRMBAREmAQ8CAQgRBAEBL04IAgQOBQiCe?=
 =?us-ascii?q?oIeDCMnB7ZAeIE0gQGCDAEBBoJo2H8tFoFnCYFNhTwzgkoaAQEFJUlsgluBI?=
 =?us-ascii?q?TSDZXonD4FVRIEVNYI9BzE+hA4BEgEmhh0igiZ6FB2IIxKKHywmciIDJjMsA?=
 =?us-ascii?q?Q8RNRMXCwcFgSNDA4EGIw88BS0dgSMhHRcUH1gbBwUSISpOeIIBD4ZleQMuX?=
 =?us-ascii?q?hoOIgI5XEo+C1IFgiwCJwMLB2Y9NxQbBgGBNYxWXDyCNXoTAYFDRwsTepMtj?=
 =?us-ascii?q?xSBfKFGNAeCOIFngWQMn3AuF6prmQajXA2FWIF/I2xwMxqDWk8DFwIPjiEZJ?=
 =?us-ascii?q?YF5ywtGMj0CBwIHDQMLkhwuPWABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 d0DgKbOyckwYNicTSjB3Q==
IronPort-HdrOrdr: A9a23:+zpz76jXQhkCi65xRMEwPzpdgXBQXiAji2hC6mlwRA09TyXBrb
 HKoBwavSWYtN9jYgBFpTngAtj5fZq4z+8I3WB/B9aftWXd01dAabsSj7cKoAeQYBEWlNQ86U
 4IScEXNDSzNykYsS+Q2mWF+qMbruVvh5rGuQ6x9R1QZDAvRI0l1gF9CgyKVm1aLTM2eKYRJd
 6yyuJ84xCkeXgRc4CaPxA+LpL+Tpbw5fXbiFY9dngaASe1/EqV1II=
X-Talos-CUID: =?us-ascii?q?9a23=3A/3J7hWpRJS0DV/oox8xrM5fmUYMoKlmM9VKOGF+?=
 =?us-ascii?q?DNnkwUpicZHyLo4oxxg=3D=3D?=
X-Talos-MUID: 9a23:r6Ie3QYPJJ1sCuBTqSDM1T5NHdpS3rmtEkdSldYUie2UKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="scan'208,217";a="267968837"
X-MGA-submission: =?us-ascii?q?MDH6BUrZqXNZFsNRDOgqNnX0YCSiVw1M/t+R+i?=
 =?us-ascii?q?tyxys2ptcFmTdO/zbJqYfcBcJbSiFZ9zlDHT/cKAYSIu2eVSJ6Jsqyny?=
 =?us-ascii?q?DK1qUp/gwWlQUFXhlrZzyUjmP+g/nDRCHfCe3kyl3ru0QQlpXrrcgKTc?=
 =?us-ascii?q?u7O9BfFlp+aBsh/IxNFm3GdQ=3D=3D?=
Received: from mx1.ist.ac.at ([81.223.84.226])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:56:16 +0100
From: Alice Lee <Alice.Lee@ist.ac.at>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [cocci] Can Coccinelle parse files where macros are used as
 binary operations?
Thread-Index: AQHcsjYep8nLBSYGA06CAzIMKRr3TbWscbAAgASxE4I=
Date: Mon, 16 Mar 2026 12:56:14 +0000
Message-ID: <79a19f5adf154119b6c4d0dc7187e383@ist.ac.at>
References: <274abdf3dbbe4c3e8f1f33fba516c8b3@ist.ac.at>,<5cd9a9c8-9f99-417f-dcfe-5c1b136ec5bf@inria.fr>
In-Reply-To: <5cd9a9c8-9f99-417f-dcfe-5c1b136ec5bf@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.15.51.121]
Content-Type: multipart/alternative;
	boundary="_000_79a19f5adf154119b6c4d0dc7187e383istacat_"
MIME-Version: 1.0
X-FEAS-Client-IP: 10.17.21.11
X-FE-Policy-ID: 1:3:0:SYSTEM
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Can Coccinelle parse files where macros are used as
 binary operations?
Reply-To: Alice Lee <Alice.Lee@ist.ac.at>
X-Loop: cocci@inria.fr
X-Sequence: 3442
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/cIIufMwdKsVVPXjAeMcEQA>

--_000_79a19f5adf154119b6c4d0dc7187e383istacat_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Julia,


Is there an alternative to --defined that allows me to actually define a ma=
cro as in the "#define LS <<" example? If I modify the code to use a simple=
r switch than the equality check from the original as follows:

#ifdef SYMB
#define LS >>
#define RS <<
#else
#define LS <<
#define RS >>
#endif

I still get a parse error when I run "spatch --cocci-file rule_test.cocci -=
-defined SYMB musl-1.2.5/src/string/memcpy.c --debug"'; is this actually be=
st done by a preprocessor and out of scope for Coccinelle?

Thanks,
Alice

________________________________
From: Julia Lawall <julia.lawall@inria.fr>
Sent: Friday, March 13, 2026 3:12:34 PM
To: Alice Lee
Cc: cocci@inria.fr
Subject: Re: [cocci] Can Coccinelle parse files where macros are used as bi=
nary operations?

[EXTERNAL EMAIL - USE CAUTION when clicking links or attachments]




On Thu, 12 Mar 2026, Alice Lee wrote:

>
> Hello,
>
> I am trying to use Coccinelle to search C codebases (I split up my questi=
ons
> to make the threads more clear) and I am struggling to understand the sco=
pe
> of the --macro-file argument.
>
> Can macros used with #if in the source code be defined in a file passed w=
ith
> --macro-file, and then the right sections of source code are ignored? I w=
as
> unable to get a small example to work, so I assume that I can define the
> macro but then there is no preprocessing to drop code. If I'm not
> overlooking something, how would you recommend I parse a file
> including these lines and then uses LS/RS as binary operators:
> #if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
> #define LS >>
> #define RS <<
> #else
> #define LS <<
> #define RS >>
> #endif
>
> I'm especially confused by this example because Coccinelle also cannot pa=
rse
> a version in which I remove the code above and put one of the pairs of
> defines in the macro definition file.

I think you want the following command line options:

  --defined                     <symbol> treat cpp symbol as defined in #if=
def
  --undefined                   <symbol> treat cpp symbol as undefined in #=
ifdef

--macro-file is for providing dummy definitions for macros used in the
code that you are trying to parse.

julia

>
> Thank you,
> Alice Lee
>
>

--_000_79a19f5adf154119b6c4d0dc7187e383istacat_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>Hi Julia,&nbsp;</p>
<p><br>
</p>
<p>Is there an alternative to --defined that allows me to actually define a=
 macro as in the &quot;#define LS &lt;&lt;&quot; example? If I modify the c=
ode to use a simpler switch than the equality check from the original as fo=
llows:&nbsp;</p>
<p></p>
<div><br>
</div>
<div>#ifdef SYMB</div>
<div>#define LS &gt;&gt;<br>
#define RS &lt;&lt;<br>
#else<br>
#define LS &lt;&lt;<br>
#define RS &gt;&gt;<br>
#endif</div>
<div><br>
</div>
<div>I still get a parse error when I run &quot;spatch --cocci-file rule_te=
st.cocci --defined SYMB musl-1.2.5/src/string/memcpy.c --debug&quot;'; is t=
his actually best done by a preprocessor and out of scope for Coccinelle?</=
div>
<div><br>
</div>
<div>Thanks,</div>
<div>Alice</div>
<p></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Julia Lawall &lt;ju=
lia.lawall@inria.fr&gt;<br>
<b>Sent:</b> Friday, March 13, 2026 3:12:34 PM<br>
<b>To:</b> Alice Lee<br>
<b>Cc:</b> cocci@inria.fr<br>
<b>Subject:</b> Re: [cocci] Can Coccinelle parse files where macros are use=
d as binary operations?</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">[EXTERNAL EMAIL - USE CAUTION when clicking links =
or attachments]
<br>
<br>
<br>
<br>
<br>
On Thu, 12 Mar 2026, Alice Lee wrote:<br>
<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; I am trying to use Coccinelle to search C codebases (I split up my que=
stions<br>
&gt; to make the threads more clear) and I am struggling to understand the =
scope<br>
&gt; of the --macro-file argument.<br>
&gt;<br>
&gt; Can macros used with #if&nbsp;in the source code be defined in a file =
passed with<br>
&gt; --macro-file, and then the right sections of source code are ignored? =
I was<br>
&gt; unable to get a small example to work, so I assume that I can define t=
he<br>
&gt; macro but then there is no preprocessing to drop code. If I'm not<br>
&gt; overlooking something, how would you recommend I&nbsp;parse a file<br>
&gt; including&nbsp;these lines and then uses LS/RS as binary operators:&nb=
sp;<br>
&gt; #if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN<br>
&gt; #define LS &gt;&gt;<br>
&gt; #define RS &lt;&lt;<br>
&gt; #else<br>
&gt; #define LS &lt;&lt;<br>
&gt; #define RS &gt;&gt;<br>
&gt; #endif<br>
&gt;<br>
&gt; I'm especially confused by this example because Coccinelle also cannot=
 parse<br>
&gt; a version in which I&nbsp;remove the code above and put one of the pai=
rs of<br>
&gt; defines in the macro definition file.<br>
<br>
I think you want the following command line options:<br>
<br>
&nbsp; --defined&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;symbol&gt=
; treat cpp symbol as defined in #ifdef<br>
&nbsp; --undefined&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;symbol&gt; treat cp=
p symbol as undefined in #ifdef<br>
<br>
--macro-file is for providing dummy definitions for macros used in the<br>
code that you are trying to parse.<br>
<br>
julia<br>
<br>
&gt;<br>
&gt; Thank you,<br>
&gt; Alice Lee<br>
&gt;<br>
&gt;<br>
</div>
</span></font>
</body>
</html>

--_000_79a19f5adf154119b6c4d0dc7187e383istacat_--
