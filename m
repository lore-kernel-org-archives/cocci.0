Return-Path: <SRS0=lOWR=SY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9230C282E1
	for <cocci@archiver.kernel.org>; Mon, 22 Apr 2019 07:50:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09EE20857
	for <cocci@archiver.kernel.org>; Mon, 22 Apr 2019 07:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ALR6wAeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09EE20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3M7o3PI011753
          ; Mon, 22 Apr 2019 09:50:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F11B77725;
	Mon, 22 Apr 2019 09:50:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B4C9E7261
 for <cocci@systeme.lip6.fr>; Mon, 22 Apr 2019 09:50:00 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3M7nxbM000391
 for <cocci@systeme.lip6.fr>; Mon, 22 Apr 2019 09:49:59 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555919399;
 bh=ycXChgtLxp60/+V0u3Jdv8FtFFink2rd3Be8BPzjfJs=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=ALR6wAeFBQlN4GXEaI4oVSDO4IBW2l4U7dmNiV//Wgygj7kyjy/49IotBUw2y7aRQ
 55x0O2QrpQt7fsu9scAagkYR2TY/mO1HUFdLCTQVFC1SdpZb1tnNH58RTYTdJxtvPR
 bkhqEc4s54OzbWAWew5KUP2iUTCFjyvcheND67yo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.90.186]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOj14-1hDVtw3llG-0066QU for
 <cocci@systeme.lip6.fr>; Mon, 22 Apr 2019 09:49:59 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b3a94631-55c3-2162-ff7d-ff3482f66641@web.de>
Date: Mon, 22 Apr 2019 09:49:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------FE508814BF4FA3B116D8C45B"
Content-Language: en-GB
X-Provags-ID: V03:K1:gquxhzmE9b//ZXLHXmcj3KvVRMNLUIhKWdFiUkkahWIQ/d24sIA
 KnIAOF1pbM1CQbz08jhnw20+gMY+0YOszJWTv4CC+mBsaCeAvyWNZxJlV6LR3hjgCo/08mF
 GpdLZczV3kt+QPWq/Qpa6ihtu79cTrbe9zMS1Jo3UjvXJfsbHWdNlmLV8NxnWMIwLw9V1aH
 oK3uUEjZSuy9srWsQqipg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ckhpm7gIPcY=:utAJGZB7Lxr//KwCKKilyX
 dL/vHq28e+BZdfEEaeiIIppmLGZeUh9l1eLbIj7aLSr2mGgHHb4H6TXMJ6N8EuB753DEm0bOG
 JCHsVEwTVfdWWBLLOGULhjQoXPdKaMN5tNwzcXruNPE660Cijxj++/Cuxr9YxG1N/DzSYJxPW
 l2+xk9H9DG+ucfvTGsu3+HeeblbdyJ8T+Nz1OmT+1tMAqtnt4rihvH8cpDQA0YKoRb7jSw0WA
 5Od5FmEw1szzVpl+GGzopPO6TFNpxV8HtJVKWL3V01qwJIxSToHUxDRhK31Nt/Crlo0vl3Aqy
 iF9UaDmsnVyzZiozLDAfjaAcsOqQKjxnn9M1QH+g6FBBctcT4ISp8u9+uKzVW2t6da7LEYCtK
 /Avq2Dtliumr0xNa1tiBxOu2uaD2pmNjWkwZ28QZDWkUr50JKVqluaB310Oai3CmkfnLI0nbI
 svvRoXA2t++KKgVSJyJxZWvMVm9PhB/8rNg5gLehyQstR7aaoy5uHu+5Hylbrz9QHn57H/4+o
 5KhfTCF3YkLDKGQaWrFi/Va+EY+kVEqEMg9gqwe5W1T2myLFqn+WshCuQXMrtairaICBZcXrR
 qoCZCGYbAk1E9LeehvhPiKohd0pGvB6E4u364+qiLbIUBXLkLLJu3mxFmnzPUw3aGR7Nci++f
 enbWJfdKWbeRTODtVNjJ+L1VLfBipZzRHV89BrtQ1X9wSp0DTtDFXXhe/J1JUV3kXzdpmDeAF
 icWvlOc7giwpICvjHAXYHLuKjMY23q8ZnGWId08xMGciLot2h7zOugZTYHnUNQq3FJgDBwmyw
 GoyBdC8HgWVB1Ho0rtJ1GFPxiUk0ebVJ2EIw2f4YiASaMih4HPZ9yJsFJXUzWC40Dyq+oUsHf
 FplsO+c5X+iZOXgv6ZOcpxdh05XqpENE/yOqSh3GarJ0frplYuFSKGcromBl9x
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Apr 2019 09:50:04 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 22 Apr 2019 09:49:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking uniqueness for source code positions during SmPL
 data processing
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This is a multi-part message in MIME format.
--------------FE508814BF4FA3B116D8C45B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I reported that I am trying a specific source code analysis out again.
Information can be imported also into database tables for such a purpose.
I observed a primary key constraint violation for my data processing attem=
pt.
Useful background information can be found for a topic like
=E2=80=9CChecking the handling of unique keys/indexes=E2=80=9D.
https://groups.google.com/d/msg/sqlalchemy/klmUwiirIQw/LDeeRTcshQ4J

A corresponding aspect can trigger an usual development challenge.
The transaction fails if questionable data were detected. It seems to be h=
ard
to find the single inappropriate data set out by SQL programming interface=
s.

Thus I developed the attached script variant for the semantic patch langua=
ge.
Another test result points interesting details out, doesn't it?


elfring@Sonne:~/Projekte/Linux/next-patched> time spatch ~/Projekte/Coccin=
elle/janitor/list_duplicate_statement_pairs_from_if_branches5.cocci driver=
s/media/dvb-frontends/stv0297.c
=E2=80=A6
A duplicate key was passed.
function: stv0297_readreg
file: drivers/media/dvb-frontends/stv0297.c
line: 87
column: 4
Traceback (most recent call last):
  File "<string>", line 4, in <module>
  File "<string>", line 26, in store_statements
RuntimeError
exn while in timeout_function
Error in Python script, line 34, file =E2=80=A6

real	0m0,606s
user	0m0,541s
sys	0m0,037s


By the way: I would like to point out once more that the code from
the SmPL rule =E2=80=9Cinitialize=E2=80=9D is 18 lines long and the defini=
tion for
the function =E2=80=9Cstore_statements=E2=80=9D starts at line 4 originall=
y.


The implementation of the function =E2=80=9Cstv0297_readreg=E2=80=9D conta=
ins two statements
which are repeated in three if branches for the desired exception handling=
.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/media/dvb-frontends/stv0297.c?id=3D085b7755808aa11f78ab9377257e1dad2=
e6fa4bb#n66


Now I wonder about the shown software behaviour again when the correspondi=
ng
source code position should be unique based on the specified data fields.
How can affected software areas be improved further?

Regards,
Markus

--------------FE508814BF4FA3B116D8C45B
Content-Type: text/plain; charset=UTF-8;
 name="list_duplicate_statement_pairs_from_if_branches5.cocci"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="list_duplicate_statement_pairs_from_if_branches5.cocci"

QGluaXRpYWxpemU6cHl0aG9uQApAQAppbXBvcnQgc3lzCm1hcHBpbmcgPSB7fQoKZGVmIHN0
b3JlX3N0YXRlbWVudHMoZnVuLCBzb3VyY2UsIHMxLCBzMik6CiAgICAiIiJBZGQgZGF0YSB0
byBhbiBpbnRlcm5hbCB0YWJsZS4iIiIKICAgIGZvciBwbGFjZSBpbiBzb3VyY2U6CiAgICAg
ICBrZXkgPSAoZnVuLCBwbGFjZS5maWxlLCBwbGFjZS5saW5lLCBpbnQocGxhY2UuY29sdW1u
KSArIDEpCiAgICAgICBpZiBrZXkgaW4gbWFwcGluZzoKICAgICAgICAgIHN5cy5zdGRlcnIu
d3JpdGUoIiIiQSBkdXBsaWNhdGUga2V5IHdhcyBwYXNzZWQuCmZ1bmN0aW9uOiAlcwpmaWxl
OiAlcwpsaW5lOiAlcwpjb2x1bW46ICVkCiIiIiAlIGtleSkKICAgICAgICAgIHJhaXNlIFJ1
bnRpbWVFcnJvcgogICAgICAgZWxzZToKICAgICAgICAgIG1hcHBpbmdba2V5XSA9IChzMSwg
czIpCgpAc2VhcmNoaW5nQAppZGVudGlmaWVyIHdvcms7CnN0YXRlbWVudCBzMSwgczI7CnBv
c2l0aW9uIHBvczsKdHlwZSBUOwpAQAogVCB3b3JrKC4uLikKIHsKIC4uLiB3aGVuIGFueQog
aWYgKC4uLikKIHsKIC4uLiB3aGVuIGFueQogczFAcG9zCiBzMgogfQogLi4uIHdoZW4gYW55
CiB9CgpAc2NyaXB0OnB5dGhvbiBjb2xsZWN0aW9uQApmdW4gPDwgc2VhcmNoaW5nLndvcms7
CnMxIDw8IHNlYXJjaGluZy5zMTsKczIgPDwgc2VhcmNoaW5nLnMyOwpwbGFjZSA8PCBzZWFy
Y2hpbmcucG9zOwpAQApzdG9yZV9zdGF0ZW1lbnRzKGZ1biwgcGxhY2UsIHMxLCBzMikKCkBm
aW5hbGl6ZTpweXRob25ACkBACmVudHJpZXMgPSBsZW4obWFwcGluZykKCmlmIGVudHJpZXMg
PiAwOgogICBmcm9tIGNvbGxlY3Rpb25zIGltcG9ydCBDb3VudGVyCiAgIGNvdW50cyA9IENv
dW50ZXIoKQoKICAgZm9yIGssIHYgaW4gbWFwcGluZy5pdGVtcygpOgogICAgICBjb3VudHNb
KHZbMF0sIHZbMV0sIGtbMF0sIGtbMV0pXSArPSAxCgogICBkZWxpbWl0ZXIgPSAifCIKICAg
ZHVwbGljYXRlcyA9IHt9CgogICBmb3IgaywgdiBpbiBjb3VudHMuaXRlbXMoKToKICAgICAg
aWYgdiA+IDE6CiAgICAgICAgIGR1cGxpY2F0ZXNba10gPSB2CgogICBpZiBsZW4oZHVwbGlj
YXRlcy5rZXlzKCkpID4gMDoKICAgICAgc3lzLnN0ZG91dC53cml0ZShkZWxpbWl0ZXIuam9p
bihbInN0YXRlbWVudDEiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAic3RhdGVtZW50MiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICciZnVuY3Rpb24gbmFtZSInLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAnInNvdXJjZSBmaWxlIicsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJpbmNpZGVuY2UiXSkpCiAgICAgIHN5cy5zdGRvdXQud3JpdGUoIlxyXG4iKQoK
ICAgICAgZm9yIGssIHYgaW4gZHVwbGljYXRlcy5pdGVtcygpOgogICAgICAgICBzeXMuc3Rk
b3V0LndyaXRlKGRlbGltaXRlci5qb2luKFtrWzBdLCBrWzFdLCBrWzJdLCBrWzNdLCBzdHIo
dildKSkKICAgICAgICAgc3lzLnN0ZG91dC53cml0ZSgiXHJcbiIpCiAgIGVsc2U6CiAgICAg
IHN5cy5zdGRlcnIud3JpdGUoIkR1cGxpY2F0ZSBzdGF0ZW1lbnRzIHdlcmUgbm90IGRldGVy
bWluZWQgZnJvbSAiCiAgICAgICAgICAgICAgICAgICAgICAgKyBzdHIoZW50cmllcykgKyAi
IHJlY29yZHMuXG4iKQogICAgICBzeXMuc3RkZXJyLndyaXRlKGRlbGltaXRlci5qb2luKFsi
c3RhdGVtZW50MSIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJz
dGF0ZW1lbnQyIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJyJm
dW5jdGlvbiBuYW1lIicsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICcic291cmNlIGZpbGUiJywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgImxpbmUiXSkpCiAgICAgIHN5cy5zdGRlcnIud3JpdGUoIlxyXG4iKQoKICAgICAgZm9y
IGssIHYgaW4gY291bnRzLml0ZW1zKCk6CiAgICAgICAgIHN5cy5zdGRvdXQud3JpdGUoZGVs
aW1pdGVyLmpvaW4oW3ZbMF0sIHZbMV0sIGtbMV0sIGtbMF0sIGtbMl1dKSkKICAgICAgICAg
c3lzLnN0ZGVyci53cml0ZSgiXHJcbiIpCmVsc2U6CiAgIHN5cy5zdGRlcnIud3JpdGUoIk5v
IHJlc3VsdCBmb3IgdGhpcyBhbmFseXNpcyFcbiIpCg==
--------------FE508814BF4FA3B116D8C45B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------FE508814BF4FA3B116D8C45B--
