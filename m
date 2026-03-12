Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4823F105F791
	for <cocci@archiver.kernel.org>; Fri, 13 Mar 2026 10:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pBRKP9AkpqSDkvgheLgzkJgm61I+0DjiYg5aY1k9+eA=;
  b=Q0NVb8xrTuyXMwuGSicOuAp/wmNuPsXemZwfl8MVj3fZ8j/iu9Nfn3aQ
   JHo/zy3ovAdaN/uUud2m8xMD/QllHJhuAV0XS2BzTKwvPDZsaw+GJ7v44
   BU7B3+yT1xcgPOtv5Ysn9QIiXNEID+4InxqPzjzRIK5POLFSLWCqShDOc
   w=;
X-CSE-ConnectionGUID: iTHAkImRT9mDJC6tPYxuQg==
X-CSE-MsgGUID: szH6rabkRGS37KLmFGyJVA==
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
   d="scan'208,217";a="267644941"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2026 11:27:45 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id ACE2581D10; Fri, 13 Mar 2026 11:27:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DADD283594
	for <cocci@sympa.inria.fr>; Thu, 12 Mar 2026 16:34:54 +0100 (CET)
X-CSE-ConnectionGUID: mFnuW280RAOP9zuK+TTTUQ==
X-CSE-MsgGUID: TDXtWvDWTjqiqohQELFwcQ==
IronPort-SDR: 69b2dd1e_6gIUfYir/PQIRIBiJfxsPET3TqfsjIyjE9B+2dDo+zR1dS+
 Lyt9gAkOtXBLcb+giLHpiK8agqNlzWgcCIVfJSw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FGDgDl27JpheJU31FagQmBUoE7GwJnaH00BAtJHYxZh?=
 =?us-ascii?q?zWUO4ougVaBfgYJAQMBDRQTKgQBAQMBA5IlAh4HAQQ4Ag0BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQFASYYgLwEMgls7ghYsFIE9A?=
 =?us-ascii?q?QERJxEBDAGBGQQbgnqCHgcPQAevWIE0gQGCDAEBBoJo2H8tFoFnCYFLAwGFA?=
 =?us-ascii?q?muCShsBBSVJbAGETIRpD4FVRIFKgkSLVCKCJnoUHZMHLIEYIgMmMywBDxE1E?=
 =?us-ascii?q?xcLBwWBZgMqLy1uMh2BIz4PCDNYGwcFhRoPiHCBYYETgyUDCwdmPTcUGwYBg?=
 =?us-ascii?q?TWNEVw9g0IBggqTex+PP0eBNYIhnyU0B4I4gWcFgV8MiQiWaC4XqmuZBiKjG?=
 =?us-ascii?q?yyFWIIWDIFcMxqDWk8DFwIPjXYBAQFBgh7KH0YyPAIHCwEBAwmSHi6BHQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+ZfMu6quQHJAne/9+qUa9scaV5r8eYIsimQD101hICG9Kvb5qy
 ncpoV56faUskd3ZJhEo6H6BEDuex3hHPJOirX5Xo3SOjUO2lHIEGgK1+KL/9SKIUDDH5tmup
 uIBJITNDSfNzJHpPe/zyX9KtAkwNOWtICE7N2ut0tFfEVER4lbqy19CgqdDwlXfWB9dOME/d
 Gnl6h6TnKbCBEqh+qAdx04Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3ASoE4vGnX3prfgN48km16szxt/brXOXjzymrveR/?=
 =?us-ascii?q?gM09OcOyHVHzTxJ9YrvM7zg=3D=3D?=
X-Talos-MUID: 9a23:OXqoNAYiWyHZd+BTixPcmA58GPhU4b2vEUcNqLgildaPDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,116,1770591600"; 
   d="scan'208,217";a="141167415"
X-MGA-submission: =?us-ascii?q?MDFK/tRQNzxqsHpeTgxj1jWJmyk7Fzk/IYc0N3?=
 =?us-ascii?q?Xe9K1QuAb2+VAfcafWMcwDkBCmQSNpngx4wVwpKw1ghlUc3VvA0jnznP?=
 =?us-ascii?q?KTU5gUMwniTl+3U5IBlA45pmXBjPX33JhyoBWg8ujdIhqu8+5lpDnEym?=
 =?us-ascii?q?96tq45K9m5sOf9wPfKSTzqwg=3D=3D?=
Received: from mx1.ist.ac.at ([81.223.84.226])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 16:34:54 +0100
From: Alice Lee <Alice.Lee@ist.ac.at>
To: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: Python script interacting with non-matching files?
Thread-Index: AQHcsjOlMgmRQDEWeUSFt0axb4WBUw==
Date: Thu, 12 Mar 2026 15:34:52 +0000
Message-ID: <e2cb31cc2b0947d29b50188dab2e1097@ist.ac.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.15.51.121]
Content-Type: multipart/alternative;
	boundary="_000_e2cb31cc2b0947d29b50188dab2e1097istacat_"
MIME-Version: 1.0
X-FEAS-Client-IP: 10.17.21.10
X-FE-Policy-ID: 1:3:0:SYSTEM
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] Python script interacting with non-matching files?
Reply-To: Alice Lee <Alice.Lee@ist.ac.at>
X-Loop: cocci@inria.fr
X-Sequence: 3424
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/3GeDf4Hl2uuovW9OKiYaLg>

--_000_e2cb31cc2b0947d29b50188dab2e1097istacat_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I am trying to use Coccinelle to search C code bases and I have a few quest=
ions.


  1.  Can a python script within a Coccinelle file somehow access the names=
 of files that are processed without matching the search? (Maybe there is s=
ome "match all" idiom that would let me get the name of every file and then=
 move on to the relevant search?)
  2.  Similarly, can a python script tell that parsing failed for a particu=
lar file?

Thank you,
Alice Lee

--_000_e2cb31cc2b0947d29b50188dab2e1097istacat_
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
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;=
,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&q=
uot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p></p>
<div>Hello,<br>
<br>
I am trying to use Coccinelle to search C code bases and I have a few quest=
ions.<br>
<br>
<ol style=3D"margin-bottom:0px; margin-top:0px">
<li>Can a python script within a Coccinelle file somehow access the names o=
f files that are processed without matching the search? (Maybe there is som=
e &quot;match all&quot; idiom that would let me get the name of every file =
and then move on to the relevant search?)</li><li>Similarly, can a python s=
cript tell that parsing failed for a particular file?</li></ol>
</div>
<div><br>
Thank you,<br>
Alice Lee&nbsp; &nbsp;&nbsp;</div>
<p></p>
</div>
</body>
</html>

--_000_e2cb31cc2b0947d29b50188dab2e1097istacat_--
