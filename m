Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0D0C4345F
	for <cocci@archiver.kernel.org>; Thu, 11 Apr 2024 17:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=i04S+SQOe6eHEzE+41cbkVGNJlfEDGk1Zr+717DmBMQ=;
  b=biRgPUjT3WmqP+pxLfR8bikV5PdINGhyRhtPVLt/peedr3CW1z4F2cHp
   k/vmptP1rM62xgQbVRdVDHM1vNcQ6W0XKZXIkU30sAspdJbG4zJjGYgQv
   LLJc2U5d8KZ7OBrl0YLu/2GCDPhXlixlfoWGcpd6aeXTlPEQCrfVHEqbM
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.07,193,1708383600"; 
   d="scan'208,217,223";a="161133927"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2024 19:46:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE13AE02E4; Thu, 11 Apr 2024 19:46:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8BA04E0131
	for <cocci@sympa.inria.fr>; Thu, 11 Apr 2024 11:54:44 +0200 (CEST)
IronPort-SDR: 6617b364_RGwK7L8eFjtYN9/0RI0A3j0nl+e7wYF46qvI8na0P72cXfW
 n4O0fZaL8+u+ER+tNyMZKk6lSIKvsDfkfLG27bg==
X-IPAS-Result: =?us-ascii?q?A0FPBAC9shdmfyqnVdFagQmBT4JEgVEzBAtIhFaBI5BFg?=
 =?us-ascii?q?RaWI4ZSFIEsPggHAQMBDUQEAQEDBDiERwKIFwIeBwEEMgcOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQgBAQUBAQECAQECBAYBAhABASIZBw4OKYVtDYJggSZhAgUDOwEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCLFwBGBEEGQEbH?=
 =?us-ascii?q?gMSCQcGAwECKwIEHgEBEQEFARQCHxsHgl4BgioBAzEDogKCIYEFQopBeAJ/F?=
 =?us-ascii?q?gUCFoEBggsG2loKGSgNbAOBVwcCBxSBNIRkJYMFAR0BgVUCAodkeicPgVVEg?=
 =?us-ascii?q?RU1gQaBN4MVggqDdYJoBIFkjQGHfoVHhGMIBxcDBwcHBAUEHAYFBQJCCQgPE?=
 =?us-ascii?q?gMEAwQEAQILEwkDAwIOAggDAggGDhMBPxIEEwsHCQQCCREGAgILAgwGBQEEA?=
 =?us-ascii?q?wIBAwMDAgQCAgMBAgICAgIDAQIKAgEHAgUDBQICAwIBAQEBAgIEAwEOBwIDB?=
 =?us-ascii?q?QUCAQUJAwMCAgQDAQICAwICAgMBBAUUAwQCBQoDCAICBwIOAwEFAgEBAgICA?=
 =?us-ascii?q?gEBAgIDCAISBAIBAgMCAggCAgcBAQIKBwMBAQIEBAQDBgICBQQNAwgFAQECA?=
 =?us-ascii?q?gQBCgIJDwUCAgMDAgMBAQECCgMJAQUCAgEDAgIEBAcBBgMFAwMEBAIDAwIMA?=
 =?us-ascii?q?QUBBQEFAQUEAgYBEwIUAgILBQYDBg4DCwQEAQICBQQGDAkEAgICBgECEQMBA?=
 =?us-ascii?q?gEHAQMDAgoBBAECCwgBBQgCDAQCAQQCAwYQAggFBgUCAgEBAgICAQgGDwMGB?=
 =?us-ascii?q?wIDAgYDBQUDAwICAgcEBAIBAgICARMGBAQCAwIDBAEFBAQDAhcIDQIFBwEJC?=
 =?us-ascii?q?ggMAQQGAgQCBAcDCAUFBAIDBAQRBwsDAgMEAgIGAxECAwQCCgIEBAcCAwEED?=
 =?us-ascii?q?QYEBAoCCwMHAQECBQMDCQcGAgMDBQQDBgIFAwMDAgMCDQICAgEJAQEBAhQCA?=
 =?us-ascii?q?w4CBAIBAgUFDAQTAgIDAgYIAgICBwMDBAIDBgsDEAMCAgICBQMEAgIUAwkEA?=
 =?us-ascii?q?gQGAgQBBgMDAgQGBQoEAgIFAgEBAgoCAQ8KBAMEAwUDBwkCBQUDAgQCAgcJA?=
 =?us-ascii?q?QECAgIDAwMDAgMCAgMDAgcDAwMHAwUDBAIDBgUHAwUFAwICAhQBBgIFCgYDB?=
 =?us-ascii?q?wYLBQUHAgYCBAgDBQICAwMDAwIGCggDAwMCAQYCAgMDAQIIAw8GAgIDBQYDA?=
 =?us-ascii?q?wMDBggDAwIGAwMCAwIDAgMDAQMCAwICAwICAggCAgMCBQQFAgIDBAIIGgICA?=
 =?us-ascii?q?gIDAwgDAwoEAgIEAQQCBAIEAgYDBAICAQcCBQMCAwIHAgIEAgICAgMCAgYIA?=
 =?us-ascii?q?gIDAwMCAgIBCQIFAQEGAgQDAgMFAwkDBAUCAwgBAQICBwcDAwQDAQIBBQQCA?=
 =?us-ascii?q?gYFAgMCAgQEBAUDAgMCBgYCAQMCCgYDBQMDAwMCAwMCAwMCBQIIAgIEBAUEA?=
 =?us-ascii?q?gcEAgQDAwMBCgIGAwICBQEBAgIFAwIEBAcCAgIHDwMCBwUCBQUFAggBBgUCA?=
 =?us-ascii?q?gMCCAECAgYBBgIEAQICDQEBAgICAwQDAwcCBAMCCAIDAxEBAwMJBgUEBQQDC?=
 =?us-ascii?q?QQPAgQBCAMBAQQIAgQDAgwCAiECBQsEBAESCggDAQEDAQECAgICAg4DAgMCA?=
 =?us-ascii?q?gMKAgMCCgMGBAICBgEBAQQGAQQCAQIJBA4JBQgIAQMCAQoBAhIFDwIJAwMGB?=
 =?us-ascii?q?AIQBgoFAwIDBQECBRUDCAMCCQIEDAMNAgMDAgYDBgIGAQYDBwsBAQkIBQMDA?=
 =?us-ascii?q?wIWAQICEAgGBg8HAgMDBAQPAxICBg4DAwIDAgECAgIDBQQFAgcDAw0FAgIHA?=
 =?us-ascii?q?wIIBQMHCQQKAggFAQIGAwICAgIFDQEBAQECAwIFAwcJCAgEBQQDAQEGBgwlA?=
 =?us-ascii?q?gIDBA8DCwMGCwEFBQEDAgICDgMFAwIDBgYBDQQBBQQJAgUHBgUCARQXBwUCC?=
 =?us-ascii?q?gIHAgICAwECCAsIAgMCCgQBDgQaAwUBAgICAwIDCAIDAgIUAwMFBAYDAgICA?=
 =?us-ascii?q?gMCAQoLAwIFAwMDAwUFAwMCGgIDAgMCAQoFAgwFBAMEAgIBAh4DAQUCAwoBB?=
 =?us-ascii?q?QkDBgICAwIFAgMGBgIEAQoOAQEBAwYLBwQYAgICBQECAUMdAgkDIwUKAwsJC?=
 =?us-ascii?q?BM9AQsHMgQ0ARQUBycBBiFfnyhFgQkFAQoJMgYPUUWlJ1SgATw0B4QWgVsGD?=
 =?us-ascii?q?IRolGOGDzOqNJhikXSRSIU4ESMSgTYIKy6BLk0jgQGCNhM8AxkPjiwWg1ifZ?=
 =?us-ascii?q?kMyAgEBNwIHAQoBAQMJiSKBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NMw9yK1RhVfH1Y4jL3VVpQqjBJ0kLtp133Aq2lEZdDV8btGfnd
 u/helz726QtN9jYhAdcLe7Sc+9qBLnhPlICOYqUItKMDOW2ldAabsSibcKoAeNJ8SdzIRgPM
 5bGsAUNDSzNykYsS+T2njALz9K+re6Gc6T5ds2g00Dcek8AJsQlDuRXTzranFLeA==
X-Talos-CUID: 9a23:BHw1wGxvHurBfkilV/DDBgVXNcIbNUP450zdGGnpOEFudY+rY3SfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3ARfYaWA/hRcKOcatXiR++gNSQf9130q+tL3wgq8k?=
 =?us-ascii?q?LncbUFXRqZAnAlA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,193,1708383600"; 
   d="scan'208,217,223";a="161036120"
X-MGA-submission: =?us-ascii?q?MDHnb0vcm8Erva4WFzOWZmMjpdAX8BUIzNFihZ?=
 =?us-ascii?q?+ooJQ7BUHsAgDbUF57f+vwQt5oFgHDeAQIYSUX7cA9KxqU9+/9hsnGCr?=
 =?us-ascii?q?D/y7H/m33s4q3mhyDJPOudu8PJTj3c7YhT6RSscxk+rLUjmo2DkytJQo?=
 =?us-ascii?q?2IVCiAKX2C2Cf8/IC6aQQ/nQ=3D=3D?=
Received: from mail-lf1-f42.google.com ([209.85.167.42])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 11:54:44 +0200
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d6e23253so6495798e87.1
        for <cocci@inria.fr>; Thu, 11 Apr 2024 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712829283; x=1713434083; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i04S+SQOe6eHEzE+41cbkVGNJlfEDGk1Zr+717DmBMQ=;
        b=Z1620uyChBl6lrCNNFmHElkUTQ0JkUmedhXf+POENMNk3LTsvGiyxU46gQIeD92tUr
         4bVlXzCaXDrYOtoifswI6ccA0g3A1WR/rDKbVmshF7aonrU0k69ARQCpTCHKEHW26c+Z
         Oh5LU1lOaez/bdJ6HzF6y3gI+fGkmZ88cGB73BRiegq3OAjFoSVLCOzz5fMh6bpWrPCb
         jOdvmV8Wq6gZESVztv4+Qm8oFq+7pNbb03spR6It79Croc3OlokoYS/hhsguNKDuLJWm
         gVEgLTs/4oInsBHtFg0l8geh7MlZ48byQ3BC/obemaiZz5NqKSFH68XMjlNSnbkoTa4a
         iu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712829283; x=1713434083;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i04S+SQOe6eHEzE+41cbkVGNJlfEDGk1Zr+717DmBMQ=;
        b=rCPipDriAGMgpBrIcxCWNNK/NyvYqhahqysWN8Kj0LW4gEq8KmG/RGYRecYlpBeQ7k
         50IYpdT0RkDdeMDuZvfUK50YKgqHBnD4MiT9/+IU6ik/Q8S4lkTJg1ELK1yqsAJtrkTM
         B1wkaU755aUDLNJPECQ6wolUyPGVjSynetYBWvAeyY5WHGOy0FtdeTqvu+lBf56rTDL8
         HUgiUI9vvfegam54ajCIBsrxlGXL88f6icWQShV5G2nuTRteevcxQby76o8sEMLY9QOm
         erteQn+xh1CA8y+hd4odt8sa+4trsqFmjUXqWAt3UymcMhK0cehZMYp+PcFuF2JPPNMm
         hHeg==
X-Gm-Message-State: AOJu0YxgzuOo8DgIvKALl21RcAcs/pLILrP+gEuLl2ACQGYKQNKwKOxf
	NQYtEcOCHw6Yo5vIYZgFdaXfmKgJFBvbn5CzxJgjzJYJ/F2dEO+TbV2uu+VYcGX2uA9z1tPm+45
	X3+eMiIQBjFL3z61JfLFH9LhjLgCjog4=
X-Google-Smtp-Source: AGHT+IGWRPHLahaoPrqiPGo1NK99l/F7W5GDUg1nNNIaepvk89i+cuvEi/KnDQFWY0xUnw+wiKBc6adVfEQKqOXlmO8=
X-Received: by 2002:a2e:9212:0:b0:2d6:e0a9:9981 with SMTP id
 k18-20020a2e9212000000b002d6e0a99981mr4127176ljg.9.1712829282901; Thu, 11 Apr
 2024 02:54:42 -0700 (PDT)
MIME-Version: 1.0
From: Akos Pasztory <akos.pasztory@gmail.com>
Date: Thu, 11 Apr 2024 12:54:31 +0300
Message-ID: <CAJwHcF57ee4M6P-nzg9=1drDQbpic-4qqbpSCbL1FO7XXsetVw@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/mixed; boundary="000000000000f7f9370615cf2456"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] type of integer decimal constants
Reply-To: Akos Pasztory <akos.pasztory@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1637
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/CAJwHcF57ee4M6P-nzg9%3D1drDQbpic-4qqbpSCbL1FO7XXsetVw%40mail.gmail.com>

--000000000000f7f9370615cf2456
Content-Type: multipart/alternative; boundary="000000000000f7f9360615cf2454"

--000000000000f7f9360615cf2454
Content-Type: text/plain; charset="UTF-8"

Hi,

I noticed an issue with how coccinelle determines types of (at least)
decimal literals.
This only happens if --int-bits and/or --long-bits is specified, since
otherwise everything is treated as "int".
The output below was truly puzzling initially:

$ { echo 'void f() {'; printf '%d;\n' $(seq 0 32); echo '}'; } > decimals.c
$ ./spatch.opt --long-bits 32 --int-bits 32 --type-c decimals.c
void f() {
0/*int*/;
1/*int*/;
2/*int*/;
3/*unsigned long*/;
4/*unsigned long*/;
5/*long long*/;
6/*long long*/;
7/*long long*/;
8/*long long*/;
9/*long long*/;
10/*int*/;
11/*int*/;
12/*int*/;
13/*int*/;
14/*int*/;
15/*int*/;
16/*int*/;
17/*int*/;
18/*int*/;
19/*int*/;
20/*int*/;
21/*int*/;
22/*unsigned long*/;
23/*unsigned long*/;
24/*unsigned long*/;
25/*unsigned long*/;
26/*unsigned long*/;
27/*unsigned long*/;
28/*unsigned long*/;
29/*unsigned long*/;
30/*unsigned long*/;
31/*unsigned long*/;
32/*unsigned long*/;
}

After some investigation, I think the problem was introduced in
3c5dc62bae3e38d77044423ecb3575f30ab230fa
when a bigint dependency was removed. The commit replaces integer
thresholds with strings,
however in is_long_dec it does the following kind of changes:

-      if Big_int.ge_big_int bn ulong_threshold
+      if s >= ulong_threshold

This seems to do a lexicographic comparison on strings instead of numeric.
One solution that came to my mind is to zero-pad the strings to same length,
then lexicographic comparison should be also correct.

Attached a patch, but note that I'm not an OCaml programmer, so it may be
not idiomatic.
Feel free to solve it another way;)

--000000000000f7f9360615cf2454
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I noticed an issue with =
how coccinelle determines types of (at least) decimal literals.</div><div>T=
his only happens if --int-bits and/or --long-bits is specified, since other=
wise everything is treated as &quot;int&quot;.</div><div>The output below w=
as truly puzzling initially:<br></div><div><br></div><div>$ { echo &#39;voi=
d f() {&#39;; printf &#39;%d;\n&#39; $(seq 0 32); echo &#39;}&#39;; } &gt; =
decimals.c</div><div>$ ./spatch.opt --long-bits 32 --int-bits 32 --type-c d=
ecimals.c</div><div>void f() {<br>0/*int*/;<br>1/*int*/;<br>2/*int*/;<br>3/=
*unsigned long*/;<br>4/*unsigned long*/;<br>5/*long long*/;<br>6/*long long=
*/;<br>7/*long long*/;<br>8/*long long*/;<br>9/*long long*/;<br>10/*int*/;<=
br>11/*int*/;<br>12/*int*/;<br>13/*int*/;<br>14/*int*/;<br>15/*int*/;<br>16=
/*int*/;<br>17/*int*/;<br>18/*int*/;<br>19/*int*/;<br>20/*int*/;<br>21/*int=
*/;<br>22/*unsigned long*/;<br>23/*unsigned long*/;<br>24/*unsigned long*/;=
<br>25/*unsigned long*/;<br>26/*unsigned long*/;<br>27/*unsigned long*/;<br=
>28/*unsigned long*/;<br>29/*unsigned long*/;<br>30/*unsigned long*/;<br>31=
/*unsigned long*/;<br>32/*unsigned long*/;<br></div><div>}</div><div><br></=
div><div>After some investigation, I think the problem was introduced in 3c=
5dc62bae3e38d77044423ecb3575f30ab230fa<br></div><div>when a bigint dependen=
cy was removed. The commit replaces integer thresholds with strings,=C2=A0<=
/div><div>however in is_long_dec it does the following kind of changes:</di=
v><div><br></div><div>- =C2=A0 =C2=A0 =C2=A0if Big_int.ge_big_int bn ulong_=
threshold<br>+ =C2=A0 =C2=A0 =C2=A0if s &gt;=3D ulong_threshold</div><div><=
br></div><div>This seems to do a lexicographic comparison on strings instea=
d of numeric.</div><div>One solution that came to my mind is to zero-pad th=
e strings to same length,</div><div>then lexicographic comparison should be=
 also correct.<br></div><div><br></div><div>Attached a patch, but note that=
 I&#39;m not an OCaml programmer, so it may be not idiomatic.</div><div>Fee=
l free to solve it another way;)</div><div><br></div></div>

--000000000000f7f9360615cf2454--
--000000000000f7f9370615cf2456
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fix-type-deduction-of-decimal-constants.patch"
Content-Disposition: attachment; 
	filename="0001-fix-type-deduction-of-decimal-constants.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_luv26c7k0>
X-Attachment-Id: f_luv26c7k0

RnJvbSAwNzgxYTY3ODMxZGFlNDliYTVkYjFlNWExZjBkMjI3MzExZTdlNzFiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8MDc4MWE2NzgzMWRhZTQ5YmE1ZGIxZTVhMWYwZDIy
NzMxMWU3ZTcxYi4xNzEyODI4ODQ3LmdpdC5ha29zLnBhc3p0b3J5QGdtYWlsLmNvbT4KRnJvbTog
QWtvcyBQYXN6dG9yeSA8YWtvcy5wYXN6dG9yeUBnbWFpbC5jb20+CkRhdGU6IFRodSwgMTEgQXBy
IDIwMjQgMDk6NTI6NDYgKzAzMDAKU3ViamVjdDogW1BBVENIXSBmaXggdHlwZSBkZWR1Y3Rpb24g
b2YgZGVjaW1hbCBjb25zdGFudHMKCkluIGEgcHJldmlvdXMgY29tbWl0ICdpc19sb25nX2RlYycg
Y2hhbmdlZCB0byBsZXhpY29ncmFwaGljYWwKY29tcGFyaXNvbiBvZiBzdHJpbmdzLCB3aGljaCB3
aWxsIGdpdmUgaW5jb3JyZWN0IHJlc3VsdHMuIEl0IG9ubHkKaGFwcGVucyBpZiBlaXRoZXIgLS1p
bnQtYml0cyBvciAtLWxvbmctYml0cyBvcHRpb24gaXMgZ2l2ZW4sIG90aGVyd2lzZQpldmVyeXRo
aW5nIGlzIHRyZWF0ZWQgYXMgImludCIuCgpNYXkgc3RpbGwgbm90IGJlIGVudGlyZWx5IGNvcnJl
Y3QsIHRoZSBzdGFuZGFyZCBzYXlzIHVuc3VmZml4ZWQKZGVjaW1hbCBjb25zdGFudHMgYXJlIG9u
ZSBvZiAiaW50IiwgImxvbmciLCBvciAibG9uZyBsb25nIiwgYW5kIG5vdyBpdApzdGlsbCBhc3Np
Z25zIHVuc2lnbmVkIHZhcmlhbnRzLgotLS0KIHBhcnNpbmdfYy9sZXhlcl9jLm1sbCAgICAgICAg
ICB8IDE5ICsrKysrKysrKystLS0KIHRlc3RzL3R5cGVvZmNvbnN0X2kzMmw2NC5jICAgICB8IDQ5
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHRlc3RzL3R5cGVvZmNvbnN0X2kz
Mmw2NC5jb2NjaSB8IDI5ICsrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy90eXBlb2Zjb25zdF9p
MzJsNjQucmVzICAgfCA0OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0
cy90eXBlb2Zjb25zdF9pbDMyLmMgICAgICAgfCA0OSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiB0ZXN0cy90eXBlb2Zjb25zdF9pbDMyLmNvY2NpICAgfCAyOSArKysrKysrKysr
KysrKysrKysrKwogdGVzdHMvdHlwZW9mY29uc3RfaWwzMi5yZXMgICAgIHwgNDkgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogNyBmaWxlcyBjaGFuZ2VkLCAyNjkgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90eXBlb2Zjb25z
dF9pMzJsNjQuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3R5cGVvZmNvbnN0X2kzMmw2NC5j
b2NjaQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3R5cGVvZmNvbnN0X2kzMmw2NC5yZXMKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90eXBlb2Zjb25zdF9pbDMyLmMKIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0ZXN0cy90eXBlb2Zjb25zdF9pbDMyLmNvY2NpCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVz
dHMvdHlwZW9mY29uc3RfaWwzMi5yZXMKCmRpZmYgLS1naXQgYS9wYXJzaW5nX2MvbGV4ZXJfYy5t
bGwgYi9wYXJzaW5nX2MvbGV4ZXJfYy5tbGwKaW5kZXggNTM3OWM4NDEuLmE1NmMxYmM3IDEwMDY0
NAotLS0gYS9wYXJzaW5nX2MvbGV4ZXJfYy5tbGwKKysrIGIvcGFyc2luZ19jL2xleGVyX2MubWxs
CkBAIC0yODEsMjAgKzI4MSwzMSBAQCBsZXQgZXJyb3JfcmFkaXggcyA9CiAKICgqIGp1bGlhOiBm
dW5jdGlvbnMgZm9yIGZpZ3VyaW5nIG91dCB0aGUgdHlwZSBvZiBpbnRlZ2VycyAqKQogCisKKygq
IENvbXBhcmUgdHdvIG51bWJlcnMgaW4gc3RyaW5nIGZvcm0gYnkgemVybyBwYWRkaW5nIHRvIHRo
ZSBzYW1lCisgICBsZW5ndGguICopCitsZXQgZ2Vfc3RyIGEgYiA9CisgIGxldCBhbGVuID0gU3Ry
aW5nLmxlbmd0aCBhIGluCisgIGxldCBibGVuID0gU3RyaW5nLmxlbmd0aCBiIGluCisgIGxldCBu
ID0gbWF4IGFsZW4gYmxlbiBpbgorICBsZXQgYXBhZCA9IChTdHJpbmcubWFrZSAobiAtIGFsZW4p
ICcwJykgXiBhIGluCisgIGxldCBicGFkID0gKFN0cmluZy5tYWtlIChuIC0gYmxlbikgJzAnKSBe
IGIgaW4KKyAgYXBhZCA+PSBicGFkCisKIGxldCBpc19sb25nX2RlYyBzIGludCB1aW50IGxvbmcg
dWxvbmcgbG9uZ2xvbmcgdWxvbmdsb25nID0KICAgbWF0Y2ggIUZsYWdfcGFyc2luZ19jLmludF90
aHJlc2hvbGRzIHdpdGgKICAgICBOb25lIC0+IGludAogICB8IFNvbWUgKF8sXyxpbnRfdGhyZXNo
b2xkLCB1aW50X3RocmVzaG9sZCxsb25nX3RocmVzaG9sZCx1bG9uZ190aHJlc2hvbGQpIC0+Ci0g
ICAgICBpZiBzID49IHVsb25nX3RocmVzaG9sZAorICAgICAgaWYgZ2Vfc3RyIHMgdWxvbmdfdGhy
ZXNob2xkCiAgICAgICB0aGVuIGxvbmdsb25nCiAgICAgICBlbHNlCi0JaWYgcyA+PSBsb25nX3Ro
cmVzaG9sZAorCWlmIGdlX3N0ciBzIGxvbmdfdGhyZXNob2xkCiAJdGhlbiB1bG9uZwogCWVsc2UK
LQkgIGlmIHMgPj0gdWludF90aHJlc2hvbGQKKwkgIGlmIGdlX3N0ciBzIHVpbnRfdGhyZXNob2xk
CiAJICB0aGVuIGxvbmcKIAkgIGVsc2UKLQkgICAgaWYgcyA+PSBpbnRfdGhyZXNob2xkCisJICAg
IGlmIGdlX3N0ciBzIGludF90aHJlc2hvbGQKIAkgICAgdGhlbiB1aW50CiAJICAgIGVsc2UgaW50
CiAKZGlmZiAtLWdpdCBhL3Rlc3RzL3R5cGVvZmNvbnN0X2kzMmw2NC5jIGIvdGVzdHMvdHlwZW9m
Y29uc3RfaTMybDY0LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAuLjFjNTg0
ZmVhCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvdHlwZW9mY29uc3RfaTMybDY0LmMKQEAgLTAs
MCArMSw0OSBAQAordm9pZCBmKCkgeworMDsKKzE7CisyOworMzsKKzQ7Cis1OworNjsKKzc7Cis4
OworOTsKKzEwOworMTE7CisxMjsKKzEzOworMTQ7CisxNTsKKzE2OworMTc7CisxODsKKzE5Owor
MjA7CisyMTsKKzIyOworMjM7CisyNDsKKzI1OworMjY7CisyNzsKKzI4OworMjk7CiszMDsKKzMx
OworMzI7CisKKzIxNDc0ODM2NDc7IC8vIDIqKjMxIC0gMQorMjE0NzQ4MzY0ODsgLy8gMioqMzEK
KzIxNDc0ODM2NDk7IC8vIDIqKjMxICsgMQorCis0Mjk0OTY3Mjk1OyAvLyAyKiozMiAtIDEKKzQy
OTQ5NjcyOTY7IC8vIDIqKjMyCis0Mjk0OTY3Mjk3OyAvLyAyKiozMiArIDEKKworOTIyMzM3MjAz
Njg1NDc3NTgwNzsgLy8gMioqNjMgLSAxCis5MjIzMzcyMDM2ODU0Nzc1ODA4OyAvLyAyKio2Mwor
OTIyMzM3MjAzNjg1NDc3NTgwOTsgLy8gMioqNjMgKzEKKworMTg0NDY3NDQwNzM3MDk1NTE2MTU7
IC8vIDIqKjY0IC0gMQorfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdHlwZW9mY29uc3RfaTMybDY0LmNv
Y2NpIGIvdGVzdHMvdHlwZW9mY29uc3RfaTMybDY0LmNvY2NpCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAwLi4zYmM3YjlmZQotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3R5cGVv
ZmNvbnN0X2kzMmw2NC5jb2NjaQpAQCAtMCwwICsxLDI5IEBACisjc3BhdGNoIC0taW50LWJpdHMg
MzIgLS1sb25nLWJpdHMgNjQKK0BACitpbnQgc2k7Citsb25nIHNsOworbG9uZyBsb25nIHNsbDsK
K3Vuc2lnbmVkIGludCB1aTsKK3Vuc2lnbmVkIGxvbmcgdWw7Cit1bnNpZ25lZCBsb25nIGxvbmcg
dWxsOworQEAKKworKAorLSBzaQorKyBJTlQoc2kpCit8CistIHNsCisrIExPTkcoc2wpCit8Cist
IHNsbAorKyBMT05HTE9ORyhzbGwpCit8CistIHVpCisrIFVJTlQodWkpCit8CistIHVsCisrIFVM
T05HKHVsKQorfAorLSB1bGwKKysgVUxPTkdMT05HKHVsbCkKKykKZGlmZiAtLWdpdCBhL3Rlc3Rz
L3R5cGVvZmNvbnN0X2kzMmw2NC5yZXMgYi90ZXN0cy90eXBlb2Zjb25zdF9pMzJsNjQucmVzCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwLi5iNjViZWMyYgotLS0gL2Rldi9udWxs
CisrKyBiL3Rlc3RzL3R5cGVvZmNvbnN0X2kzMmw2NC5yZXMKQEAgLTAsMCArMSw0OSBAQAordm9p
ZCBmKCkgeworSU5UKDApOworSU5UKDEpOworSU5UKDIpOworSU5UKDMpOworSU5UKDQpOworSU5U
KDUpOworSU5UKDYpOworSU5UKDcpOworSU5UKDgpOworSU5UKDkpOworSU5UKDEwKTsKK0lOVCgx
MSk7CitJTlQoMTIpOworSU5UKDEzKTsKK0lOVCgxNCk7CitJTlQoMTUpOworSU5UKDE2KTsKK0lO
VCgxNyk7CitJTlQoMTgpOworSU5UKDE5KTsKK0lOVCgyMCk7CitJTlQoMjEpOworSU5UKDIyKTsK
K0lOVCgyMyk7CitJTlQoMjQpOworSU5UKDI1KTsKK0lOVCgyNik7CitJTlQoMjcpOworSU5UKDI4
KTsKK0lOVCgyOSk7CitJTlQoMzApOworSU5UKDMxKTsKK0lOVCgzMik7CisKK0lOVCgyMTQ3NDgz
NjQ3KTsgLy8gMioqMzEgLSAxCitMT05HKDIxNDc0ODM2NDgpOyAvLyAyKiozMQorTE9ORygyMTQ3
NDgzNjQ5KTsgLy8gMioqMzEgKyAxCisKK0xPTkcoNDI5NDk2NzI5NSk7IC8vIDIqKjMyIC0gMQor
TE9ORyg0Mjk0OTY3Mjk2KTsgLy8gMioqMzIKK0xPTkcoNDI5NDk2NzI5Nyk7IC8vIDIqKjMyICsg
MQorCitMT05HKDkyMjMzNzIwMzY4NTQ3NzU4MDcpOyAvLyAyKio2MyAtIDEKK1VMT05HKDkyMjMz
NzIwMzY4NTQ3NzU4MDgpOyAvLyAyKio2MworVUxPTkcoOTIyMzM3MjAzNjg1NDc3NTgwOSk7IC8v
IDIqKjYzICsxCisKK1VMT05HKDE4NDQ2NzQ0MDczNzA5NTUxNjE1KTsgLy8gMioqNjQgLSAxCit9
CmRpZmYgLS1naXQgYS90ZXN0cy90eXBlb2Zjb25zdF9pbDMyLmMgYi90ZXN0cy90eXBlb2Zjb25z
dF9pbDMyLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAuLjFjNTg0ZmVhCi0t
LSAvZGV2L251bGwKKysrIGIvdGVzdHMvdHlwZW9mY29uc3RfaWwzMi5jCkBAIC0wLDAgKzEsNDkg
QEAKK3ZvaWQgZigpIHsKKzA7CisxOworMjsKKzM7Cis0OworNTsKKzY7Cis3OworODsKKzk7Cisx
MDsKKzExOworMTI7CisxMzsKKzE0OworMTU7CisxNjsKKzE3OworMTg7CisxOTsKKzIwOworMjE7
CisyMjsKKzIzOworMjQ7CisyNTsKKzI2OworMjc7CisyODsKKzI5OworMzA7CiszMTsKKzMyOwor
CisyMTQ3NDgzNjQ3OyAvLyAyKiozMSAtIDEKKzIxNDc0ODM2NDg7IC8vIDIqKjMxCisyMTQ3NDgz
NjQ5OyAvLyAyKiozMSArIDEKKworNDI5NDk2NzI5NTsgLy8gMioqMzIgLSAxCis0Mjk0OTY3Mjk2
OyAvLyAyKiozMgorNDI5NDk2NzI5NzsgLy8gMioqMzIgKyAxCisKKzkyMjMzNzIwMzY4NTQ3NzU4
MDc7IC8vIDIqKjYzIC0gMQorOTIyMzM3MjAzNjg1NDc3NTgwODsgLy8gMioqNjMKKzkyMjMzNzIw
MzY4NTQ3NzU4MDk7IC8vIDIqKjYzICsxCisKKzE4NDQ2NzQ0MDczNzA5NTUxNjE1OyAvLyAyKio2
NCAtIDEKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3R5cGVvZmNvbnN0X2lsMzIuY29jY2kgYi90ZXN0
cy90eXBlb2Zjb25zdF9pbDMyLmNvY2NpCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAw
MDAwLi5iNDdlNGFlNgotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3R5cGVvZmNvbnN0X2lsMzIu
Y29jY2kKQEAgLTAsMCArMSwyOSBAQAorI3NwYXRjaCAtLWludC1iaXRzIDMyIC0tbG9uZy1iaXRz
IDMyCitAQAoraW50IHNpOworbG9uZyBzbDsKK2xvbmcgbG9uZyBzbGw7Cit1bnNpZ25lZCBpbnQg
dWk7Cit1bnNpZ25lZCBsb25nIHVsOwordW5zaWduZWQgbG9uZyBsb25nIHVsbDsKK0BACisKKygK
Ky0gc2kKKysgSU5UKHNpKQorfAorLSBzbAorKyBMT05HKHNsKQorfAorLSBzbGwKKysgTE9OR0xP
Tkcoc2xsKQorfAorLSB1aQorKyBVSU5UKHVpKQorfAorLSB1bAorKyBVTE9ORyh1bCkKK3wKKy0g
dWxsCisrIFVMT05HTE9ORyh1bGwpCispCmRpZmYgLS1naXQgYS90ZXN0cy90eXBlb2Zjb25zdF9p
bDMyLnJlcyBiL3Rlc3RzL3R5cGVvZmNvbnN0X2lsMzIucmVzCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAwLi5mNzQ1MTNjZgotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3R5cGVv
ZmNvbnN0X2lsMzIucmVzCkBAIC0wLDAgKzEsNDkgQEAKK3ZvaWQgZigpIHsKK0lOVCgwKTsKK0lO
VCgxKTsKK0lOVCgyKTsKK0lOVCgzKTsKK0lOVCg0KTsKK0lOVCg1KTsKK0lOVCg2KTsKK0lOVCg3
KTsKK0lOVCg4KTsKK0lOVCg5KTsKK0lOVCgxMCk7CitJTlQoMTEpOworSU5UKDEyKTsKK0lOVCgx
Myk7CitJTlQoMTQpOworSU5UKDE1KTsKK0lOVCgxNik7CitJTlQoMTcpOworSU5UKDE4KTsKK0lO
VCgxOSk7CitJTlQoMjApOworSU5UKDIxKTsKK0lOVCgyMik7CitJTlQoMjMpOworSU5UKDI0KTsK
K0lOVCgyNSk7CitJTlQoMjYpOworSU5UKDI3KTsKK0lOVCgyOCk7CitJTlQoMjkpOworSU5UKDMw
KTsKK0lOVCgzMSk7CitJTlQoMzIpOworCitJTlQoMjE0NzQ4MzY0Nyk7IC8vIDIqKjMxIC0gMQor
VUxPTkcoMjE0NzQ4MzY0OCk7IC8vIDIqKjMxCitVTE9ORygyMTQ3NDgzNjQ5KTsgLy8gMioqMzEg
KyAxCisKK1VMT05HKDQyOTQ5NjcyOTUpOyAvLyAyKiozMiAtIDEKK0xPTkdMT05HKDQyOTQ5Njcy
OTYpOyAvLyAyKiozMgorTE9OR0xPTkcoNDI5NDk2NzI5Nyk7IC8vIDIqKjMyICsgMQorCitMT05H
TE9ORyg5MjIzMzcyMDM2ODU0Nzc1ODA3KTsgLy8gMioqNjMgLSAxCitMT05HTE9ORyg5MjIzMzcy
MDM2ODU0Nzc1ODA4KTsgLy8gMioqNjMKK0xPTkdMT05HKDkyMjMzNzIwMzY4NTQ3NzU4MDkpOyAv
LyAyKio2MyArMQorCitMT05HTE9ORygxODQ0Njc0NDA3MzcwOTU1MTYxNSk7IC8vIDIqKjY0IC0g
MQorfQotLSAKMi4zOS4yCgo=
--000000000000f7f9370615cf2456--
