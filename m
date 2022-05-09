Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DF8C433F5
	for <cocci@archiver.kernel.org>; Mon,  9 May 2022 10:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=tG8GiqQOFSOnKKvWfH2ghI7CRqpUfoN1/jh3k+hRMZE=;
  b=DF6RuXkqk7Hm6vEBtyFN5UzI/7DydnuYGh2trnyYZaQ7o0B7rIczb3va
   F0NJ7QkfStKXeJVoE73V6JE0n00mBqEGVFjqQeoJwxTPsROsByevayksn
   dOxukwxCMrU76qoUJp1ceaKscqDWa1S3FaOSz235aIazWCwviRGZ2GO7I
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208,217";a="35334565"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 May 2022 12:49:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C479AE009B; Mon,  9 May 2022 12:49:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 377EFE009B
	for <cocci@sympa.inria.fr>; Mon,  9 May 2022 12:49:52 +0200 (CEST)
IronPort-SDR: CxkGTaH/AQoiAU4xuTkI1uzJsx5+4CfpB9rqwsido9gmYIRJ0UwU8/JjwjAv6f/azHBwYw/3is
 ZDCtFCWn53CEX+6SQ3V1uRZZhTUaqOLKljDVS7j3m5Ee4+GHqtAwtUMywFOxlBRbCUVaHdxoaL
 kG40G3AP9c3yvLpU9I8JuTSyfYhWdc84YhVNbIYpeoNBAzl7E9Jr5cQ+ynKpeZXccdmNCBQp0s
 DUYRjsX6FcaTeUnfTG6KqoQVOCGGeSuapC4XNQUW/GtzOwEJwbV+0ACKvHCAuxJC2xsqVy5Ti2
 4ZqMfB8wbRtZ+73h2SrOBnvZ
X-IPAS-Result: =?us-ascii?q?A0CxAwDq8Hhif6/dVdFaHgE8DAILhAiBUi4EC0OEToEjj?=
 =?us-ascii?q?UOCKIsngQWSMwsBAwENQgQBAYUCAoU9Ah0HAQRHAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBEwEBDQsJBwgKBw4OBWABYQMBRIFPgXQLAzENgjUig?=
 =?us-ascii?q?2sBAQEBAgESER0BGx4DAQsGCQcNKgICIgERAQUBEgoZGweFPgEDDSSffYEEQ?=
 =?us-ascii?q?Yo4eoEVBReBAYIJBoRLChkoDWcDgVkCBxKHQAIUREoBAYchJxCBVUSBS4J0P?=
 =?us-ascii?q?oURgwmCZQSVJ7IdkkQ0B4NMgTsGDJ41MYN1kxiRRpZioWOFKxAjEoFEgX1NI?=
 =?us-ascii?q?1AxgjdOAQIBAQENAQIBAQMBAgECCQEBApIPimBCMTsCBgEKAQEDCZFvAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:RY37IK4viC09gG55416olgxRtP3BchMFZxGqfqrLsTDasY5as4F+v
 mtOD2CAbviPNjH9ftFxbdvn9UtV68TUydVmHgpkqi9jZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2+aEvfDjW1nX4
 Y6q8pWGULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 MVH7La9ayR2B/LBvrtDEEMAGHpwbaITrdcrIVDn2SCS50jPcn+p3fY3SU9vYtBe9eFwDmVDs
 /cfLVjhbDjZ37PwkO/9ELM1wJ18caEHP6tH0p1k5TjdAO09SJbPWaKM7tZC2TY2j9xPNfnbb
 ssdLzFoaXwsZjUUZwxMVM9gx49EgFH1TDhTklKzjJYMuXnKxyZDj7W9H+L8L4niqcJ9xx7E/
 Aoq5V/RCRYRP9230iuA6nvqh+nVnCq9Vph6KVGj3vtjgVnW2G9KTRNPCgb9rv6+hUqzHdlYL
 iT45xbCs4Ai/hWBQ/veACTnrVjb4F1GA9ELHb01vVTlJrXv3y6VAW0NTzhkYdMgtdMrSTFC6
 rNvt4O5bdCImO3FIU9x5ot4vhvpZndIdT5qiTssCFpas4O68enfmzqWFo47eJNZmOEZDt0Z/
 txnhC03hrFWk81Skqviog2BjDWrqZzECAUy4207v15JDCspOuZJhKTysTA3CMqsyq7HFjFtW
 1Baw6CjABgmV83lqcB0aLxl8EuVz/iEKibAplVkAoMs8T+gk1b6I90KuGwndB04Y59bEdMMX
 KM1kVMBjHO0FCv6BZKbn6rsYyjX5fO9Soy6Dq68giRmO8IvL1XvEN5Sib64hjixyiDAYIkwP
 pCUdcvEMJrpIfUP8dZCfM9EieVD7nlmmwv7HMmnpzz6j+f2TCPKEd8tbQrWBshkvfjsiFiEo
 753aZHWoz0BC7aWSneMoeYuwaUidydT6Wbe8JwJKIZu42NORAkcNhMm6e5/K9E9w/QJx48lP
 BiVAydl9bY2vlWfQS3iV5ypQOqHsU9XoS1pMCoyE0yv3nR/M4+j4L1OJZQydLgjsudkyKcsH
 fUCfsyBBNVJSyjGq2xNN8mj8NQ6eUT5nx+KMgqkfCM7IMxtSgnPzdnuIVni+SwIOSyouJZsu
 LanzA7aHcEOSl06XsbbYf6i1X2run0ZlL4gVkfEOIgBd0Dl8YwsICv016dlL8YJIBTF5z2by
 wfGWUdC9beR+9c4qYCbi7qFooGlF/pFMnBbR2SLv6yrMST6/3a4xdASXeuNewfbXjym9ainY
 9JT0KigYvAKmVB9s718Haxu+qQw6oa9vLRd1AllQCzGYln3WLNtJn6KgZtGuqFXnOMLvAK3X
 geR+YAfN+zWZYXqF1keIAdjZeOGjKlGlj7X5PUzAUP7+C4no+bdABsKZ0GB2H5HMb94EII52
 uN96sQY3Aqy10gxOdGcgyEIqmmBci4aX6M8us1ICYPnkFB3mFRLYJiZFCyvpZ/WNIgKPU4tL
 TuZwqHFgu0ElEbFdnMyE1nL3PZc1ctS4kEUlAdaKgTbgMfBi982wAZVrWY9QDNTw0gVyOl0I
 GVqaxB4KKjmE+2EXySfs71A2j2tBSF1PmT0wloN0XPaFgymDzOQamI6PumJ8QYS9Gc0kv23O
 l2H4D6NbNooVJiZMugOtYpNpPnqTNg3/QrH8CxiN9rQBIE0OFIJnYf3DVflaHLb7QcZi0jOp
 O0s9+F1AUE+2ej8vIVjY7SnOX8spNxo6YCMrTyNPE/EII0ERAyP5A==
IronPort-HdrOrdr: A9a23:Sfeg3aoOy3X233zBLt+XIfwaV5omeYIsimQD101hICG9E/bo8P
 xG+c5w6faaskdzZJhNo7C90cq7IE80l6QFg7X5VI3KNGLbUQCTXeRfBOXZslnd8u7FmtK1F5
 0MT0GzMrLN5JFB4/rH3A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208,217";a="35334563"
X-MGA-submission: =?us-ascii?q?MDEScbX51RYHcCo9QqWlGiXoJAN3C+x9bwY8kM?=
 =?us-ascii?q?4SufVnPWsbUCMoLYLeXT22w2SCIROOCTdL32erN0TuYtWtQkoWGyStkM?=
 =?us-ascii?q?cHuDmaCpvGesW4mTzeBJ6duWEtWn4dmZ9rbubub4CwgNTNzmRR5fM/mT?=
 =?us-ascii?q?2c2H5G8VfzQVR/HVdJQeKeLg=3D=3D?=
Received: from mail-vk1-f175.google.com ([209.85.221.175])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 12:49:51 +0200
Received: by mail-vk1-f175.google.com with SMTP id d132so6727473vke.0
        for <cocci@inria.fr>; Mon, 09 May 2022 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tG8GiqQOFSOnKKvWfH2ghI7CRqpUfoN1/jh3k+hRMZE=;
        b=QDfvqY7BpxvTVfeDcWOydWea/xuTHeTEl7YC5th7d35zrsJ6USyzzPkuWDZ91Ycvnl
         A7LI202929waJMwbY4b/9sG5+qHkFYe6LzR02p1IN544O3biUDrtpIbu23/HeYeRfjVQ
         23i3ekYHHoGdfMFPOFrI58J899SQLi+BwnBFKgABJaDBccDA5B2+z/cENsDbVjr/UPIR
         DhoUDEipjosf/+CXml0gQkmwY6TPB4slkRSBS8YHWddrI1KjZYm8Sh8D60Oo6RPoNiyf
         85iGD7G8jcTa/Pswsrx2LuwAT/hEYxKeY1WPAYw8DF00oiwdal/gfjJC0u7ytfMCXQ+z
         PVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tG8GiqQOFSOnKKvWfH2ghI7CRqpUfoN1/jh3k+hRMZE=;
        b=qo4lprYytl0ArlmE+NvH++C97w5GCRb01vzYKtNkisb0jie2VUJ2cAPjr4beOskwpR
         tQVR6HWF8HbyG3uKabTWBKuLnGRnKs5RhZZiZU5765P0mlJXuE8ban+1yXUmlczxN3/u
         27v3vom75MKxUjsqnuroYBuEYx2xGKEn6KamFRvRHgivX7UQzkUiZYN8+1+0w6H0b7TS
         JTnMbFuoihWNBYGpDFjOc4SfhxpiYkwhx89c1/HhKLvfES5A/GuWW1Hns04nHWXxVvL0
         0o/u3dX8wiVGe4jyWLDu74tN3u/kblec8n69jwsAQKq6P6yuFzEN+M1twd3kTMdEK0Eh
         52Cw==
X-Gm-Message-State: AOAM533TiN5h4iOxSIxtUxgnfIO7qPFrisRTrrPg7gIXW5WVrOzd4HQP
	0FlAOkxLVqdg8OPlPVzzZX/+1p/ZIty5gRYa7gRFRo7J
X-Google-Smtp-Source: ABdhPJy9mWYp5ZpAB0mLOUVY0/d9UPWtGjFH8qJY7K+WmBIhAGR4VMOHS0ZvRzB/cnHWvJZL2W6GbjOnj4UaiRm6KUU=
X-Received: by 2002:a1f:dd43:0:b0:352:21e5:782d with SMTP id
 u64-20020a1fdd43000000b0035221e5782dmr7488097vkg.15.1652093390170; Mon, 09
 May 2022 03:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
In-Reply-To: <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Mon, 9 May 2022 12:49:14 +0200
Message-ID: <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/alternative; boundary="000000000000a82d7c05de91f721"
Subject: [cocci] Fwd: List global variables.
Reply-To: Alessandro Carminati <alessandro.carminati@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 368
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/CAPp5cGS%2BANKVuE%2BQThN%3DByqm%3DBR0FotbCe7aQgjX77Ee65UDuQ%40mail.gmail.com>

--000000000000a82d7c05de91f721
Content-Type: text/plain; charset="UTF-8"

Hello Julia,

The solution you sent indeed does what I expected.
Although I needed a solution for this specific case, and yours fit my needs
perfectly, I'd love it if you wanted to explain it to me.
Would you mind add a short explanation of this statement:
`position p : script:python(i) { p[0].current_element == i};`
I probably have a simplified understanding of what a position is. Maybe it
is worth digging deeper and having a more concrete knowledge. Any read you
want to suggest to me?

Thank you for your time.
Alessandro




Il giorno lun 9 mag 2022 alle ore 12:17 Julia Lawall <julia.lawall@inria.fr>
ha scritto:

>
>
> On Mon, 9 May 2022, Alessandro Carminati wrote:
>
> > Hello,I need to build a tool that just lists the global variables for a
> > given c project.
>
> @r@
> type T;
> identifier i;
> position p : script:python(i) { p[0].current_element == i};
> @@
>
> *T i@p;
>
> The * is just for illustration.  You can do whatever you want with i.
>
> julia
>

--000000000000a82d7c05de91f721
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">Hello Julia,<d=
iv><br></div><div>The solution you sent indeed does what I expected.<br>Alt=
hough I needed a solution for this specific case, and yours fit my needs pe=
rfectly, I&#39;d love it if you wanted to explain it to me.<br>Would you mi=
nd add a short explanation of this statement:<br>`position p : script:pytho=
n(i) { p[0].current_element =3D=3D i};`<br>I probably have a simplified und=
erstanding of what a position is. Maybe it is worth digging deeper and havi=
ng a more concrete knowledge. Any read you want to suggest to me?<br></div>=
<div><br></div><div>Thank you for your time.</div><div><div><div dir=3D"ltr=
" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"=
><div><div dir=3D"ltr">Alessandro<br><br><br><div style=3D"display:inline">=
</div></div></div></div></div></div></div></div><br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il giorno lun 9 m=
ag 2022 alle ore 12:17 Julia Lawall &lt;<a href=3D"mailto:julia.lawall@inri=
a.fr" target=3D"_blank">julia.lawall@inria.fr</a>&gt; ha scritto:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On Mon, 9 May 2022, Alessandro Carminati wrote:<br>
<br>
&gt; Hello,I need to build a tool that just lists the global variables for =
a<br>
&gt; given c project.<br>
<br>
@r@<br>
type T;<br>
identifier i;<br>
position p : script:python(i) { p[0].current_element =3D=3D i};<br>
@@<br>
<br>
*T i@p;<br>
<br>
The * is just for illustration.=C2=A0 You can do whatever you want with i.<=
br>
<br>
julia<br>
</blockquote></div>
</div></div>

--000000000000a82d7c05de91f721--
