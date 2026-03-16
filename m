Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57539F3382A
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2026 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=e/5AB5xGFaEoEEq56S8gKWbUenXebQ7a8jCQOkes5lQ=;
  b=A1/bstIu9D2HiFV2KcR2604mZ3dcje0CX9PrtX4y/zag7L48Vs28nLOf
   f+OX4bcMa98pkkh46CyFJOE8EyD9/HIRHyHVgzUiU4WT+XSNwb04p3+rw
   ulvMjES3ypHC+HVO6UCJGOKsuv0Lyl+2YtXtap4UhH4Kh3gcDMyb9e8uM
   o=;
X-CSE-ConnectionGUID: JZc2q66jT+ulMxeAjXO2MQ==
X-CSE-MsgGUID: IpLfKBUwR/K7fBzT6zAXKA==
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
   d="scan'208,217";a="268119308"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2026 10:40:40 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 30B4782300; Tue, 17 Mar 2026 10:40:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B32F180E28
	for <cocci@sympa.inria.fr>; Mon, 16 Mar 2026 13:50:07 +0100 (CET)
X-CSE-ConnectionGUID: QZtS8UnyTluD2N5rKsNGyg==
X-CSE-MsgGUID: S+EdEKCXT3u4MJP0Nmeesg==
IronPort-SDR: 69b7fc7f_CgYx8abyelFdU7RMoiypBIEp1NcSHk943QhKYM+885a4M0r
 /LsT4U4jDmJSoksjb/6FDIk8akVIXAEdVm0zDFA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H1AQBc+7dpheJU31FaHgEBCxIMggULgT0BgQOBZTQEC?=
 =?us-ascii?q?0kdli8DkheKLoFpgWkCBgkBAwENUQQBAQMBA4UAAo0jAh4HAQQzBg4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQFASYZPDYJiATOCF?=
 =?us-ascii?q?iwUdgEBAQECAS0TAQERJgEECwIBCBEEAQEvTggCBA4FCBOCZ4IeDCMnB7ZIe?=
 =?us-ascii?q?IE0gQGCDAEBBoJo2H8tFoFnCYFNhTwzgkoaAQEFJUlsgluBITSDZXonD4FVR?=
 =?us-ascii?q?IFKgkQxPoQOARIBJoYdIoImehQdiDWKHywmciIDJjMsAQ8RNRMXCwcFgSNDA?=
 =?us-ascii?q?4EGI0sFLR2BIyEdDwgUH1gbBwUSISpOeIIBD4ZleQMuXhoOIgI5XEo+C1IFg?=
 =?us-ascii?q?iwCJwMLB2Y9NxQbBgGBNYxWXDyBboFUAYEwWQFAWJJjSo8UR4E1giGKQpRjN?=
 =?us-ascii?q?AeCOIFngWQMn3AuF6prmQajPSyFWIF+JGxwMxqDWk8DFwIPjiEZgh7LC0YyP?=
 =?us-ascii?q?QIHAgcNAwuSHC6BHQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 t0AgKvOxBgRhQh5TCg=
IronPort-HdrOrdr: A9a23:0OF3tqPwnhoSPcBcTjujsMiBIKoaSvp037By7TEVdfRUGvb0qy
 ncpoV+6faUskdoZJhEo6H9BEDuexLhHPJOirX5eI3SPjUO21HYV72Kj7GD/9SIIUSXygce79
 YCT0EUMrHN5C1B4/oSlzPWLz9P+rO62ZHtqsub9nFpTQt7L4FMhj0JdzqzIwlYaCF9QbA9FJ
 aa+45mnlObCA4qh4+Adx44tqD41rv2fbzdEGc7OyI=
X-Talos-CUID: =?us-ascii?q?9a23=3AKW4vDWkwRzHStadCurdnaJZs0X/XOUTv0EyAHkm?=
 =?us-ascii?q?pNWJ0ZOezFEWz44VLgsU7zg=3D=3D?=
X-Talos-MUID: 9a23:oyhKswm+L5GWRIVivboAdnpZd+pkzoeFOHxWjMkjmfHcEyl9NiyS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="scan'208,217";a="267967412"
X-MGA-submission: =?us-ascii?q?MDE7RlqmoD9oIVyMloFdAQ5OMX12VZ8t5YG4Fh?=
 =?us-ascii?q?og+wCI5UmJf/m04JvydsFHXzN3WzbnxYEmAS4Ejv8Qik2L+ApK9RfmzZ?=
 =?us-ascii?q?87mP/z4z6oWI42hMZgiwetGuGWhnrpe07WvEVLzf2zCR0cAfyAKAXPFf?=
 =?us-ascii?q?rzgOTQ3FIH0NLI8x8uECdNGg=3D=3D?=
Received: from mx1.ist.ac.at ([81.223.84.226])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:50:07 +0100
From: Alice Lee <Alice.Lee@ist.ac.at>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [cocci] Python script interacting with non-matching files?
Thread-Index: AQHcsjOlMgmRQDEWeUSFt0axb4WBU7WscoWAgAStWCM=
Date: Mon, 16 Mar 2026 12:50:05 +0000
Message-ID: <45e5450fb5734b8091dbcf586fc880f6@ist.ac.at>
References: <e2cb31cc2b0947d29b50188dab2e1097@ist.ac.at>,<36eb7fe0-99b7-7191-134a-3adbe9d41d68@inria.fr>
In-Reply-To: <36eb7fe0-99b7-7191-134a-3adbe9d41d68@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.15.51.121]
Content-Type: multipart/alternative;
	boundary="_000_45e5450fb5734b8091dbcf586fc880f6istacat_"
MIME-Version: 1.0
X-FEAS-Client-IP: 10.17.21.11
X-FE-Policy-ID: 1:3:0:SYSTEM
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Python script interacting with non-matching files?
Reply-To: Alice Lee <Alice.Lee@ist.ac.at>
X-Loop: cocci@inria.fr
X-Sequence: 3441
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/0vICw7qCxCXeNbqRuCQMRw>

--_000_45e5450fb5734b8091dbcf586fc880f6istacat_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Julia,


Thanks for getting back to me!


  1.  Maybe it's easier to state my overall goal: I want to count the numbe=
r of matches for some rule for each file in a directory. Currently I can ge=
t a python dictionary correctly counting the number of matches in files in =
which there is at least one match.
Your particular solution wouldn't work unless I know some value is in all f=
iles. Is the best solution just to get directory information in the initial=
ization script to populate the dictionary instead of trying to do this thro=
ugh Coccinelle?
  2.  My ideal solution would make a dictionary of all matches in each file=
 and report files that don't parse as having a count of -1. Files aren't pa=
rtially failing to parse, at least according to the --debug output, but say=
 "bad" on every line. Still no way to access that in the python script?

Thanks,
Alice
________________________________
From: Julia Lawall <julia.lawall@inria.fr>
Sent: Friday, March 13, 2026 3:15:29 PM
To: Alice Lee
Cc: cocci@inria.fr
Subject: Re: [cocci] Python script interacting with non-matching files?

[EXTERNAL EMAIL - USE CAUTION when clicking links or attachments]




On Thu, 12 Mar 2026, Alice Lee wrote:

>
> Hello,
>
> I am trying to use Coccinelle to search C code bases and I have a few
> questions.
>
>  1. Can a python script within a Coccinelle file somehow access the names=
 of
>     files that are processed without matching the search? (Maybe there is
>     some "match all" idiom that would let me get the name of every file a=
nd
>     then move on to the relevant search?)

I don't completely understand the question.  You can attach a position
variable to some matched code and then print the file name associated with
that code:

@r@
position p;
@@

foo@p();

@script:python@
p << r.p;
@@

print p[0].file  // put proper python code here

>  2. Similarly, can a python script tell that parsing failed for a particu=
lar
>     file?

No, python doesn't have an access to the information about what could be
parsed.  There is --verbose-parsing.  But parsing rarely fails for a whole
file.  If it can't parse one thing, it will just move on to the next thing
and try from there.

julia

> Thank you,
> Alice Lee
>
>
>

--_000_45e5450fb5734b8091dbcf586fc880f6istacat_
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
<p>Thanks for getting back to me!</p>
<p><br>
</p>
<ol style=3D"margin-bottom:0px; margin-top:0px">
<li>Maybe it's easier to state my overall goal: I want to count the number =
of matches for some rule for each file in a directory. Currently I can get =
a python dictionary correctly counting the number of matches in files in wh=
ich there is at least one match.&nbsp;<br>
Your particular solution wouldn't work unless I know some value is in all f=
iles. Is the best solution just to get directory information in the initial=
ization script to populate the dictionary instead of trying to do this thro=
ugh Coccinelle?</li><li>My ideal solution would make a dictionary of all ma=
tches in each file and report files that don't parse as having a count of -=
1. Files aren't partially failing to parse, at least according to the --deb=
ug output, but say &quot;bad&quot; on every line. Still no way
 to access that in the python script?</li></ol>
<div><br>
</div>
<div>Thanks,</div>
<div>Alice</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Julia Lawall &lt;ju=
lia.lawall@inria.fr&gt;<br>
<b>Sent:</b> Friday, March 13, 2026 3:15:29 PM<br>
<b>To:</b> Alice Lee<br>
<b>Cc:</b> cocci@inria.fr<br>
<b>Subject:</b> Re: [cocci] Python script interacting with non-matching fil=
es?</font>
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
&gt; I am trying to use Coccinelle to search C code bases and I have a few<=
br>
&gt; questions.<br>
&gt;<br>
&gt;&nbsp; 1. Can a python script within a Coccinelle file somehow access t=
he names of<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; files that are processed without matching the =
search? (Maybe there is<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; some &quot;match all&quot; idiom that would le=
t me get the name of every file and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; then move on to the relevant search?)<br>
<br>
I don't completely understand the question.&nbsp; You can attach a position=
<br>
variable to some matched code and then print the file name associated with<=
br>
that code:<br>
<br>
@r@<br>
position p;<br>
@@<br>
<br>
foo@p();<br>
<br>
@script:python@<br>
p &lt;&lt; r.p;<br>
@@<br>
<br>
print p[0].file&nbsp; // put proper python code here<br>
<br>
&gt;&nbsp; 2. Similarly, can a python script tell that parsing failed for a=
 particular<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; file?<br>
<br>
No, python doesn't have an access to the information about what could be<br=
>
parsed.&nbsp; There is --verbose-parsing.&nbsp; But parsing rarely fails fo=
r a whole<br>
file.&nbsp; If it can't parse one thing, it will just move on to the next t=
hing<br>
and try from there.<br>
<br>
julia<br>
<br>
&gt; Thank you,<br>
&gt; Alice Lee&nbsp; &nbsp;&nbsp;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div>
</span></font>
</body>
</html>

--_000_45e5450fb5734b8091dbcf586fc880f6istacat_--
